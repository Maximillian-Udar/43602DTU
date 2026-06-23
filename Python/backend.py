import threading
import time
import asyncio
import random
from collections import deque

class FPGABridge:
    def __init__(self, port='COM4', baud=115200):
        self.port = port
        self.baud = baud
        self.connected = False
        self.simulation_mode = False 
        self.running = True
        
        # --- DEFINER ALLE VARIABLER HER FRA START SÅ GUI IKKE CRASHRE ---
        self.measured_pos = 0.0      
        self.measured_pos_int = 0    
        self.odometer = 0.0            
        self.odometer_int = 0
        self.total_rots = 0          # DENNE MANGLEDE!
        self.simulated_target = 0.0 
        self.manual_direction = 0
        # -------------------------------------------------------------
        
        self.pos_history = deque(maxlen=100)
        self.time_history = deque(maxlen=100)
        self.start_time = time.time()
        
        try:
            import serial
            self.ser = serial.Serial(port, baud, timeout=0.1)
            self.connected = True
            print(f"Forbundet til hardware på {port}")
            threading.Thread(target=self._listen, daemon=True).start()
        except Exception as e:
            print(f"Hardware ikke fundet. STARTER SIMULERING.")
            self.ser = None
            self.simulation_mode = True
            self.connected = True 
            threading.Thread(target=self._simulator_logic, daemon=True).start()

    def _listen(self):
        """Læser 7-byte pakke fra hardware"""
        while self.running and self.ser:
            if self.ser.in_waiting >= 7:
                if self.ser.read(1) == b'\xff':
                    data = self.ser.read(6)
                    if len(data) == 6:
                        # 1. Position (Signed 16-bit)
                        new_pos = int.from_bytes(data[:2], byteorder='big', signed=True)
                        self.measured_pos = float(new_pos)
                        
                        # 2. Total Rotations (Unsigned 32-bit fra total_count_control logik)
                        self.total_rots = int.from_bytes(data[2:], byteorder='big', signed=False)
                        
                        # 3. Beregn Odometer (7.5 rotationer per cm)
                        self.odometer = self.total_rots / 7.5
                        
                        self.update_history()
            time.sleep(0.01)

    def _simulator_logic(self):
        """Simulerer motorbevægelse og tæller rotationer"""
        while self.running:
            old_pos = self.measured_pos
            
            if self.manual_direction != 0:
                step = 0.2 if abs(self.manual_direction) == 1 else 0.6
                if self.manual_direction < 0: step = -step
                self.measured_pos += step
                self.simulated_target = self.measured_pos
            else:
                dist_to_target = self.simulated_target - self.measured_pos
                if abs(dist_to_target) > 0.1:
                    self.measured_pos += max(-0.4, min(0.4, dist_to_target))
            
            # Stop ved 0 og 90
            self.measured_pos = max(0.0, min(90.0, self.measured_pos))
            
            # Opdater rotationer (kun hvis vi har flyttet os)
            actual_move_cm = abs(self.measured_pos - old_pos)
            self.total_rots += int(actual_move_cm * 7.5)
            self.odometer = self.total_rots / 7.5
            
            self.update_history()
            time.sleep(0.05)

    def update_history(self):
        """Opdaterer de variabler som UI'en læser"""
        self.measured_pos_int = int(self.measured_pos) 
        self.odometer_int = int(self.odometer)
        
        t = time.time() - self.start_time
        self.time_history.append(round(t, 1))
        self.pos_history.append(self.measured_pos_int)

    def send_raw(self, cmd_byte, val_byte):
        if self.simulation_mode:
            if cmd_byte == 0x01: 
                self.manual_direction = 0
                self.simulated_target = float(val_byte)
            elif cmd_byte == 0x02:
                if val_byte == 0 or val_byte == 5:
                    self.manual_direction = 0
                    self.simulated_target = self.measured_pos
                elif val_byte == 1: self.manual_direction = 1
                elif val_byte == 2: self.manual_direction = 2
                elif val_byte == 3: self.manual_direction = -1
                elif val_byte == 4: self.manual_direction = -2
        elif self.connected and self.ser:
            packet = bytearray([0xAA, cmd_byte, val_byte])
            self.ser.write(packet)

    def close(self):
        self.running = False
        if self.ser: self.ser.close()