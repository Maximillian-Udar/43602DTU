error id: file:///C:/Users/maxim/FPGA_Programs/src/main/scala/GenerateAllVerilog.scala:emitVerilog.
file:///C:/Users/maxim/FPGA_Programs/src/main/scala/GenerateAllVerilog.scala
empty definition using pc, found symbol in pc: 
empty definition using semanticdb
empty definition using fallback
non-local guesses:
	 -chisel3/emitVerilog.
	 -chisel3/emitVerilog#
	 -chisel3/emitVerilog().
	 -chisel3/util/emitVerilog.
	 -chisel3/util/emitVerilog#
	 -chisel3/util/emitVerilog().
	 -emitVerilog.
	 -emitVerilog#
	 -emitVerilog().
	 -scala/Predef.emitVerilog.
	 -scala/Predef.emitVerilog#
	 -scala/Predef.emitVerilog().
offset: 321
uri: file:///C:/Users/maxim/FPGA_Programs/src/main/scala/GenerateAllVerilog.scala
text:
```scala
import chisel3._
import chisel3.util._

object GenerateAllVerilog extends App {
  //emitVerilog(new ClockModule, Array("-td", "Verilog"))
  //emitVerilog(new StopWatch, Array("-td", "Verilog"))
  //emitVerilog(new MultiAlarm, Array("-td", "Verilog"))
  //emitVerilog(new MultiAlarm, Array("-td", "Verilog"))
  emi@@tVerilog(new PwmFsmAnalogOut, Array("-td", "Verilog"))
  emitVerilog(new Pwm, Array("-td", "Verilog"))
}
```


#### Short summary: 

empty definition using pc, found symbol in pc: 