import chisel3._
import chisel3.util._
import chisel3.experimental.FixedPoint

class MotorDriver(scale_down: Int = 100) extends Module {
    val io = IO(new Bundle{
        val uart_rx        = Input(Bool())
        val uart_tx        = Output(Bool())
        val photo_diode_A  = Input(Bool())
        val photo_diode_B  = Input(Bool())
        val over_current   = Input(Bool())
        
        val T1 = Output(Bool()) 
        val T2 = Output(Bool()) 
        val T3 = Output(Bool()) 
        val T4 = Output(Bool()) 
    })

    // --- 1. Module Instantiation ---
    val rx               = Module(new UartRx(100000000, 115200))
    val tx               = Module(new UartTx(100000000, 115200))
    val rotation_counter = Module(new RotationCounter)
    val pwm_gen          = Module(new DCMotorPwm(30000))
    val pid              = Module(new PIDController(16, 12))
    val stuck_detector   = Module(new StuckDetector(200)) // 200ms allowance

    // --- 2. Control Registers ---
    val target_position = RegInit(0.U(8.W))    // Target in meters (0-90)
    val manual_speed    = RegInit(512.U(10.W)) // 512 = 50% = Stop in Lock Anti-Phase
    val control_mode    = RegInit(false.B)     // false = Manual, true = PID
    val manual_brake    = RegInit(false.B)     

    // --- 3. UART Command Parser (2-Byte Protocol) ---
    rx.io.rx := io.uart_rx
    val cmdByte = RegInit(0.U(8.W))
    val isValueByte = RegInit(false.B)

    when(rx.io.done) {
        when(!isValueByte) {
            cmdByte := rx.io.data
            isValueByte := true.B
        }.otherwise {
            switch(cmdByte) {
                is(0x01.U) { // Command: Set Target Position (Automatic Mode)
                    target_position := rx.io.data
                    control_mode := true.B
                    manual_brake := false.B
                }
                is(0x02.U) { // Command: Set Manual Movement
                    control_mode := false.B
                    switch(rx.io.data) {
                        is(0.U) { manual_speed := 512.U; manual_brake := false.B } // Stop
                        is(1.U) { manual_speed := 650.U; manual_brake := false.B } // Slow Fwd
                        is(2.U) { manual_speed := 900.U; manual_brake := false.B } // Fast Fwd
                        is(3.U) { manual_speed := 350.U; manual_brake := false.B } // Slow Back
                        is(4.U) { manual_speed := 100.U; manual_brake := false.B } // Fast Back
                        is(5.U) { manual_brake := true.B }                         // Brake
                    }
                }
                is(0xFF.U) { // Command: Reset Stuck Status
                    // Handled by clearShutdown wiring below
                }
            }
            isValueByte := false.B
        }
    }

    // --- 4. Feedback Processing ---
    rotation_counter.io.signal_A := io.photo_diode_A
    rotation_counter.io.signal_B := io.photo_diode_B
    

    val scaled_turns = RegNext(rotation_counter.io.turns * 1398.U)
    val current_pos_m = RegNext(scaled_turns >> 20)

    // --- 5. PID Control Logic ---
    pid.io.setPoint    := target_position.asFixedPoint(12.BP)
    pid.io.measuredVal := current_pos_m.asFixedPoint(12.BP)
    pid.io.resetBuffer := !control_mode || manual_brake
    
    // Default Gains (can be made adjustable via UART if needed)
    pid.io.kp := 10.F(12.BP)
    pid.io.ki := 1.F(12.BP)
    pid.io.kd := 0.F(12.BP)

    // Scaling PID output (FixedPoint 12-bit frac) to 10-bit PWM (0-1023)
    // 0.5 (Stop) in PID is 2048 raw. Right shift by 2 gives 512.
    val pid_duty_raw = (pid.io.controlOut.asUInt >> 2)
    val pid_duty     = Mux(pid_duty_raw > 1023.U, 1023.U, pid_duty_raw(9,0))

    // --- 6. Safety & H-Bridge Driving ---
    stuck_detector.io.externalOvercurrentInput := io.over_current
    stuck_detector.io.clearShutdown := (rx.io.done && cmdByte === 0xFF.U)

    // Select source for duty cycle
    pwm_gen.io.duty_cycle := RegNext(Mux(control_mode, pid_duty, manual_speed))
    
    // Safety Brake triggers on hardware over-current OR manual command
    pwm_gen.io.brake := manual_brake || stuck_detector.io.motorDisable

    // Drive physical gates
    io.T1 := pwm_gen.io.T1
    io.T2 := pwm_gen.io.T2
    io.T3 := pwm_gen.io.T3
    io.T4 := pwm_gen.io.T4


    val txTimer = RegInit(0.U(24.W))
    tx.io.data  := current_pos_m
    tx.io.start := false.B
    
    when(txTimer >= 10000000.U) {
        when(!tx.io.busy) {
            tx.io.start := true.B
            txTimer := 0.U
        }
    }.otherwise {
        txTimer := txTimer + 1.U
    }
    io.uart_tx := tx.io.tx
}