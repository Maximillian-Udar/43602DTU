import serial, sys, time, threading

class MotorController:
    def __init__(self):
        print("\n" + "="*30)
        print("  COMMAND MENU")
        print("  p <m> : Go to meters")
        print("  sf, ff, sb, fb : Manual speeds")
        print("  s : Stop | r : Reset | q : Quit")
        print("="*30 + "\n")
        try:
            self.ser = serial.Serial('COM4', 115200, timeout=0.01)
            self.ser.reset_input_buffer()
            print(f"[*] Connected to COM4")
        except:
            print(f"[!] Connection failed"); sys.exit(1)

        self.current_pos = 0
        self.running = True
        threading.Thread(target=self._worker, daemon=True).start()

    def _worker(self):
        while self.running:
            if self.ser.in_waiting > 15: self.ser.reset_input_buffer()
            if self.ser.in_waiting >= 3:
                if self.ser.read(1) == b'\xff':
                    data = self.ser.read(2)
                    if len(data) == 2:
                        self.current_pos = int.from_bytes(data, byteorder='big', signed=True)
                        sys.stdout.write(f"\r[Telemetry] Position: {self.current_pos} cm         ")
                        sys.stdout.flush()
            time.sleep(0.01)

    def send(self, cmd, val): self.ser.write(bytearray([0xAA, cmd, val]))

if __name__ == "__main__":
    ctrl = MotorController()
    while True:
        try:
            l = input("\n> ").lower().split()
            if not l: continue
            c = l[0]
            if c == 'p':  
                if int(l[1]) < 0:
                    pass
                else:
                    ctrl.send(0x01, int(l[1]))
            elif c == 's': ctrl.send(0x02, 0)
            elif c == 'sf': ctrl.send(0x02, 1)
            elif c == 'ff': ctrl.send(0x02, 2)
            elif c == 'sb': ctrl.send(0x02, 3)
            elif c == 'fb': ctrl.send(0x02, 4)
            elif c == 'r':  ctrl.send(0xFF, 0x00)
            elif c == 'q':  break
        except (KeyboardInterrupt, EOFError): break
    ctrl.running = False; ctrl.ser.close()