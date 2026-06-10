error id: file://<WORKSPACE>/src/main/scala/thermo.scala:
file://<WORKSPACE>/src/main/scala/thermo.scala
empty definition using pc, found symbol in pc: 
empty definition using semanticdb
empty definition using fallback
non-local guesses:
	 -chisel3.
	 -chisel3#
	 -chisel3().
	 -chisel3/util.
	 -chisel3/util#
	 -chisel3/util().
	 -scala/Predef.
	 -scala/Predef#
	 -scala/Predef().
offset: 485
uri: file://<WORKSPACE>/src/main/scala/thermo.scala
text:
```scala
import chisel3._
import chisel3.util._

class ThermometerDigital extends Module {
  val io = IO(new Bundle {
    val sensor_in = Input(Bool())
    val seg       = Output(UInt(7.W))
    val an        = Output(UInt(4.W))
  })

  val display = Module(new DisplayMultiplexer(100000))

  val hours   = Wire(UInt(8.W))
  val minutes = Wire(UInt(8.W))

  when(io.sensor_in) {
    hours   := 
    minutes := Cat(1.U(5.W), 18.U(5.W))
    letter := Cat()
  } .otherwise {
    hours   := Cat(18.U@@(5.W), 17.U(5.W))
    minutes := Cat(0.U(5.W), 18.U(5.W))
  }

  display.io.disp_content := Cat(hours(7, 0), minutes(7, 0))

  io.seg := display.io.seg
  io.an  := display.io.an
}

// Boilerplate to generate Verilog
object ThermometerMain extends App {
  emitVerilog(new ThermometerDigital)
}

```


#### Short summary: 

empty definition using pc, found symbol in pc: 