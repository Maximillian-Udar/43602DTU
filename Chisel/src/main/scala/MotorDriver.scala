import chisel3._
import chisel3.util._
import chisel3.experimental.FixedPoint

class MotorDriver(KP : Int, KI: Int, KD: Int) extends Module {
    val io = IO(new Bundle{
        val uart_rx          = Input(Bool())
        val photo_diode_A    = Input(Bool())
        val photo_diode_B    = Input(Bool())
        val over_current_pos = Input(Bool())
        val over_current_neg = Input(Bool())
        val error_cleared    = Input(Bool())
        val uart_tx          = Output(Bool())
        val T1               = Output(Bool()) 
        val T2               = Output(Bool()) 
        val T3               = Output(Bool()) 
        val T4               = Output(Bool()) 
        val seg              = Output(UInt(8.W))
        val an               = Output(UInt(4.W))
    })

    val pidWidth = 32
    val pidBP    = 12

    // Modules
    val rx                   = Module(new UartRx)
    val tx                   = Module(new UartTx)
    val rotation_counter     = Module(new RotationCounter)
    val pwm_gen              = Module(new DCMotorPwm(25000))
    val pid                  = Module(new PIDController(pidWidth, pidBP))
    val stuck_detector       = Module(new StuckDetector)
    val disp_mux             = Module(new DisplayMultiplexer)
    val filter_A             = Module(new Debouncer(50)) 
    val filter_B             = Module(new Debouncer(50))
    val error_clear_debounce = Module(new Debouncer)

    // State Registers
    val target_position = RegInit(0.U(8.W))
    val manual_speed    = RegInit(512.U(10.W))
    val control_mode    = RegInit(true.B)
    val manual_brake    = RegInit(true.B)

    // UART
    rx.io.rx := io.uart_rx
    val sHeader :: sCmd :: sValue :: Nil = Enum(3)
    val uartState = RegInit(sHeader)
    val cmdByte   = RegInit(0.U(8.W))

    when(rx.io.done) {
        switch(uartState) {
            is(sHeader) {
                when(rx.io.data === 0xAA.U) { uartState := sCmd }
            }
            is(sCmd) {
                cmdByte   := rx.io.data
                uartState := sValue
            }
            is(sValue) {
                switch(cmdByte) {
                    is(0x01.U) { // Position Command
                        target_position := rx.io.data
                        control_mode    := true.B
                        manual_brake    := false.B
                    }
                    is(0x02.U) { // Manual Command
                        control_mode := false.B
                        manual_brake := false.B
                        switch(rx.io.data) {
                            is(0.U) { manual_speed := 512.U; manual_brake := true.B }
                            is(1.U) { manual_speed := 640.U } // Slow Fwd
                            is(2.U) { manual_speed := 950.U } // Fast Fwd
                            is(3.U) { manual_speed := 380.U } // Slow Back
                            is(4.U) { manual_speed := 70.U  } // Fast Back
                            is(5.U) { manual_brake := true.B } // Hard Brake
                        }
                    }
                }
                uartState := sHeader
            }
        }
    }

    // Sensors
    filter_A.io.btn_in := io.photo_diode_A
    filter_B.io.btn_in := io.photo_diode_B
    rotation_counter.io.signal_A := filter_A.io.state
    rotation_counter.io.signal_B := filter_B.io.state
    val current_pos_m = (rotation_counter.io.turns * 1398.U) >> 20
    val current_pos_cm = (rotation_counter.io.turns * 136.U) >> 10

    // PID Control
    pid.io.setPoint    := target_position.asFixedPoint(pidBP.BP)
    pid.io.measuredVal := current_pos_m.asFixedPoint(pidBP.BP)
    pid.io.resetBuffer := !control_mode || manual_brake
    pid.io.kp := (KP).F(pidWidth.W, pidBP.BP)
    pid.io.ki := (KI).F(pidWidth.W, pidBP.BP)
    pid.io.kd := (KD).F(pidWidth.W, pidBP.BP)

    val half_const = FixedPoint.fromDouble(0.5, pidWidth.W, pidBP.BP)
    val pid_duty_shifted = pid.io.controlOut + half_const
    val pid_duty = (pid_duty_shifted.asUInt >> (pidBP - 10).U)(9, 0)

    // Brake Logic
    error_clear_debounce.io.btn_in := io.error_cleared
    stuck_detector.io.externalOvercurrentInput := (io.over_current_pos || io.over_current_neg)
    stuck_detector.io.clearShutdown := ((rx.io.done && cmdByte === 0xFF.U) || error_clear_debounce.io.out)

    val brake_active = (stuck_detector.io.motorDisable || manual_brake)
    
    pwm_gen.io.duty_cycle := Mux(control_mode, pid_duty, manual_speed)
    pwm_gen.io.brake      := brake_active

    // Outputs
    io.T1 := pwm_gen.io.T1
    io.T2 := pwm_gen.io.T2
    io.T3 := pwm_gen.io.T3
    io.T4 := pwm_gen.io.T4

    // Display
    io.an := disp_mux.io.an
    io.seg := disp_mux.io.seg
    disp_mux.io.dots := "b0000".U
    when (brake_active) {
        disp_mux.io.disp_content := Cat(SegSymbol.S.asUInt, SegSymbol.T.asUInt, SegSymbol.O.asUInt, SegSymbol.P.asUInt)
    } .otherwise {
        val modeLabel = Mux(control_mode, 
                            Cat(SegSymbol.A.asUInt, SegSymbol.U.asUInt, SegSymbol.T.asUInt, SegSymbol.O.asUInt),
                            Cat(SegSymbol.Blank.asUInt, SegSymbol.M.asUInt, SegSymbol.A.asUInt, SegSymbol.N.asUInt))
        disp_mux.io.disp_content := modeLabel
    }

    // Telemetry
    val txTimer = RegInit(0.U(24.W))
    tx.io.data  := current_pos_cm(7,0)
    tx.io.start := false.B
    when(txTimer >= 5000000.U) {
        when(!tx.io.busy) { tx.io.start := true.B; txTimer := 0.U }
    }.otherwise { txTimer := txTimer + 1.U }
    io.uart_tx := tx.io.tx
}