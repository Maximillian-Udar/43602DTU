import chisel3._
import chisel3.util._

object GenerateAllVerilog extends App {
  //emitVerilog(new VariablePWM(30000), Array("-td", "Verilog"))
  emitVerilog(new RotationCounter, Array("-td", "Verilog"))
}

class BCD extends Module {
  val io = IO(new Bundle {
    val b_number = Input(UInt(6.W))
    val out      = Output(UInt(8.W))
  })
  val tens = io.b_number / 10.U
  val ones = io.b_number % 10.U
  io.out := Cat(tens(3, 0), ones(3, 0))
}

class Debouncer(fac: Int = 100000) extends Module {
  val io = IO(new Bundle {
    val btn_in = Input(Bool())
    val out    = Output(Bool())
    val state  = Output(Bool())
  })
  // Synchronize
  val btn_sync = RegNext(RegNext(io.btn_in))
  val btnDebReg = RegInit(false.B)
  val cntReg = RegInit(0.U(32.W))
  val tick = cntReg === (fac - 1).U

  // Counter
  cntReg := cntReg + 1.U
  when (tick) {
    cntReg := 0.U
    btnDebReg := btn_sync
  }

  val btnCleanPrev = RegNext(btnDebReg)
  io.out := btnDebReg && !btnCleanPrev
  io.state := btnDebReg
}

class DisplayMultiplexer(refresh_limit: Int = 100000, inital_dots: Int = 0) extends Module {
  val io = IO(new Bundle {
    val disp_content = Input(UInt(20.W))
    val dots         = Input(UInt(4.W))
    val seg          = Output(UInt(8.W))
    val an           = Output(UInt(4.W))
  })
  //io.dots := inital_dots.U
  val sevSeg = WireDefault("b1111111".U(7.W))
  val select = WireDefault("b0001".U(4.W))

  // Timing logic
  val cnt = RegInit(0.U(log2Up(refresh_limit).W))
  cnt := Mux(cnt === (refresh_limit - 1).U, 0.U, cnt + 1.U)
  val tick = cnt === (refresh_limit - 1).U

  val digit = RegInit(0.U(2.W))
  when(tick) {
    digit := digit + 1.U
  }

  val currentRaw = Wire(UInt(5.W))
  currentRaw := 0.U
  switch(digit) {
    is(0.U) { currentRaw := io.disp_content(4, 0) }
    is(1.U) { currentRaw := io.disp_content(9, 5) }
    is(2.U) { currentRaw := io.disp_content(14, 10) }
    is(3.U) { currentRaw := io.disp_content(19, 15) }
  }

  val decoder = Module(new SevenSegDec)
  val currentDot = io.dots(digit)
  decoder.io.in := SegSymbol.safe(currentRaw)._1
  sevSeg := decoder.io.out
  val fullSeg = currentDot ## sevSeg



  // Anode selection
  switch(digit) {
    is(0.U) { select := "b0001".U }
    is(1.U) { select := "b0010".U }
    is(2.U) { select := "b0100".U }
    is(3.U) { select := "b1000".U }
  }

  io.seg := ~fullSeg
  io.an  := ~select
}

class SevenSegDec extends Module {
  val io = IO(new Bundle {
    val in  = Input(SegSymbol())
    val out = Output(UInt(7.W))
  })

  io.out := MuxLookup(io.in, 0.U(7.W))(Seq(
    SegSymbol.s0    -> "b0111111".U,
    SegSymbol.s1    -> "b0000110".U,
    SegSymbol.s2    -> "b1011011".U,
    SegSymbol.s3    -> "b1001111".U,
    SegSymbol.s4    -> "b1100110".U,
    SegSymbol.s5    -> "b1101101".U,
    SegSymbol.s6    -> "b1111101".U,
    SegSymbol.s7    -> "b0000111".U,
    SegSymbol.s8    -> "b1111111".U,
    SegSymbol.s9    -> "b1101111".U,
    SegSymbol.A     -> "b1110111".U,
    SegSymbol.B     -> "b1111100".U,
    SegSymbol.C     -> "b0111001".U,
    SegSymbol.D     -> "b1011110".U,
    SegSymbol.E     -> "b1111001".U,
    SegSymbol.F     -> "b1110001".U,
    SegSymbol.G     -> "b0111100".U,
    SegSymbol.H     -> "b1110110".U,
    SegSymbol.I     -> "b0000110".U,
    SegSymbol.J     -> "b0001111".U,
    SegSymbol.L     -> "b0111000".U,
    SegSymbol.N     -> "b1110000".U,
    SegSymbol.O     -> "b0111111".U,
    SegSymbol.P     -> "b1110011".U,
    SegSymbol.Q     -> "b1100111".U,
    SegSymbol.R     -> "b0110001".U,
    SegSymbol.S     -> "b1101101".U,
    SegSymbol.T     -> "b1111000".U,
    SegSymbol.U     -> "b0111111".U,
    SegSymbol.Blank -> "b0000000".U
  ))
}

object SegSymbol extends ChiselEnum {
  val s0, s1, s2, s3, s4, s5, s6, s7, s8, s9 = Value
  val A, B, C, D, E, F, G, H, I, J, L, N, O, P, Q, R, S, T, U, Blank = Value
}

class RisingFsm extends Module {
  val io = IO(new Bundle{
    val din = Input(Bool())
    val risingEdge = Output(Bool())
  })
  object State extends ChiselEnum {
    val zero, one = Value
  }
  import State._
  val stateReg = RegInit(zero)
  io.risingEdge := false.B
  switch (stateReg) {
    is(zero) {
      when(io.din) {
        stateReg := one
        io.risingEdge := true.B
      }
    }
    is(one) {
      when(!io.din) {
        stateReg := zero
      }
    }
  }
}