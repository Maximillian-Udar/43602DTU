import chisel3._
import chisel3.util._

object GenerateAllVerilog extends App {
  //emitVerilog(new ClockModule, Array("-td", "Verilog"))
  //emitVerilog(new StopWatch, Array("-td", "Verilog"))
  //emitVerilog(new MultiAlarm, Array("-td", "Verilog"))
  //emitVerilog(new MultiAlarm, Array("-td", "Verilog"))
  emitVerilog(new PwmFsmAnalogOut, Array("-td", "Verilog"))
  //emitVerilog(new Pwm, Array("-td", "Verilog"))
}