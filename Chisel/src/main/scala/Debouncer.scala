import chisel3._

class Debouncer(fac: Int = 100000) extends Module {
  val io = IO(new Bundle {
    val btn_in = Input(Bool())
    val out    = Output(Bool())
    val state  = Output(Bool())
  })
  // Synchronize
  val btn_sync = RegNext(RegNext(io.btn_in))
  val btnDebReg = RegInit(false.B)
  val cntReg = RegInit(0.U(32.W))
  val tick = cntReg === (fac - 1).U

  // Counter
  cntReg := cntReg + 1.U
  when (tick) {
    cntReg := 0.U
    btnDebReg := btn_sync
  }

  val btnCleanPrev = RegNext(btnDebReg)
  io.out := btnDebReg && !btnCleanPrev
  io.state := btnDebReg
}