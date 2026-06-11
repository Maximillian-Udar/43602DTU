FIRRTL version 1.2.0
circuit MotorDriver :
  module UartRx :
    input clock : Clock
    input reset : Reset
    output io : { flip rx : UInt<1>, done : UInt<1>, data : UInt<8>} @[src/main/scala/Functions.scala 12:14]

    reg rxReg_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), rxReg_REG) @[src/main/scala/Functions.scala 21:30]
    rxReg_REG <= io.rx @[src/main/scala/Functions.scala 21:30]
    reg rxReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), rxReg) @[src/main/scala/Functions.scala 21:22]
    rxReg <= rxReg_REG @[src/main/scala/Functions.scala 21:22]
    reg shiftReg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[src/main/scala/Functions.scala 22:25]
    reg cntReg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[src/main/scala/Functions.scala 23:23]
    reg bitsReg : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[src/main/scala/Functions.scala 24:24]
    reg stateReg : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[src/main/scala/Functions.scala 27:25]
    io.done <= UInt<1>("h0") @[src/main/scala/Functions.scala 29:11]
    io.data <= shiftReg @[src/main/scala/Functions.scala 30:11]
    node _T = eq(UInt<2>("h0"), stateReg) @[src/main/scala/Functions.scala 32:20]
    when _T : @[src/main/scala/Functions.scala 32:20]
      node _T_1 = eq(rxReg, UInt<1>("h0")) @[src/main/scala/Functions.scala 34:12]
      when _T_1 : @[src/main/scala/Functions.scala 34:20]
        stateReg <= UInt<2>("h1") @[src/main/scala/Functions.scala 35:18]
        cntReg <= UInt<1>("h0") @[src/main/scala/Functions.scala 36:16]
    else :
      node _T_2 = eq(UInt<2>("h1"), stateReg) @[src/main/scala/Functions.scala 32:20]
      when _T_2 : @[src/main/scala/Functions.scala 32:20]
        node _T_3 = eq(cntReg, UInt<9>("h1b2")) @[src/main/scala/Functions.scala 40:19]
        when _T_3 : @[src/main/scala/Functions.scala 40:34]
          stateReg <= UInt<2>("h2") @[src/main/scala/Functions.scala 41:18]
          cntReg <= UInt<1>("h0") @[src/main/scala/Functions.scala 42:16]
          bitsReg <= UInt<1>("h0") @[src/main/scala/Functions.scala 43:17]
        else :
          node _cntReg_T = add(cntReg, UInt<1>("h1")) @[src/main/scala/Functions.scala 44:38]
          node _cntReg_T_1 = tail(_cntReg_T, 1) @[src/main/scala/Functions.scala 44:38]
          cntReg <= _cntReg_T_1 @[src/main/scala/Functions.scala 44:28]
      else :
        node _T_4 = eq(UInt<2>("h2"), stateReg) @[src/main/scala/Functions.scala 32:20]
        when _T_4 : @[src/main/scala/Functions.scala 32:20]
          node _T_5 = sub(UInt<10>("h364"), UInt<1>("h1")) @[src/main/scala/Functions.scala 47:31]
          node _T_6 = tail(_T_5, 1) @[src/main/scala/Functions.scala 47:31]
          node _T_7 = eq(cntReg, _T_6) @[src/main/scala/Functions.scala 47:19]
          when _T_7 : @[src/main/scala/Functions.scala 47:38]
            cntReg <= UInt<1>("h0") @[src/main/scala/Functions.scala 48:16]
            node _shiftReg_T = bits(shiftReg, 7, 1) @[src/main/scala/Functions.scala 49:40]
            node _shiftReg_T_1 = cat(rxReg, _shiftReg_T) @[src/main/scala/Functions.scala 49:24]
            shiftReg <= _shiftReg_T_1 @[src/main/scala/Functions.scala 49:18]
            node _T_8 = eq(bitsReg, UInt<3>("h7")) @[src/main/scala/Functions.scala 50:22]
            when _T_8 : @[src/main/scala/Functions.scala 50:31]
              stateReg <= UInt<2>("h3") @[src/main/scala/Functions.scala 50:42]
            else :
              node _bitsReg_T = add(bitsReg, UInt<1>("h1")) @[src/main/scala/Functions.scala 51:41]
              node _bitsReg_T_1 = tail(_bitsReg_T, 1) @[src/main/scala/Functions.scala 51:41]
              bitsReg <= _bitsReg_T_1 @[src/main/scala/Functions.scala 51:30]
          else :
            node _cntReg_T_2 = add(cntReg, UInt<1>("h1")) @[src/main/scala/Functions.scala 52:38]
            node _cntReg_T_3 = tail(_cntReg_T_2, 1) @[src/main/scala/Functions.scala 52:38]
            cntReg <= _cntReg_T_3 @[src/main/scala/Functions.scala 52:28]
        else :
          node _T_9 = eq(UInt<2>("h3"), stateReg) @[src/main/scala/Functions.scala 32:20]
          when _T_9 : @[src/main/scala/Functions.scala 32:20]
            node _T_10 = sub(UInt<10>("h364"), UInt<1>("h1")) @[src/main/scala/Functions.scala 55:31]
            node _T_11 = tail(_T_10, 1) @[src/main/scala/Functions.scala 55:31]
            node _T_12 = eq(cntReg, _T_11) @[src/main/scala/Functions.scala 55:19]
            when _T_12 : @[src/main/scala/Functions.scala 55:38]
              stateReg <= UInt<2>("h0") @[src/main/scala/Functions.scala 56:18]
              io.done <= UInt<1>("h1") @[src/main/scala/Functions.scala 57:17]
            else :
              node _cntReg_T_4 = add(cntReg, UInt<1>("h1")) @[src/main/scala/Functions.scala 58:38]
              node _cntReg_T_5 = tail(_cntReg_T_4, 1) @[src/main/scala/Functions.scala 58:38]
              cntReg <= _cntReg_T_5 @[src/main/scala/Functions.scala 58:28]


  module UartTx :
    input clock : Clock
    input reset : Reset
    output io : { flip data : UInt<8>, flip start : UInt<1>, tx : UInt<1>, busy : UInt<1>} @[src/main/scala/Functions.scala 65:14]

    reg reg : UInt<10>, clock with :
      reset => (reset, UInt<10>("h1")) @[src/main/scala/Functions.scala 73:20]
    reg cnt : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[src/main/scala/Functions.scala 74:20]
    reg bits : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[src/main/scala/Functions.scala 75:21]
    reg state : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[src/main/scala/Functions.scala 78:22]
    node _io_tx_T = bits(reg, 0, 0) @[src/main/scala/Functions.scala 80:15]
    io.tx <= _io_tx_T @[src/main/scala/Functions.scala 80:9]
    node _io_busy_T = eq(state, UInt<1>("h1")) @[src/main/scala/Functions.scala 81:20]
    io.busy <= _io_busy_T @[src/main/scala/Functions.scala 81:11]
    node _T = eq(UInt<1>("h0"), state) @[src/main/scala/Functions.scala 83:17]
    when _T : @[src/main/scala/Functions.scala 83:17]
      when io.start : @[src/main/scala/Functions.scala 85:22]
        node reg_hi = cat(UInt<1>("h1"), io.data) @[src/main/scala/Functions.scala 86:19]
        node _reg_T = cat(reg_hi, UInt<1>("h0")) @[src/main/scala/Functions.scala 86:19]
        reg <= _reg_T @[src/main/scala/Functions.scala 86:13]
        bits <= UInt<1>("h0") @[src/main/scala/Functions.scala 87:14]
        cnt <= UInt<1>("h0") @[src/main/scala/Functions.scala 88:13]
        state <= UInt<1>("h1") @[src/main/scala/Functions.scala 89:15]
    else :
      node _T_1 = eq(UInt<1>("h1"), state) @[src/main/scala/Functions.scala 83:17]
      when _T_1 : @[src/main/scala/Functions.scala 83:17]
        node _T_2 = sub(UInt<10>("h364"), UInt<1>("h1")) @[src/main/scala/Functions.scala 93:28]
        node _T_3 = tail(_T_2, 1) @[src/main/scala/Functions.scala 93:28]
        node _T_4 = eq(cnt, _T_3) @[src/main/scala/Functions.scala 93:16]
        when _T_4 : @[src/main/scala/Functions.scala 93:35]
          cnt <= UInt<1>("h0") @[src/main/scala/Functions.scala 94:13]
          node _reg_T_1 = bits(reg, 9, 1) @[src/main/scala/Functions.scala 95:28]
          node _reg_T_2 = cat(UInt<1>("h1"), _reg_T_1) @[src/main/scala/Functions.scala 95:19]
          reg <= _reg_T_2 @[src/main/scala/Functions.scala 95:13]
          node _T_5 = eq(bits, UInt<4>("h9")) @[src/main/scala/Functions.scala 96:19]
          when _T_5 : @[src/main/scala/Functions.scala 96:28]
            state <= UInt<1>("h0") @[src/main/scala/Functions.scala 96:36]
          else :
            node _bits_T = add(bits, UInt<1>("h1")) @[src/main/scala/Functions.scala 97:35]
            node _bits_T_1 = tail(_bits_T, 1) @[src/main/scala/Functions.scala 97:35]
            bits <= _bits_T_1 @[src/main/scala/Functions.scala 97:27]
        else :
          node _cnt_T = add(cnt, UInt<1>("h1")) @[src/main/scala/Functions.scala 98:32]
          node _cnt_T_1 = tail(_cnt_T, 1) @[src/main/scala/Functions.scala 98:32]
          cnt <= _cnt_T_1 @[src/main/scala/Functions.scala 98:25]


  module RotationCounter :
    input clock : Clock
    input reset : Reset
    output io : { flip signal_A : UInt<1>, flip signal_B : UInt<1>, turns : UInt<16>} @[src/main/scala/Functions.scala 195:14]

    reg aSync_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), aSync_REG) @[src/main/scala/Functions.scala 201:30]
    aSync_REG <= io.signal_A @[src/main/scala/Functions.scala 201:30]
    reg aSync : UInt<1>, clock with :
      reset => (UInt<1>("h0"), aSync) @[src/main/scala/Functions.scala 201:22]
    aSync <= aSync_REG @[src/main/scala/Functions.scala 201:22]
    reg bSync_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), bSync_REG) @[src/main/scala/Functions.scala 202:30]
    bSync_REG <= io.signal_B @[src/main/scala/Functions.scala 202:30]
    reg bSync : UInt<1>, clock with :
      reset => (UInt<1>("h0"), bSync) @[src/main/scala/Functions.scala 202:22]
    bSync <= bSync_REG @[src/main/scala/Functions.scala 202:22]
    reg aReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), aReg) @[src/main/scala/Functions.scala 203:22]
    aReg <= aSync @[src/main/scala/Functions.scala 203:22]
    node _rise_A_T = eq(aReg, UInt<1>("h0")) @[src/main/scala/Functions.scala 204:25]
    node rise_A = and(aSync, _rise_A_T) @[src/main/scala/Functions.scala 204:22]
    reg turns : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[src/main/scala/Functions.scala 206:22]
    when rise_A : @[src/main/scala/Functions.scala 208:16]
      node _T = eq(bSync, UInt<1>("h0")) @[src/main/scala/Functions.scala 209:10]
      when _T : @[src/main/scala/Functions.scala 209:18]
        node _turns_T = add(turns, UInt<1>("h1")) @[src/main/scala/Functions.scala 210:22]
        node _turns_T_1 = tail(_turns_T, 1) @[src/main/scala/Functions.scala 210:22]
        turns <= _turns_T_1 @[src/main/scala/Functions.scala 210:13]
      else :
        node _turns_T_2 = sub(turns, UInt<1>("h1")) @[src/main/scala/Functions.scala 212:22]
        node _turns_T_3 = tail(_turns_T_2, 1) @[src/main/scala/Functions.scala 212:22]
        turns <= _turns_T_3 @[src/main/scala/Functions.scala 212:13]
    io.turns <= turns @[src/main/scala/Functions.scala 215:12]

  module DCMotorPwm :
    input clock : Clock
    input reset : Reset
    output io : { flip duty_cycle : UInt<10>, flip brake : UInt<1>, T1 : UInt<1>, T2 : UInt<1>, T3 : UInt<1>, T4 : UInt<1>} @[src/main/scala/Functions.scala 105:14]

    reg pwmCounter : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[src/main/scala/Functions.scala 116:29]
    node _T = sub(UInt<12>("hd05"), UInt<1>("h1")) @[src/main/scala/Functions.scala 118:35]
    node _T_1 = tail(_T, 1) @[src/main/scala/Functions.scala 118:35]
    node _T_2 = geq(pwmCounter, _T_1) @[src/main/scala/Functions.scala 118:19]
    when _T_2 : @[src/main/scala/Functions.scala 118:42]
      pwmCounter <= UInt<1>("h0") @[src/main/scala/Functions.scala 119:16]
    else :
      node _pwmCounter_T = add(pwmCounter, UInt<1>("h1")) @[src/main/scala/Functions.scala 121:30]
      node _pwmCounter_T_1 = tail(_pwmCounter_T, 1) @[src/main/scala/Functions.scala 121:30]
      pwmCounter <= _pwmCounter_T_1 @[src/main/scala/Functions.scala 121:16]
    node _threshold_T = mul(io.duty_cycle, UInt<12>("hd05")) @[src/main/scala/Functions.scala 124:34]
    node threshold = shr(_threshold_T, 10) @[src/main/scala/Functions.scala 124:50]
    node pwmSignal = lt(pwmCounter, threshold) @[src/main/scala/Functions.scala 125:30]
    wire conduct_T1 : UInt<1> @[src/main/scala/Functions.scala 127:24]
    wire conduct_T2 : UInt<1> @[src/main/scala/Functions.scala 128:24]
    wire conduct_T3 : UInt<1> @[src/main/scala/Functions.scala 129:24]
    wire conduct_T4 : UInt<1> @[src/main/scala/Functions.scala 130:24]
    when io.brake : @[src/main/scala/Functions.scala 132:18]
      conduct_T1 <= UInt<1>("h1") @[src/main/scala/Functions.scala 133:16]
      conduct_T2 <= UInt<1>("h0") @[src/main/scala/Functions.scala 134:16]
      conduct_T3 <= UInt<1>("h1") @[src/main/scala/Functions.scala 135:16]
      conduct_T4 <= UInt<1>("h0") @[src/main/scala/Functions.scala 136:16]
    else :
      conduct_T2 <= pwmSignal @[src/main/scala/Functions.scala 138:16]
      conduct_T3 <= pwmSignal @[src/main/scala/Functions.scala 139:16]
      node _conduct_T1_T = eq(pwmSignal, UInt<1>("h0")) @[src/main/scala/Functions.scala 140:19]
      conduct_T1 <= _conduct_T1_T @[src/main/scala/Functions.scala 140:16]
      node _conduct_T4_T = eq(pwmSignal, UInt<1>("h0")) @[src/main/scala/Functions.scala 141:19]
      conduct_T4 <= _conduct_T4_T @[src/main/scala/Functions.scala 141:16]
    io.T1 <= conduct_T1 @[src/main/scala/Functions.scala 145:9]
    io.T3 <= conduct_T3 @[src/main/scala/Functions.scala 146:9]
    node _io_T2_T = eq(conduct_T2, UInt<1>("h0")) @[src/main/scala/Functions.scala 147:12]
    io.T2 <= _io_T2_T @[src/main/scala/Functions.scala 147:9]
    node _io_T4_T = eq(conduct_T4, UInt<1>("h0")) @[src/main/scala/Functions.scala 148:12]
    io.T4 <= _io_T4_T @[src/main/scala/Functions.scala 148:9]

  module PIDController :
    input clock : Clock
    input reset : Reset
    output io : { flip setPoint : Fixed<16><<12>>, flip measuredVal : Fixed<16><<12>>, flip kp : Fixed<16><<12>>, flip ki : Fixed<16><<12>>, flip kd : Fixed<16><<12>>, flip resetBuffer : UInt<1>, controlOut : Fixed<16><<12>>} @[src/main/scala/Functions.scala 153:14]

    node _errorReg_T = sub(io.setPoint, io.measuredVal) @[src/main/scala/Functions.scala 163:38]
    node _errorReg_T_1 = tail(_errorReg_T, 1) @[src/main/scala/Functions.scala 163:38]
    node _errorReg_T_2 = asFixedPoint(_errorReg_T_1, 12) @[src/main/scala/Functions.scala 163:38]
    reg errorReg : Fixed<<12>>, clock with :
      reset => (UInt<1>("h0"), errorReg) @[src/main/scala/Functions.scala 163:25]
    errorReg <= _errorReg_T_2 @[src/main/scala/Functions.scala 163:25]
    node _kpReg_T = eq(io.kp, asFixedPoint(UInt<1>("h0"), 12)) @[src/main/scala/Functions.scala 164:36]
    node _kpReg_T_1 = mux(_kpReg_T, asFixedPoint(UInt<17>("ha000"), 12), io.kp) @[src/main/scala/Functions.scala 164:29]
    reg kpReg : Fixed<<12>>, clock with :
      reset => (UInt<1>("h0"), kpReg) @[src/main/scala/Functions.scala 164:25]
    kpReg <= _kpReg_T_1 @[src/main/scala/Functions.scala 164:25]
    node _kiReg_T = eq(io.ki, asFixedPoint(UInt<1>("h0"), 12)) @[src/main/scala/Functions.scala 165:36]
    node _kiReg_T_1 = mux(_kiReg_T, asFixedPoint(UInt<14>("h1000"), 12), io.ki) @[src/main/scala/Functions.scala 165:29]
    reg kiReg : Fixed<<12>>, clock with :
      reset => (UInt<1>("h0"), kiReg) @[src/main/scala/Functions.scala 165:25]
    kiReg <= _kiReg_T_1 @[src/main/scala/Functions.scala 165:25]
    node _kdReg_T = eq(io.kd, asFixedPoint(UInt<1>("h0"), 12)) @[src/main/scala/Functions.scala 166:36]
    node _kdReg_T_1 = mux(_kdReg_T, asFixedPoint(UInt<1>("h0"), 12), io.kd) @[src/main/scala/Functions.scala 166:29]
    reg kdReg : Fixed<<12>>, clock with :
      reset => (UInt<1>("h0"), kdReg) @[src/main/scala/Functions.scala 166:25]
    kdReg <= _kdReg_T_1 @[src/main/scala/Functions.scala 166:25]
    node _pTerm_T = mul(kpReg, errorReg) @[src/main/scala/Functions.scala 168:29]
    reg pTerm : Fixed<<24>>, clock with :
      reset => (UInt<1>("h0"), pTerm) @[src/main/scala/Functions.scala 168:22]
    pTerm <= _pTerm_T @[src/main/scala/Functions.scala 168:22]
    node _iTermNext_T = mul(kiReg, errorReg) @[src/main/scala/Functions.scala 169:33]
    reg iTermNext : Fixed<<24>>, clock with :
      reset => (UInt<1>("h0"), iTermNext) @[src/main/scala/Functions.scala 169:26]
    iTermNext <= _iTermNext_T @[src/main/scala/Functions.scala 169:26]
    reg prevErrorReg : Fixed<16><<12>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 12)) @[src/main/scala/Functions.scala 171:29]
    node _dTerm_T = sub(errorReg, prevErrorReg) @[src/main/scala/Functions.scala 172:41]
    node _dTerm_T_1 = tail(_dTerm_T, 1) @[src/main/scala/Functions.scala 172:41]
    node _dTerm_T_2 = asFixedPoint(_dTerm_T_1, 12) @[src/main/scala/Functions.scala 172:41]
    node _dTerm_T_3 = mul(kdReg, _dTerm_T_2) @[src/main/scala/Functions.scala 172:29]
    reg dTerm : Fixed<<24>>, clock with :
      reset => (UInt<1>("h0"), dTerm) @[src/main/scala/Functions.scala 172:22]
    dTerm <= _dTerm_T_3 @[src/main/scala/Functions.scala 172:22]
    prevErrorReg <= errorReg @[src/main/scala/Functions.scala 173:16]
    reg integralReg : Fixed<16><<12>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 12)) @[src/main/scala/Functions.scala 177:28]
    when io.resetBuffer : @[src/main/scala/Functions.scala 179:24]
      integralReg <= asFixedPoint(UInt<16>("h0"), 12) @[src/main/scala/Functions.scala 180:17]
    else :
      node _sum_T = add(integralReg, iTermNext) @[src/main/scala/Functions.scala 182:27]
      node _sum_T_1 = tail(_sum_T, 1) @[src/main/scala/Functions.scala 182:27]
      node sum = asFixedPoint(_sum_T_1, 24) @[src/main/scala/Functions.scala 182:27]
      node _integralReg_T = gt(sum, asFixedPoint(UInt<14>("h1000"), 12)) @[src/main/scala/Functions.scala 183:28]
      node _integralReg_T_1 = lt(sum, asFixedPoint(UInt<1>("h0"), 12)) @[src/main/scala/Functions.scala 183:62]
      node _integralReg_T_2 = mux(_integralReg_T_1, asFixedPoint(UInt<1>("h0"), 12), sum) @[src/main/scala/Functions.scala 183:57]
      node _integralReg_T_3 = mux(_integralReg_T, asFixedPoint(UInt<14>("h1000"), 12), _integralReg_T_2) @[src/main/scala/Functions.scala 183:23]
      integralReg <= _integralReg_T_3 @[src/main/scala/Functions.scala 183:17]
    node _rawOutput_T = add(pTerm, integralReg) @[src/main/scala/Functions.scala 187:33]
    node _rawOutput_T_1 = tail(_rawOutput_T, 1) @[src/main/scala/Functions.scala 187:33]
    node _rawOutput_T_2 = asFixedPoint(_rawOutput_T_1, 24) @[src/main/scala/Functions.scala 187:33]
    node _rawOutput_T_3 = add(_rawOutput_T_2, dTerm) @[src/main/scala/Functions.scala 187:47]
    node _rawOutput_T_4 = tail(_rawOutput_T_3, 1) @[src/main/scala/Functions.scala 187:47]
    node _rawOutput_T_5 = asFixedPoint(_rawOutput_T_4, 24) @[src/main/scala/Functions.scala 187:47]
    reg rawOutput : Fixed<<24>>, clock with :
      reset => (UInt<1>("h0"), rawOutput) @[src/main/scala/Functions.scala 187:26]
    rawOutput <= _rawOutput_T_5 @[src/main/scala/Functions.scala 187:26]
    node _saturatedOut_T = gt(rawOutput, asFixedPoint(UInt<14>("h1000"), 12)) @[src/main/scala/Functions.scala 188:36]
    node _saturatedOut_T_1 = lt(rawOutput, asFixedPoint(UInt<1>("h0"), 12)) @[src/main/scala/Functions.scala 188:76]
    node _saturatedOut_T_2 = mux(_saturatedOut_T_1, asFixedPoint(UInt<1>("h0"), 12), rawOutput) @[src/main/scala/Functions.scala 188:65]
    node saturatedOut = mux(_saturatedOut_T, asFixedPoint(UInt<14>("h1000"), 12), _saturatedOut_T_2) @[src/main/scala/Functions.scala 188:25]
    reg io_controlOut_REG : Fixed<<24>>, clock with :
      reset => (UInt<1>("h0"), io_controlOut_REG) @[src/main/scala/Functions.scala 190:27]
    io_controlOut_REG <= saturatedOut @[src/main/scala/Functions.scala 190:27]
    io.controlOut <= io_controlOut_REG @[src/main/scala/Functions.scala 190:17]

  module StuckDetector :
    input clock : Clock
    input reset : Reset
    output io : { flip externalOvercurrentInput : UInt<1>, flip clearShutdown : UInt<1>, is_stuck : UInt<1>, motorDisable : UInt<1>} @[src/main/scala/Functions.scala 220:14]

    node maxCycles = mul(UInt<17>("h186a0"), UInt<8>("hc8")) @[src/main/scala/Functions.scala 228:44]
    reg durationReg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[src/main/scala/Functions.scala 229:28]
    reg isStuckReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[src/main/scala/Functions.scala 230:28]
    when io.clearShutdown : @[src/main/scala/Functions.scala 232:26]
      isStuckReg <= UInt<1>("h0") @[src/main/scala/Functions.scala 233:17]
      durationReg <= UInt<1>("h0") @[src/main/scala/Functions.scala 234:17]
    else :
      node _T = eq(isStuckReg, UInt<1>("h0")) @[src/main/scala/Functions.scala 236:10]
      when _T : @[src/main/scala/Functions.scala 236:23]
        when io.externalOvercurrentInput : @[src/main/scala/Functions.scala 237:41]
          node _T_1 = geq(durationReg, maxCycles) @[src/main/scala/Functions.scala 238:26]
          when _T_1 : @[src/main/scala/Functions.scala 238:40]
            isStuckReg <= UInt<1>("h1") @[src/main/scala/Functions.scala 239:22]
          else :
            node _durationReg_T = add(durationReg, UInt<1>("h1")) @[src/main/scala/Functions.scala 241:38]
            node _durationReg_T_1 = tail(_durationReg_T, 1) @[src/main/scala/Functions.scala 241:38]
            durationReg <= _durationReg_T_1 @[src/main/scala/Functions.scala 241:23]
        else :
          durationReg <= UInt<1>("h0") @[src/main/scala/Functions.scala 244:21]
    io.is_stuck <= isStuckReg @[src/main/scala/Functions.scala 249:20]
    io.motorDisable <= isStuckReg @[src/main/scala/Functions.scala 250:20]

  module MotorDriver :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip uart_rx : UInt<1>, uart_tx : UInt<1>, flip photo_diode_A : UInt<1>, flip photo_diode_B : UInt<1>, flip over_current : UInt<1>, T1 : UInt<1>, T2 : UInt<1>, T3 : UInt<1>, T4 : UInt<1>} @[src/main/scala/MotorDriver.scala 6:16]

    inst rx of UartRx @[src/main/scala/MotorDriver.scala 20:34]
    rx.clock <= clock
    rx.reset <= reset
    inst tx of UartTx @[src/main/scala/MotorDriver.scala 21:34]
    tx.clock <= clock
    tx.reset <= reset
    inst rotation_counter of RotationCounter @[src/main/scala/MotorDriver.scala 22:34]
    rotation_counter.clock <= clock
    rotation_counter.reset <= reset
    inst pwm_gen of DCMotorPwm @[src/main/scala/MotorDriver.scala 23:34]
    pwm_gen.clock <= clock
    pwm_gen.reset <= reset
    inst pid of PIDController @[src/main/scala/MotorDriver.scala 24:34]
    pid.clock <= clock
    pid.reset <= reset
    inst stuck_detector of StuckDetector @[src/main/scala/MotorDriver.scala 25:34]
    stuck_detector.clock <= clock
    stuck_detector.reset <= reset
    reg target_position : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[src/main/scala/MotorDriver.scala 28:34]
    reg manual_speed : UInt<10>, clock with :
      reset => (reset, UInt<10>("h200")) @[src/main/scala/MotorDriver.scala 29:34]
    reg control_mode : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[src/main/scala/MotorDriver.scala 30:34]
    reg manual_brake : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[src/main/scala/MotorDriver.scala 31:34]
    rx.io.rx <= io.uart_rx @[src/main/scala/MotorDriver.scala 34:14]
    reg cmdByte : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[src/main/scala/MotorDriver.scala 35:26]
    reg isValueByte : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[src/main/scala/MotorDriver.scala 36:30]
    when rx.io.done : @[src/main/scala/MotorDriver.scala 38:22]
      node _T = eq(isValueByte, UInt<1>("h0")) @[src/main/scala/MotorDriver.scala 39:14]
      when _T : @[src/main/scala/MotorDriver.scala 39:28]
        cmdByte <= rx.io.data @[src/main/scala/MotorDriver.scala 40:21]
        isValueByte <= UInt<1>("h1") @[src/main/scala/MotorDriver.scala 41:25]
      else :
        node _T_1 = eq(UInt<1>("h1"), cmdByte) @[src/main/scala/MotorDriver.scala 43:29]
        when _T_1 : @[src/main/scala/MotorDriver.scala 43:29]
          target_position <= rx.io.data @[src/main/scala/MotorDriver.scala 45:37]
          control_mode <= UInt<1>("h1") @[src/main/scala/MotorDriver.scala 46:34]
          manual_brake <= UInt<1>("h0") @[src/main/scala/MotorDriver.scala 47:34]
        else :
          node _T_2 = eq(UInt<2>("h2"), cmdByte) @[src/main/scala/MotorDriver.scala 43:29]
          when _T_2 : @[src/main/scala/MotorDriver.scala 43:29]
            control_mode <= UInt<1>("h0") @[src/main/scala/MotorDriver.scala 50:34]
            node _T_3 = eq(UInt<1>("h0"), rx.io.data) @[src/main/scala/MotorDriver.scala 51:40]
            when _T_3 : @[src/main/scala/MotorDriver.scala 51:40]
              manual_speed <= UInt<10>("h200") @[src/main/scala/MotorDriver.scala 52:48]
              manual_brake <= UInt<1>("h0") @[src/main/scala/MotorDriver.scala 52:71]
            else :
              node _T_4 = eq(UInt<1>("h1"), rx.io.data) @[src/main/scala/MotorDriver.scala 51:40]
              when _T_4 : @[src/main/scala/MotorDriver.scala 51:40]
                manual_speed <= UInt<10>("h28a") @[src/main/scala/MotorDriver.scala 53:48]
                manual_brake <= UInt<1>("h0") @[src/main/scala/MotorDriver.scala 53:71]
              else :
                node _T_5 = eq(UInt<2>("h2"), rx.io.data) @[src/main/scala/MotorDriver.scala 51:40]
                when _T_5 : @[src/main/scala/MotorDriver.scala 51:40]
                  manual_speed <= UInt<10>("h384") @[src/main/scala/MotorDriver.scala 54:48]
                  manual_brake <= UInt<1>("h0") @[src/main/scala/MotorDriver.scala 54:71]
                else :
                  node _T_6 = eq(UInt<2>("h3"), rx.io.data) @[src/main/scala/MotorDriver.scala 51:40]
                  when _T_6 : @[src/main/scala/MotorDriver.scala 51:40]
                    manual_speed <= UInt<9>("h15e") @[src/main/scala/MotorDriver.scala 55:48]
                    manual_brake <= UInt<1>("h0") @[src/main/scala/MotorDriver.scala 55:71]
                  else :
                    node _T_7 = eq(UInt<3>("h4"), rx.io.data) @[src/main/scala/MotorDriver.scala 51:40]
                    when _T_7 : @[src/main/scala/MotorDriver.scala 51:40]
                      manual_speed <= UInt<7>("h64") @[src/main/scala/MotorDriver.scala 56:48]
                      manual_brake <= UInt<1>("h0") @[src/main/scala/MotorDriver.scala 56:71]
                    else :
                      node _T_8 = eq(UInt<3>("h5"), rx.io.data) @[src/main/scala/MotorDriver.scala 51:40]
                      when _T_8 : @[src/main/scala/MotorDriver.scala 51:40]
                        manual_brake <= UInt<1>("h1") @[src/main/scala/MotorDriver.scala 57:48]
          else :
            node _T_9 = eq(UInt<8>("hff"), cmdByte) @[src/main/scala/MotorDriver.scala 43:29]
            when _T_9 : @[src/main/scala/MotorDriver.scala 43:29]
              skip
        isValueByte <= UInt<1>("h0") @[src/main/scala/MotorDriver.scala 64:25]
    rotation_counter.io.signal_A <= io.photo_diode_A @[src/main/scala/MotorDriver.scala 69:34]
    rotation_counter.io.signal_B <= io.photo_diode_B @[src/main/scala/MotorDriver.scala 70:34]
    node _scaled_turns_T = mul(rotation_counter.io.turns, UInt<11>("h576")) @[src/main/scala/MotorDriver.scala 73:58]
    reg scaled_turns : UInt, clock with :
      reset => (UInt<1>("h0"), scaled_turns) @[src/main/scala/MotorDriver.scala 73:31]
    scaled_turns <= _scaled_turns_T @[src/main/scala/MotorDriver.scala 73:31]
    node _current_pos_m_T = shr(scaled_turns, 20) @[src/main/scala/MotorDriver.scala 74:46]
    reg current_pos_m : UInt, clock with :
      reset => (UInt<1>("h0"), current_pos_m) @[src/main/scala/MotorDriver.scala 74:32]
    current_pos_m <= _current_pos_m_T @[src/main/scala/MotorDriver.scala 74:32]
    node _pid_io_setPoint_T = asFixedPoint(target_position, 12) @[src/main/scala/MotorDriver.scala 77:55]
    pid.io.setPoint <= _pid_io_setPoint_T @[src/main/scala/MotorDriver.scala 77:24]
    node _pid_io_measuredVal_T = asFixedPoint(current_pos_m, 12) @[src/main/scala/MotorDriver.scala 78:53]
    pid.io.measuredVal <= _pid_io_measuredVal_T @[src/main/scala/MotorDriver.scala 78:24]
    node _pid_io_resetBuffer_T = eq(control_mode, UInt<1>("h0")) @[src/main/scala/MotorDriver.scala 79:27]
    node _pid_io_resetBuffer_T_1 = or(_pid_io_resetBuffer_T, manual_brake) @[src/main/scala/MotorDriver.scala 79:41]
    pid.io.resetBuffer <= _pid_io_resetBuffer_T_1 @[src/main/scala/MotorDriver.scala 79:24]
    pid.io.kp <= asFixedPoint(UInt<17>("ha000"), 12) @[src/main/scala/MotorDriver.scala 82:15]
    pid.io.ki <= asFixedPoint(UInt<14>("h1000"), 12) @[src/main/scala/MotorDriver.scala 83:15]
    pid.io.kd <= asFixedPoint(UInt<1>("h0"), 12) @[src/main/scala/MotorDriver.scala 84:15]
    node _pid_duty_raw_T = asUInt(pid.io.controlOut) @[src/main/scala/MotorDriver.scala 88:43]
    node pid_duty_raw = shr(_pid_duty_raw_T, 2) @[src/main/scala/MotorDriver.scala 88:50]
    node _pid_duty_T = gt(pid_duty_raw, UInt<10>("h3ff")) @[src/main/scala/MotorDriver.scala 89:41]
    node _pid_duty_T_1 = bits(pid_duty_raw, 9, 0) @[src/main/scala/MotorDriver.scala 89:71]
    node pid_duty = mux(_pid_duty_T, UInt<10>("h3ff"), _pid_duty_T_1) @[src/main/scala/MotorDriver.scala 89:27]
    stuck_detector.io.externalOvercurrentInput <= io.over_current @[src/main/scala/MotorDriver.scala 92:48]
    node _stuck_detector_io_clearShutdown_T = eq(cmdByte, UInt<8>("hff")) @[src/main/scala/MotorDriver.scala 93:63]
    node _stuck_detector_io_clearShutdown_T_1 = and(rx.io.done, _stuck_detector_io_clearShutdown_T) @[src/main/scala/MotorDriver.scala 93:52]
    stuck_detector.io.clearShutdown <= _stuck_detector_io_clearShutdown_T_1 @[src/main/scala/MotorDriver.scala 93:37]
    node _pwm_gen_io_duty_cycle_T = mux(control_mode, pid_duty, manual_speed) @[src/main/scala/MotorDriver.scala 96:41]
    reg pwm_gen_io_duty_cycle_REG : UInt, clock with :
      reset => (UInt<1>("h0"), pwm_gen_io_duty_cycle_REG) @[src/main/scala/MotorDriver.scala 96:37]
    pwm_gen_io_duty_cycle_REG <= _pwm_gen_io_duty_cycle_T @[src/main/scala/MotorDriver.scala 96:37]
    pwm_gen.io.duty_cycle <= pwm_gen_io_duty_cycle_REG @[src/main/scala/MotorDriver.scala 96:27]
    node _pwm_gen_io_brake_T = or(manual_brake, stuck_detector.io.motorDisable) @[src/main/scala/MotorDriver.scala 99:38]
    pwm_gen.io.brake <= _pwm_gen_io_brake_T @[src/main/scala/MotorDriver.scala 99:22]
    io.T1 <= pwm_gen.io.T1 @[src/main/scala/MotorDriver.scala 102:11]
    io.T2 <= pwm_gen.io.T2 @[src/main/scala/MotorDriver.scala 103:11]
    io.T3 <= pwm_gen.io.T3 @[src/main/scala/MotorDriver.scala 104:11]
    io.T4 <= pwm_gen.io.T4 @[src/main/scala/MotorDriver.scala 105:11]
    reg txTimer : UInt<24>, clock with :
      reset => (reset, UInt<24>("h0")) @[src/main/scala/MotorDriver.scala 108:26]
    tx.io.data <= current_pos_m @[src/main/scala/MotorDriver.scala 109:17]
    tx.io.start <= UInt<1>("h0") @[src/main/scala/MotorDriver.scala 110:17]
    node _T_10 = geq(txTimer, UInt<24>("h989680")) @[src/main/scala/MotorDriver.scala 112:18]
    when _T_10 : @[src/main/scala/MotorDriver.scala 112:33]
      node _T_11 = eq(tx.io.busy, UInt<1>("h0")) @[src/main/scala/MotorDriver.scala 113:14]
      when _T_11 : @[src/main/scala/MotorDriver.scala 113:27]
        tx.io.start <= UInt<1>("h1") @[src/main/scala/MotorDriver.scala 114:25]
        txTimer <= UInt<1>("h0") @[src/main/scala/MotorDriver.scala 115:21]
    else :
      node _txTimer_T = add(txTimer, UInt<1>("h1")) @[src/main/scala/MotorDriver.scala 118:28]
      node _txTimer_T_1 = tail(_txTimer_T, 1) @[src/main/scala/MotorDriver.scala 118:28]
      txTimer <= _txTimer_T_1 @[src/main/scala/MotorDriver.scala 118:17]
    io.uart_tx <= tx.io.tx @[src/main/scala/MotorDriver.scala 120:16]

