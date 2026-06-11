import chisel3._
import chisel3.util._

class MotorDriver extends Module {
    val io = IO(new Bundle{
        // Inputs
        val direction     = Input(UInt(3.W))
        val high_speed    = Input(Bool())
        val E_stop        = Input(Bool())
        val photo_diode_1 = Input(Bool())
        val photo_diode_2 = Input(Bool())

        // Outputs
        val pwm_out_positive = Output(Bool())
        val pwm_out_negative = Output(Bool())
        val motor_brake      = Output(Bool())   

    })
    val rotation_counter = Module(new RotationCounter)
    val pwm_generator    = Module(new DCMotorPwm(30000))
    val motor_stopper    = Module(new MotorStop)
    val PIDcontroller    = Module(new PIDController)
    val stuck_detector   = Module(new StuckDetector(200))

    val sNormalForward :: sFastForward :: sNormalBack :: sFastBack :: sBrake :: sStopped :: Nil = Enum(6)
    val stateReg = RegInit(sStopped)

    


}