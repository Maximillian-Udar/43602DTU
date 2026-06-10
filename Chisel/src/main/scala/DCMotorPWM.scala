import chisel3._
import chisel3.util._

class PwmFsmAnalogOut extends Module {
  val io = IO(new Bundle {
    val switch_state = Input(Bool())
    val pwmOut       = Output(Bool())
    val pwmOutInv    = Output(Bool())
    val seg          = Output(UInt(8.W))
    val an           = Output(UInt(4.W))
  })

  val input_debounce = Module(new Debouncer)
  val rising_edge    = Module(new RisingFsm)

  input_debounce.io.btn_in := io.switch_state
  rising_edge.io.din       := input_debounce.io.out
  val rise                 = rising_edge.io.risingEdge

  object State extends ChiselEnum {
    val s10, s25, s50, s75, s90 = Value
  }
  val stateReg = RegInit(State.s10)

  when (rise) {
    switch (stateReg) {
      is (State.s10) { stateReg := State.s25 }
      is (State.s25) { stateReg := State.s50 }
      is (State.s50) { stateReg := State.s75 }
      is (State.s75) { stateReg := State.s90 }
      is (State.s90) { stateReg := State.s10 }
    }
  }

  val dutyCycle = Wire(UInt(12.W))
  val d3        = Wire(UInt(5.W))
  val d2        = Wire(UInt(5.W))
  val d1        = Wire(UInt(5.W))
  val d0        = Wire(UInt(5.W))

  // Default Fallbacks
  dutyCycle := 0.U 
  d3        := 0.U
  d2        := 0.U
  d1        := 0.U
  d0        := 29.U

  switch (stateReg) {
    is (State.s10) { 
      dutyCycle := 333.U
      d2        := 1.U
      d1        := 0.U
    }
    is (State.s25) { 
      dutyCycle := 833.U
      d2        := 2.U
      d1        := 5.U
    }
    is (State.s50) { 
      dutyCycle := 1667.U
      d2        := 5.U
      d1        := 0.U
    }
    is (State.s75) { 
      dutyCycle := 2500.U
      d2        := 7.U
      d1        := 5.U
    }
    is (State.s90) { 
      dutyCycle := 3000.U
      d2        := 9.U
      d1        := 0.U
    }
  }

  val displayMux = Module(new DisplayMultiplexer)
  
  displayMux.io.disp_content := Cat(d3, d2, d1, d0)
  displayMux.io.dots         := "b0100".U
  
  io.seg := displayMux.io.seg
  io.an  := displayMux.io.an

  val pwmCounter = RegInit(0.U(12.W))
  when (pwmCounter === 3332.U) {
    pwmCounter := 0.U
  } .otherwise {
    pwmCounter := pwmCounter + 1.U
  }
  io.pwmOut := pwmCounter < dutyCycle
  io.pwmOutInv := ~(pwmCounter < dutyCycle)
}
