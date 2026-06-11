error id: file:///C:/Users/maxim/43602DTU/Chisel/src/main/scala/MotorDriver.scala:
file:///C:/Users/maxim/43602DTU/Chisel/src/main/scala/MotorDriver.scala
empty definition using pc, found symbol in pc: 
empty definition using semanticdb
empty definition using fallback
non-local guesses:
	 -chisel3/signal_B.
	 -chisel3/signal_B#
	 -chisel3/signal_B().
	 -chisel3/util/signal_B.
	 -chisel3/util/signal_B#
	 -chisel3/util/signal_B().
	 -signal_B.
	 -signal_B#
	 -signal_B().
	 -scala/Predef.signal_B.
	 -scala/Predef.signal_B#
	 -scala/Predef.signal_B().
offset: 228
uri: file:///C:/Users/maxim/43602DTU/Chisel/src/main/scala/MotorDriver.scala
text:
```scala
import chisel3._
import chisel3.util._

class MotorDriver extends Module {
    val io = IO(new Bundle{
        // Inputs
        val switch_state = Input(Bool())
        val photo_diode_1     = Input(Bool())
        val signal_B@@     = Input(Bool())

        // Outputs
        val pwm_out_positive = Output(Bool())
        val pwm_out_negative = Output(Bool())
        val motor_brake      = Output(Bool())   

    })
    val rotation_counter = Module(new RotationCounter)
    val pwm_generator    = Module(new DCMotorPwm(30000))
    val motor_stopper    = Module(new MotorStop)
    val PIDcontroller    = Module(new PIDController)
    val stuck_detector   = Module(new StuckDetector(200))

    val sNormal :: sBrake :: sFast :: sStopped :: Nil = Enum(4)
    val stateReg = RegInit(sStopped)


}
```


#### Short summary: 

empty definition using pc, found symbol in pc: 