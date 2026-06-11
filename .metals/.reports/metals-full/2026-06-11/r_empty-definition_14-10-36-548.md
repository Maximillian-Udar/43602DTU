error id: file:///C:/Users/maxim/43602DTU/Chisel/src/main/scala/DCMotorPWM.scala:ChiselEnum#
file:///C:/Users/maxim/43602DTU/Chisel/src/main/scala/DCMotorPWM.scala
empty definition using pc, found symbol in pc: 
empty definition using semanticdb
empty definition using fallback
non-local guesses:
	 -chisel3/ChiselEnum#
	 -chisel3/util/ChiselEnum#
	 -ChiselEnum#
	 -scala/Predef.ChiselEnum#
offset: 658
uri: file:///C:/Users/maxim/43602DTU/Chisel/src/main/scala/DCMotorPWM.scala
text:
```scala
import chisel3._
import chisel3.util._

class VariablePWM(pwmFreqHz: Int = 1000) extends Module {
  val io = IO(new Bundle {
    val duty_cycle = Input(UInt(3.W))
    val pwmOutPos    = Output(Bool())
    val pwmOutNeg    = Output(Bool())
  })

  val clockFreq    = 100000000
  val periodCycles = clockFreq / pwmFreqHz
  val counterWidth = log2Ceil(periodCycles).W

  val input_debounce = Module(new Debouncer)
  val rising_edge    = Module(new RisingFsm)

  input_debounce.io.btn_in := io.switch_state
  rising_edge.io.din       := input_debounce.io.out
  val rise                 = rising_edge.io.risingEdge

  object State extends Chi@@selEnum {
    val s10, s25, s50, s75, s90 = Value
  }
  val stateReg = RegInit(State.s50)

  when (rise) {
    switch (stateReg) {
      is (State.s10) { stateReg := State.s25 }
      is (State.s25) { stateReg := State.s50 }
      is (State.s50) { stateReg := State.s75 }
      is (State.s75) { stateReg := State.s90 }
      is (State.s90) { stateReg := State.s10 }
    }
  }
    // Default dutycycle 
  val dutyCycle = Wire(UInt(counterWidth))
  dutyCycle := (periodCycles * 50 / 100).U


  switch (stateReg) {
    is (State.s10) { dutyCycle := (periodCycles * 10 / 100).U }
    is (State.s25) { dutyCycle := (periodCycles * 25 / 100).U }
    is (State.s50) { dutyCycle := (periodCycles * 50 / 100).U }
    is (State.s75) { dutyCycle := (periodCycles * 75 / 100).U }
    is (State.s90) { dutyCycle := (periodCycles * 90 / 100).U }
  }
  val pwmCounter = RegInit(0.U(counterWidth))
  
  when (pwmCounter === (periodCycles - 1).U) {
    pwmCounter := 0.U
  } .otherwise {
    pwmCounter := pwmCounter + 1.U
  }

  io.pwmOutPos := pwmCounter < dutyCycle
  io.pwmOutNeg := ~(pwmCounter < dutyCycle)
}

```


#### Short summary: 

empty definition using pc, found symbol in pc: 