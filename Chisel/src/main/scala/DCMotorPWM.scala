import chisel3._
import chisel3.util._

class VariablePWM(pwmFreqHz: Int = 1000) extends Module {
  val io = IO(new Bundle {
    val duty_cycle = Input(UInt(3.W))
    val pwmOutPos  = Output(Bool())
    val pwmOutNeg  = Output(Bool())
  })

  val clockFreq    = 100000000
  val periodCycles = clockFreq / pwmFreqHz
  val counterWidth = log2Ceil(periodCycles).W

  val dutyCycle = Wire(UInt(counterWidth))
  
  dutyCycle := (periodCycles * 50 / 100).U

  switch (io.duty_cycle) {
    is (0.U) { dutyCycle := (periodCycles * 50 / 100).U } // Stopped
    is (1.U) { dutyCycle := (periodCycles * 25 / 100).U } // Normal Back
    is (2.U) { dutyCycle := (periodCycles * 75 / 100).U } // Normal Forward
    is (3.U) { dutyCycle := (periodCycles * 10 / 100).U } // Fast Back
    is (4.U) { dutyCycle := (periodCycles * 90 / 100).U } // Fast Forward
  }

  val pwmCounter = RegInit(0.U(counterWidth))
  
  when (pwmCounter === (periodCycles - 1).U) {
    pwmCounter := 0.U
  } .otherwise {
    pwmCounter := pwmCounter + 1.U
  }

  val pwmSignal = pwmCounter < dutyCycle
  io.pwmOutPos := pwmSignal
  io.pwmOutNeg := !pwmSignal
}
