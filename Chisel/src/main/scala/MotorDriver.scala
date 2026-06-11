import chisel3._
import chisel3.util._

class MotorDriver(scale_down: Int = 100) extends Module {
    val io = IO(new Bundle{
        // Inputs
        val position         = Input(UInt(7.W))
        val high_speed       = Input(Bool())
        val emergency_stop   = Input(Bool())
        val over_current     = Input(Bool())
        val photo_diode_A    = Input(Bool())
        val photo_diode_B    = Input(Bool())
        val jam_cleared      = Input(Bool())
        val new_Kp           = Input(UInt(6.W))
        val new_Ki           = Input(UInt(6.W))
        val new_Kd           = Input(UInt(6.W)) 
        val PID_reset_buffer = Input(Bool())

        // Outputs
        val pwm_out_positive = Output(Bool())
        val pwm_out_negative = Output(Bool())
        val motor_brake      = Output(Bool())   

    })
    val rotation_counter = Module(new RotationCounter)
    val pwm_generator    = Module(new DCMotorPwm(30000))
    val motor_stopper    = Module(new MotorStop)
    val PID    = Module(new PIDController)
    val stuck_detector   = Module(new StuckDetector(200))

    // Wiring RotationCounter
        // Inputs
    rotation_counter.io.signal_A := io.photo_diode_A
    rotation_counter.io.signal_B := io.photo_diode_B
        // Outputs
    val turns = rotation_counter.io.turns
    // Current position scaled
    val current_pos_scaled = turns / (750 / scale_down)
    
    // Wiring PWMGenerator
        // Inputs
    pwm_generator.io.duty_cycle := 0.U
        // Outputs
    val pwmoutneg = pwm_generator.io.pwmOutNeg
    val pwmoutpos = pwm_generator.io.pwmOutPos

    // Wiring MotorStopper
        // Inputs
    motor_stopper.io.motor_kill := io.emergency_stop
    motor_stopper.io.motor_cleared := io.jam_cleared
    val stop_motor = motor_stopper.io.motor_stop_signal

    // Wiring PIDController
        // Inputs
    PID.io.setPoint := io.position
    PID.io.measuredVal := current_pos_scaled
    PID.io.kp := io.new_Kp
    PID.io.ki := io.new_Ki
    PID.io.kd := io.new_Kd
    PID.io.resetBuffer := io.PID_reset_buffer
        // Outputs
    val PID_out = PID.io.controlOut

    // Wiring Stuck detector
        // Inputs
    stuck_detector.io.externalOvercurrentInput := io.over_current
    stuck_detector.io.clearShutdown := io.jam_cleared
        // Outputs
    val motor_stuck = stuck_detector.io.is_stuck
    val motor_stop = stuck_detector.io.motorDisable

    


    val sNormalForward :: sFastForward :: sNormalBack :: sFastBack :: sBrake :: sStopped :: Nil = Enum(6)
    val stateReg = RegInit(sStopped)




}