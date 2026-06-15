import sys
import serial
import threading
import time
import numpy as np
from PyQt6.QtWidgets import (QApplication, QMainWindow, QWidget, QVBoxLayout, 
                             QHBoxLayout, QGridLayout, QLabel, QPushButton, 
                             QSlider, QLineEdit, QFrame)
from PyQt6.QtCore import Qt, QTimer, pyqtSignal, QObject
from PyQt6.QtGui import QFont, QColor
import pyqtgraph as pg

# --- UART PROTOCOL SETTINGS ---
BAUD_RATE = 115200
COM_PORT = 'COM3'  # Change to your port

class TelemetryData(QObject):
    """Container for data shared between Serial Thread and GUI"""
    pos_updated = pyqtSignal(int)
    
    def __init__(self):
        super().__init__()
        self.target_pos = 0
        self.current_pos = 0
        self.motor_current = 0.0
        self.system_state = "Idle"
        self.is_stuck = False

class MotorSerialThread(threading.Thread):
    def __init__(self, data_obj):
        super().__init__()
        self.data = data_obj
        self.running = True
        try:
            self.ser = serial.Serial(COM_PORT, BAUD_RATE, timeout=0.1)
        except:
            print(f"CRITICAL: Could not open {COM_PORT}")
            self.ser = None

    def run(self):
        while self.running and self.ser:
            if self.ser.in_waiting > 0:
                # Assuming FPGA sends 1 byte for position (0-90m)
                raw_byte = self.ser.read(1)
                val = int.from_bytes(raw_byte, byteorder='big')
                self.data.current_pos = val
                self.data.pos_updated.emit(val)

    def send_cmd(self, cmd, val):
        if self.ser:
            self.ser.write(bytearray([cmd, val]))

class InfoCard(QFrame):
    """Custom widget for the dashboard cards"""
    def __init__(self, title, unit=""):
        super().__init__()
        self.setFrameShape(QFrame.Shape.StyledPanel)
        self.setStyleSheet("""
            QFrame {
                background-color: #0b141d;
                border: 1px solid #1e2d3d;
                border-radius: 8px;
            }
            QLabel { color: #8fa0b3; border: none; }
        """)
        layout = QVBoxLayout()
        self.title_label = QLabel(title.upper())
        self.title_label.setFont(QFont("Arial", 8, QFont.Weight.Bold))
        
        self.value_label = QLabel(f"0.00 {unit}")
        self.value_label.setFont(QFont("Arial", 14, QFont.Weight.Bold))
        self.value_label.setStyleSheet("color: white;")
        
        layout.addWidget(self.title_label)
        layout.addWidget(self.value_label)
        self.setLayout(layout)

    def update_value(self, val, color="white"):
        self.value_label.setText(str(val))
        self.value_label.setStyleSheet(f"color: {color};")

