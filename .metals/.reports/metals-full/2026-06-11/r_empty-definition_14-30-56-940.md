error id: file:///C:/Users/maxim/43602DTU/Chisel/src/main/scala/BCD.scala:util.
file:///C:/Users/maxim/43602DTU/Chisel/src/main/scala/BCD.scala
empty definition using pc, found symbol in pc: 
empty definition using semanticdb
empty definition using fallback
non-local guesses:
	 -chisel3/chisel3/util.
	 -chisel3/util/chisel3/util.
	 -chisel3/util.
	 -scala/Predef.chisel3.util.
offset: 36
uri: file:///C:/Users/maxim/43602DTU/Chisel/src/main/scala/BCD.scala
text:
```scala
import chisel3._
import chisel3.uti@@l._

class BCD extends Module {
  val io = IO(new Bundle {
    val b_number = Input(UInt(6.W))
    val out      = Output(UInt(8.W))
  })
  val tens = io.b_number / 10.U
  val ones = io.b_number % 10.U
  io.out := Cat(tens(3, 0), ones(3, 0))
}
```


#### Short summary: 

empty definition using pc, found symbol in pc: 