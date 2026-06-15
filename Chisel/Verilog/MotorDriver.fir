FIRRTL version 1.2.0
circuit MotorDriver :
  module UartRx :
    input clock : Clock
    input reset : Reset
    output io : { flip rx : UInt<1>, done : UInt<1>, data : UInt<8>} @[\\src\\main\\scala\\Functions.scala 115:14]

    reg rxReg_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), rxReg_REG) @[\\src\\main\\scala\\Functions.scala 122:33]
    rxReg_REG <= io.rx @[\\src\\main\\scala\\Functions.scala 122:33]
    reg rxReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), rxReg) @[\\src\\main\\scala\\Functions.scala 122:25]
    rxReg <= rxReg_REG @[\\src\\main\\scala\\Functions.scala 122:25]
    reg shiftReg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[\\src\\main\\scala\\Functions.scala 123:25]
    reg cntReg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[\\src\\main\\scala\\Functions.scala 124:25]
    reg bitsReg : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[\\src\\main\\scala\\Functions.scala 125:25]
    reg stateReg : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[\\src\\main\\scala\\Functions.scala 127:25]
    io.done <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 128:11]
    io.data <= shiftReg @[\\src\\main\\scala\\Functions.scala 129:11]
    node _T = eq(UInt<2>("h0"), stateReg) @[\\src\\main\\scala\\Functions.scala 130:20]
    when _T : @[\\src\\main\\scala\\Functions.scala 130:20]
      node _T_1 = eq(rxReg, UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 131:22]
      when _T_1 : @[\\src\\main\\scala\\Functions.scala 131:30]
        stateReg <= UInt<2>("h1") @[\\src\\main\\scala\\Functions.scala 131:41]
        cntReg <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 131:59]
    else :
      node _T_2 = eq(UInt<2>("h1"), stateReg) @[\\src\\main\\scala\\Functions.scala 130:20]
      when _T_2 : @[\\src\\main\\scala\\Functions.scala 130:20]
        node _T_3 = eq(cntReg, UInt<9>("h1b2")) @[\\src\\main\\scala\\Functions.scala 132:30]
        when _T_3 : @[\\src\\main\\scala\\Functions.scala 132:45]
          stateReg <= UInt<2>("h2") @[\\src\\main\\scala\\Functions.scala 132:56]
          cntReg <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 132:73]
          bitsReg <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 132:89]
        else :
          node _cntReg_T = add(cntReg, UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 132:127]
          node _cntReg_T_1 = tail(_cntReg_T, 1) @[\\src\\main\\scala\\Functions.scala 132:127]
          cntReg <= _cntReg_T_1 @[\\src\\main\\scala\\Functions.scala 132:117]
      else :
        node _T_4 = eq(UInt<2>("h2"), stateReg) @[\\src\\main\\scala\\Functions.scala 130:20]
        when _T_4 : @[\\src\\main\\scala\\Functions.scala 130:20]
          node _T_5 = sub(UInt<10>("h364"), UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 133:41]
          node _T_6 = tail(_T_5, 1) @[\\src\\main\\scala\\Functions.scala 133:41]
          node _T_7 = eq(cntReg, _T_6) @[\\src\\main\\scala\\Functions.scala 133:29]
          when _T_7 : @[\\src\\main\\scala\\Functions.scala 133:48]
            cntReg <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 133:57]
            node _shiftReg_T = bits(shiftReg, 7, 1) @[\\src\\main\\scala\\Functions.scala 133:96]
            node _shiftReg_T_1 = cat(rxReg, _shiftReg_T) @[\\src\\main\\scala\\Functions.scala 133:80]
            shiftReg <= _shiftReg_T_1 @[\\src\\main\\scala\\Functions.scala 133:74]
            node _T_8 = eq(bitsReg, UInt<3>("h7")) @[\\src\\main\\scala\\Functions.scala 133:118]
            when _T_8 : @[\\src\\main\\scala\\Functions.scala 133:127]
              stateReg <= UInt<2>("h3") @[\\src\\main\\scala\\Functions.scala 133:138]
            else :
              node _bitsReg_T = add(bitsReg, UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 133:180]
              node _bitsReg_T_1 = tail(_bitsReg_T, 1) @[\\src\\main\\scala\\Functions.scala 133:180]
              bitsReg <= _bitsReg_T_1 @[\\src\\main\\scala\\Functions.scala 133:169]
          else :
            node _cntReg_T_2 = add(cntReg, UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 133:219]
            node _cntReg_T_3 = tail(_cntReg_T_2, 1) @[\\src\\main\\scala\\Functions.scala 133:219]
            cntReg <= _cntReg_T_3 @[\\src\\main\\scala\\Functions.scala 133:209]
        else :
          node _T_9 = eq(UInt<2>("h3"), stateReg) @[\\src\\main\\scala\\Functions.scala 130:20]
          when _T_9 : @[\\src\\main\\scala\\Functions.scala 130:20]
            node _T_10 = sub(UInt<10>("h364"), UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 134:41]
            node _T_11 = tail(_T_10, 1) @[\\src\\main\\scala\\Functions.scala 134:41]
            node _T_12 = eq(cntReg, _T_11) @[\\src\\main\\scala\\Functions.scala 134:29]
            when _T_12 : @[\\src\\main\\scala\\Functions.scala 134:48]
              stateReg <= UInt<2>("h0") @[\\src\\main\\scala\\Functions.scala 134:59]
              io.done <= UInt<1>("h1") @[\\src\\main\\scala\\Functions.scala 134:77]
            else :
              node _cntReg_T_4 = add(cntReg, UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 134:118]
              node _cntReg_T_5 = tail(_cntReg_T_4, 1) @[\\src\\main\\scala\\Functions.scala 134:118]
              cntReg <= _cntReg_T_5 @[\\src\\main\\scala\\Functions.scala 134:108]


  module UartTx :
    input clock : Clock
    input reset : Reset
    output io : { flip data : UInt<8>, flip start : UInt<1>, tx : UInt<1>, busy : UInt<1>} @[\\src\\main\\scala\\Functions.scala 139:14]

    reg reg : UInt<10>, clock with :
      reset => (reset, UInt<10>("h1")) @[\\src\\main\\scala\\Functions.scala 146:20]
    reg cnt : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[\\src\\main\\scala\\Functions.scala 147:20]
    reg bits : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[\\src\\main\\scala\\Functions.scala 148:21]
    reg state : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 150:22]
    node _io_tx_T = bits(reg, 0, 0) @[\\src\\main\\scala\\Functions.scala 151:15]
    io.tx <= _io_tx_T @[\\src\\main\\scala\\Functions.scala 151:9]
    node _io_busy_T = eq(state, UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 152:20]
    io.busy <= _io_busy_T @[\\src\\main\\scala\\Functions.scala 152:11]
    node _T = eq(UInt<1>("h0"), state) @[\\src\\main\\scala\\Functions.scala 153:17]
    when _T : @[\\src\\main\\scala\\Functions.scala 153:17]
      when io.start : @[\\src\\main\\scala\\Functions.scala 154:32]
        node reg_hi = cat(UInt<1>("h1"), io.data) @[\\src\\main\\scala\\Functions.scala 154:44]
        node _reg_T = cat(reg_hi, UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 154:44]
        reg <= _reg_T @[\\src\\main\\scala\\Functions.scala 154:38]
        bits <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 154:70]
        cnt <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 154:82]
        state <= UInt<1>("h1") @[\\src\\main\\scala\\Functions.scala 154:96]
    else :
      node _T_1 = eq(UInt<1>("h1"), state) @[\\src\\main\\scala\\Functions.scala 153:17]
      when _T_1 : @[\\src\\main\\scala\\Functions.scala 153:17]
        node _T_2 = sub(UInt<10>("h364"), UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 155:38]
        node _T_3 = tail(_T_2, 1) @[\\src\\main\\scala\\Functions.scala 155:38]
        node _T_4 = eq(cnt, _T_3) @[\\src\\main\\scala\\Functions.scala 155:26]
        when _T_4 : @[\\src\\main\\scala\\Functions.scala 155:45]
          cnt <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 155:51]
          node _reg_T_1 = bits(reg, 9, 1) @[\\src\\main\\scala\\Functions.scala 155:78]
          node _reg_T_2 = cat(UInt<1>("h1"), _reg_T_1) @[\\src\\main\\scala\\Functions.scala 155:69]
          reg <= _reg_T_2 @[\\src\\main\\scala\\Functions.scala 155:63]
          node _T_5 = eq(bits, UInt<4>("h9")) @[\\src\\main\\scala\\Functions.scala 155:97]
          when _T_5 : @[\\src\\main\\scala\\Functions.scala 155:106]
            state <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 155:114]
          else :
            node _bits_T = add(bits, UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 155:150]
            node _bits_T_1 = tail(_bits_T, 1) @[\\src\\main\\scala\\Functions.scala 155:150]
            bits <= _bits_T_1 @[\\src\\main\\scala\\Functions.scala 155:142]
        else :
          node _cnt_T = add(cnt, UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 155:183]
          node _cnt_T_1 = tail(_cnt_T, 1) @[\\src\\main\\scala\\Functions.scala 155:183]
          cnt <= _cnt_T_1 @[\\src\\main\\scala\\Functions.scala 155:176]


  module RotationCounter :
    input clock : Clock
    input reset : Reset
    output io : { flip signal_A : UInt<1>, flip signal_B : UInt<1>, turns : UInt<32>} @[\\src\\main\\scala\\Functions.scala 10:14]

    reg aSync_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), aSync_REG) @[\\src\\main\\scala\\Functions.scala 16:31]
    aSync_REG <= io.signal_A @[\\src\\main\\scala\\Functions.scala 16:31]
    reg aSync : UInt<1>, clock with :
      reset => (UInt<1>("h0"), aSync) @[\\src\\main\\scala\\Functions.scala 16:23]
    aSync <= aSync_REG @[\\src\\main\\scala\\Functions.scala 16:23]
    reg bSync_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), bSync_REG) @[\\src\\main\\scala\\Functions.scala 17:31]
    bSync_REG <= io.signal_B @[\\src\\main\\scala\\Functions.scala 17:31]
    reg bSync : UInt<1>, clock with :
      reset => (UInt<1>("h0"), bSync) @[\\src\\main\\scala\\Functions.scala 17:23]
    bSync <= bSync_REG @[\\src\\main\\scala\\Functions.scala 17:23]
    reg aReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), aReg) @[\\src\\main\\scala\\Functions.scala 18:23]
    aReg <= aSync @[\\src\\main\\scala\\Functions.scala 18:23]
    node _rise_A_T = eq(aReg, UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 19:25]
    node rise_A = and(aSync, _rise_A_T) @[\\src\\main\\scala\\Functions.scala 19:22]
    reg turns : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[\\src\\main\\scala\\Functions.scala 20:23]
    when rise_A : @[\\src\\main\\scala\\Functions.scala 22:16]
      node _T = eq(bSync, UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 23:10]
      when _T : @[\\src\\main\\scala\\Functions.scala 23:18]
        node _turns_T = add(turns, UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 24:22]
        node _turns_T_1 = tail(_turns_T, 1) @[\\src\\main\\scala\\Functions.scala 24:22]
        turns <= _turns_T_1 @[\\src\\main\\scala\\Functions.scala 24:13]
      else :
        node _turns_T_2 = eq(turns, UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 26:26]
        node _turns_T_3 = sub(turns, UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 26:46]
        node _turns_T_4 = tail(_turns_T_3, 1) @[\\src\\main\\scala\\Functions.scala 26:46]
        node _turns_T_5 = mux(_turns_T_2, UInt<1>("h0"), _turns_T_4) @[\\src\\main\\scala\\Functions.scala 26:19]
        turns <= _turns_T_5 @[\\src\\main\\scala\\Functions.scala 26:13]
    io.turns <= turns @[\\src\\main\\scala\\Functions.scala 29:12]

  module DCMotorPwm :
    input clock : Clock
    input reset : Reset
    output io : { flip duty_cycle : UInt<10>, flip brake : UInt<1>, T1 : UInt<1>, T2 : UInt<1>, T3 : UInt<1>, T4 : UInt<1>} @[\\src\\main\\scala\\Functions.scala 33:14]

    reg pwmCounter : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[\\src\\main\\scala\\Functions.scala 44:29]
    node _T = sub(UInt<12>("hd05"), UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 46:35]
    node _T_1 = tail(_T, 1) @[\\src\\main\\scala\\Functions.scala 46:35]
    node _T_2 = geq(pwmCounter, _T_1) @[\\src\\main\\scala\\Functions.scala 46:19]
    when _T_2 : @[\\src\\main\\scala\\Functions.scala 46:42]
      pwmCounter <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 47:16]
    else :
      node _pwmCounter_T = add(pwmCounter, UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 49:30]
      node _pwmCounter_T_1 = tail(_pwmCounter_T, 1) @[\\src\\main\\scala\\Functions.scala 49:30]
      pwmCounter <= _pwmCounter_T_1 @[\\src\\main\\scala\\Functions.scala 49:16]
    node _threshold_T = mul(io.duty_cycle, UInt<12>("hd05")) @[\\src\\main\\scala\\Functions.scala 52:34]
    node threshold = shr(_threshold_T, 10) @[\\src\\main\\scala\\Functions.scala 52:50]
    node pwmSignal = lt(pwmCounter, threshold) @[\\src\\main\\scala\\Functions.scala 53:30]
    wire conduct_T1 : UInt<1> @[\\src\\main\\scala\\Functions.scala 55:24]
    wire conduct_T2 : UInt<1> @[\\src\\main\\scala\\Functions.scala 56:24]
    wire conduct_T3 : UInt<1> @[\\src\\main\\scala\\Functions.scala 57:24]
    wire conduct_T4 : UInt<1> @[\\src\\main\\scala\\Functions.scala 58:24]
    when io.brake : @[\\src\\main\\scala\\Functions.scala 60:18]
      conduct_T1 <= UInt<1>("h1") @[\\src\\main\\scala\\Functions.scala 61:16]
      conduct_T2 <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 62:16]
      conduct_T3 <= UInt<1>("h1") @[\\src\\main\\scala\\Functions.scala 63:16]
      conduct_T4 <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 64:16]
    else :
      conduct_T2 <= pwmSignal @[\\src\\main\\scala\\Functions.scala 66:16]
      conduct_T3 <= pwmSignal @[\\src\\main\\scala\\Functions.scala 67:16]
      node _conduct_T4_T = eq(pwmSignal, UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 68:19]
      conduct_T4 <= _conduct_T4_T @[\\src\\main\\scala\\Functions.scala 68:16]
      node _conduct_T1_T = eq(pwmSignal, UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 69:19]
      conduct_T1 <= _conduct_T1_T @[\\src\\main\\scala\\Functions.scala 69:16]
    io.T1 <= conduct_T1 @[\\src\\main\\scala\\Functions.scala 72:9]
    io.T3 <= conduct_T3 @[\\src\\main\\scala\\Functions.scala 73:9]
    node _io_T2_T = eq(conduct_T2, UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 74:12]
    io.T2 <= _io_T2_T @[\\src\\main\\scala\\Functions.scala 74:9]
    node _io_T4_T = eq(conduct_T4, UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 75:12]
    io.T4 <= _io_T4_T @[\\src\\main\\scala\\Functions.scala 75:9]

  module PIDController :
    input clock : Clock
    input reset : Reset
    output io : { flip setPoint : Fixed<32><<12>>, flip measuredVal : Fixed<32><<12>>, flip kp : Fixed<32><<12>>, flip ki : Fixed<32><<12>>, flip kd : Fixed<32><<12>>, flip resetBuffer : UInt<1>, controlOut : Fixed<32><<12>>} @[\\src\\main\\scala\\Functions.scala 79:14]

    node _errorReg_T = sub(io.setPoint, io.measuredVal) @[\\src\\main\\scala\\Functions.scala 89:38]
    node _errorReg_T_1 = tail(_errorReg_T, 1) @[\\src\\main\\scala\\Functions.scala 89:38]
    node _errorReg_T_2 = asFixedPoint(_errorReg_T_1, 12) @[\\src\\main\\scala\\Functions.scala 89:38]
    reg errorReg : Fixed<<12>>, clock with :
      reset => (UInt<1>("h0"), errorReg) @[\\src\\main\\scala\\Functions.scala 89:25]
    errorReg <= _errorReg_T_2 @[\\src\\main\\scala\\Functions.scala 89:25]
    node _pTerm_T = mul(io.kp, errorReg) @[\\src\\main\\scala\\Functions.scala 90:29]
    reg pTerm : Fixed<<24>>, clock with :
      reset => (UInt<1>("h0"), pTerm) @[\\src\\main\\scala\\Functions.scala 90:22]
    pTerm <= _pTerm_T @[\\src\\main\\scala\\Functions.scala 90:22]
    reg integralReg : Fixed<32><<12>>, clock with :
      reset => (reset, asFixedPoint(UInt<32>("h0"), 12)) @[\\src\\main\\scala\\Functions.scala 91:28]
    node _iTermNext_T = mul(io.ki, errorReg) @[\\src\\main\\scala\\Functions.scala 92:33]
    reg iTermNext : Fixed<<24>>, clock with :
      reset => (UInt<1>("h0"), iTermNext) @[\\src\\main\\scala\\Functions.scala 92:26]
    iTermNext <= _iTermNext_T @[\\src\\main\\scala\\Functions.scala 92:26]
    when io.resetBuffer : @[\\src\\main\\scala\\Functions.scala 97:24]
      integralReg <= asFixedPoint(UInt<32>("h0"), 12) @[\\src\\main\\scala\\Functions.scala 98:17]
    else :
      node _nextSum_T = add(integralReg, iTermNext) @[\\src\\main\\scala\\Functions.scala 100:39]
      node _nextSum_T_1 = tail(_nextSum_T, 1) @[\\src\\main\\scala\\Functions.scala 100:39]
      node _nextSum_T_2 = asFixedPoint(_nextSum_T_1, 24) @[\\src\\main\\scala\\Functions.scala 100:39]
      reg nextSum : Fixed<<24>>, clock with :
        reset => (UInt<1>("h0"), nextSum) @[\\src\\main\\scala\\Functions.scala 100:26]
      nextSum <= _nextSum_T_2 @[\\src\\main\\scala\\Functions.scala 100:26]
      node _integralReg_T = gt(nextSum, asFixedPoint(UInt<32>("h800"), 12)) @[\\src\\main\\scala\\Functions.scala 101:32]
      node _integralReg_T_1 = lt(nextSum, asFixedPoint(UInt<32>("hfffff800"), 12)) @[\\src\\main\\scala\\Functions.scala 102:32]
      node _integralReg_T_2 = mux(_integralReg_T_1, asFixedPoint(UInt<32>("hfffff800"), 12), nextSum) @[\\src\\main\\scala\\Functions.scala 102:23]
      node _integralReg_T_3 = mux(_integralReg_T, asFixedPoint(UInt<32>("h800"), 12), _integralReg_T_2) @[\\src\\main\\scala\\Functions.scala 101:23]
      integralReg <= _integralReg_T_3 @[\\src\\main\\scala\\Functions.scala 101:17]
    reg prevErrorReg : Fixed<32><<12>>, clock with :
      reset => (reset, asFixedPoint(UInt<32>("h0"), 12)) @[\\src\\main\\scala\\Functions.scala 105:29]
    node _dTerm_T = sub(errorReg, prevErrorReg) @[\\src\\main\\scala\\Functions.scala 106:41]
    node _dTerm_T_1 = tail(_dTerm_T, 1) @[\\src\\main\\scala\\Functions.scala 106:41]
    node _dTerm_T_2 = asFixedPoint(_dTerm_T_1, 12) @[\\src\\main\\scala\\Functions.scala 106:41]
    node _dTerm_T_3 = mul(io.kd, _dTerm_T_2) @[\\src\\main\\scala\\Functions.scala 106:29]
    reg dTerm : Fixed<<24>>, clock with :
      reset => (UInt<1>("h0"), dTerm) @[\\src\\main\\scala\\Functions.scala 106:22]
    dTerm <= _dTerm_T_3 @[\\src\\main\\scala\\Functions.scala 106:22]
    prevErrorReg <= errorReg @[\\src\\main\\scala\\Functions.scala 107:16]
    node _rawOutput_T = add(pTerm, integralReg) @[\\src\\main\\scala\\Functions.scala 109:25]
    node _rawOutput_T_1 = tail(_rawOutput_T, 1) @[\\src\\main\\scala\\Functions.scala 109:25]
    node _rawOutput_T_2 = asFixedPoint(_rawOutput_T_1, 24) @[\\src\\main\\scala\\Functions.scala 109:25]
    node _rawOutput_T_3 = add(_rawOutput_T_2, dTerm) @[\\src\\main\\scala\\Functions.scala 109:39]
    node _rawOutput_T_4 = tail(_rawOutput_T_3, 1) @[\\src\\main\\scala\\Functions.scala 109:39]
    node rawOutput = asFixedPoint(_rawOutput_T_4, 24) @[\\src\\main\\scala\\Functions.scala 109:39]
    node _io_controlOut_T = gt(rawOutput, asFixedPoint(UInt<32>("h800"), 12)) @[\\src\\main\\scala\\Functions.scala 110:34]
    node _io_controlOut_T_1 = lt(rawOutput, asFixedPoint(UInt<32>("hfffff800"), 12)) @[\\src\\main\\scala\\Functions.scala 111:34]
    node _io_controlOut_T_2 = mux(_io_controlOut_T_1, asFixedPoint(UInt<32>("hfffff800"), 12), rawOutput) @[\\src\\main\\scala\\Functions.scala 111:23]
    node _io_controlOut_T_3 = mux(_io_controlOut_T, asFixedPoint(UInt<32>("h800"), 12), _io_controlOut_T_2) @[\\src\\main\\scala\\Functions.scala 110:23]
    io.controlOut <= _io_controlOut_T_3 @[\\src\\main\\scala\\Functions.scala 110:17]

  module StuckDetector :
    input clock : Clock
    input reset : Reset
    output io : { flip externalOvercurrentInput : UInt<1>, flip clearShutdown : UInt<1>, is_stuck : UInt<1>, motorDisable : UInt<1>} @[\\src\\main\\scala\\Functions.scala 160:14]

    node maxCycles = mul(UInt<17>("h186a0"), UInt<8>("h96")) @[\\src\\main\\scala\\Functions.scala 167:44]
    reg durationReg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[\\src\\main\\scala\\Functions.scala 168:28]
    reg isStuckReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 169:28]
    when io.clearShutdown : @[\\src\\main\\scala\\Functions.scala 170:26]
      isStuckReg <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 170:39]
      durationReg <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 170:63]
    else :
      node _T = eq(isStuckReg, UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 171:10]
      when _T : @[\\src\\main\\scala\\Functions.scala 171:23]
        when io.externalOvercurrentInput : @[\\src\\main\\scala\\Functions.scala 172:41]
          node _T_1 = geq(durationReg, maxCycles) @[\\src\\main\\scala\\Functions.scala 173:26]
          when _T_1 : @[\\src\\main\\scala\\Functions.scala 173:40]
            isStuckReg <= UInt<1>("h1") @[\\src\\main\\scala\\Functions.scala 173:53]
          else :
            node _durationReg_T = add(durationReg, UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 173:104]
            node _durationReg_T_1 = tail(_durationReg_T, 1) @[\\src\\main\\scala\\Functions.scala 173:104]
            durationReg <= _durationReg_T_1 @[\\src\\main\\scala\\Functions.scala 173:89]
        else :
          durationReg <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 174:33]
    io.is_stuck <= isStuckReg @[\\src\\main\\scala\\Functions.scala 177:15]
    io.motorDisable <= isStuckReg @[\\src\\main\\scala\\Functions.scala 178:19]

  module SevenSegDec :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<5>, out : UInt<7>} @[\\src\\main\\scala\\Functions.scala 230:14]

    node _io_out_T = asUInt(io.in) @[\\src\\main\\scala\\Functions.scala 235:29]
    node _io_out_T_1 = asUInt(UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 236:18]
    node _io_out_T_2 = asUInt(UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 237:18]
    node _io_out_T_3 = asUInt(UInt<2>("h2")) @[\\src\\main\\scala\\Functions.scala 238:18]
    node _io_out_T_4 = asUInt(UInt<2>("h3")) @[\\src\\main\\scala\\Functions.scala 239:18]
    node _io_out_T_5 = asUInt(UInt<3>("h4")) @[\\src\\main\\scala\\Functions.scala 240:18]
    node _io_out_T_6 = asUInt(UInt<3>("h5")) @[\\src\\main\\scala\\Functions.scala 241:18]
    node _io_out_T_7 = asUInt(UInt<3>("h6")) @[\\src\\main\\scala\\Functions.scala 242:18]
    node _io_out_T_8 = asUInt(UInt<3>("h7")) @[\\src\\main\\scala\\Functions.scala 243:18]
    node _io_out_T_9 = asUInt(UInt<4>("h8")) @[\\src\\main\\scala\\Functions.scala 244:18]
    node _io_out_T_10 = asUInt(UInt<4>("h9")) @[\\src\\main\\scala\\Functions.scala 245:18]
    node _io_out_T_11 = asUInt(UInt<4>("ha")) @[\\src\\main\\scala\\Functions.scala 246:17]
    node _io_out_T_12 = asUInt(UInt<4>("hb")) @[\\src\\main\\scala\\Functions.scala 247:17]
    node _io_out_T_13 = asUInt(UInt<4>("hc")) @[\\src\\main\\scala\\Functions.scala 248:17]
    node _io_out_T_14 = asUInt(UInt<4>("hd")) @[\\src\\main\\scala\\Functions.scala 249:17]
    node _io_out_T_15 = asUInt(UInt<4>("he")) @[\\src\\main\\scala\\Functions.scala 250:17]
    node _io_out_T_16 = asUInt(UInt<4>("hf")) @[\\src\\main\\scala\\Functions.scala 251:17]
    node _io_out_T_17 = asUInt(UInt<5>("h10")) @[\\src\\main\\scala\\Functions.scala 252:17]
    node _io_out_T_18 = asUInt(UInt<5>("h11")) @[\\src\\main\\scala\\Functions.scala 253:17]
    node _io_out_T_19 = asUInt(UInt<5>("h12")) @[\\src\\main\\scala\\Functions.scala 254:17]
    node _io_out_T_20 = asUInt(UInt<5>("h13")) @[\\src\\main\\scala\\Functions.scala 255:17]
    node _io_out_T_21 = asUInt(UInt<5>("h14")) @[\\src\\main\\scala\\Functions.scala 256:17]
    node _io_out_T_22 = asUInt(UInt<5>("h15")) @[\\src\\main\\scala\\Functions.scala 257:17]
    node _io_out_T_23 = asUInt(UInt<5>("h16")) @[\\src\\main\\scala\\Functions.scala 258:17]
    node _io_out_T_24 = asUInt(UInt<5>("h17")) @[\\src\\main\\scala\\Functions.scala 259:17]
    node _io_out_T_25 = asUInt(UInt<5>("h18")) @[\\src\\main\\scala\\Functions.scala 260:17]
    node _io_out_T_26 = asUInt(UInt<5>("h19")) @[\\src\\main\\scala\\Functions.scala 261:17]
    node _io_out_T_27 = asUInt(UInt<5>("h1a")) @[\\src\\main\\scala\\Functions.scala 262:17]
    node _io_out_T_28 = asUInt(UInt<5>("h1b")) @[\\src\\main\\scala\\Functions.scala 263:17]
    node _io_out_T_29 = asUInt(UInt<5>("h1c")) @[\\src\\main\\scala\\Functions.scala 264:17]
    node _io_out_T_30 = asUInt(UInt<5>("h1d")) @[\\src\\main\\scala\\Functions.scala 265:21]
    node _io_out_T_31 = eq(_io_out_T_1, _io_out_T) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_32 = mux(_io_out_T_31, UInt<6>("h3f"), UInt<7>("h0")) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_33 = eq(_io_out_T_2, _io_out_T) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_34 = mux(_io_out_T_33, UInt<3>("h6"), _io_out_T_32) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_35 = eq(_io_out_T_3, _io_out_T) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_36 = mux(_io_out_T_35, UInt<7>("h5b"), _io_out_T_34) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_37 = eq(_io_out_T_4, _io_out_T) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_38 = mux(_io_out_T_37, UInt<7>("h4f"), _io_out_T_36) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_39 = eq(_io_out_T_5, _io_out_T) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_40 = mux(_io_out_T_39, UInt<7>("h66"), _io_out_T_38) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_41 = eq(_io_out_T_6, _io_out_T) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_42 = mux(_io_out_T_41, UInt<7>("h6d"), _io_out_T_40) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_43 = eq(_io_out_T_7, _io_out_T) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_44 = mux(_io_out_T_43, UInt<7>("h7d"), _io_out_T_42) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_45 = eq(_io_out_T_8, _io_out_T) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_46 = mux(_io_out_T_45, UInt<3>("h7"), _io_out_T_44) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_47 = eq(_io_out_T_9, _io_out_T) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_48 = mux(_io_out_T_47, UInt<7>("h7f"), _io_out_T_46) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_49 = eq(_io_out_T_10, _io_out_T) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_50 = mux(_io_out_T_49, UInt<7>("h6f"), _io_out_T_48) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_51 = eq(_io_out_T_11, _io_out_T) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_52 = mux(_io_out_T_51, UInt<7>("h77"), _io_out_T_50) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_53 = eq(_io_out_T_12, _io_out_T) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_54 = mux(_io_out_T_53, UInt<7>("h7c"), _io_out_T_52) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_55 = eq(_io_out_T_13, _io_out_T) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_56 = mux(_io_out_T_55, UInt<6>("h39"), _io_out_T_54) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_57 = eq(_io_out_T_14, _io_out_T) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_58 = mux(_io_out_T_57, UInt<7>("h5e"), _io_out_T_56) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_59 = eq(_io_out_T_15, _io_out_T) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_60 = mux(_io_out_T_59, UInt<7>("h79"), _io_out_T_58) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_61 = eq(_io_out_T_16, _io_out_T) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_62 = mux(_io_out_T_61, UInt<7>("h71"), _io_out_T_60) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_63 = eq(_io_out_T_17, _io_out_T) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_64 = mux(_io_out_T_63, UInt<6>("h3c"), _io_out_T_62) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_65 = eq(_io_out_T_18, _io_out_T) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_66 = mux(_io_out_T_65, UInt<7>("h76"), _io_out_T_64) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_67 = eq(_io_out_T_19, _io_out_T) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_68 = mux(_io_out_T_67, UInt<3>("h6"), _io_out_T_66) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_69 = eq(_io_out_T_20, _io_out_T) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_70 = mux(_io_out_T_69, UInt<4>("hf"), _io_out_T_68) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_71 = eq(_io_out_T_21, _io_out_T) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_72 = mux(_io_out_T_71, UInt<6>("h38"), _io_out_T_70) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_73 = eq(_io_out_T_22, _io_out_T) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_74 = mux(_io_out_T_73, UInt<7>("h70"), _io_out_T_72) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_75 = eq(_io_out_T_23, _io_out_T) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_76 = mux(_io_out_T_75, UInt<6>("h3f"), _io_out_T_74) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_77 = eq(_io_out_T_24, _io_out_T) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_78 = mux(_io_out_T_77, UInt<7>("h73"), _io_out_T_76) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_79 = eq(_io_out_T_25, _io_out_T) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_80 = mux(_io_out_T_79, UInt<7>("h67"), _io_out_T_78) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_81 = eq(_io_out_T_26, _io_out_T) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_82 = mux(_io_out_T_81, UInt<6>("h31"), _io_out_T_80) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_83 = eq(_io_out_T_27, _io_out_T) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_84 = mux(_io_out_T_83, UInt<7>("h6d"), _io_out_T_82) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_85 = eq(_io_out_T_28, _io_out_T) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_86 = mux(_io_out_T_85, UInt<7>("h78"), _io_out_T_84) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_87 = eq(_io_out_T_29, _io_out_T) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_88 = mux(_io_out_T_87, UInt<6>("h3f"), _io_out_T_86) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_89 = eq(_io_out_T_30, _io_out_T) @[\\src\\main\\scala\\Functions.scala 235:46]
    node _io_out_T_90 = mux(_io_out_T_89, UInt<1>("h0"), _io_out_T_88) @[\\src\\main\\scala\\Functions.scala 235:46]
    io.out <= _io_out_T_90 @[\\src\\main\\scala\\Functions.scala 235:10]

  module DisplayMultiplexer :
    input clock : Clock
    input reset : Reset
    output io : { flip disp_content : UInt<20>, flip dots : UInt<4>, seg : UInt<8>, an : UInt<4>} @[\\src\\main\\scala\\Functions.scala 182:14]

    reg cnt : UInt<17>, clock with :
      reset => (reset, UInt<17>("h0")) @[\\src\\main\\scala\\Functions.scala 189:20]
    node _cnt_T = eq(cnt, UInt<17>("h1869f")) @[\\src\\main\\scala\\Functions.scala 190:18]
    node _cnt_T_1 = add(cnt, UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 190:54]
    node _cnt_T_2 = tail(_cnt_T_1, 1) @[\\src\\main\\scala\\Functions.scala 190:54]
    node _cnt_T_3 = mux(_cnt_T, UInt<1>("h0"), _cnt_T_2) @[\\src\\main\\scala\\Functions.scala 190:13]
    cnt <= _cnt_T_3 @[\\src\\main\\scala\\Functions.scala 190:7]
    node tick = eq(cnt, UInt<17>("h1869f")) @[\\src\\main\\scala\\Functions.scala 191:18]
    reg digit : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[\\src\\main\\scala\\Functions.scala 193:22]
    when tick : @[\\src\\main\\scala\\Functions.scala 194:14]
      node _digit_T = add(digit, UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 194:31]
      node _digit_T_1 = tail(_digit_T, 1) @[\\src\\main\\scala\\Functions.scala 194:31]
      digit <= _digit_T_1 @[\\src\\main\\scala\\Functions.scala 194:22]
    wire currentRaw : UInt<5> @[\\src\\main\\scala\\Functions.scala 196:24]
    currentRaw <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 197:14]
    node _T = eq(UInt<1>("h0"), digit) @[\\src\\main\\scala\\Functions.scala 198:17]
    when _T : @[\\src\\main\\scala\\Functions.scala 198:17]
      node _currentRaw_T = bits(io.disp_content, 4, 0) @[\\src\\main\\scala\\Functions.scala 199:44]
      currentRaw <= _currentRaw_T @[\\src\\main\\scala\\Functions.scala 199:26]
    else :
      node _T_1 = eq(UInt<1>("h1"), digit) @[\\src\\main\\scala\\Functions.scala 198:17]
      when _T_1 : @[\\src\\main\\scala\\Functions.scala 198:17]
        node _currentRaw_T_1 = bits(io.disp_content, 9, 5) @[\\src\\main\\scala\\Functions.scala 200:44]
        currentRaw <= _currentRaw_T_1 @[\\src\\main\\scala\\Functions.scala 200:26]
      else :
        node _T_2 = eq(UInt<2>("h2"), digit) @[\\src\\main\\scala\\Functions.scala 198:17]
        when _T_2 : @[\\src\\main\\scala\\Functions.scala 198:17]
          node _currentRaw_T_2 = bits(io.disp_content, 14, 10) @[\\src\\main\\scala\\Functions.scala 201:44]
          currentRaw <= _currentRaw_T_2 @[\\src\\main\\scala\\Functions.scala 201:26]
        else :
          node _T_3 = eq(UInt<2>("h3"), digit) @[\\src\\main\\scala\\Functions.scala 198:17]
          when _T_3 : @[\\src\\main\\scala\\Functions.scala 198:17]
            node _currentRaw_T_3 = bits(io.disp_content, 19, 15) @[\\src\\main\\scala\\Functions.scala 202:44]
            currentRaw <= _currentRaw_T_3 @[\\src\\main\\scala\\Functions.scala 202:26]
    inst decoder of SevenSegDec @[\\src\\main\\scala\\Functions.scala 205:23]
    decoder.clock <= clock
    decoder.reset <= reset
    wire _decoder_io_in_WIRE : UInt<5> @[\\src\\main\\scala\\Functions.scala 206:29]
    _decoder_io_in_WIRE <= currentRaw @[\\src\\main\\scala\\Functions.scala 206:29]
    wire _decoder_io_in_WIRE_1 : UInt<5> @[\\src\\main\\scala\\Functions.scala 206:29]
    _decoder_io_in_WIRE_1 <= _decoder_io_in_WIRE @[\\src\\main\\scala\\Functions.scala 206:29]
    decoder.io.in <= _decoder_io_in_WIRE_1 @[\\src\\main\\scala\\Functions.scala 206:17]
    node _currentDot_T = dshr(io.dots, digit) @[\\src\\main\\scala\\Functions.scala 209:27]
    node currentDot = bits(_currentDot_T, 0, 0) @[\\src\\main\\scala\\Functions.scala 209:27]
    node fullSeg = cat(currentDot, decoder.io.out) @[\\src\\main\\scala\\Functions.scala 210:28]
    wire select : UInt<4> @[\\src\\main\\scala\\Functions.scala 212:27]
    select <= UInt<4>("h1") @[\\src\\main\\scala\\Functions.scala 212:27]
    node _T_4 = eq(UInt<1>("h0"), digit) @[\\src\\main\\scala\\Functions.scala 213:17]
    when _T_4 : @[\\src\\main\\scala\\Functions.scala 213:17]
      select <= UInt<1>("h1") @[\\src\\main\\scala\\Functions.scala 214:22]
    else :
      node _T_5 = eq(UInt<1>("h1"), digit) @[\\src\\main\\scala\\Functions.scala 213:17]
      when _T_5 : @[\\src\\main\\scala\\Functions.scala 213:17]
        select <= UInt<2>("h2") @[\\src\\main\\scala\\Functions.scala 215:22]
      else :
        node _T_6 = eq(UInt<2>("h2"), digit) @[\\src\\main\\scala\\Functions.scala 213:17]
        when _T_6 : @[\\src\\main\\scala\\Functions.scala 213:17]
          select <= UInt<3>("h4") @[\\src\\main\\scala\\Functions.scala 216:22]
        else :
          node _T_7 = eq(UInt<2>("h3"), digit) @[\\src\\main\\scala\\Functions.scala 213:17]
          when _T_7 : @[\\src\\main\\scala\\Functions.scala 213:17]
            select <= UInt<4>("h8") @[\\src\\main\\scala\\Functions.scala 217:22]
    node _io_seg_T = not(fullSeg) @[\\src\\main\\scala\\Functions.scala 220:13]
    io.seg <= _io_seg_T @[\\src\\main\\scala\\Functions.scala 220:10]
    node _io_an_T = not(select) @[\\src\\main\\scala\\Functions.scala 221:13]
    io.an <= _io_an_T @[\\src\\main\\scala\\Functions.scala 221:10]

  module MotorDriver :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip uart_rx : UInt<1>, flip photo_diode_A : UInt<1>, flip photo_diode_B : UInt<1>, flip over_current_pos : UInt<1>, flip over_current_neg : UInt<1>, uart_tx : UInt<1>, T1 : UInt<1>, T2 : UInt<1>, T3 : UInt<1>, T4 : UInt<1>, seg : UInt<8>, an : UInt<4>} @[\\src\\main\\scala\\MotorDriver.scala 6:16]

    inst rx of UartRx @[\\src\\main\\scala\\MotorDriver.scala 26:34]
    rx.clock <= clock
    rx.reset <= reset
    inst tx of UartTx @[\\src\\main\\scala\\MotorDriver.scala 27:34]
    tx.clock <= clock
    tx.reset <= reset
    inst rotation_counter of RotationCounter @[\\src\\main\\scala\\MotorDriver.scala 28:34]
    rotation_counter.clock <= clock
    rotation_counter.reset <= reset
    inst pwm_gen of DCMotorPwm @[\\src\\main\\scala\\MotorDriver.scala 29:34]
    pwm_gen.clock <= clock
    pwm_gen.reset <= reset
    inst pid of PIDController @[\\src\\main\\scala\\MotorDriver.scala 30:34]
    pid.clock <= clock
    pid.reset <= reset
    inst stuck_detector of StuckDetector @[\\src\\main\\scala\\MotorDriver.scala 31:34]
    stuck_detector.clock <= clock
    stuck_detector.reset <= reset
    inst disp_mux of DisplayMultiplexer @[\\src\\main\\scala\\MotorDriver.scala 32:34]
    disp_mux.clock <= clock
    disp_mux.reset <= reset
    disp_mux.io.dots <= UInt<1>("h0") @[\\src\\main\\scala\\MotorDriver.scala 34:22]
    node _disp_mux_io_disp_content_T = asUInt(UInt<5>("h1d")) @[\\src\\main\\scala\\MotorDriver.scala 35:53]
    node _disp_mux_io_disp_content_T_1 = asUInt(UInt<5>("h1d")) @[\\src\\main\\scala\\MotorDriver.scala 35:77]
    node _disp_mux_io_disp_content_T_2 = asUInt(UInt<5>("h1d")) @[\\src\\main\\scala\\MotorDriver.scala 35:101]
    node _disp_mux_io_disp_content_T_3 = asUInt(UInt<5>("h1d")) @[\\src\\main\\scala\\MotorDriver.scala 35:125]
    node disp_mux_io_disp_content_lo = cat(_disp_mux_io_disp_content_T_2, _disp_mux_io_disp_content_T_3) @[\\src\\main\\scala\\MotorDriver.scala 35:36]
    node disp_mux_io_disp_content_hi = cat(_disp_mux_io_disp_content_T, _disp_mux_io_disp_content_T_1) @[\\src\\main\\scala\\MotorDriver.scala 35:36]
    node _disp_mux_io_disp_content_T_4 = cat(disp_mux_io_disp_content_hi, disp_mux_io_disp_content_lo) @[\\src\\main\\scala\\MotorDriver.scala 35:36]
    disp_mux.io.disp_content <= _disp_mux_io_disp_content_T_4 @[\\src\\main\\scala\\MotorDriver.scala 35:30]
    pwm_gen.io.brake <= UInt<1>("h0") @[\\src\\main\\scala\\MotorDriver.scala 36:22]
    io.an <= disp_mux.io.an @[\\src\\main\\scala\\MotorDriver.scala 38:11]
    io.seg <= disp_mux.io.seg @[\\src\\main\\scala\\MotorDriver.scala 39:12]
    reg target_position : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[\\src\\main\\scala\\MotorDriver.scala 41:34]
    reg manual_speed : UInt<10>, clock with :
      reset => (reset, UInt<10>("h200")) @[\\src\\main\\scala\\MotorDriver.scala 42:34]
    reg control_mode : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[\\src\\main\\scala\\MotorDriver.scala 43:34]
    reg manual_brake : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[\\src\\main\\scala\\MotorDriver.scala 44:34]
    rx.io.rx <= io.uart_rx @[\\src\\main\\scala\\MotorDriver.scala 46:14]
    reg cmdByte : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[\\src\\main\\scala\\MotorDriver.scala 47:26]
    reg isValueByte : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[\\src\\main\\scala\\MotorDriver.scala 48:30]
    when rx.io.done : @[\\src\\main\\scala\\MotorDriver.scala 50:22]
      node _T = eq(isValueByte, UInt<1>("h0")) @[\\src\\main\\scala\\MotorDriver.scala 51:14]
      when _T : @[\\src\\main\\scala\\MotorDriver.scala 51:28]
        cmdByte <= rx.io.data @[\\src\\main\\scala\\MotorDriver.scala 52:21]
        isValueByte <= UInt<1>("h1") @[\\src\\main\\scala\\MotorDriver.scala 53:25]
      else :
        node _T_1 = eq(UInt<1>("h1"), cmdByte) @[\\src\\main\\scala\\MotorDriver.scala 55:29]
        when _T_1 : @[\\src\\main\\scala\\MotorDriver.scala 55:29]
          target_position <= rx.io.data @[\\src\\main\\scala\\MotorDriver.scala 57:37]
          control_mode <= UInt<1>("h1") @[\\src\\main\\scala\\MotorDriver.scala 58:34]
          manual_brake <= UInt<1>("h0") @[\\src\\main\\scala\\MotorDriver.scala 59:34]
        else :
          node _T_2 = eq(UInt<2>("h2"), cmdByte) @[\\src\\main\\scala\\MotorDriver.scala 55:29]
          when _T_2 : @[\\src\\main\\scala\\MotorDriver.scala 55:29]
            control_mode <= UInt<1>("h0") @[\\src\\main\\scala\\MotorDriver.scala 62:34]
            node _T_3 = eq(UInt<1>("h0"), rx.io.data) @[\\src\\main\\scala\\MotorDriver.scala 63:40]
            when _T_3 : @[\\src\\main\\scala\\MotorDriver.scala 63:40]
              manual_speed <= UInt<10>("h200") @[\\src\\main\\scala\\MotorDriver.scala 64:48]
              manual_brake <= UInt<1>("h0") @[\\src\\main\\scala\\MotorDriver.scala 64:71]
            else :
              node _T_4 = eq(UInt<1>("h1"), rx.io.data) @[\\src\\main\\scala\\MotorDriver.scala 63:40]
              when _T_4 : @[\\src\\main\\scala\\MotorDriver.scala 63:40]
                manual_speed <= UInt<10>("h28a") @[\\src\\main\\scala\\MotorDriver.scala 65:48]
                manual_brake <= UInt<1>("h0") @[\\src\\main\\scala\\MotorDriver.scala 65:71]
              else :
                node _T_5 = eq(UInt<2>("h2"), rx.io.data) @[\\src\\main\\scala\\MotorDriver.scala 63:40]
                when _T_5 : @[\\src\\main\\scala\\MotorDriver.scala 63:40]
                  manual_speed <= UInt<10>("h384") @[\\src\\main\\scala\\MotorDriver.scala 66:48]
                  manual_brake <= UInt<1>("h0") @[\\src\\main\\scala\\MotorDriver.scala 66:71]
                else :
                  node _T_6 = eq(UInt<2>("h3"), rx.io.data) @[\\src\\main\\scala\\MotorDriver.scala 63:40]
                  when _T_6 : @[\\src\\main\\scala\\MotorDriver.scala 63:40]
                    manual_speed <= UInt<9>("h176") @[\\src\\main\\scala\\MotorDriver.scala 67:48]
                    manual_brake <= UInt<1>("h0") @[\\src\\main\\scala\\MotorDriver.scala 67:71]
                  else :
                    node _T_7 = eq(UInt<3>("h4"), rx.io.data) @[\\src\\main\\scala\\MotorDriver.scala 63:40]
                    when _T_7 : @[\\src\\main\\scala\\MotorDriver.scala 63:40]
                      manual_speed <= UInt<7>("h7c") @[\\src\\main\\scala\\MotorDriver.scala 68:48]
                      manual_brake <= UInt<1>("h0") @[\\src\\main\\scala\\MotorDriver.scala 68:71]
                    else :
                      node _T_8 = eq(UInt<3>("h5"), rx.io.data) @[\\src\\main\\scala\\MotorDriver.scala 63:40]
                      when _T_8 : @[\\src\\main\\scala\\MotorDriver.scala 63:40]
                        manual_brake <= UInt<1>("h1") @[\\src\\main\\scala\\MotorDriver.scala 69:48]
        isValueByte <= UInt<1>("h0") @[\\src\\main\\scala\\MotorDriver.scala 73:25]
    rotation_counter.io.signal_A <= io.photo_diode_A @[\\src\\main\\scala\\MotorDriver.scala 77:34]
    rotation_counter.io.signal_B <= io.photo_diode_B @[\\src\\main\\scala\\MotorDriver.scala 78:34]
    node _current_pos_m_T = mul(rotation_counter.io.turns, UInt<11>("h576")) @[\\src\\main\\scala\\MotorDriver.scala 80:52]
    node current_pos_m = shr(_current_pos_m_T, 20) @[\\src\\main\\scala\\MotorDriver.scala 80:62]
    node _pid_io_setPoint_T = asFixedPoint(target_position, 12) @[\\src\\main\\scala\\MotorDriver.scala 82:55]
    pid.io.setPoint <= _pid_io_setPoint_T @[\\src\\main\\scala\\MotorDriver.scala 82:24]
    node _pid_io_measuredVal_T = asFixedPoint(current_pos_m, 12) @[\\src\\main\\scala\\MotorDriver.scala 83:53]
    pid.io.measuredVal <= _pid_io_measuredVal_T @[\\src\\main\\scala\\MotorDriver.scala 83:24]
    node _pid_io_resetBuffer_T = eq(control_mode, UInt<1>("h0")) @[\\src\\main\\scala\\MotorDriver.scala 84:27]
    node _pid_io_resetBuffer_T_1 = or(_pid_io_resetBuffer_T, manual_brake) @[\\src\\main\\scala\\MotorDriver.scala 84:41]
    pid.io.resetBuffer <= _pid_io_resetBuffer_T_1 @[\\src\\main\\scala\\MotorDriver.scala 84:24]
    pid.io.kp <= asFixedPoint(UInt<32>("h50000"), 12) @[\\src\\main\\scala\\MotorDriver.scala 86:15]
    pid.io.ki <= asFixedPoint(UInt<32>("h0"), 12) @[\\src\\main\\scala\\MotorDriver.scala 87:15]
    pid.io.kd <= asFixedPoint(UInt<32>("h1000"), 12) @[\\src\\main\\scala\\MotorDriver.scala 88:15]
    node _pid_duty_shifted_T = add(pid.io.controlOut, asFixedPoint(UInt<32>("h800"), 12)) @[\\src\\main\\scala\\MotorDriver.scala 91:46]
    node _pid_duty_shifted_T_1 = tail(_pid_duty_shifted_T, 1) @[\\src\\main\\scala\\MotorDriver.scala 91:46]
    node pid_duty_shifted = asFixedPoint(_pid_duty_shifted_T_1, 12) @[\\src\\main\\scala\\MotorDriver.scala 91:46]
    node _pid_duty_T = asUInt(pid_duty_shifted) @[\\src\\main\\scala\\MotorDriver.scala 92:38]
    node _pid_duty_T_1 = shr(_pid_duty_T, 2) @[\\src\\main\\scala\\MotorDriver.scala 92:45]
    node pid_duty = bits(_pid_duty_T_1, 9, 0) @[\\src\\main\\scala\\MotorDriver.scala 92:50]
    node _stuck_detector_io_externalOvercurrentInput_T = or(io.over_current_pos, io.over_current_neg) @[\\src\\main\\scala\\MotorDriver.scala 94:72]
    stuck_detector.io.externalOvercurrentInput <= _stuck_detector_io_externalOvercurrentInput_T @[\\src\\main\\scala\\MotorDriver.scala 94:48]
    node _stuck_detector_io_clearShutdown_T = eq(cmdByte, UInt<8>("hff")) @[\\src\\main\\scala\\MotorDriver.scala 95:74]
    node _stuck_detector_io_clearShutdown_T_1 = and(rx.io.done, _stuck_detector_io_clearShutdown_T) @[\\src\\main\\scala\\MotorDriver.scala 95:63]
    stuck_detector.io.clearShutdown <= _stuck_detector_io_clearShutdown_T_1 @[\\src\\main\\scala\\MotorDriver.scala 95:48]
    node _pwm_gen_io_duty_cycle_T = mux(control_mode, pid_duty, manual_speed) @[\\src\\main\\scala\\MotorDriver.scala 97:33]
    pwm_gen.io.duty_cycle <= _pwm_gen_io_duty_cycle_T @[\\src\\main\\scala\\MotorDriver.scala 97:27]
    node brake_active = or(stuck_detector.io.motorDisable, manual_brake) @[\\src\\main\\scala\\MotorDriver.scala 98:56]
    pwm_gen.io.brake <= brake_active @[\\src\\main\\scala\\MotorDriver.scala 100:22]
    when brake_active : @[\\src\\main\\scala\\MotorDriver.scala 102:25]
      node _disp_mux_io_disp_content_T_5 = asUInt(UInt<5>("h1a")) @[\\src\\main\\scala\\MotorDriver.scala 103:53]
      node _disp_mux_io_disp_content_T_6 = asUInt(UInt<5>("h1b")) @[\\src\\main\\scala\\MotorDriver.scala 103:73]
      node _disp_mux_io_disp_content_T_7 = asUInt(UInt<5>("h16")) @[\\src\\main\\scala\\MotorDriver.scala 103:93]
      node _disp_mux_io_disp_content_T_8 = asUInt(UInt<5>("h17")) @[\\src\\main\\scala\\MotorDriver.scala 103:113]
      node disp_mux_io_disp_content_lo_1 = cat(_disp_mux_io_disp_content_T_7, _disp_mux_io_disp_content_T_8) @[\\src\\main\\scala\\MotorDriver.scala 103:40]
      node disp_mux_io_disp_content_hi_1 = cat(_disp_mux_io_disp_content_T_5, _disp_mux_io_disp_content_T_6) @[\\src\\main\\scala\\MotorDriver.scala 103:40]
      node _disp_mux_io_disp_content_T_9 = cat(disp_mux_io_disp_content_hi_1, disp_mux_io_disp_content_lo_1) @[\\src\\main\\scala\\MotorDriver.scala 103:40]
      disp_mux.io.disp_content <= _disp_mux_io_disp_content_T_9 @[\\src\\main\\scala\\MotorDriver.scala 103:34]
    io.T1 <= pwm_gen.io.T1 @[\\src\\main\\scala\\MotorDriver.scala 106:11]
    io.T2 <= pwm_gen.io.T2 @[\\src\\main\\scala\\MotorDriver.scala 107:11]
    io.T3 <= pwm_gen.io.T3 @[\\src\\main\\scala\\MotorDriver.scala 108:11]
    io.T4 <= pwm_gen.io.T4 @[\\src\\main\\scala\\MotorDriver.scala 109:11]
    reg txTimer : UInt<24>, clock with :
      reset => (reset, UInt<24>("h0")) @[\\src\\main\\scala\\MotorDriver.scala 111:26]
    node _tx_io_data_T = bits(current_pos_m, 7, 0) @[\\src\\main\\scala\\MotorDriver.scala 112:33]
    tx.io.data <= _tx_io_data_T @[\\src\\main\\scala\\MotorDriver.scala 112:17]
    tx.io.start <= UInt<1>("h0") @[\\src\\main\\scala\\MotorDriver.scala 113:17]
    node _T_9 = geq(txTimer, UInt<24>("h989680")) @[\\src\\main\\scala\\MotorDriver.scala 114:18]
    when _T_9 : @[\\src\\main\\scala\\MotorDriver.scala 114:33]
      node _T_10 = eq(tx.io.busy, UInt<1>("h0")) @[\\src\\main\\scala\\MotorDriver.scala 115:14]
      when _T_10 : @[\\src\\main\\scala\\MotorDriver.scala 115:27]
        tx.io.start <= UInt<1>("h1") @[\\src\\main\\scala\\MotorDriver.scala 116:25]
        txTimer <= UInt<1>("h0") @[\\src\\main\\scala\\MotorDriver.scala 117:21]
    else :
      node _txTimer_T = add(txTimer, UInt<1>("h1")) @[\\src\\main\\scala\\MotorDriver.scala 119:38]
      node _txTimer_T_1 = tail(_txTimer_T, 1) @[\\src\\main\\scala\\MotorDriver.scala 119:38]
      txTimer <= _txTimer_T_1 @[\\src\\main\\scala\\MotorDriver.scala 119:27]
    io.uart_tx <= tx.io.tx @[\\src\\main\\scala\\MotorDriver.scala 120:16]

