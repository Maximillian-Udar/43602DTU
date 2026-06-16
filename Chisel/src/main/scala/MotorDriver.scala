import chisel3._
import chisel3.util._
import chisel3.experimental.FixedPoint

class MotorDriver extends Module {
    val io = IO(new Bundle{
        // Inputs
        val uart_rx          = Input(Bool())
        val photo_diode_A    = Input(Bool())
        val photo_diode_B    = Input(Bool())
        val over_current_pos = Input(Bool())
        val over_current_neg = Input(Bool())
        val error_cleared    = Input(Bool())
        // Outputs
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

    val rx                   = Module(new UartRx)
    val tx                   = Module(new UartTx)
    val rotation_counter     = Module(new RotationCounter)
    val pwm_gen              = Module(new DCMotorPwm)
    val pid                  = Module(new PIDController(pidWidth, pidBP))
    val stuck_detector       = Module(new StuckDetector)
    val disp_mux             = Module(new DisplayMultiplexer)
    val error_clear_debounce = Module(new Debouncer)

    error_clear_debounce.io.btn_in := io.error_cleared

    disp_mux.io.dots := "b0000".U
    disp_mux.io.disp_content := Cat(SegSymbol.Blank.asUInt, SegSymbol.Blank.asUInt, SegSymbol.Blank.asUInt, SegSymbol.Blank.asUInt)
    pwm_gen.io.brake := false.B 
    
    io.an := disp_mux.io.an
    io.seg := disp_mux.io.seg

    val target_position = RegInit(0.U(8.W))
    val manual_speed    = RegInit(512.U(10.W))
    val control_mode    = RegInit(false.B)
    val manual_brake    = RegInit(false.B)     

    rx.io.rx := io.uart_rx
    val cmdByte = RegInit(0.U(8.W))
    val isValueByte = RegInit(false.B)

    when(rx.io.done) {
        when(!isValueByte) {
            cmdByte := rx.io.data
            isValueByte := true.B
        }.otherwise {
            switch(cmdByte) {
                is(0x01.U) { 
                    target_position := rx.io.data
                    control_mode := true.B
                    manual_brake := false.B
                }
                is(0x02.U) { 
                    control_mode := false.B
                    switch(rx.io.data) {
                        is(0.U) { manual_speed := 512.U; manual_brake := false.B }
                        is(1.U) { manual_speed := 650.U; manual_brake := false.B }
                        is(2.U) { manual_speed := 900.U; manual_brake := false.B }
                        is(3.U) { manual_speed := 374.U; manual_brake := false.B }
                        is(4.U) { manual_speed := 124.U; manual_brake := false.B }
                        is(5.U) { manual_brake := true.B }
                    }
                }
            }
            isValueByte := false.B
        }
    }

    rotation_counter.io.signal_A := io.photo_diode_A
    rotation_counter.io.signal_B := io.photo_diode_B
    
    val current_pos_m = (rotation_counter.io.turns * 1398.U) >> 20

    pid.io.setPoint    := target_position.asFixedPoint(pidBP.BP)
    pid.io.measuredVal := current_pos_m.asFixedPoint(pidBP.BP)
    pid.io.resetBuffer := !control_mode || manual_brake
    
    pid.io.kp := 80.F(pidWidth.W, pidBP.BP)
    pid.io.ki := 0.F(pidWidth.W, pidBP.BP)
    pid.io.kd := 1.F(pidWidth.W, pidBP.BP)

    val half_const = FixedPoint.fromDouble(0.5, pidWidth.W, pidBP.BP)
    val pid_duty_shifted = pid.io.controlOut + half_const
    val pid_duty = (pid_duty_shifted.asUInt >> 2)(9, 0)

    stuck_detector.io.externalOvercurrentInput := (io.over_current_pos || io.over_current_neg)
    stuck_detector.io.clearShutdown            := ((rx.io.done && cmdByte === 0xFF.U) || error_clear_debounce.io.out)

    pwm_gen.io.duty_cycle := Mux(control_mode, pid_duty, manual_speed)
    val brake_active = (stuck_detector.io.motorDisable || manual_brake)
    
    pwm_gen.io.brake := brake_active

    when (brake_active) {
        disp_mux.io.disp_content := Cat(SegSymbol.S.asUInt, SegSymbol.T.asUInt, SegSymbol.O.asUInt, SegSymbol.P.asUInt)
    }

    io.T1 := pwm_gen.io.T1
    io.T2 := pwm_gen.io.T2
    io.T3 := pwm_gen.io.T3
    io.T4 := pwm_gen.io.T4

    val txTimer = RegInit(0.U(24.W))
    tx.io.data  := current_pos_m(7,0)
    tx.io.start := false.B
    when(txTimer >= 10000000.U) {
        when(!tx.io.busy) {
            tx.io.start := true.B
            txTimer := 0.U
        }
    }.otherwise { txTimer := txTimer + 1.U }
    io.uart_tx := tx.io.tx
}