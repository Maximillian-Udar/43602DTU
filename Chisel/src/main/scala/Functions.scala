import chisel3._
import chisel3.util._
import chisel3.experimental.FixedPoint

object GenerateAllVerilog extends App {
  emitVerilog(new MotorDriver(1, 0.5, 0.1), Array("-td", "Verilog"))
}

class RotationCounter extends Module {
  val io = IO(new Bundle {
    val signal_A = Input(Bool())
    val signal_B = Input(Bool())
    val turns    = Output(SInt(32.W))
  })
  val aSync = RegNext(RegNext(io.signal_A))
  val bSync = RegNext(RegNext(io.signal_B))
  val aReg  = RegNext(aSync)
  val rise_A = aSync && !aReg
  val turns = RegInit(0.S(32.W))
  when(rise_A) {
    when(!bSync) { turns := turns + 1.S }
      .otherwise { turns := turns - 1.S }
  }
  io.turns := turns
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
    conduct_T4 := !pwmSignal
    conduct_T1 := !pwmSignal
  }

  io.T1 := conduct_T1
  io.T3 := conduct_T3
  io.T2 := !conduct_T2
  io.T4 := !conduct_T4
}

class PIDController(val w: Int, val f: Int) extends Module {
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
  val pTerm = RegNext(io.kp * errorReg)
  val integralReg = RegInit(0.F(w.W, f.BP))
  val iTermNext = RegNext(io.ki * errorReg)
  
  val limit_pos = FixedPoint.fromDouble(0.5, w.W, f.BP)
  val limit_neg = FixedPoint.fromDouble(-0.5, w.W, f.BP)

  when(io.resetBuffer) {
    integralReg := 0.F(w.W, f.BP)
  }.otherwise {
    val nextSum = RegNext(integralReg + iTermNext)
    integralReg := Mux(nextSum > limit_pos, limit_pos, 
                   Mux(nextSum < limit_neg, limit_neg, nextSum))
  }

  val prevErrorReg = RegInit(0.F(w.W, f.BP))
  val dTerm = RegNext(io.kd * (errorReg - prevErrorReg))
  prevErrorReg := errorReg

  val rawOutput = RegNext(pTerm + integralReg + dTerm)
  io.controlOut := Mux(rawOutput > limit_pos, limit_pos, 
                   Mux(rawOutput < limit_neg, limit_neg, rawOutput))
}

class UartRx(frequency: Int = 100000000, baudRate: Int = 115200) extends Module {
  val io = IO(new Bundle {
    val rx   = Input(Bool())
    val done = Output(Bool())
    val data = Output(UInt(8.W))
  })
  val BIT_CNT = ((frequency + baudRate / 2) / baudRate).U
  val START_CNT = ((frequency + baudRate / 2) / (baudRate * 2)).U
  val rxReg    = RegNext(RegNext(io.rx))
  val shiftReg = RegInit(0.U(8.W))
  val cntReg   = RegInit(0.U(32.W))
  val bitsReg  = RegInit(0.U(4.W))
  val sIdle :: sStart :: sData :: sStop :: Nil = Enum(4)
  val stateReg = RegInit(sIdle)
  io.done := false.B
  io.data := shiftReg
  switch(stateReg) {
    is(sIdle) { when(!rxReg) { stateReg := sStart; cntReg := 0.U } }
    is(sStart) { when(cntReg === START_CNT) { stateReg := sData; cntReg := 0.U; bitsReg := 0.U }.otherwise { cntReg := cntReg + 1.U } }
    is(sData) { when(cntReg === BIT_CNT - 1.U) { cntReg := 0.U; shiftReg := Cat(rxReg, shiftReg(7, 1)); when(bitsReg === 7.U) { stateReg := sStop }.otherwise { bitsReg := bitsReg + 1.U } }.otherwise { cntReg := cntReg + 1.U } }
    is(sStop) { when(cntReg === BIT_CNT - 1.U) { stateReg := sIdle; io.done := true.B }.otherwise { cntReg := cntReg + 1.U } }
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
    is(sIdle) { when(io.start) { reg := Cat(1.U, io.data, 0.U); bits := 0.U; cnt := 0.U; state := sData } }
    is(sData) { when(cnt === BIT_CNT - 1.U) { cnt := 0.U; reg := Cat(1.U, reg(9, 1)); when(bits === 9.U) { state := sIdle }.otherwise { bits := bits + 1.U } }.otherwise { cnt := cnt + 1.U } }
  }
}

