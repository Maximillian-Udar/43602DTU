import chisel3._
import chisel3.util._
import chisel3.experimental.FixedPoint

class MotorDriver(KP: Double, KI: Double, KD: Double) extends Module {
  val io = IO(new Bundle {
    val uart_rx          = Input(Bool())
    val photo_sensor_A    = Input(Bool())
    val photo_sensor_B    = Input(Bool())
    val over_current_positive = Input(Bool())
    val over_current_negative = Input(Bool())
    val error_cleared    = Input(Bool())
    val uart_tx          = Output(Bool())
    val T1, T2, T3, T4   = Output(Bool())
    val seg              = Output(UInt(8.W))
    val an               = Output(UInt(4.W))
  })

  val pidWidth = 32
  val pidBP    = 12

  def filter(in: Bool): Bool = {
    val sync = in
    val cnt  = RegInit(0.U(14.W))
    val out  = RegInit(false.B)
    when(sync === out) { cnt := 0.U }
    .otherwise { cnt := cnt + 1.U; when(cnt === 100.U) { out := sync } }
    out
  }

  val rx               = Module(new UartRx)
  val tx               = Module(new UartTx)
  val rotation_counter = Module(new RotationCounter)
  val pwm_gen          = Module(new DCMotorPwm(20000))
  val pid              = Module(new PIDController(pidWidth, pidBP))
  val stuck_detector   = Module(new StuckDetector)
  val disp_mux         = Module(new DisplayMultiplexer)


  // Registers
  val target_pos_cm = RegInit(0.S(32.W)) 
  val manual_speed  = RegInit(512.U(10.W))
  val control_mode  = RegInit(true.B)
  val manual_brake  = RegInit(true.B) 
  val turns = rotation_counter.io.turns

  // --- UART Parser (Header 0xAA -> Cmd -> Value) ---
  rx.io.rx := io.uart_rx
  val sHeader :: sCmd :: sValue :: Nil = Enum(3)
  val uartState = RegInit(sHeader)
  val cmdByte   = RegInit(0.U(8.W))
  val pid_timer = RegInit(0.U(17.W))
  val pid_tick  = pid_timer === 99999.U
  pid.io.tick := true.B

  when(pid_tick) {
    pid_timer := 0.U
  } .otherwise {
    pid_timer := pid_timer + 1.U
  }

  when(rx.io.done) {
    switch(uartState) {
      is(sHeader) { when(rx.io.data === 0xAA.U) { uartState := sCmd } }
      is(sCmd)    { cmdByte := rx.io.data; uartState := sValue }
      is(sValue)  {
        switch(cmdByte) {
          is(0x01.U) { // Meters to CM
            target_pos_cm := (rx.io.data * 100.U).asSInt
            control_mode  := true.B
            manual_brake  := false.B
          }
          is(0x02.U) { 
            control_mode := false.B
            manual_brake := false.B
            switch(rx.io.data) {
              is(0.U) { manual_speed := 512.U; manual_brake := true.B }
              is(1.U) { manual_speed := 640.U }
              is(2.U) { manual_speed := 800.U }
              is(3.U) { manual_speed := 380.U }
              is(4.U) { manual_speed := 170.U  }
              is(5.U) { manual_brake := true.B }
            }
          }
        }
        uartState := sHeader
      }
    }
  }

  // --- Encoder Math ---
  rotation_counter.io.signal_A := filter(io.photo_sensor_A)
  rotation_counter.io.signal_B := filter(io.photo_sensor_B)
  // (Turns * 136) / 1024 = Signed CM
  
  val current_pos_cm = (turns * 136.S) >> 10

  // --- PID Control ---
  pid.io.setPoint    := target_pos_cm.asFixedPoint(pidBP.BP)
  pid.io.measuredVal := current_pos_cm.asFixedPoint(pidBP.BP)
  pid.io.resetBuffer := !control_mode || manual_brake
  
  // These now accept the Double values from the constructor
  pid.io.kp := KP.F(pidWidth.W, pidBP.BP)
  pid.io.ki := KI.F(pidWidth.W, pidBP.BP)
  pid.io.kd := KD.F(pidWidth.W, pidBP.BP)

  val half_const = FixedPoint.fromDouble(0.5, pidWidth.W, pidBP.BP)  
  val pid_duty_shifted = pid.io.controlOut + half_const
  val raw_duty = (pid_duty_shifted.asUInt >> (pidBP - 10).U)
  val pid_duty = Mux(raw_duty > 1023.U, 1023.U, raw_duty(9, 0))

  // --- Safety & Output ---
  stuck_detector.io.external_overcurrent_input := (io.over_current_positive || io.over_current_negative)
  stuck_detector.io.clear_shutdown := ((rx.io.done && cmdByte === 0xFF.U) || io.error_cleared)

  val brake_active = (stuck_detector.io.motor_disable || manual_brake)
  pwm_gen.io.duty_cycle := Mux(control_mode, pid_duty, manual_speed)
  pwm_gen.io.brake      := brake_active

  io.T1 := pwm_gen.io.T1; io.T2 := pwm_gen.io.T2
  io.T3 := pwm_gen.io.T3; io.T4 := pwm_gen.io.T4

  // --- 16-bit Signed Telemetry (Prevents wrap-around) ---
  val txTimer = RegInit(0.U(24.W))
  val sTxHigh :: sTxLow :: Nil = Enum(2)
  val txState = RegInit(sTxHigh)
  tx.io.data := 0.U; tx.io.start := false.B
  when(txTimer >= 5000000.U) {
    switch(txState) {
      is(sTxHigh) {
        when(!tx.io.busy) {
          tx.io.data := current_pos_cm(15, 8).asUInt
          tx.io.start := true.B
          txState := sTxLow
        }
      }
      is(sTxLow) {
        when(!tx.io.busy) {
          tx.io.data := current_pos_cm(7, 0).asUInt
          tx.io.start := true.B
          txState := sTxHigh
          txTimer := 0.U
        }
      }
    }
  }.otherwise { txTimer := txTimer + 1.U }
  io.uart_tx := tx.io.tx

  // Display
  io.an := disp_mux.io.an; io.seg := disp_mux.io.seg
  disp_mux.io.dots := "b0000".U
  disp_mux.io.disp_content := Mux(brake_active, 
    Cat(SegSymbol.S.asUInt, SegSymbol.T.asUInt, SegSymbol.O.asUInt, SegSymbol.P.asUInt),
    Mux(control_mode, Cat(SegSymbol.A.asUInt, SegSymbol.U.asUInt, SegSymbol.T.asUInt, SegSymbol.O.asUInt),
                      Cat(SegSymbol.Blank.asUInt, SegSymbol.Blank.asUInt, SegSymbol.Blank.asUInt, SegSymbol.Blank.asUInt)))
}