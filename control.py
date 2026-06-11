import serial
import time
import threading

# --- CONFIGURATION ---
COM_PORT = 'COM3'
BAUD_RATE = 115200

class MotorController:
    def __init__(self, port, baud):
        try:
            self.ser = serial.Serial(port, baud, timeout=1)
            print(f"Connected to FPGA on {port}")
        except Exception as e:
            print(f"Error connecting: {e}")
            exit()

        self.current_position = 0
        self.running = True

        # Start a background thread to listen for position updates from FPGA
        self.reader_thread = threading.Thread(target=self._read_telemetry, daemon=True)
        self.reader_thread.start()

    def _read_telemetry(self):
        """Reads the 1-byte position updates sent by the FPGA 10 times/sec."""
        while self.running:
            if self.ser.in_waiting > 0:
                data = self.ser.read(1)
                self.current_position = int.from_bytes(data, byteorder='big')
                # Optional: Clear screen and print status
                print(f"\rCurrent Position: {self.current_position}m | Target: {self.target}m", end="")

    def set_position(self, meters):
        """Sends Command 0x01: Set Target Position."""
        if 0 <= meters <= 90:
            self.target = meters
            self.ser.write(bytearray([0x01, meters]))
        else:
            print("Position must be between 0 and 90m")

    def set_manual_mode(self, mode_id):
        """Sends Command 0x02: Manual Control.
        0=Stop, 1=Slow Fwd, 2=Fast Fwd, 3=Slow Back, 4=Fast Back, 5=Brake
        """
        self.ser.write(bytearray([0x02, mode_id]))

    def reset_stuck(self):
        """Sends Command 0xFF: Clear stuck detector/shutdown."""
        self.ser.write(bytearray([0xFF, 0x00]))
        print("\nReset command sent.")

    def close(self):
        self.running = False
        self.ser.close()

# --- MAIN INTERFACE ---
if __name__ == "__main__":
    ctrl = MotorController(COM_PORT, BAUD_RATE)
    ctrl.target = 0

    print("\n--- FPGA Target Retrieval Controller ---")
    print("Commands:")
    print("  p [val] : Set Position (0-90m)")
    print("  m [0-5] : Manual (0:Stop, 1:S_Fwd, 2:F_Fwd, 3:S_Back, 4:F_Back, 5:Brake)")
    print("  r       : Reset Stuck Status")
    print("  q       : Quit")

    try:
        while True:
            cmd_input = input("\nEnter command: ").split()
            if not cmd_input: continue
            
            char = cmd_input[0].lower()

            if char == 'p' and len(cmd_input) > 1:
                ctrl.set_position(int(cmd_input[1]))
            elif char == 'm' and len(cmd_input) > 1:
                ctrl.set_manual_mode(int(cmd_input[1]))
            elif char == 'r':
                ctrl.reset_stuck()
            elif char == 'q':
                break
            else:
                print("Invalid command.")

    except KeyboardInterrupt:
        pass
    finally:
        ctrl.close()
        print("\nDisconnected.")