class StuckDetector(val OverCurrentAllowance_ms : Int = 150) extends Module {
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
  when(io.clearShutdown) { isStuckReg := false.B; durationReg := 0.U }.otherwise {
    when(!isStuckReg) {
      when(io.externalOvercurrentInput) {
        when(durationReg >= maxCycles) { isStuckReg := true.B }.otherwise { durationReg := durationReg + 1.U }
      }.otherwise { durationReg := 0.U }
    }
  }
  io.is_stuck := isStuckReg
  io.motorDisable := isStuckReg
}

class DisplayMultiplexer(refresh_limit: Int = 100000) extends Module {
  val io = IO(new Bundle {
    val disp_content = Input(UInt(20.W))
    val dots         = Input(UInt(4.W))
    val seg          = Output(UInt(8.W))
    val an           = Output(UInt(4.W))
  })
  
  val cnt = RegInit(0.U(log2Up(refresh_limit).W))
  cnt := Mux(cnt === (refresh_limit - 1).U, 0.U, cnt + 1.U)
  val tick = cnt === (refresh_limit - 1).U

  val digit = RegInit(0.U(2.W))
  when(tick) { digit := digit + 1.U }

  val currentRaw = Wire(UInt(5.W))
  currentRaw := 0.U
  switch(digit) {
    is(0.U) { currentRaw := io.disp_content(4, 0) }
    is(1.U) { currentRaw := io.disp_content(9, 5) }
    is(2.U) { currentRaw := io.disp_content(14, 10) }
    is(3.U) { currentRaw := io.disp_content(19, 15) }
  }

  val decoder = Module(new SevenSegDec)
  decoder.io.in := SegSymbol(currentRaw)
  
  val sevSeg = decoder.io.out
  val currentDot = io.dots(digit)
  val fullSeg = currentDot ## sevSeg

  val select = WireDefault("b0001".U(4.W))
  switch(digit) {
    is(0.U) { select := "b0001".U }
    is(1.U) { select := "b0010".U }
    is(2.U) { select := "b0100".U }
    is(3.U) { select := "b1000".U }
  }

  io.seg := ~fullSeg
  io.an  := ~select
}

object SegSymbol extends ChiselEnum {
  val s0, s1, s2, s3, s4, s5, s6, s7, s8, s9 = Value
  val A, B, C, D, E, F, G, H, I, J, L, M, N, O, P, Q, R, S, T, U, Blank = Value
}

class SevenSegDec extends Module {
  val io = IO(new Bundle {
    val in  = Input(SegSymbol())
    val out = Output(UInt(7.W))
  })

  io.out := MuxLookup(io.in.asUInt, 0.U(7.W))(Seq(
    SegSymbol.s0.asUInt    -> "b0111111".U,
    SegSymbol.s1.asUInt    -> "b0000110".U,
    SegSymbol.s2.asUInt    -> "b1011011".U,
    SegSymbol.s3.asUInt    -> "b1001111".U,
    SegSymbol.s4.asUInt    -> "b1100110".U,
    SegSymbol.s5.asUInt    -> "b1101101".U,
    SegSymbol.s6.asUInt    -> "b1111101".U,
    SegSymbol.s7.asUInt    -> "b0000111".U,
    SegSymbol.s8.asUInt    -> "b1111111".U,
    SegSymbol.s9.asUInt    -> "b1101111".U,
    SegSymbol.A.asUInt     -> "b1110111".U,
    SegSymbol.B.asUInt     -> "b1111100".U,
    SegSymbol.C.asUInt     -> "b0111001".U,
    SegSymbol.D.asUInt     -> "b1011110".U,
    SegSymbol.E.asUInt     -> "b1111001".U,
    SegSymbol.F.asUInt     -> "b1110001".U,
    SegSymbol.G.asUInt     -> "b0111100".U,
    SegSymbol.H.asUInt     -> "b1110110".U,
    SegSymbol.I.asUInt     -> "b0000110".U,
    SegSymbol.J.asUInt     -> "b0001111".U,
    SegSymbol.L.asUInt     -> "b0111000".U,
    SegSymbol.M.asUInt     -> "b0111000".U,
    SegSymbol.N.asUInt     -> "b1110000".U,
    SegSymbol.O.asUInt     -> "b0111111".U,
    SegSymbol.P.asUInt     -> "b1110011".U,
    SegSymbol.Q.asUInt     -> "b1100111".U,
    SegSymbol.R.asUInt     -> "b0110001".U,
    SegSymbol.S.asUInt     -> "b1101101".U,
    SegSymbol.T.asUInt     -> "b1111000".U,
    SegSymbol.U.asUInt     -> "b0111110".U,
    SegSymbol.Blank.asUInt -> "b0000000".U
  ))
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