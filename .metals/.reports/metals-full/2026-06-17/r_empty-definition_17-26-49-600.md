error id: file:///C:/Users/maxim/43602DTU/Chisel/src/main/scala/SecondDriver.scala:
file:///C:/Users/maxim/43602DTU/Chisel/src/main/scala/SecondDriver.scala
empty definition using pc, found symbol in pc: 
empty definition using semanticdb
empty definition using fallback
non-local guesses:
	 -chisel3.
	 -chisel3#
	 -chisel3().
	 -chisel3/util.
	 -chisel3/util#
	 -chisel3/util().
	 -scala/Predef.
	 -scala/Predef#
	 -scala/Predef().
offset: 2849
uri: file:///C:/Users/maxim/43602DTU/Chisel/src/main/scala/SecondDriver.scala
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
  stuck_detector.io.externalOvercurrentInput := (io.over_current_positive|| io.over_current_negative)

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
              is(0.U) {manual_speed := 512.U@@ //; manual_brake := true.B}
            }
            }
        }
      }
    }
  }


}
```


#### Short summary: 

empty definition using pc, found symbol in pc: 