import serial
import threading
import time
import tkinter as tk
from tkinter import messagebox

# Color Palette
BG_COLOR = "#0b0e14"
CARD_BG = "#161b22"
ACCENT_BLUE = "#3b82f6"
ACCENT_GREEN = "#22c55e"
ACCENT_RED = "#ef4444"
ACCENT_ORANGE = "#f59e0b"
TEXT_PRIMARY = "#ffffff"
TEXT_SECONDARY = "#8b949e"

class MotorControllerGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("American Shooting System")
        self.root.configure(bg=BG_COLOR)
        
        # Fullscreen Setup
        self.root.attributes("-fullscreen", True)
        self.root.bind("<Escape>", lambda e: self.on_close())

        # Serial Logic
        self.port = "COM4"
        self.baud = 115200
        self.running = True
        
        # Telemetry Variables
        self.current_pos = tk.StringVar(value="0")
        self.total_rots = tk.StringVar(value="0")
        
        # Odometer & Service Logic
        self.odometer = 0.0 
        self.last_pos = 0
        self.last_milestone = 0 
        self.service_due = False
        self.odometer_str = tk.StringVar(value="0.00 cm")

        try:
            self.ser = serial.Serial(self.port, self.baud, timeout=0.01)
            self.ser.reset_input_buffer()
            self.hw_status_text = tk.StringVar(value="HARDWARE ONLINE")
            self.hw_status_color = ACCENT_GREEN
        except Exception:
            self.hw_status_text = tk.StringVar(value="HARDWARE OFFLINE")
            self.hw_status_color = ACCENT_RED

        self.setup_ui()
        
        self.thread = threading.Thread(target=self._worker, daemon=True)
        self.thread.start()

    def setup_ui(self):
        # --- HEADER BAR ---
        self.header = tk.Frame(self.root, bg="#0d1117", height=70)
        self.header.pack(fill="x", padx=0, pady=0)
        self.header.pack_propagate(False)

        tk.Label(self.header, text="(A)merican (S)hooting (S)ystem", fg=TEXT_PRIMARY, bg="#0d1117", 
                 font=("Arial", 16, "bold")).pack(side="left", padx=30)
        
        self.status_badge = tk.Label(self.header, textvariable=self.hw_status_text, fg=BG_COLOR, 
                                     bg=self.hw_status_color, font=("Arial", 10, "bold"), padx=15, pady=5)
        self.status_badge.pack(side="right", padx=30)

        # Main Container
        main_frame = tk.Frame(self.root, bg=BG_COLOR)
        main_frame.pack(fill="both", expand=True, padx=30, pady=30)

        # --- LEFT COLUMN (CONTROLS) ---
        left_col = tk.Frame(main_frame, bg=BG_COLOR, width=450)
        left_col.pack(side="left", fill="y", padx=(0, 30))
        left_col.pack_propagate(False)

        # Big Retrieve Button
        tk.Button(left_col, text="RETRIEVE TARGET FOR SERVICE", bg=ACCENT_BLUE, fg=TEXT_PRIMARY,
                                 font=("Arial", 14, "bold"), relief="flat", height=2,
                                 command=lambda: self.send(0x02, 3)).pack(fill="x", pady=(0, 20))

        # --- ENLARGED PID SECTION ---
        pid_frame = tk.Frame(left_col, bg=CARD_BG, padx=25, pady=30)
        pid_frame.pack(fill="x", pady=(0, 20))
        
        tk.Label(pid_frame, text="AUTOMATIC POSITIONING (PID)", fg=ACCENT_BLUE, bg=CARD_BG, font=("Arial", 10, "bold")).pack(anchor="w")
        tk.Label(pid_frame, text="SET TARGET DISTANCE", fg=TEXT_PRIMARY, bg=CARD_BG, font=("Arial", 14, "bold")).pack(anchor="w", pady=(20, 5))
        
        # Massive Entry
        self.pos_entry = tk.Entry(pid_frame, bg="#0d1117", fg=TEXT_PRIMARY, insertbackground="white", 
                                  relief="flat", font=("Arial", 72, "bold"), justify="center")
        self.pos_entry.pack(fill="x", pady=15, ipady=20)
        self.pos_entry.insert(0, "0")

        # Huge Action Button
        tk.Button(pid_frame, text="SET DISTANCE", bg=ACCENT_BLUE, fg=TEXT_PRIMARY, relief="flat",
                  command=self.cmd_go_to_pos, font=("Arial", 18, "bold"), height=2).pack(fill="x", pady=(10, 0))

        # Manual Overdrive
        manual_frame = tk.Frame(left_col, bg=CARD_BG, padx=15, pady=15)
        manual_frame.pack(fill="x")
        tk.Label(manual_frame, text="MANUAL OVERDRIVE", fg=TEXT_SECONDARY, bg=CARD_BG, font=("Arial", 9, "bold")).pack(anchor="w", pady=(0, 10))
        
        grid_frame = tk.Frame(manual_frame, bg=CARD_BG)
        grid_frame.pack(fill="x")
        btn_configs = [
            ("FWD FAST", ACCENT_GREEN, 0x02, 2, 0, 0), ("REV FAST", ACCENT_RED, 0x02, 4, 0, 1),
            ("FWD SLOW", ACCENT_GREEN, 0x02, 1, 1, 0), ("REV SLOW", ACCENT_ORANGE, 0x02, 3, 1, 1)
        ]
        for text, color, cmd, val, r, c in btn_configs:
            tk.Button(grid_frame, text=text, bg=color, fg=TEXT_PRIMARY, relief="flat", font=("Arial", 9, "bold"),
                      height=2, command=lambda cmd=cmd, val=val: self.send(cmd, val)).grid(row=r, column=c, padx=2, pady=2, sticky="nsew")
        grid_frame.columnconfigure(0, weight=1); grid_frame.columnconfigure(1, weight=1)

        tk.Button(manual_frame, text="STOP / BRAKE", bg="#374151", fg=TEXT_PRIMARY, relief="flat",
                  font=("Arial", 10, "bold"), pady=12, command=lambda: self.send(0x02, 0)).pack(fill="x", pady=(10, 0))

        # --- RIGHT COLUMN (STATS & LIVE) ---
        right_col = tk.Frame(main_frame, bg=BG_COLOR)
        right_col.pack(side="left", fill="both", expand=True)

        stats_frame = tk.Frame(right_col, bg=CARD_BG, padx=25, pady=25)
        stats_frame.pack(fill="x", pady=(0, 20))
        
        #tk.Label(stats_frame, text="CURRENT POSITION", fg=TEXT_SECONDARY, bg=CARD_BG, font=("Arial", 10, "bold")).grid(row=0, column=0, sticky="w")
        #tk.Label(stats_frame, textvariable=self.current_pos, fg=TEXT_PRIMARY, bg=CARD_BG, font=("Arial", 28, "bold")).grid(row=1, column=0, sticky="w")
        
        tk.Label(stats_frame, text="TOTAL TRAVEL (ODOMETER)", fg=TEXT_SECONDARY, bg=CARD_BG, font=("Arial", 10, "bold")).grid(row=0, column=1, sticky="w", padx=60)
        tk.Label(stats_frame, textvariable=self.odometer_str, fg=ACCENT_ORANGE, bg=CARD_BG, font=("Arial", 28, "bold")).grid(row=1, column=1, sticky="w", padx=60)

        # SPLIT MIDDLE PANEL
        split_frame = tk.Frame(right_col, bg=BG_COLOR)
        split_frame.pack(fill="both", expand=True)

        # LARGE LEFT: Live Measured Position
        live_frame = tk.Frame(split_frame, bg=CARD_BG, highlightbackground=ACCENT_BLUE, highlightthickness=1)
        live_frame.pack(side="left", fill="both", expand=True, padx=(0, 15))
        
        tk.Label(live_frame, text="LIVE MEASURED POSITION", fg=ACCENT_BLUE, bg=CARD_BG, font=("Arial", 12, "bold")).pack(pady=(60, 0))
        inner_live = tk.Frame(live_frame, bg=CARD_BG)
        inner_live.pack(expand=True)
        tk.Label(inner_live, textvariable=self.current_pos, fg=ACCENT_BLUE, bg=CARD_BG, font=("Arial", 140, "bold")).pack(side="left")
        tk.Label(inner_live, text="cm", fg=ACCENT_BLUE, bg=CARD_BG, font=("Arial", 50, "bold")).pack(side="left", padx=15, pady=(45, 0))

        # SMALL RIGHT: Position Selector
        select_frame = tk.Frame(split_frame, bg=CARD_BG, width=220, padx=15, pady=20)
        select_frame.pack(side="right", fill="y")
        select_frame.pack_propagate(False)

        tk.Label(select_frame, text="QUICK PRESETS", fg=TEXT_SECONDARY, bg=CARD_BG, font=("Arial", 10, "bold")).pack(pady=(0, 15))
        
        presets = [("5 cm", 5), ("10 cm", 10), ("25 cm", 25), ("50 cm", 50), ("75 cm", 75), ("90 cm", 90)]
        for label, val in presets:
            tk.Button(select_frame, text=label, bg="#2d333b", fg=TEXT_PRIMARY, relief="flat",
                      font=("Arial", 10, "bold"), height=2, command=lambda v=val: self.send(0x01, v)).pack(fill="x", pady=4)

        # Footer Actions
        bottom_btns = tk.Frame(right_col, bg=BG_COLOR)
        bottom_btns.pack(fill="x", pady=(20, 0))

        tk.Button(bottom_btns, text="RESET STUCK SENSOR", bg=BG_COLOR, fg=ACCENT_BLUE, relief="flat",
                  highlightbackground=ACCENT_BLUE, highlightthickness=1, font=("Arial", 10, "bold"),
                  command=lambda: self.send(0xFF, 0x00)).pack(side="left", fill="x", expand=True, padx=(0, 5))

        self.service_btn = tk.Button(bottom_btns, text="ACKNOWLEDGE SERVICE", bg=BG_COLOR, fg=ACCENT_ORANGE, relief="flat",
                  highlightbackground=ACCENT_ORANGE, highlightthickness=1, font=("Arial", 10, "bold"),
                  command=self.reset_service_alert)

    def _worker(self):
        while self.running:
            try:
                if hasattr(self, 'ser') and self.ser.in_waiting >= 7:
                    if self.ser.read(1) == b'\xff':
                        data = self.ser.read(6)
                        if len(data) == 6:
                            pos = int.from_bytes(data[:2], byteorder='big', signed=True)
                            rots = int.from_bytes(data[2:], byteorder='big', signed=False)
                            self.current_pos.set(str(pos))
                            self.total_rots.set(str(rots))
                            delta = abs(pos - self.last_pos)
                            if delta < 50: self.odometer += delta
                            self.last_pos = pos
                            self.odometer_str.set(f"{self.odometer:.0f} cm")
                            milestone = int(self.odometer // 100)
                            if milestone > self.last_milestone:
                                self.last_milestone = milestone
                                self.trigger_service_alert()
            except: pass
            time.sleep(0.01)

    def trigger_service_alert(self):
        self.service_due = True
        self.hw_status_text.set("SERVICE DUE (100CM+)")
        self.status_badge.config(bg=ACCENT_ORANGE)
        self.service_btn.pack(side="right", fill="x", expand=True, padx=(5, 0))
        threading.Thread(target=lambda: messagebox.showinfo("Service", "Routine service required (100cm traveled).")).start()

    def reset_service_alert(self):
        self.service_due = False
        self.hw_status_text.set("HARDWARE ONLINE")
        self.status_badge.config(bg=ACCENT_GREEN)
        self.service_btn.pack_forget()

    def send(self, cmd, val):
        if hasattr(self, 'ser'):
            try: self.ser.write(bytearray([0xAA, cmd, val]))
            except: pass

    def cmd_go_to_pos(self):
        try:
            val = int(self.pos_entry.get())
            self.send(0x01, val)
        except ValueError:
            messagebox.showwarning("Input Error", "Enter valid distance")

    def on_close(self):
        self.running = False
        if hasattr(self, 'ser'): self.ser.close()
        self.root.destroy()

if __name__ == "__main__":
    root = tk.Tk()
    app = MotorControllerGUI(root)
    root.mainloop()