import chisel3._
import chisel3.util._
import chisel3.experimental.FixedPoint


object GenerateAllVerilog extends App {
  //emitVerilog(new VariablePWM(30000), Array("-td", "Verilog"))
  emitVerilog(new RotationCounter, Array("-td", "Verilog"))
}

class BCD extends Module {
  val io = IO(new Bundle {
    val b_number = Input(UInt(6.W))
    val out      = Output(UInt(8.W))
  })
  val tens = io.b_number / 10.U
  val ones = io.b_number % 10.U
  io.out := Cat(tens(3, 0), ones(3, 0))
}

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

class DisplayMultiplexer(refresh_limit: Int = 100000, inital_dots: Int = 0) extends Module {
  val io = IO(new Bundle {
    val disp_content = Input(UInt(20.W))
    val dots         = Input(UInt(4.W))
    val seg          = Output(UInt(8.W))
    val an           = Output(UInt(4.W))
  })
  //io.dots := inital_dots.U
  val sevSeg = WireDefault("b1111111".U(7.W))
  val select = WireDefault("b0001".U(4.W))

  // Timing logic
  val cnt = RegInit(0.U(log2Up(refresh_limit).W))
  cnt := Mux(cnt === (refresh_limit - 1).U, 0.U, cnt + 1.U)
  val tick = cnt === (refresh_limit - 1).U

  val digit = RegInit(0.U(2.W))
  when(tick) {
    digit := digit + 1.U
  }

  val currentRaw = Wire(UInt(5.W))
  currentRaw := 0.U
  switch(digit) {
    is(0.U) { currentRaw := io.disp_content(4, 0) }
    is(1.U) { currentRaw := io.disp_content(9, 5) }
    is(2.U) { currentRaw := io.disp_content(14, 10) }
    is(3.U) { currentRaw := io.disp_content(19, 15) }
  }

  val decoder = Module(new SevenSegDec)
  val currentDot = io.dots(digit)
  decoder.io.in := SegSymbol.safe(currentRaw)._1
  sevSeg := decoder.io.out
  val fullSeg = currentDot ## sevSeg



  // Anode selection
  switch(digit) {
    is(0.U) { select := "b0001".U }
    is(1.U) { select := "b0010".U }
    is(2.U) { select := "b0100".U }
    is(3.U) { select := "b1000".U }
  }

  io.seg := ~fullSeg
  io.an  := ~select
}

class SevenSegDec extends Module {
  val io = IO(new Bundle {
    val in  = Input(SegSymbol())
    val out = Output(UInt(7.W))
  })

  io.out := MuxLookup(io.in, 0.U(7.W))(Seq(
    SegSymbol.s0    -> "b0111111".U,
    SegSymbol.s1    -> "b0000110".U,
    SegSymbol.s2    -> "b1011011".U,
    SegSymbol.s3    -> "b1001111".U,
    SegSymbol.s4    -> "b1100110".U,
    SegSymbol.s5    -> "b1101101".U,
    SegSymbol.s6    -> "b1111101".U,
    SegSymbol.s7    -> "b0000111".U,
    SegSymbol.s8    -> "b1111111".U,
    SegSymbol.s9    -> "b1101111".U,
    SegSymbol.A     -> "b1110111".U,
    SegSymbol.B     -> "b1111100".U,
    SegSymbol.C     -> "b0111001".U,
    SegSymbol.D     -> "b1011110".U,
    SegSymbol.E     -> "b1111001".U,
    SegSymbol.F     -> "b1110001".U,
    SegSymbol.G     -> "b0111100".U,
    SegSymbol.H     -> "b1110110".U,
    SegSymbol.I     -> "b0000110".U,
    SegSymbol.J     -> "b0001111".U,
    SegSymbol.L     -> "b0111000".U,
    SegSymbol.N     -> "b1110000".U,
    SegSymbol.O     -> "b0111111".U,
    SegSymbol.P     -> "b1110011".U,
    SegSymbol.Q     -> "b1100111".U,
    SegSymbol.R     -> "b0110001".U,
    SegSymbol.S     -> "b1101101".U,
    SegSymbol.T     -> "b1111000".U,
    SegSymbol.U     -> "b0111111".U,
    SegSymbol.Blank -> "b0000000".U
  ))
}

