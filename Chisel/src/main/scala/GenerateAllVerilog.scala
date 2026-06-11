import chisel3._
import chisel3.util._

object GenerateAllVerilog extends App {
  emitVerilog(new VariablePWM(30000), Array("-td", "Verilog"))
}