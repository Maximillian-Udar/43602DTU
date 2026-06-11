import chisel3._
import chisel3.util._

class RotationCounter extends Module {
  val io = IO(new Bundle {
    val signal_A = Input(Bool())
    val signal_B = Input(Bool())
    val turns    = Output(UInt(10.W))
  })

  val aSync = RegNext(RegNext(io.signal_A))
  val bSync = RegNext(RegNext(io.signal_B))
  
  val aReg = RegNext(aSync)
  val rise_A = aSync && !aReg
  val fall_A = !aSync && aReg

  val turns = RegInit(0.U(10.W))

  when(rise_A) {
    when(!bSync) {
      turns := turns + 1.U
    } .otherwise {
      turns := turns - 1.U
    }
  }
  io.turns := turns
}