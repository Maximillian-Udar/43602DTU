error id: file:///C:/Users/maxim/43602DTU/Chisel/src/main/scala/MotorDriver.scala:clearShutdown.
file:///C:/Users/maxim/43602DTU/Chisel/src/main/scala/MotorDriver.scala
empty definition using pc, found symbol in pc: 
empty definition using semanticdb
empty definition using fallback
non-local guesses:
	 -chisel3/stuck_detector/io/clearShutdown.
	 -chisel3/stuck_detector/io/clearShutdown#
	 -chisel3/stuck_detector/io/clearShutdown().
	 -chisel3/util/stuck_detector/io/clearShutdown.
	 -chisel3/util/stuck_detector/io/clearShutdown#
	 -chisel3/util/stuck_detector/io/clearShutdown().
	 -stuck_detector/io/clearShutdown.
	 -stuck_detector/io/clearShutdown#
	 -stuck_detector/io/clearShutdown().
	 -scala/Predef.stuck_detector.io.clearShutdown.
	 -scala/Predef.stuck_detector.io.clearShutdown#
	 -scala/Predef.stuck_detector.io.clearShutdown().
offset: 2926
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

  // --- Submodule Instances ---
  val rx               = Module(new UartRx)
  val tx               = Module(new UartTx)
  val rotation_counter = Module(new RotationCounter)
  val pwm_gen          = Module(new DCMotorPwm(20000))
  val pid              = Module(new PIDController(pidWidth, pidBP))
  val stuck_detector   = Module(new StuckDetector)
  val disp_mux         = Module(new DisplayMultiplexer)

  // --- Registers ---
  val target_pos_cm = RegInit(0.S(32.W)) 
  val manual_speed  = RegInit(512.U(10.W))
  val control_mode  = RegInit(false.B) 
  val manual_brake  = RegInit(true.B)  

  // --- 1. FIRRTL INITIALIZATION FIX (Wiring everything) ---
  rx.io.rx := io.uart_rx
  rotation_counter.io.signal_A := io.photo_diode_A
  rotation_counter.io.signal_B := io.photo_diode_B
  disp_mux.io.dots := 0.U
  
  // Connect Stuck Detector to prevent VOID error
  // If your system locks in STOP, change this line to false.B for testing
  stuck_detector.io.externalOvercurrentInput := (io.over_current_pos || io.over_current_neg)
  
  // --- Scaling Math (1 Pulse/Rev, 7.5 Revs/CM) ---
  // Distance = turns / 7.5. Using fixed point for PID precision.
  val cmPerPulse = FixedPoint.fromDouble(1.0 / 7.5, pidWidth.W, pidBP.BP)
  val current_pos_fp = rotation_counter.io.turns.asFixedPoint(0.BP) * cmPerPulse
  val current_pos_cm = current_pos_fp.asSInt

  // --- UART Parser ---
  val sHeader :: sCmd :: sValue :: Nil = Enum(3)
  val uartState = RegInit(sHeader)
  val cmdByte   = RegInit(0.U(8.W))
  val reset_triggered = WireDefault(false.B)

  when(rx.io.done) {
    switch(uartState) {
      is(sHeader) { when(rx.io.data === 0xAA.U) { uartState := sCmd } }
      is(sCmd)    { cmdByte := rx.io.data; uartState := sValue }
      is(sValue)  {
        switch(cmdByte) {
          is(0x01.U) { target_pos_cm := (rx.io.data * 100.U).asSInt; control_mode := true.B; manual_brake := false.B }
          is(0x02.U) { control_mode := false.B; manual_brake := false.B; 
                       switch(rx.io.data) { is(0.U){manual_brake:=true.B}; is(1.U){manual_speed:=650.U} } }
          is(0xFF.U) { reset_triggered := true.B }
        }
        uartState := sHeader
      }
    }
  }
  
  stuck_detector.io.clea@@rShutdown := io.error_cleared || reset_triggered

  // --- PID & PWM ---
  pid.io.tick        := true.B 
  pid.io.setPoint    := target_pos_cm.asFixedPoint(pidBP.BP)
  pid.io.measuredVal := current_pos_fp
  pid.io.resetBuffer := !control_mode || manual_brake
  pid.io.kp := KP.F(pidWidth.W, pidBP.BP); pid.io.ki := KI.F(pidWidth.W, pidBP.BP); pid.io.kd := KD.F(pidWidth.W, pidBP.BP)

  val pid_duty = ( (pid.io.controlOut + 0.5.F(pidBP.BP)).asUInt >> (pidBP-10).U )(9,0)
  pwm_gen.io.duty_cycle := Mux(control_mode, pid_duty, manual_speed)
  pwm_gen.io.brake      := manual_brake || stuck_detector.io.motorDisable || io.over_current_pos || io.over_current_neg
  
  io.T1 := pwm_gen.io.T1; io.T2 := pwm_gen.io.T2; io.T3 := pwm_gen.io.T3; io.T4 := pwm_gen.io.T4

  // --- Telemetry [0xFF, High, Low] ---
  val txTimer = RegInit(0.U(24.W))
  val sSync :: sHigh :: sLow :: Nil = Enum(3)
  val txState = RegInit(sSync)
  tx.io.data := 0.U; tx.io.start := false.B
  when(txTimer >= 2000000.U) {
    switch(txState) {
      is(sSync) { when(!tx.io.busy) { tx.io.data := 0xFF.U; tx.io.start := true.B; txState := sHigh } }
      is(sHigh) { when(!tx.io.busy) { tx.io.data := current_pos_cm(15, 8).asUInt; tx.io.start := true.B; txState := sLow } }
      is(sLow)  { when(!tx.io.busy) { tx.io.data := current_pos_cm(7, 0).asUInt; tx.io.start := true.B; txState := sSync; txTimer := 0.U } }
    }
  }.otherwise { txTimer := txTimer + 1.U }
  io.uart_tx := tx.io.tx

  // --- Display ---
  io.an := disp_mux.io.an; io.seg := disp_mux.io.seg
  disp_mux.io.disp_content := Mux(stuck_detector.io.motorDisable, 0x570F5.U, current_pos_cm(15,0).asUInt)
}
```


#### Short summary: 

empty definition using pc, found symbol in pc: 