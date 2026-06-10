error id: file:///C:/Users/maxim/FPGA_Programs/src/main/scala/DispMux.scala:
file:///C:/Users/maxim/FPGA_Programs/src/main/scala/DispMux.scala
empty definition using pc, found symbol in pc: 
empty definition using semanticdb
empty definition using fallback
non-local guesses:
	 -chisel3/util/UInt.
	 -chisel3/util/UInt#
	 -chisel3/util/UInt().
	 -chisel3/UInt.
	 -chisel3/UInt#
	 -chisel3/UInt().
	 -UInt.
	 -UInt#
	 -UInt().
	 -scala/Predef.UInt.
	 -scala/Predef.UInt#
	 -scala/Predef.UInt().
offset: 746
uri: file:///C:/Users/maxim/FPGA_Programs/src/main/scala/DispMux.scala
text:
```scala
import chisel3.util._
import chisel3._


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

  val currentRaw = Wire(@@UInt(5.W))
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
```


#### Short summary: 

empty definition using pc, found symbol in pc: 