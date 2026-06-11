import chisel3._
import chisel3.util._

/**
  * Basys 3 Digital Stuck Detector for DTU 34602.
  * Monitors a 3.3V digital high signal from an external current sensor comparator.
  */
class Basys3DigitalStuckDetector(val OverCurrentAllowance_ms : Int = 100) extends Module {
    val io = IO(new Bundle {
        val externalOvercurrentInput = Input(Bool())      
        val clearShutdown            = Input(Bool()) 
        val is_stuck                 = Output(Bool()) 
        val motorDisable             = Output(Bool()) 
  })

    val clockFreqHz = 100000000
    val maxCycles   = (clockFreqHz / 1000) * OverCurrentAllowance_ms
    val durationReg = RegInit(0.U(32.W))

    // 2. Latched Safety State Register
    val isStuckReg  = RegInit(false.B)

    // 3. Evaluation Logic Loop
    when(io.clearShutdown) {
    isStuckReg  := false.B
    durationReg := 0.U
    }.otherwise {
    when(!isStuckReg) {
        // Evaluate direct digital logic high
        when(io.externalOvercurrentInput) {
        when(durationReg >= maxCycles.U) {
            isStuckReg := true.B
        }.otherwise {
            durationReg := durationReg + 1.U
        }
        }.otherwise {
        durationReg := 0.U // Reset instantly if signal drops low
        }
    }
    }

    // 4. Update Output Flags
    io.is_stuck := isStuckReg
    io.motorDisable   := isStuckReg
    }
