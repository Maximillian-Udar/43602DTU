from nicegui import ui

def create_interface(bridge):
    ui.dark_mode().enable()
    
    # Header
    with ui.header().classes('items-center justify-between bg-slate-900 px-4'):
        ui.label('FPGA TARGET CONTROL').classes('text-xl font-bold')
        with ui.row().classes('items-center'):
            status = 'ONLINE' if bridge.connected else 'OFFLINE'
            color = 'green' if bridge.connected else 'red'
            ui.badge(f"HARDWARE {status}", color=color)

    with ui.row().classes('w-full no-wrap items-stretch'):
        
        # --- VENSTRE KOLONNE: KONTROL ---
        with ui.column().classes('w-1/3 p-4 gap-4'):
            
            # RETRIEVAL KNAP (0 cm)
            with ui.card().classes('w-full bg-blue-900 p-2'):
                ui.button('RETRIEVE TARGET (0 cm)', 
                          on_click=lambda: bridge.send_raw(0x01, 0)
                          ).classes('w-full h-16 text-lg font-bold').props('color=blue-6')

            # Automatisk Mode (PID)
            with ui.card().classes('w-full'):
                ui.label('Automatic Positioning (PID)').classes('text-xs text-slate-400')
                target_val = ui.number(label='Set Target (cm)', value=0, min=0, max=90)
                ui.button('SET DISTANCE', 
                          on_click=lambda: bridge.send_raw(0x01, int(target_val.value))
                          ).classes('w-full')

            # Manuel Mode
            with ui.card().classes('w-full'):
                ui.label('Manual Overdrive').classes('text-xs text-slate-400')
                with ui.grid(columns=2).classes('w-full gap-2'):
                    ui.button('FWD FAST', color='green-9', on_click=lambda: bridge.send_raw(0x02, 2))
                    ui.button('REV FAST', color='red-9', on_click=lambda: bridge.send_raw(0x02, 4))
                    ui.button('FWD SLOW', color='green-6', on_click=lambda: bridge.send_raw(0x02, 1))
                    ui.button('REV SLOW', color='orange-6', on_click=lambda: bridge.send_raw(0x02, 3))
                
                ui.button('STOP / BRAKE', color='grey-9', on_click=lambda: bridge.send_raw(0x02, 0)).classes('w-full mt-2')

            # Sikkerhed
            ui.button('RESET STUCK SENSOR', on_click=lambda: bridge.send_raw(0xFF, 0)).classes('w-full').props('outline')

        # --- HØJRE KOLONNE: DATA & STATUS ---
        with ui.column().classes('w-2/3 p-4 gap-4'):
            
            # Odometer sektionen i gui.py
            with ui.card().classes('w-full bg-slate-800 p-4'):
                with ui.row().classes('items-center justify-between w-full'):
                    with ui.column():
                        ui.label('TOTAL DISTANCE').classes('text-xs text-slate-400')
                        ui.label().bind_text_from(bridge, 'odometer_int', backward=lambda x: f"{x} cm").classes('text-xl font-mono')
                    with ui.column().classes('items-end'):
                        ui.label('TOTAL PULSES').classes('text-xs text-slate-400')
                        ui.label().bind_text_from(bridge, 'total_rots').classes('text-sm font-mono text-slate-500')
                
                ui.label('⚠️ SERVICE: CHANGE THE OIL!').classes('text-red-500 font-bold text-center w-full mt-2') \
                    .bind_visibility_from(bridge, 'odometer_int', backward=lambda x: x >= 200)

            # Position sektionen i gui.py
            with ui.card().classes('items-center p-6 w-full border-2 border-blue-900'):
                ui.label('LIVE MEASURED POSITION').classes('text-xs font-bold text-slate-400')
                # RETTELSE: Brug measured_pos_int
                ui.label().bind_text_from(bridge, 'measured_pos_int', 
                    backward=lambda x: f"{x} cm").classes('text-7xl font-mono text-blue-400')

            # Graf
            line_chart = ui.echart({
                'xAxis': {'type': 'category', 'data': []},
                'yAxis': {'type': 'value', 'name': 'cm', 'min': 0, 'max': 90},
                'series': [{'data': [], 'type': 'line', 'smooth': True, 'color': '#3b82f6', 'symbol': 'none'}]
            }).classes('w-full h-64')

    def refresh_ui():
        line_chart.options['xAxis']['data'] = list(bridge.time_history)
        line_chart.options['series'][0]['data'] = list(bridge.pos_history)
        line_chart.update()

    ui.timer(0.1, refresh_ui)
