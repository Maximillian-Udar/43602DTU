error id: file:///C:/Users/maxim/43602DTU/Chisel/src/main/scala/MotorDriver.scala:photo_diode_A.
file:///C:/Users/maxim/43602DTU/Chisel/src/main/scala/MotorDriver.scala
empty definition using pc, found symbol in pc: 
empty definition using semanticdb
empty definition using fallback
non-local guesses:
	 -chisel3/io/photo_diode_A.
	 -chisel3/io/photo_diode_A#
	 -chisel3/io/photo_diode_A().
	 -chisel3/util/io/photo_diode_A.
	 -chisel3/util/io/photo_diode_A#
	 -chisel3/util/io/photo_diode_A().
	 -io/photo_diode_A.
	 -io/photo_diode_A#
	 -io/photo_diode_A().
	 -scala/Predef.io.photo_diode_A.
	 -scala/Predef.io.photo_diode_A#
	 -scala/Predef.io.photo_diode_A().
offset: 1296
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

  // --- Submodules ---
  val rx = Module(new UartRx); val tx = Module(new UartTx)
  val pwm_gen = Module(new DCMotorPwm(20000))
  val pid = Module(new PIDController(pidWidth, pidBP))
  val stuck_detector = Module(new StuckDetector)
  val disp_mux = Module(new DisplayMultiplexer)

  // --- 1. DIGITAL NOISE FILTER (0.1ms) ---
  def filter(in: Bool): Bool = {
    val sync = RegNext(RegNext(in))
    val cnt  = RegInit(0.U(14.W))
    val out  = RegInit(false.B)
    when(sync === out) { cnt := 0.U }
    .otherwise { cnt := cnt + 1.U; when(cnt === 10000.U) { out := sync } }
    out
  }
  val pulse_A = filter(io.@@photo_diode_A)
  val pulse_edge = pulse_A && !RegNext(pulse_A)

  // --- 2. INFERRED DIRECTION COUNTER & NEGATIVE PREVENTION ---
  val turns = RegInit(0.S(32.W))
  // Only count if we are driving the motor significantly (prevents noise at rest)
  val is_driving_fwd  = pwm_gen.io.duty_cycle > 540.U
  val is_driving_back = pwm_gen.io.duty_cycle < 484.U
  
  when(pulse_edge) {
    when(is_driving_fwd) { turns := turns + 1.S }
    .elsewhen(is_driving_back) { turns := turns - 1.S }
  }
  // Hard Instruction: Do not allow negative rotations
  when(turns < 0.S) { turns := 0.S }

  // Scaling: 1 pulse/rev, 7.5 revs = 1 cm
  val cmPerPulse = FixedPoint.fromDouble(1.0 / 7.5, pidWidth.W, pidBP.BP)
  val current_pos_fp = turns.asFixedPoint(0.BP) * cmPerPulse
  val current_pos_cm = (current_pos_fp >> pidBP).asSInt

  // --- 3. REGISTERS & STARTUP GUARD ---
  val target_pos_cm = RegInit(0.S(32.W)) 
  val manual_speed  = RegInit(512.U(10.W))
  val control_mode  = RegInit(false.B) 
  val manual_brake  = RegInit(true.B)  
  val system_active = RegInit(false.B) 

  rx.io.rx := io.uart_rx
  disp_mux.io.dots := 0.U
  stuck_detector.io.externalOvercurrentInput := (io.over_current_pos || io.over_current_neg)

  // UART Parser
  val sHeader :: sCmd :: sValue :: Nil = Enum(3)
  val uartState = RegInit(sHeader); val cmdByte = RegInit(0.U(8.W))
  val uart_reset = WireDefault(false.B)
  when(rx.io.done) {
    switch(uartState) {
      is(sHeader) { when(rx.io.data === 0xAA.U) { uartState := sCmd } }
      is(sCmd)    { cmdByte := rx.io.data; uartState := sValue }
      is(sValue)  {
        system_active := true.B
        switch(cmdByte) {
          is(0x01.U) { target_pos_cm := (rx.io.data * 100.U).asSInt; control_mode := true.B; manual_brake := false.B }
          is(0x02.U) { 
            control_mode := false.B; manual_brake := false.B
            switch(rx.io.data) {
              is(0.U) { manual_brake := true.B; manual_speed := 512.U }
              is(1.U) { manual_speed := 640.U }; is(2.U) { manual_speed := 950.U }
              is(3.U) { manual_speed := 380.U }; is(4.U) { manual_speed := 70.U }
              is(5.U) { manual_brake := true.B }
            }
          }
          is(0xFF.U) { uart_reset := true.B }
        }
        uartState := sHeader
      }
    }
  }
  stuck_detector.io.clearShutdown := io.error_cleared || uart_reset

  // --- 4. PID WITH STRICT DEADBAND (Stops oscillation) ---
  val error_abs = Mux(target_pos_cm > current_pos_cm, target_pos_cm - current_pos_cm, current_pos_cm - target_pos_cm)
  // If within 1cm (approx 8 pulses), stop immediately. 1-pulse systems cannot hunt for 0.1cm.
  val near_target = (control_mode && error_abs === 0.S)

  pid.io.tick        := true.B 
  pid.io.setPoint    := target_pos_cm.asFixedPoint(pidBP.BP)
  pid.io.measuredVal := current_pos_fp
  pid.io.resetBuffer := !control_mode || manual_brake || !system_active || near_target
  pid.io.kp := KP.F(pidWidth.W, pidBP.BP); pid.io.ki := KI.F(pidWidth.W, pidBP.BP); pid.io.kd := KD.F(pidWidth.W, pidBP.BP)

  val pid_duty_raw = ((pid.io.controlOut + 0.5.F(pidBP.BP)).asUInt >> (pidBP-10).U)
  val pid_duty = Mux(near_target, 512.U, Mux(pid_duty_raw > 1023.U, 1023.U, pid_duty_raw(9,0)))
  
  pwm_gen.io.duty_cycle := Mux(control_mode, pid_duty, manual_speed)
  val is_stopped = manual_brake || stuck_detector.io.motorDisable || !system_active || near_target
  pwm_gen.io.brake := is_stopped

  // HI-Z Conduct Logic
  when(!system_active) {
    io.T1 := false.B; io.T3 := false.B; io.T2 := true.B; io.T4 := true.B 
  } .otherwise {
    io.T1 := pwm_gen.io.T1; io.T2 := pwm_gen.io.T2
    io.T3 := pwm_gen.io.T3; io.T4 := pwm_gen.io.T4
  }

  // Telemetry
  val txTimer = RegInit(0.U(24.W))
  val sSync :: sHigh :: sLow :: Nil = Enum(3)
  val txState = RegInit(sSync)
  tx.io.data := 0.U; tx.io.start := false.B
  when(txTimer >= 2500000.U) {
    switch(txState) {
      is(sSync) { when(!tx.io.busy) { tx.io.data := 0xFF.U; tx.io.start := true.B; txState := sHigh } }
      is(sHigh) { when(!tx.io.busy) { tx.io.data := current_pos_cm(15, 8).asUInt; tx.io.start := true.B; txState := sLow } }
      is(sLow)  { when(!tx.io.busy) { tx.io.data := current_pos_cm(7, 0).asUInt; tx.io.start := true.B; txState := sSync; txTimer := 0.U } }
    }
  }.otherwise { txTimer := txTimer + 1.U }
  io.uart_tx := tx.io.tx

  // Display (AUTO / STOP only)
  io.an := disp_mux.io.an; io.seg := disp_mux.io.seg
  val sym_AUTO = Cat(SegSymbol.A.asUInt, SegSymbol.U.asUInt, SegSymbol.T.asUInt, SegSymbol.O.asUInt)
  val sym_STOP = Cat(SegSymbol.S.asUInt, SegSymbol.T.asUInt, SegSymbol.O.asUInt, SegSymbol.P.asUInt)
  disp_mux.io.disp_content := Mux(is_stopped, sym_STOP, sym_AUTO)
}
```


#### Short summary: 

empty definition using pc, found symbol in pc: 