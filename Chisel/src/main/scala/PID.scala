import chisel3._
import chisel3.util._
import chisel3.experimental.FixedPoint

class PIDController(val w: Int = 16, val f: Int = 12) extends Module {
  val io = IO(new Bundle {
    // Inputs
    val setPoint    = Input(FixedPoint(w.W, f.BP))
    val measuredVal = Input(FixedPoint(w.W, f.BP))
    val kp          = Input(FixedPoint(w.W, f.BP))
    val ki          = Input(FixedPoint(w.W, f.BP))
    val kd          = Input(FixedPoint(w.W, f.BP))
    val resetBuffer = Input(Bool())

    // Outputs
    val controlOut  = Output(FixedPoint(w.W, f.BP))
  })

  val error = io.setPoint - io.measuredVal

  val pTerm = io.kp * error

  val prevErrorReg = RegInit(0.FixedPoint(w.W, f.BP))
  val dTerm        = io.kd * (error - prevErrorReg)
  prevErrorReg     := error

  val upperLimit = 1.0.FixedPoint(w.W, f.BP)
  val lowerLimit = 0.0.FixedPoint(w.W, f.BP)
  
  val integralReg = RegInit(0.FixedPoint(w.W, f.BP))
  val iTermNext   = integralReg + (io.ki * error)

  when(io.resetBuffer) {
    integralReg := 0.FixedPoint(w.W, f.BP)
  }.otherwise {
    when(iTermNext > upperLimit) {
      integralReg := upperLimit
    }.elsewhen(iTermNext < lowerLimit) {
      integralReg := lowerLimit
    }.otherwise {
      integralReg := iTermNext
    }
  }
  val iTerm = integralReg

  val rawOutput = pTerm + iTerm + dTerm

  val saturatedOut = Wire(FixedPoint(w.W, f.BP))
  when(rawOutput > upperLimit) {
    saturatedOut := upperLimit
  }.elsewhen(rawOutput < lowerLimit) {
    saturatedOut := lowerLimit
  }.otherwise {
    saturatedOut := rawOutput
  }

  io.controlOut := saturatedOut
}
