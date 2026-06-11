import chisel3._
import chisel3.util._

class MotorDriver extends Module {
    val io = IO(new Bundle{
        // Inputs
        val switch_state = Input(Bool())
        val signal_A     = Input(Bool())
        val signal_B     = Input(Bool())

        // Outputs
        val pwmOutPos    = Output(Bool())
        val pwmOutNeg    = Output(Bool())
        
    })
    
}