import chisel3._
import chisel3.util._

class BCD extends Module {
  val io = IO(new Bundle {
    val b_number = Input(UInt(6.W))
    val out      = Output(UInt(8.W))
  })
  val tens = io.b_number / 10.U
  val ones = io.b_number % 10.U
  io.out := Cat(tens(3, 0), ones(3, 0))
}