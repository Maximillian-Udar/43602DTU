error id: file://<WORKSPACE>/Chisel/src/main/scala/SecondDriver.scala:
file://<WORKSPACE>/Chisel/src/main/scala/SecondDriver.scala
empty definition using pc, found symbol in pc: 
empty definition using semanticdb
empty definition using fallback
non-local guesses:
	 -chisel3/sSync.
	 -chisel3/sSync#
	 -chisel3/sSync().
	 -chisel3/util/sSync.
	 -chisel3/util/sSync#
	 -chisel3/util/sSync().
	 -sSync.
	 -sSync#
	 -sSync().
	 -scala/Predef.sSync.
	 -scala/Predef.sSync#
	 -scala/Predef.sSync().
offset: 5319
uri: file://<WORKSPACE>/Chisel/src/main/scala/SecondDriver.scala
text:
```scala
import chisel3._
import chisel3.util._
import chisel3.experimental.FixedPoint

class SecondDriver(Kp: Double, Ki: Double, Kd: Double) extends Module {
  val io = IO(new Bundle {
    // Inputs
    val uart_rx = Input(Bool())
    val photo_sensor_A = Input(Bool())
    val photo_sensor_B = Input(Bool())
    val over_current_positive = Input(Bool())
    val over_current_negative = Input(Bool())
    val error_cleared = Input(Bool())
    // Outputs
    val uart_tx = Output(Bool())
    val T1 = Output(Bool())
    val T2 = Output(Bool())
    val T3 = Output(Bool())
    val T4 = Output(Bool())
    val seg = Output(UInt(8.W))
    val an = Output(UInt(4.W))
  })
  // total width of a number
  val pidWidth = 32
  // Where is the decimal point
  val pidDP = 12

  // Modules
  val rx = Module(new UartRx)
  val tx = Module(new UartTx)
  val pwm_signal = Module(new DCMotorPWM(22000))
  val pid = Module(new PIDController(pidWidth, pidDP))
  val stuck_detector = Module(new StuckDetector)
  val display = Module(new DisplayMultiplexer)
  val rotations = Module(new RotationCounter)

  // Functions
  def filter(in: Bool): Bool = {
    val sync = RegNext(RegNext(in))
    val cnt  = RegInit(0.U(14.W))
    val out  = RegInit(false.B)
    when(sync === out) { cnt := 0.U }
    .otherwise { cnt := cnt + 1.U when(cnt === 10000.U) { out := sync } }
    out
  }

  // Wiring modules
  rx.io.rx := io.uart_rx
  rotations.io.signal_A := filter(io.photo_diode_A)
  rotations.io.signal_B := filter(io.photo_diode_B)
  display.io.dots := 0.U
  stuck_detector.io.external_overcurrent_input := (io.over_current_positive|| io.over_current_negative)
    // PID tick
  val pid_timer = RegInit(0.U(17.W))
  val pid_tick  = pid_timer === 99999.U

  when(pid_tick) {
    pid_timer := 0.U
  } .otherwise {
    pid_timer := pid_timer + 1.U
  }

  // Position scaling
  val cm_per_pulse = FixedPoint.fromDouble(1.0, 7.5, pidWidth.W, pidDP.BP)
  val current_position_fixed_point = rotations.io.turns.asFixedPoint(0.BP) * cm_per_pulse
  val current_position_cm = (current_position_fixed_point >> pidDP).asSInt

  // Registers
  val target_position_cm = RegInit(0.S(32.W))
  val manual_speed = RegInit(512.U(10.W))
  val control_mode = RegInit(true.B)
  val manual_brake = RegInit(true.B)

  // UART commands
  val sHeader :: sCMD :: sValue :: Nil = Enum(3)
  val uartState = RegInit(sHeader)
  val CMDByte = RegInit(0.U(8.W))
  val reset_triggered = WireDefault(false.B)

  when (rx.io.done) {
    switch (uartState){
      is(sHeader) { when(rx.io.data === 0xAA.U) { uartState := sCMD}}
      is(sCMD) { CMDByte := rx.io.data; uartState := sValue}
      is(sValue) {
        switch(CMDByte) {
          is(0x01.U) { target_position_cm := (rx.io.data * 100.U).asSInt }
          is(0x02.U) { 
            control_mode := false.B
            manual_brake := false.B
            switch(rx.io.data) {
              // MAYBE ADD MANUAL BRAKE??
              is(0.U) { manual_speed := 512.U } //; manual_brake := true.B}
              is(1.U) { manual_speed := 640.U } // s_fwd
              is(2.U) { manual_speed := 750.U } // f_fwd
              is(3.U) { manual_speed := 380.U } // s_back
              is(4.U) { manual_speed := 270.U } // f_back
              is(5.U) { manual_brake := true.B }
            }
            }
        is(0xFF.U) { reset_triggered := true.B }
        }
        uartState := sHeader
      }
    }
  }
  stuck_detector.io.clear_shutdown (io.error_cleared || reset_triggered)

  // PID
  val at_position = (control_mode && (target_position_cm === current_position_cm))
  pid.io.measuredVal := current_position_cm
  pid.io.setPoint := target_position_cm.asFixedPoint(pidDP.BP)
  pid.io.tick := true.B
  pid.io.resetBuffer := !control_mode || manual_brake || !system_active
    // Gains
  pid.io.kp := Kp.F(pidWidth.W, pidDP.BP)
  pid.io.ki := Ki.F(pidWidth.W, pidDP.BP)
  pid.io.kd := Kd.F(pidWidth.W, pidDP.BP)
  val pid_duty_raw = ((pid.io.controlOut + 0.5.F(pidDP.BP)).asUInt >> (pidDP - 10).U)
  val pid_duty = Mux(at_position, 512.U, Mux(pid_duty_raw > 1023.U, 1023.U, pid_duty_raw(9, 0)))
  pwm_signal.io.duty_cycle := Mux(control_mode, pid_duty, manual_speed)
  val motor_stopped = manual_brake || stuck_detector.io.motor_disable || !system_active || at_position
  pwm_signal.io.brake := motor_stopped

  // Brake until system is active
  when (!system_active) {
    io.T1 := false.B
    io.T2 := true.B
    io.T3 := false.B
    io.T4 := true.B
  } .otherwise {
    io.T1 := pwm_signal.io.T1
    io.T2 := pwm_signal.io.T2
    io.T3 := pwm_signal.io.T3
    io.T4 := pwm_signal.io.T4
  }

  // Telemetry
  val txTimer = RegInit(0.U(24.W))
  val sSync :: sHigh :: sLow :: Nil = Enum(3)
  val txState = RegInit(sSync)
  tx.io.data := 0.U
  tx.io.start := false.B
  when(txTimer >= 2500000.U) {
    switch(txState) {
      is(sSync) {
        when(!tx.io.busy) {
          tx.io.data := 0xFF.U
          tx.io.start := true.B
          txState := sHigh
        }}
      is(sHigh) {
        when(!tx.io.busy) {
          tx.io.data := current_position_cm(7, 0).asUInt
          tx.io.start := true.B
          txState := sSync
          txTimer := 0.U
        }}
      is(sLow) {
        when(!tx.io.busy) {
          tx.io.data := current_position_cm(7, 0).asUInt
          tx.io.start := true.B
          txState := sS@@ync
          txTimer := 0.U
        }
      }
    }
  }

}
```


#### Short summary: 

empty definition using pc, found symbol in pc: 