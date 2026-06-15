import chisel3._
import chisel3.util._

class PWMTest(pwmFreqHz: Int = 30000) extends Module {
  val io = IO(new Bundle {
    val switch_state = Input(Bool()) // Button to cycle duty cycles
    val brake        = Input(Bool()) // High = Brake
    // H-Bridge Outputs
    val T1           = Output(Bool()) // Bottom-Left (NMOS) - High to conduct
    val T2           = Output(Bool()) // Top-Left    (PMOS) - Low to conduct
    val T3           = Output(Bool()) // Bottom-Right (NMOS) - High to conduct
    val T4           = Output(Bool()) // Top-Right   (PMOS) - Low to conduct
    // Display Outputs
    val seg          = Output(UInt(8.W))
    val an           = Output(UInt(4.W))
  })

  val clockFreq    = 100000000
  val periodCycles = clockFreq / pwmFreqHz
  val counterWidth = log2Ceil(periodCycles).W
  
  val pwmCounter = RegInit(0.U(counterWidth))
  when(pwmCounter >= (periodCycles - 1).U) {
    pwmCounter := 0.U
  } .otherwise {
    pwmCounter := pwmCounter + 1.U
  }

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


  val dutyThreshold = WireDefault(0.U(counterWidth)) 
  
  val d3 = WireInit(0.U(5.W))
  val d2 = WireInit(0.U(5.W))
  val d1 = WireInit(0.U(5.W))
  val d0 = WireInit(29.U(5.W))

  switch (stateReg) {
    is (State.s10) { 
      dutyThreshold := (periodCycles * 10 / 100).U
      d2 := 1.U; d1 := 0.U
    }
    is (State.s25) { 
      dutyThreshold := (periodCycles * 25 / 100).U
      d2 := 2.U; d1 := 5.U
    }
    is (State.s50) { 
      dutyThreshold := (periodCycles * 50 / 100).U
      d2 := 5.U; d1 := 0.U
    }
    is (State.s75) { 
      dutyThreshold := (periodCycles * 75 / 100).U
      d2 := 7.U; d1 := 5.U
    }
    is (State.s90) { 
      dutyThreshold := (periodCycles * 90 / 100).U
      d2 := 9.U; d1 := 0.U
    }
  }

  // --- 5. H-Bridge Logic ---
  val pwmSignal = pwmCounter < dutyThreshold

  val conduct_T1 = Wire(Bool())
  val conduct_T2 = Wire(Bool())
  val conduct_T3 = Wire(Bool())
  val conduct_T4 = Wire(Bool())

  when(io.brake) {
    // Braking: Turn on both bottom NMOS to short motor to GND
    conduct_T1 := true.B
    conduct_T2 := false.B
    conduct_T3 := true.B
    conduct_T4 := false.B
  } .otherwise {
    // Normal PWM Drive
    conduct_T2 := pwmSignal
    conduct_T3 := pwmSignal
    
    conduct_T4 := !pwmSignal
    conduct_T1 := !pwmSignal
  }

  // Output Mapping
  io.T1 := conduct_T1        // NMOS: High = On
  io.T3 := conduct_T3        // NMOS: High = On
  io.T2 := !conduct_T2       // PMOS: Low = On
  io.T4 := !conduct_T4       // PMOS: Low = On

  // --- 6. 7-Segment Display ---
  val displayMux = Module(new DisplayMultiplexer)
  displayMux.io.disp_content := Cat(d3, d2, d1, d0)
  displayMux.io.dots         := "b0100".U
  io.seg := displayMux.io.seg
  io.an  := displayMux.io.an
}