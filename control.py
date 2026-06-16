import serial
import time
import threading
import sys

COM_PORT = 'COM4' 
BAUD_RATE = 115200

class FPGAController:
    def __init__(self, port, baud):
        self.ser = serial.Serial(port, baud, timeout=0.1)
        self.current_pos_cm = 0
        self.last_mode = "STARTUP_LOCK"
        self.running = True
        self.reader_thread = threading.Thread(target=self._read_telemetry, daemon=True)
        self.reader_thread.start()

    def _read_telemetry(self):
        while self.running:
            if self.ser.in_waiting > 0:
                data = self.ser.read(1)
                self.current_pos_cm = int.from_bytes(data, byteorder='big')
                sys.stdout.write(f"\r[Status] Mode: {self.last_mode} | Position: {self.current_pos_cm} cm   ")
                sys.stdout.flush()

    def send_packet(self, cmd, val):
        # 0xAA is the security header
        self.ser.write(bytearray([0xAA, cmd, val]))

    def set_position(self, meters):
        self.last_mode = "AUTO"
        self.send_packet(0x01, meters)

    def set_manual(self, mode_id):
        modes = ["STOP/BRAKE", "SLOW_FWD", "FAST_FWD", "SLOW_BACK", "FAST_BACK", "HARD_BRAKE"]
        self.last_mode = f"MANUAL({modes[mode_id]})"
        self.send_packet(0x02, mode_id)

    def reset_safety(self):
        self.send_packet(0xFF, 0x00)
        print("\n[*] Reset command sent.")

# --- MAIN ---
if __name__ == "__main__":
    ctrl = FPGAController(COM_PORT, BAUD_RATE)
    print("\nCommands: p <m>, m <0-5>, r (Reset), q (Quit)")
    try:
        while True:
            inp = input("\n> ").split()
            if not inp: continue
            if inp[0] == 'p': ctrl.set_position(int(inp[1]))
            elif inp[0] == 'm': ctrl.set_manual(int(inp[1]))
            elif inp[0] == 'r': ctrl.reset_safety()
            elif inp[0] == 'q': break
    finally:
        ctrl.ser.close()