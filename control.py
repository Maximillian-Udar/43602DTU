import serial
import time
import threading
import sys
import serial.tools.list_ports

# --- CONFIGURATION ---
BAUD_RATE = 115200
HEADER = 0xAA  # Security Header required by FPGA

class MotorController:
    def __init__(self):
        self.port = self._find_port()
        try:
            self.ser = serial.Serial(self.port, BAUD_RATE, timeout=0.05)
            # Clear buffers to ensure we start at the beginning of a telemetry packet
            self.ser.reset_input_buffer()
            self.ser.reset_output_buffer()
            print(f"[*] Connected to {self.port}")
        except Exception as e:
            print(f"[!] Could not open port: {e}")
            sys.exit(1)

        self.current_pos_cm = 0
        self.last_mode = "STARTUP_LOCK"
        self.running = True

        # Telemetry thread
        self.thread = threading.Thread(target=self._telemetry_worker, daemon=True)
        self.thread.start()

    def _find_port(self):
        """Helper to find the FPGA/USB-Serial port."""
        ports = list(serial.tools.list_ports.comports())
        for p in ports:
            # Common names for FPGA/USB-Serial chips
            if "UART" in p.description or "USB" in p.description or "Serial" in p.description:
                return p.device
        # Fallback for manual entry
        return 'COM4' 

    def _telemetry_worker(self):
        """
        Reads 2-byte signed telemetry.
        Includes a sync-check to ensure we aren't reading bytes out of order.
        """
        while self.running:
            try:
                # We need at least 2 bytes for a position packet
                if self.ser.in_waiting >= 2:
                    # If the buffer has grown too large, clear it to remove lag
                    if self.ser.in_waiting > 10:
                        self.ser.reset_input_buffer()
                        continue
                    
                    data = self.ser.read(2)
                    # Convert Big-Endian Signed 16-bit
                    val = int.from_bytes(data, byteorder='big', signed=True)
                    
                    # Basic sanity check: if value jumps by > 5000 in one step, 
                    # we are likely out of byte-sync. Skip one byte to re-align.
                    if abs(val - self.current_pos_cm) > 5000 and self.current_pos_cm != 0:
                        self.ser.read(1) # Shift alignment
                        continue

                    self.current_pos_cm = val
                    self._update_ui()
            except Exception:
                break

    def _update_ui(self):
        """Refresh the status line."""
        sys.stdout.write(f"\r[Status] Mode: {self.last_mode} | Position: {self.current_pos_cm} cm   ")
        sys.stdout.flush()

    def send(self, cmd, val):
        """Send [0xAA, Command, Value] packet."""
        try:
            packet = bytearray([HEADER, cmd, val])
            self.ser.write(packet)
            # Small delay to ensure FPGA state machine processes the packet
            time.sleep(0.01) 
        except Exception as e:
            print(f"\n[!] Write Error: {e}")

    def set_position(self, meters):
        self.last_mode = "AUTO"
        print(f"\n[*] Seeking {meters}m ({meters*100}cm)...")
        self.send(0x01, meters)

    def set_manual(self, mode_id):
        modes = ["STOP/BRAKE", "SLOW_FWD", "FAST_FWD", "SLOW_BACK", "FAST_BACK", "HARD_BRAKE"]
        self.last_mode = f"MANUAL({modes[mode_id]})"
        print(f"\n[*] Manual Command: {modes[mode_id]}")
        self.send(0x02, mode_id)

    def reset_safety(self):
        print("\n[*] Sending Reset/Clear command...")
        self.send(0xFF, 0x00)

    def stop(self):
        self.running = False
        self.ser.close()

# --- CLI INTERFACE ---
if __name__ == "__main__":
    ctrl = MotorController()
    print("\n--- FPGA Motor Controller V2 (Signed/16-bit Sync) ---")
    print("Commands:")
    print("  p <m> : Go to Position in meters (0-90)")
    print("  m <0-5>: Manual Mode (0:Stop, 1:SF, 2:FF, 3:SB, 4:FB, 5:Brake)")
    print("  r     : Reset/Clear Safety Trip")
    print("  q     : Quit")
    
    try:
        while True:
            # We use input() - it will break the status line but is easier for control
            cmd_input = input("\n> ").split()
            if not cmd_input: continue
            
            action = cmd_input[0].lower()
            
            if action == 'p' and len(cmd_input) > 1:
                ctrl.set_position(int(cmd_input[1]))
            elif action == 'm' and len(cmd_input) > 1:
                ctrl.set_manual(int(cmd_input[1]))
            elif action == 'r':
                ctrl.reset_safety()
            elif action == 'q':
                break
    except KeyboardInterrupt:
        pass
    finally:
        ctrl.stop()
        print("\n[*] Disconnected.")