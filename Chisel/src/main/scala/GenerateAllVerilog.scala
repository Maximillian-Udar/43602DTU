import chisel3._
import chisel3.util._

object GenerateAllVerilog extends App {
  emitVerilog(new PwmFsmAnalogOut, Array("-td", "Verilog"))
}