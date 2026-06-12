import chisel3._
import chisel3.util._
import chisel3.experimental.FixedPoint

object GenerateAllVerilog extends App {
  emitVerilog(new MotorDriver, Array("-td", "Verilog"))
}

class UartRx(frequency: Int = 100000000, baudRate: Int = 115200) extends Module {
  val io = IO(new Bundle {
    val rx   = Input(Bool())
    val done = Output(Bool())
    val data = Output(UInt(8.W))
  })

  val BIT_CNT = ((frequency + baudRate / 2) / baudRate).U
  val START_CNT = ((frequency + baudRate / 2) / (baudRate * 2)).U

  val rxReg = RegNext(RegNext(io.rx))
  val shiftReg = RegInit(0.U(8.W))
  val cntReg = RegInit(0.U(32.W))
  val bitsReg = RegInit(0.U(4.W))

  val sIdle :: sStart :: sData :: sStop :: Nil = Enum(4)
  val stateReg = RegInit(sIdle)

  io.done := false.B
  io.data := shiftReg

  switch(stateReg) {
    is(sIdle) {
      when(!rxReg) {
        stateReg := sStart
        cntReg := 0.U
      }
    }
    is(sStart) {
      when(cntReg === START_CNT) {
        stateReg := sData
        cntReg := 0.U
        bitsReg := 0.U
      }.otherwise { cntReg := cntReg + 1.U }
    }
    is(sData) {
      when(cntReg === BIT_CNT - 1.U) {
        cntReg := 0.U
        shiftReg := Cat(rxReg, shiftReg(7, 1))
        when(bitsReg === 7.U) { stateReg := sStop }
        .otherwise { bitsReg := bitsReg + 1.U }
      }.otherwise { cntReg := cntReg + 1.U }
    }
    is(sStop) {
      when(cntReg === BIT_CNT - 1.U) {
        stateReg := sIdle
        io.done := true.B
      }.otherwise { cntReg := cntReg + 1.U }
    }
  }
}

class UartTx(frequency: Int = 100000000, baudRate: Int = 115200) extends Module {
  val io = IO(new Bundle {
    val data  = Input(UInt(8.W))
    val start = Input(Bool())
    val tx    = Output(Bool())
    val busy  = Output(Bool())
  })

  val BIT_CNT = ((frequency + baudRate / 2) / baudRate).U
  val reg = RegInit(1.U(10.W))
  val cnt = RegInit(0.U(32.W))
  val bits = RegInit(0.U(4.W))

  val sIdle :: sData :: Nil = Enum(2)
  val state = RegInit(sIdle)

  io.tx := reg(0)
  io.busy := state === sData

  switch(state) {
    is(sIdle) {
      when(io.start) {
        reg := Cat(1.U, io.data, 0.U)
        bits := 0.U
        cnt := 0.U
        state := sData
      }
    }
    is(sData) {
      when(cnt === BIT_CNT - 1.U) {
        cnt := 0.U
        reg := Cat(1.U, reg(9, 1))
        when(bits === 9.U) { state := sIdle }
        .otherwise { bits := bits + 1.U }
      }.otherwise { cnt := cnt + 1.U }
    }
  }
}

class DCMotorPwm(pwmFreqHz: Int = 30000) extends Module {
  val io = IO(new Bundle {
    val duty_cycle = Input(UInt(10.W))
    val brake      = Input(Bool())
    val T1         = Output(Bool())
    val T2         = Output(Bool())
    val T3         = Output(Bool())
    val T4         = Output(Bool())
  })

  val clockFreq    = 100000000
  val periodCycles = (clockFreq / pwmFreqHz).U
  val pwmCounter   = RegInit(0.U(32.W))

  when(pwmCounter >= periodCycles - 1.U) {
    pwmCounter := 0.U
  } .otherwise {
    pwmCounter := pwmCounter + 1.U
  }

  val threshold = (io.duty_cycle * periodCycles) >> 10
  val pwmSignal = pwmCounter < threshold

  val conduct_T1 = Wire(Bool())
  val conduct_T2 = Wire(Bool())
  val conduct_T3 = Wire(Bool())
  val conduct_T4 = Wire(Bool())

  when(io.brake) {
    conduct_T1 := true.B  
    conduct_T2 := false.B 
    conduct_T3 := true.B  
    conduct_T4 := false.B 
  } .otherwise {
    conduct_T2 := pwmSignal
    conduct_T3 := pwmSignal
    conduct_T1 := !pwmSignal
    conduct_T4 := !pwmSignal
  }

  io.T1 := conduct_T1
  io.T3 := conduct_T3
  io.T2 := !conduct_T2 // Invert for PMOS
  io.T4 := !conduct_T4 // Invert for PMOS
}

