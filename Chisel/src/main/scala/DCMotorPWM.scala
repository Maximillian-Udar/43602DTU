
import chisel3._
import chisel3.util._

class VariablePWM(pwmFreqHz: Int = 1000) extends Module {
  val io = IO(new Bundle {
    val switch_state = Input(Bool())
    val pwmOutPos    = Output(Bool())
    val pwmOutNeg    = Output(Bool())
    
    val seg          = Output(UInt(8.W))
    val an           = Output(UInt(4.W))
  })

  val clockFreq    = 100000000
  val periodCycles = clockFreq / pwmFreqHz
  val counterWidth = log2Ceil(periodCycles).W

  val input_debounce = Module(new Debouncer)
  val rising_edge    = Module(new RisingFsm)

  input_debounce.io.btn_in := io.switch_state
  rising_edge.io.din       := input_debounce.io.out
  val rise                 = rising_edge.io.risingEdge

  object State extends ChiselEnum {
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
    // Set default values as 0, 0, 0, 0, BLANK
  val dutyCycle = Wire(UInt(counterWidth))
  dutyCycle := 0.U 
  val d3        = WireInit(0.U(5.W))
  val d2        = WireInit(0.U(5.W))
  val d1        = WireInit(0.U(5.W))
  val d0        = WireInit(29.U(5.W))

  switch (stateReg) {
    is (State.s10) { 
      dutyCycle := (periodCycles * 10 / 100).U
      d2 := 1.U
      d1 := 0.U
    }
    is (State.s25) { 
      dutyCycle := (periodCycles * 25 / 100).U
      d2 := 2.U
      d1 := 5.U
    }
    is (State.s50) { 
      dutyCycle := (periodCycles * 50 / 100).U
      d2 := 5.U
      d1 := 0.U
    }
    is (State.s75) { 
      dutyCycle := (periodCycles * 75 / 100).U
      d2 := 7.U
      d1 := 5.U
    }
    is (State.s90) { 
      dutyCycle := (periodCycles * 90 / 100).U
      d2 := 9.U
      d1 := 0.U
    }
  }

  val displayMux = Module(new DisplayMultiplexer)
  displayMux.io.disp_content := Cat(d3, d2, d1, d0)
  displayMux.io.dots         := "b0100".U
  io.seg := displayMux.io.seg
  io.an  := displayMux.io.an

  val pwmCounter = RegInit(0.U(counterWidth))
  
  when (pwmCounter === (periodCycles - 1).U) {
    pwmCounter := 0.U
  } .otherwise {
    pwmCounter := pwmCounter + 1.U
  }

  io.pwmOutPos := pwmCounter < dutyCycle
  io.pwmOutNeg := ~(pwmCounter < dutyCycle)
}