class TargetDashboard(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Target Retrieval System - Control Console")
        self.resize(1100, 900)
        self.setStyleSheet("background-color: #050a0e; color: white;")
        
        self.data = TelemetryData()
        self.serial_thread = MotorSerialThread(self.data)
        self.serial_thread.start()
        
        self.init_ui()
        
        # UI Update Timer
        self.timer = QTimer()
        self.timer.timeout.connect(self.refresh_ui)
        self.timer.start(100) # 10Hz Refresh

        # Plot Data Buffers
        self.pos_history = np.zeros(100)
        self.time_steps = np.arange(100)

    def init_ui(self):
        main_layout = QVBoxLayout()
        
        # --- HEADER ---
        header = QFrame()
        header.setStyleSheet("background-color: #102e33; border-bottom: 2px solid #00ffcc;")
        header_layout = QHBoxLayout(header)
        title = QLabel("TARGET RETRIEVAL SYSTEM")
        title.setFont(QFont("Arial", 16, QFont.Weight.Bold))
        status = QLabel("● SIMULATOR ONLINE")
        status.setStyleSheet("color: #00ffcc;")
        header_layout.addWidget(title)
        header_layout.addStretch()
        header_layout.addWidget(status)
        main_layout.addWidget(header)

        # --- TOP CONTROLS ---
        ctrl_section = QGridLayout()
        self.dist_slider = QSlider(Qt.Orientation.Horizontal)
        self.dist_slider.setRange(0, 90)
        self.dist_slider.valueChanged.connect(self.on_slider_change)
        
        self.btn_start = QPushButton("START")
        self.btn_start.setStyleSheet("background-color: #28a745; color: white; padding: 15px; font-weight: bold;")
        self.btn_start.clicked.connect(lambda: self.serial_thread.send_cmd(0x02, 1))
        
        self.btn_stop = QPushButton("STOP")
        self.btn_stop.setStyleSheet("background-color: #5a6268; color: white; padding: 15px; font-weight: bold;")
        self.btn_stop.clicked.connect(lambda: self.serial_thread.send_cmd(0x02, 0))

        self.btn_estop = QPushButton("EMERGENCY STOP")
        self.btn_estop.setStyleSheet("background-color: #dc3545; color: white; padding: 15px; font-weight: bold;")
        self.btn_estop.clicked.connect(lambda: self.serial_thread.send_cmd(0x02, 5))

        ctrl_section.addWidget(QLabel("TARGET DISTANCE (m)"), 0, 0)
        ctrl_section.addWidget(self.dist_slider, 1, 0, 1, 2)
        ctrl_section.addWidget(self.btn_start, 2, 0)
        ctrl_section.addWidget(self.btn_stop, 2, 1)
        ctrl_section.addWidget(self.btn_estop, 1, 2, 2, 1)
        main_layout.addLayout(ctrl_section)

        # --- INFO CARDS ---
        card_layout = QGridLayout()
        self.card_pos = InfoCard("Current Position", "m")
        self.card_target = InfoCard("Target Position", "m")
        self.card_current = InfoCard("Motor Current", "A")
        self.card_state = InfoCard("System State")
        
        card_layout.addWidget(self.card_pos, 0, 0)
        card_layout.addWidget(self.card_target, 0, 1)
        card_layout.addWidget(self.card_current, 0, 2)
        card_layout.addWidget(self.card_state, 0, 3)
        main_layout.addLayout(card_layout)

        # --- CHARTS ---
        chart_layout = QHBoxLayout()
        self.pos_plot = pg.PlotWidget(title="Position vs Time")
        self.pos_plot.setBackground('#0b141d')
        self.pos_curve = self.pos_plot.plot(pen=pg.mkPen(color='#00ffcc', width=2))
        
        chart_layout.addWidget(self.pos_plot)
        main_layout.addLayout(chart_layout)

        # --- GAINS ---
        gain_layout = QHBoxLayout()
        self.kp_input = QLineEdit("10.0")
        self.ki_input = QLineEdit("0.35")
        gain_layout.addWidget(QLabel("Kp:"))
        gain_layout.addWidget(self.kp_input)
        gain_layout.addWidget(QLabel("Ki:"))
        gain_layout.addWidget(self.ki_input)
        main_layout.addLayout(gain_layout)

        central_widget = QWidget()
        central_widget.setLayout(main_layout)
        self.setCentralWidget(central_widget)

    def on_slider_change(self):
        val = self.dist_slider.value()
        self.data.target_pos = val
        self.serial_thread.send_cmd(0x01, val)

    def refresh_ui(self):
        self.card_pos.update_value(f"{self.data.current_pos}.00 m")
        self.card_target.update_value(f"{self.data.target_pos}.00 m")
        
        # Update Plot
        self.pos_history = np.roll(self.pos_history, -1)
        self.pos_history[-1] = self.data.current_pos
        self.pos_curve.setData(self.time_steps, self.pos_history)

    def closeEvent(self, event):
        self.serial_thread.running = False
        self.serial_thread.join()
        event.accept()

if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = TargetDashboard()
    window.show()
    sys.exit(app.exec())