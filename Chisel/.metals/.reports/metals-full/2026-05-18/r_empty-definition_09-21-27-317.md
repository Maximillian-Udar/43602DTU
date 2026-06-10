error id: file://<WORKSPACE>/src/main/scala/DispMux.scala:
file://<WORKSPACE>/src/main/scala/DispMux.scala
empty definition using pc, found symbol in pc: 
empty definition using semanticdb
empty definition using fallback
non-local guesses:
	 -chisel3/util/disp_content.
	 -chisel3/util/disp_content#
	 -chisel3/util/disp_content().
	 -chisel3/disp_content.
	 -chisel3/disp_content#
	 -chisel3/disp_content().
	 -disp_content.
	 -disp_content#
	 -disp_content().
	 -scala/Predef.disp_content.
	 -scala/Predef.disp_content#
	 -scala/Predef.disp_content().
offset: 325
uri: file://<WORKSPACE>/src/main/scala/DispMux.scala
text:
```scala
import chisel3.util._
import chisel3._

/*
ONLY FOR DISPLAYING DATA IN TWO BLOCK!!
Change it to four separate block, one for each digit
*/


class DisplayMultiplexer(refresh_limit: Int = 100000) extends Module {
  val io = IO(new Bundle {
    //val hours = Input(UInt(8.W))
    //val minutes = Input(UInt(8.W))
    val disp_c@@ontent = Input(UInt(16.U))
    val seg = Output(UInt(7.W))
    val an = Output(UInt(4.W))
  })

  // Delay function
  def delay(n: Int) = {
    val cntReg = RegInit(0.U(log2Up(n).max(1).W))
    cntReg := Mux(cntReg === (n - 1).U, 0.U, cntReg + 1.U)
    cntReg
  }

  // Initiate default state of display
  val sevSeg = WireDefault("b1111111".U(7.W))
  val select = WireDefault("b0001".U(4.W))

  val cnt = delay(refresh_limit)
  val tick = cnt === (refresh_limit - 1).U

  // Cycle through digit on display
  val digit = RegInit(0.U(2.W))
  when(tick) {
    digit := Mux(digit === 3.U, 0.U, digit + 1.U)
  }

  // Display relevant data on correct digit
  val current = Wire(UInt(4.W))
  current := 0.U
  switch(digit) {
    is(0.U) { current := io.minutes(3, 0) }
    is(1.U) { current := io.minutes(7, 4) }
    is(2.U) { current := io.hours(3, 0) }
    is(3.U) { current := io.hours(7, 4) }
  }

  // digit switching
  val decoder = Module(new SevenSegDec)
  decoder.io.in := current
  sevSeg := decoder.io.out

  switch(digit) {
    is(0.U) { select := "b0001".U }
    is(1.U) { select := "b0010".U }
    is(2.U) { select := "b0100".U }
    is(3.U) { select := "b1000".U }
  }

  io.seg := ~sevSeg
  io.an  := ~select
}

class SevenSegDec extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(4.W))
    val out = Output(UInt(7.W))
  })

  val sevSeg = WireDefault(0.U)

  sevSeg := MuxLookup(io.in, 0.U(7.W))(Seq(
    0.U  -> "b0111111".U, // 0
    1.U  -> "b0000110".U, // 1
    2.U  -> "b1011011".U, // 2
    3.U  -> "b1001111".U, // 3
    4.U  -> "b1100110".U, // 4
    5.U  -> "b1101101".U, // 5
    6.U  -> "b1111101".U, // 6
    7.U  -> "b0000111".U, // 7
    8.U  -> "b1111111".U, // 8
    9.U  -> "b1101111".U, // 9
    10.U -> "b1110111".U, // A
    11.U -> "b1111100".U, // b
    12.U -> "b0111001".U, // C
    13.U -> "b1011110".U, // d
    14.U -> "b1111001".U, // E
    15.U -> "b1110001".U, // F
    16.U -> "b1110110".U, // H
    17.U -> "b0111000".U, // L
    18.U -> "b0000000".U // Blank/Off

  ))

  io.out := sevSeg
}
```


#### Short summary: 

empty definition using pc, found symbol in pc: 