object SegSymbol extends ChiselEnum {
  val s0, s1, s2, s3, s4, s5, s6, s7, s8, s9 = Value
  val A, B, C, D, E, F, G, H, I, J, L, N, O, P, Q, R, S, T, U, Blank = Value
}

class RisingFsm extends Module {
  val io = IO(new Bundle{
    val din = Input(Bool())
    val risingEdge = Output(Bool())
  })
  object State extends ChiselEnum {
    val zero, one = Value
  }
  import State._
  val stateReg = RegInit(zero)
  io.risingEdge := false.B
  switch (stateReg) {
    is(zero) {
      when(io.din) {
        stateReg := one
        io.risingEdge := true.B
      }
    }
    is(one) {
      when(!io.din) {
        stateReg := zero
      }
    }
  }
}

class StuckDetector(val OverCurrentAllowance_ms : Int = 100) extends Module {
  val io = IO(new Bundle {
      val externalOvercurrentInput = Input(Bool())      
      val clearShutdown            = Input(Bool()) 
      val is_stuck                 = Output(Bool()) 
      val motorDisable             = Output(Bool()) 
})

  val clockFreqHz = 100000000
  val maxCycles   = (clockFreqHz / 1000) * OverCurrentAllowance_ms
  val durationReg = RegInit(0.U(32.W))

  val isStuckReg  = RegInit(false.B)

  when(io.clearShutdown) {
  isStuckReg  := false.B
  durationReg := 0.U
  }.otherwise {
      when(!isStuckReg) {
          when(io.externalOvercurrentInput) {
          when(durationReg >= maxCycles.U) {
              isStuckReg := true.B
          }.otherwise {
              durationReg := durationReg + 1.U
          }
          }.otherwise {
          durationReg := 0.U 
          }
      }
  }

  io.is_stuck := isStuckReg
  io.motorDisable   := isStuckReg
}

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

class MotorStop extends Module {
    val io = IO(new Bundle {
        val motor_cleared     = Input(Bool())
        val motor_kill        = Input(Bool())
        val motor_stop_signal = Output(Bool())
    })
    
    io.motor_stop_signal := true.B
    
    val sIdle :: sMotorKill :: Nil = Enum(2)
    val stateReg = RegInit(sMotorKill)

    val rising_confirm = Module(new RisingFsm)
    rising_confirm.io.btn_in := io.motor_cleared
    val clearPressed = rising_confirm.io.out

    switch(stateReg) {
        is(sMotorKill) {
            io.motor_stop_signal := true.B
            when(clearPressed && !io.motor_kill) {
                stateReg := sIdle
            }
        }
        is(sIdle) {
            io.motor_stop_signal := false.B

            when(io.motor_kill) {
                stateReg := sMotorKill
            }
        }
    }

    when(io.motor_kill) {
        io.motor_stop_signal := true.B
    }
}

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
  val kpActive = Wire(FixedPoint(w.W, f.BP))
  val kiActive = Wire(FixedPoint(w.W, f.BP))
  val kdActive = Wire(FixedPoint(w.W, f.BP))

  when(io.kp === 0.FixedPoint(w.W, f.BP)) { kpActive := 10.FixedPoint(w.W, f.BP) }.otherwise { kpActive := io.kp }
  when(io.ki === 0.FixedPoint(w.W, f.BP)) { kiActive := 15.FixedPoint(w.W, f.BP) }.otherwise { kiActive := io.ki }
  when(io.kd === 0.FixedPoint(w.W, f.BP)) { kdActive := 2.FixedPoint(w.W, f.BP) }.otherwise { kdActive := io.kd }

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