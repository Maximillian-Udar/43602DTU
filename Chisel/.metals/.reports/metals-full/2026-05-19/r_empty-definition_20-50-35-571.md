error id: file://<WORKSPACE>/src/main/scala/FilteredAccumulator.scala:
file://<WORKSPACE>/src/main/scala/FilteredAccumulator.scala
empty definition using pc, found symbol in pc: 
empty definition using semanticdb
empty definition using fallback
non-local guesses:
	 -chisel3/Input.
	 -chisel3/Input#
	 -chisel3/Input().
	 -chisel3/util/Input.
	 -chisel3/util/Input#
	 -chisel3/util/Input().
	 -Input.
	 -Input#
	 -Input().
	 -scala/Predef.Input.
	 -scala/Predef.Input#
	 -scala/Predef.Input().
offset: 159
uri: file://<WORKSPACE>/src/main/scala/FilteredAccumulator.scala
text:
```scala
import chisel3._
import chisel3.util._

class FilteredAccumulator extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(8.W))
    val valid = Inp@@ut(Bool())
    val enable = Input(Bool())
    val clear = Input(Bool())
    val out = Output(UInt(8.W))
  })
  val reg = RegInit(0.U(8.W))
  val addResult = reg + io.in
  val nextValue = Mux(io.valid, addResult, reg)
  when(io.clear) {
    reg := 0.U
  } .elsewhen(io.enable) {
    reg := nextValue
  }
  io.out := reg
}

object FilteredAccumulator extends App {
  emitVerilog(new FilteredAccumulator)
}
```


#### Short summary: 

empty definition using pc, found symbol in pc: 