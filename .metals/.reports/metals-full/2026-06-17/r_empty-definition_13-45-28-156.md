error id: file:///C:/Users/maxim/43602DTU/Chisel/src/main/scala/MotorDriver.scala:_empty_/MotorDriver#Nil.
file:///C:/Users/maxim/43602DTU/Chisel/src/main/scala/MotorDriver.scala
empty definition using pc, found symbol in pc: 
empty definition using semanticdb
empty definition using fallback
non-local guesses:
	 -chisel3/Nil.
	 -chisel3/Nil#
	 -chisel3/Nil().
	 -chisel3/util/Nil.
	 -chisel3/util/Nil#
	 -chisel3/util/Nil().
	 -Nil.
	 -Nil#
	 -Nil().
	 -scala/Predef.Nil.
	 -scala/Predef.Nil#
	 -scala/Predef.Nil().
offset: 4063
uri: file:///C:/Users/maxim/43602DTU/Chisel/src/main/scala/MotorDriver.scala
text:
```scala
import chisel3._
import chisel3.util._
import chisel3.experimental.FixedPoint

class MotorDriver(KP: Double, KI: Double, KD: Double) extends Module {
  val io = IO(new Bundle {
    val uart_rx          = Input(Bool())
    val photo_diode_A    = Input(Bool())
    val photo_diode_B    = Input(Bool())
    val over_current_pos = Input(Bool())
    val over_current_neg = Input(Bool())
    val error_cleared    = Input(Bool())
    val uart_tx          = Output(Bool())
    val T1, T2, T3, T4   = Output(Bool())
    val seg              = Output(UInt(8.W))
    val an               = Output(UInt(4.W))
  })

  val pidWidth = 32
  val pidBP    = 12

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

  // --- UART Parser ---
  rx.io.rx := io.uart_rx
  val sHeader :: sCmd :: sValue :: Nil = Enum(3)
  val uartState = RegInit(sHeader)
  val cmdByte   = RegInit(0.U(8.W))

  when(rx.io.done) {
    switch(uartState) {
      is(sHeader) { when(rx.io.data === 0xAA.U) { uartState := sCmd } }
      is(sCmd)    { cmdByte := rx.io.data; uartState := sValue }
      is(sValue)  {
        switch(cmdByte) {
          is(0x01.U) { // Automatic Mode
            target_pos_cm := (rx.io.data * 100.U).asSInt
            control_mode  := true.B
            manual_brake  := false.B
          }
          is(0x02.U) { // Manual Mode
            control_mode := false.B
            manual_brake := false.B
            switch(rx.io.data) {
              is(0.U) { manual_speed := 512.U; manual_brake := true.B }
              is(1.U) { manual_speed := 640.U }
              is(2.U) { manual_speed := 950.U }
              is(3.U) { manual_speed := 380.U }
              is(4.U) { manual_speed := 70.U  }
              is(5.U) { manual_brake := true.B }
            }
          }
        }
        uartState := sHeader
      }
    }
  }

  // --- Encoder Math ---
  rotation_counter.io.signal_A := io.photo_diode_A
  rotation_counter.io.signal_B := io.photo_diode_B
  val current_pos_cm = (rotation_counter.io.turns * 136.S) >> 10

  // --- PID Control ---
  pid.io.setPoint    := target_pos_cm.asFixedPoint(pidBP.BP)
  pid.io.measuredVal := current_pos_cm.asFixedPoint(pidBP.BP)
  pid.io.resetBuffer := !control_mode || manual_brake
  pid.io.kp := KP.F(pidWidth.W, pidBP.BP)
  pid.io.ki := KI.F(pidWidth.W, pidBP.BP)
  pid.io.kd := KD.F(pidWidth.W, pidBP.BP)

  // Shift PID (-0.5 to 0.5) to (0.0 to 1.0) for PWM
  val half_const = FixedPoint.fromDouble(0.5, pidWidth.W, pidBP.BP)
  val pid_duty_shifted = pid.io.controlOut + half_const
  
  // FIXED: Multiply by 1024 and CLAMP to prevent wrap-around at 1.0
  val raw_duty = (pid_duty_shifted.asUInt >> (pidBP - 10).U)
  val pid_duty = Mux(raw_duty > 1023.U, 1023.U, raw_duty(9, 0))

  // --- Safety & Output ---
  stuck_detector.io.externalOvercurrentInput := (io.over_current_pos || io.over_current_neg)
  
  // FIXED: Clear shutdown when ANY new command (p, m, or r) is received
  stuck_detector.io.clearShutdown := (io.error_cleared || 
                                     (rx.io.done && (cmdByte === 0xFF.U || cmdByte === 0x01.U || cmdByte === 0x02.U)))

  val brake_active = (stuck_detector.io.motorDisable || manual_brake)
  pwm_gen.io.duty_cycle := Mux(control_mode, pid_duty, manual_speed)
  pwm_gen.io.brake      := brake_active

  io.T1 := pwm_gen.io.T1; io.T2 := pwm_gen.io.T2
  io.T3 := pwm_gen.io.T3; io.T4 := pwm_gen.io.T4

  // --- Telemetry ---
  val txTimer = RegInit(0.U(24.W))
  val sTxHigh :: sTxLow :: N@@il = Enum(2)
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
```


#### Short summary: 

empty definition using pc, found symbol in pc: 