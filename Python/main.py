from nicegui import ui
from backend import FPGABridge
from gui import create_interface

# Ret COM-porten til den port din Basys 3 bruger
bridge = FPGABridge(port='COM4') 

create_interface(bridge)

ui.run(title="Target Retrieval System", reload=False, port=8080)