class PIDController(val w: Int = 16, val f: Int = 12) extends Module {
  val io = IO(new Bundle {
    val setPoint    = Input(FixedPoint(w.W, f.BP))
    val measuredVal = Input(FixedPoint(w.W, f.BP))
    val kp          = Input(FixedPoint(w.W, f.BP))
    val ki          = Input(FixedPoint(w.W, f.BP))
    val kd          = Input(FixedPoint(w.W, f.BP))
    val resetBuffer = Input(Bool())
    val controlOut  = Output(FixedPoint(w.W, f.BP))
  })

  val errorReg = RegNext(io.setPoint - io.measuredVal)
  val kpReg    = RegNext(Mux(io.kp === 0.F(f.BP), 10.F(f.BP), io.kp))
  val kiReg    = RegNext(Mux(io.ki === 0.F(f.BP), 1.F(f.BP), io.ki))
  val kdReg    = RegNext(Mux(io.kd === 0.F(f.BP), 0.F(f.BP), io.kd))

  val pTerm = RegNext(kpReg * errorReg)
  val iTermNext = RegNext(kiReg * errorReg)
  
  val prevErrorReg = RegInit(0.F(w.W, f.BP))
  val dTerm = RegNext(kdReg * (errorReg - prevErrorReg))
  prevErrorReg := errorReg

  val upperLimit = 1.0.F(f.BP)
  val lowerLimit = 0.0.F(f.BP)
  val integralReg = RegInit(0.F(w.W, f.BP))
  
  when(io.resetBuffer) {
    integralReg := 0.F(w.W, f.BP)
  }.otherwise {
    val sum = integralReg + iTermNext
    integralReg := Mux(sum > upperLimit, upperLimit, Mux(sum < lowerLimit, lowerLimit, sum))
  }

  val rawOutput = RegNext(pTerm + integralReg + dTerm)
  val saturatedOut = Mux(rawOutput > upperLimit, upperLimit, Mux(rawOutput < lowerLimit, lowerLimit, rawOutput))

  io.controlOut := RegNext(saturatedOut)
}

class RotationCounter extends Module {
  val io = IO(new Bundle {
    val signal_A = Input(Bool())
    val signal_B = Input(Bool())
    val turns    = Output(UInt(16.W))
  })

  val aSync = RegNext(RegNext(io.signal_A))
  val bSync = RegNext(RegNext(io.signal_B))
  val aReg  = RegNext(aSync)
  val rise_A = aSync && !aReg

  val turns = RegInit(0.U(16.W))

  when(rise_A) {
    when(!bSync) {
      turns := turns + 1.U
    } .otherwise {
      turns := turns - 1.U
    }
  }
  io.turns := turns
}

class StuckDetector(val OverCurrentAllowance_ms : Int = 100) extends Module {
  val io = IO(new Bundle {
      val externalOvercurrentInput = Input(Bool())      
      val clearShutdown            = Input(Bool()) 
      val is_stuck                 = Output(Bool()) 
      val motorDisable             = Output(Bool()) 
  })

  val clockFreqHz = 100000000
  val maxCycles   = (clockFreqHz / 1000).U * OverCurrentAllowance_ms.U
  val durationReg = RegInit(0.U(32.W))
  val isStuckReg  = RegInit(false.B)

  when(io.clearShutdown) {
    isStuckReg  := false.B
    durationReg := 0.U
  }.otherwise {
    when(!isStuckReg) {
      when(io.externalOvercurrentInput) {
        when(durationReg >= maxCycles) {
          isStuckReg := true.B
        }.otherwise {
          durationReg := durationReg + 1.U
        }
      }.otherwise {
        durationReg := 0.U 
      }
    }
  }

  io.is_stuck      := isStuckReg
  io.motorDisable  := isStuckReg
}

class RisingFsm extends Module {
  val io = IO(new Bundle{
    val din = Input(Bool())
    val risingEdge = Output(Bool())
  })
  val stateReg = RegInit(false.B)
  io.risingEdge := io.din && !stateReg
  stateReg := io.din
}


class Debouncer(fac: Int = 100000) extends Module {
  val io = IO(new Bundle {
    val btn_in = Input(Bool())
    val out    = Output(Bool())
    val state  = Output(Bool())
  })
  val btn_sync = RegNext(RegNext(io.btn_in))
  val btnDebReg = RegInit(false.B)
  val cntReg = RegInit(0.U(32.W))
  val tick = cntReg === (fac - 1).U

  cntReg := cntReg + 1.U
  when (tick) {
    cntReg := 0.U
    btnDebReg := btn_sync
  }

  val btnCleanPrev = RegNext(btnDebReg)
  io.out := btnDebReg && !btnCleanPrev
  io.state := btnDebReg
}

class BCD extends Module {
  val io = IO(new Bundle {
    val b_number = Input(UInt(6.W))
    val out      = Output(UInt(8.W))
  })
  io.out := Cat(io.b_number / 10.U, io.b_number % 10.U)
}