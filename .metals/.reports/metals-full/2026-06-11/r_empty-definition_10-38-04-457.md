error id: file:///C:/Users/maxim/43602DTU/Chisel/src/main/scala/PositionSensor.scala:
file:///C:/Users/maxim/43602DTU/Chisel/src/main/scala/PositionSensor.scala
empty definition using pc, found symbol in pc: 
empty definition using semanticdb
empty definition using fallback
non-local guesses:
	 -chisel3/dispmux.
	 -chisel3/util/dispmux.
	 -dispmux.
	 -scala/Predef.dispmux.
offset: 1007
uri: file:///C:/Users/maxim/43602DTU/Chisel/src/main/scala/PositionSensor.scala
text:
```scala
import chisel3._
import chisel3.util._

class PositionSensor(scale : Int = 100) extends Module {
  val io = IO(new Bundle {
    val signal_A      = Input(Bool())
    val signal_B      = Input(Bool())
    val show_position = Input(Bool())
    val seg           = Output(UInt(8.W))
    val an            = Output(UInt(4.W))
  })
  val turns = RegInit(0.U(10.W))
  val turns_BCD = Module(new BCD)
  turns_BCD.io.b_number := turns

  val A_rising = Module(new RisingFsm)
  A_rising.io.din := io.signal_A
  val rise_A = A_rising.io.risingEdge
  
  val B_rising = Module(new RisingFsm)
  B_rising.io.din := io.signal_B
  val rise_B = B_rising.io.risingEdge

when (rise_A && !rise_B) {
  turns := turns + 1.U
}

when (!rise_A && rise_B) {
  turns := turns - 1.U
}

val dispmux = Module(new DisplayMultiplexer)
when (io.show_position) {

}.otherwise {dispmux.io.disp_content := Cat(
  29.U(5.W), 29.U(5.W), 0.U(1.W) ## turns_BCD.io.out(7, 4), 0.U(1.W) ## turns_BCD.io.out(3, 0))
@@dispmux.io.dots := "b0000".U}

io.seg := dispmux.io.seg
io.an := dispmux.io.an

//io.position := turns / (750 / scale)
}
```


#### Short summary: 

empty definition using pc, found symbol in pc: 