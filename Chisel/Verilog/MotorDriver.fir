FIRRTL version 1.2.0
circuit MotorDriver :
  module UartRx :
    input clock : Clock
    input reset : Reset
    output io : { flip rx : UInt<1>, done : UInt<1>, data : UInt<8>} @[\\src\\main\\scala\\Functions.scala 113:14]

    reg rxReg_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), rxReg_REG) @[\\src\\main\\scala\\Functions.scala 120:33]
    rxReg_REG <= io.rx @[\\src\\main\\scala\\Functions.scala 120:33]
    reg rxReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), rxReg) @[\\src\\main\\scala\\Functions.scala 120:25]
    rxReg <= rxReg_REG @[\\src\\main\\scala\\Functions.scala 120:25]
    reg shiftReg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[\\src\\main\\scala\\Functions.scala 121:25]
    reg cntReg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[\\src\\main\\scala\\Functions.scala 122:25]
    reg bitsReg : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[\\src\\main\\scala\\Functions.scala 123:25]
    reg stateReg : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[\\src\\main\\scala\\Functions.scala 125:25]
    io.done <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 126:11]
    io.data <= shiftReg @[\\src\\main\\scala\\Functions.scala 127:11]
    node _T = eq(UInt<2>("h0"), stateReg) @[\\src\\main\\scala\\Functions.scala 128:20]
    when _T : @[\\src\\main\\scala\\Functions.scala 128:20]
      node _T_1 = eq(rxReg, UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 129:22]
      when _T_1 : @[\\src\\main\\scala\\Functions.scala 129:30]
        stateReg <= UInt<2>("h1") @[\\src\\main\\scala\\Functions.scala 129:41]
        cntReg <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 129:59]
    else :
      node _T_2 = eq(UInt<2>("h1"), stateReg) @[\\src\\main\\scala\\Functions.scala 128:20]
      when _T_2 : @[\\src\\main\\scala\\Functions.scala 128:20]
        node _T_3 = eq(cntReg, UInt<9>("h1b2")) @[\\src\\main\\scala\\Functions.scala 130:30]
        when _T_3 : @[\\src\\main\\scala\\Functions.scala 130:45]
          stateReg <= UInt<2>("h2") @[\\src\\main\\scala\\Functions.scala 130:56]
          cntReg <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 130:73]
          bitsReg <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 130:89]
        else :
          node _cntReg_T = add(cntReg, UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 130:127]
          node _cntReg_T_1 = tail(_cntReg_T, 1) @[\\src\\main\\scala\\Functions.scala 130:127]
          cntReg <= _cntReg_T_1 @[\\src\\main\\scala\\Functions.scala 130:117]
      else :
        node _T_4 = eq(UInt<2>("h2"), stateReg) @[\\src\\main\\scala\\Functions.scala 128:20]
        when _T_4 : @[\\src\\main\\scala\\Functions.scala 128:20]
          node _T_5 = sub(UInt<10>("h364"), UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 131:41]
          node _T_6 = tail(_T_5, 1) @[\\src\\main\\scala\\Functions.scala 131:41]
          node _T_7 = eq(cntReg, _T_6) @[\\src\\main\\scala\\Functions.scala 131:29]
          when _T_7 : @[\\src\\main\\scala\\Functions.scala 131:48]
            cntReg <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 131:57]
            node _shiftReg_T = bits(shiftReg, 7, 1) @[\\src\\main\\scala\\Functions.scala 131:96]
            node _shiftReg_T_1 = cat(rxReg, _shiftReg_T) @[\\src\\main\\scala\\Functions.scala 131:80]
            shiftReg <= _shiftReg_T_1 @[\\src\\main\\scala\\Functions.scala 131:74]
            node _T_8 = eq(bitsReg, UInt<3>("h7")) @[\\src\\main\\scala\\Functions.scala 131:118]
            when _T_8 : @[\\src\\main\\scala\\Functions.scala 131:127]
              stateReg <= UInt<2>("h3") @[\\src\\main\\scala\\Functions.scala 131:138]
            else :
              node _bitsReg_T = add(bitsReg, UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 131:180]
              node _bitsReg_T_1 = tail(_bitsReg_T, 1) @[\\src\\main\\scala\\Functions.scala 131:180]
              bitsReg <= _bitsReg_T_1 @[\\src\\main\\scala\\Functions.scala 131:169]
          else :
            node _cntReg_T_2 = add(cntReg, UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 131:219]
            node _cntReg_T_3 = tail(_cntReg_T_2, 1) @[\\src\\main\\scala\\Functions.scala 131:219]
            cntReg <= _cntReg_T_3 @[\\src\\main\\scala\\Functions.scala 131:209]
        else :
          node _T_9 = eq(UInt<2>("h3"), stateReg) @[\\src\\main\\scala\\Functions.scala 128:20]
          when _T_9 : @[\\src\\main\\scala\\Functions.scala 128:20]
            node _T_10 = sub(UInt<10>("h364"), UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 132:41]
            node _T_11 = tail(_T_10, 1) @[\\src\\main\\scala\\Functions.scala 132:41]
            node _T_12 = eq(cntReg, _T_11) @[\\src\\main\\scala\\Functions.scala 132:29]
            when _T_12 : @[\\src\\main\\scala\\Functions.scala 132:48]
              stateReg <= UInt<2>("h0") @[\\src\\main\\scala\\Functions.scala 132:59]
              io.done <= UInt<1>("h1") @[\\src\\main\\scala\\Functions.scala 132:77]
            else :
              node _cntReg_T_4 = add(cntReg, UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 132:118]
              node _cntReg_T_5 = tail(_cntReg_T_4, 1) @[\\src\\main\\scala\\Functions.scala 132:118]
              cntReg <= _cntReg_T_5 @[\\src\\main\\scala\\Functions.scala 132:108]


  module UartTx :
    input clock : Clock
    input reset : Reset
    output io : { flip data : UInt<8>, flip start : UInt<1>, tx : UInt<1>, busy : UInt<1>} @[\\src\\main\\scala\\Functions.scala 137:14]

    reg reg : UInt<10>, clock with :
      reset => (reset, UInt<10>("h1")) @[\\src\\main\\scala\\Functions.scala 144:20]
    reg cnt : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[\\src\\main\\scala\\Functions.scala 145:20]
    reg bits : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[\\src\\main\\scala\\Functions.scala 146:21]
    reg state : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 148:22]
    node _io_tx_T = bits(reg, 0, 0) @[\\src\\main\\scala\\Functions.scala 149:15]
    io.tx <= _io_tx_T @[\\src\\main\\scala\\Functions.scala 149:9]
    node _io_busy_T = eq(state, UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 150:20]
    io.busy <= _io_busy_T @[\\src\\main\\scala\\Functions.scala 150:11]
    node _T = eq(UInt<1>("h0"), state) @[\\src\\main\\scala\\Functions.scala 151:17]
    when _T : @[\\src\\main\\scala\\Functions.scala 151:17]
      when io.start : @[\\src\\main\\scala\\Functions.scala 152:32]
        node reg_hi = cat(UInt<1>("h1"), io.data) @[\\src\\main\\scala\\Functions.scala 152:44]
        node _reg_T = cat(reg_hi, UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 152:44]
        reg <= _reg_T @[\\src\\main\\scala\\Functions.scala 152:38]
        bits <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 152:70]
        cnt <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 152:82]
        state <= UInt<1>("h1") @[\\src\\main\\scala\\Functions.scala 152:96]
    else :
      node _T_1 = eq(UInt<1>("h1"), state) @[\\src\\main\\scala\\Functions.scala 151:17]
      when _T_1 : @[\\src\\main\\scala\\Functions.scala 151:17]
        node _T_2 = sub(UInt<10>("h364"), UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 153:38]
        node _T_3 = tail(_T_2, 1) @[\\src\\main\\scala\\Functions.scala 153:38]
        node _T_4 = eq(cnt, _T_3) @[\\src\\main\\scala\\Functions.scala 153:26]
        when _T_4 : @[\\src\\main\\scala\\Functions.scala 153:45]
          cnt <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 153:51]
          node _reg_T_1 = bits(reg, 9, 1) @[\\src\\main\\scala\\Functions.scala 153:78]
          node _reg_T_2 = cat(UInt<1>("h1"), _reg_T_1) @[\\src\\main\\scala\\Functions.scala 153:69]
          reg <= _reg_T_2 @[\\src\\main\\scala\\Functions.scala 153:63]
          node _T_5 = eq(bits, UInt<4>("h9")) @[\\src\\main\\scala\\Functions.scala 153:97]
          when _T_5 : @[\\src\\main\\scala\\Functions.scala 153:106]
            state <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 153:114]
          else :
            node _bits_T = add(bits, UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 153:150]
            node _bits_T_1 = tail(_bits_T, 1) @[\\src\\main\\scala\\Functions.scala 153:150]
            bits <= _bits_T_1 @[\\src\\main\\scala\\Functions.scala 153:142]
        else :
          node _cnt_T = add(cnt, UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 153:183]
          node _cnt_T_1 = tail(_cnt_T, 1) @[\\src\\main\\scala\\Functions.scala 153:183]
          cnt <= _cnt_T_1 @[\\src\\main\\scala\\Functions.scala 153:176]


  module RotationCounter :
    input clock : Clock
    input reset : Reset
    output io : { flip signal_A : UInt<1>, flip signal_B : UInt<1>, turns : UInt<32>} @[\\src\\main\\scala\\Functions.scala 11:14]

    reg aSync_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), aSync_REG) @[\\src\\main\\scala\\Functions.scala 17:31]
    aSync_REG <= io.signal_A @[\\src\\main\\scala\\Functions.scala 17:31]
    reg aSync : UInt<1>, clock with :
      reset => (UInt<1>("h0"), aSync) @[\\src\\main\\scala\\Functions.scala 17:23]
    aSync <= aSync_REG @[\\src\\main\\scala\\Functions.scala 17:23]
    reg bSync_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), bSync_REG) @[\\src\\main\\scala\\Functions.scala 18:31]
    bSync_REG <= io.signal_B @[\\src\\main\\scala\\Functions.scala 18:31]
    reg bSync : UInt<1>, clock with :
      reset => (UInt<1>("h0"), bSync) @[\\src\\main\\scala\\Functions.scala 18:23]
    bSync <= bSync_REG @[\\src\\main\\scala\\Functions.scala 18:23]
    reg aReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), aReg) @[\\src\\main\\scala\\Functions.scala 19:23]
    aReg <= aSync @[\\src\\main\\scala\\Functions.scala 19:23]
    node _rise_A_T = eq(aReg, UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 20:25]
    node rise_A = and(aSync, _rise_A_T) @[\\src\\main\\scala\\Functions.scala 20:22]
    reg turns : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[\\src\\main\\scala\\Functions.scala 21:23]
    when rise_A : @[\\src\\main\\scala\\Functions.scala 23:16]
      node _T = eq(bSync, UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 24:10]
      when _T : @[\\src\\main\\scala\\Functions.scala 24:18]
        node _turns_T = add(turns, UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 25:22]
        node _turns_T_1 = tail(_turns_T, 1) @[\\src\\main\\scala\\Functions.scala 25:22]
        turns <= _turns_T_1 @[\\src\\main\\scala\\Functions.scala 25:13]
      else :
        node _turns_T_2 = eq(turns, UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 27:26]
        node _turns_T_3 = sub(turns, UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 27:46]
        node _turns_T_4 = tail(_turns_T_3, 1) @[\\src\\main\\scala\\Functions.scala 27:46]
        node _turns_T_5 = mux(_turns_T_2, UInt<1>("h0"), _turns_T_4) @[\\src\\main\\scala\\Functions.scala 27:19]
        turns <= _turns_T_5 @[\\src\\main\\scala\\Functions.scala 27:13]
    io.turns <= turns @[\\src\\main\\scala\\Functions.scala 30:12]

  module DCMotorPwm :
    input clock : Clock
    input reset : Reset
    output io : { flip duty_cycle : UInt<10>, flip brake : UInt<1>, T1 : UInt<1>, T2 : UInt<1>, T3 : UInt<1>, T4 : UInt<1>} @[\\src\\main\\scala\\Functions.scala 34:14]

    reg pwmCounter : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[\\src\\main\\scala\\Functions.scala 45:29]
    node _T = sub(UInt<12>("hd05"), UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 47:35]
    node _T_1 = tail(_T, 1) @[\\src\\main\\scala\\Functions.scala 47:35]
    node _T_2 = geq(pwmCounter, _T_1) @[\\src\\main\\scala\\Functions.scala 47:19]
    when _T_2 : @[\\src\\main\\scala\\Functions.scala 47:42]
      pwmCounter <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 48:16]
    else :
      node _pwmCounter_T = add(pwmCounter, UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 50:30]
      node _pwmCounter_T_1 = tail(_pwmCounter_T, 1) @[\\src\\main\\scala\\Functions.scala 50:30]
      pwmCounter <= _pwmCounter_T_1 @[\\src\\main\\scala\\Functions.scala 50:16]
    node _threshold_T = mul(io.duty_cycle, UInt<12>("hd05")) @[\\src\\main\\scala\\Functions.scala 53:34]
    node threshold = shr(_threshold_T, 10) @[\\src\\main\\scala\\Functions.scala 53:50]
    node pwmSignal = lt(pwmCounter, threshold) @[\\src\\main\\scala\\Functions.scala 54:30]
    wire drive_T1 : UInt<1> @[\\src\\main\\scala\\Functions.scala 56:22]
    wire drive_T2 : UInt<1> @[\\src\\main\\scala\\Functions.scala 57:22]
    wire drive_T3 : UInt<1> @[\\src\\main\\scala\\Functions.scala 58:22]
    wire drive_T4 : UInt<1> @[\\src\\main\\scala\\Functions.scala 59:22]
    when io.brake : @[\\src\\main\\scala\\Functions.scala 61:18]
      drive_T1 <= UInt<1>("h1") @[\\src\\main\\scala\\Functions.scala 62:14]
      drive_T2 <= UInt<1>("h1") @[\\src\\main\\scala\\Functions.scala 63:14]
      drive_T3 <= UInt<1>("h1") @[\\src\\main\\scala\\Functions.scala 64:14]
      drive_T4 <= UInt<1>("h1") @[\\src\\main\\scala\\Functions.scala 65:14]
    else :
      node _drive_T2_T = eq(pwmSignal, UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 67:17]
      drive_T2 <= _drive_T2_T @[\\src\\main\\scala\\Functions.scala 67:14]
      node _drive_T1_T = eq(pwmSignal, UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 68:17]
      drive_T1 <= _drive_T1_T @[\\src\\main\\scala\\Functions.scala 68:14]
      drive_T4 <= pwmSignal @[\\src\\main\\scala\\Functions.scala 70:14]
      drive_T3 <= pwmSignal @[\\src\\main\\scala\\Functions.scala 71:14]
    io.T1 <= drive_T1 @[\\src\\main\\scala\\Functions.scala 74:9]
    io.T2 <= drive_T2 @[\\src\\main\\scala\\Functions.scala 75:9]
    io.T3 <= drive_T3 @[\\src\\main\\scala\\Functions.scala 76:9]
    io.T4 <= drive_T4 @[\\src\\main\\scala\\Functions.scala 77:9]

  module PIDController :
    input clock : Clock
    input reset : Reset
    output io : { flip setPoint : Fixed<16><<12>>, flip measuredVal : Fixed<16><<12>>, flip kp : Fixed<16><<12>>, flip ki : Fixed<16><<12>>, flip kd : Fixed<16><<12>>, flip resetBuffer : UInt<1>, controlOut : Fixed<16><<12>>} @[\\src\\main\\scala\\Functions.scala 81:14]

    node _errorReg_T = sub(io.setPoint, io.measuredVal) @[\\src\\main\\scala\\Functions.scala 91:38]
    node _errorReg_T_1 = tail(_errorReg_T, 1) @[\\src\\main\\scala\\Functions.scala 91:38]
    node _errorReg_T_2 = asFixedPoint(_errorReg_T_1, 12) @[\\src\\main\\scala\\Functions.scala 91:38]
    reg errorReg : Fixed<<12>>, clock with :
      reset => (UInt<1>("h0"), errorReg) @[\\src\\main\\scala\\Functions.scala 91:25]
    errorReg <= _errorReg_T_2 @[\\src\\main\\scala\\Functions.scala 91:25]
    node pTerm = mul(io.kp, errorReg) @[\\src\\main\\scala\\Functions.scala 92:21]
    reg integralReg : Fixed<16><<12>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 12)) @[\\src\\main\\scala\\Functions.scala 93:28]
    node iTermNext = mul(io.ki, errorReg) @[\\src\\main\\scala\\Functions.scala 94:25]
    when io.resetBuffer : @[\\src\\main\\scala\\Functions.scala 95:24]
      integralReg <= asFixedPoint(UInt<16>("h0"), 12) @[\\src\\main\\scala\\Functions.scala 96:17]
    else :
      node _nextSum_T = add(integralReg, iTermNext) @[\\src\\main\\scala\\Functions.scala 98:31]
      node _nextSum_T_1 = tail(_nextSum_T, 1) @[\\src\\main\\scala\\Functions.scala 98:31]
      node nextSum = asFixedPoint(_nextSum_T_1, 24) @[\\src\\main\\scala\\Functions.scala 98:31]
      node _integralReg_T = gt(nextSum, asFixedPoint(UInt<13>("h800"), 12)) @[\\src\\main\\scala\\Functions.scala 99:32]
      node _integralReg_T_1 = lt(nextSum, asFixedPoint(UInt<12>("h800"), 12)) @[\\src\\main\\scala\\Functions.scala 100:32]
      node _integralReg_T_2 = mux(_integralReg_T_1, asFixedPoint(UInt<12>("h800"), 12), nextSum) @[\\src\\main\\scala\\Functions.scala 100:23]
      node _integralReg_T_3 = mux(_integralReg_T, asFixedPoint(UInt<13>("h800"), 12), _integralReg_T_2) @[\\src\\main\\scala\\Functions.scala 99:23]
      integralReg <= _integralReg_T_3 @[\\src\\main\\scala\\Functions.scala 99:17]
    reg prevErrorReg : Fixed<16><<12>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 12)) @[\\src\\main\\scala\\Functions.scala 103:29]
    node _dTerm_T = sub(errorReg, prevErrorReg) @[\\src\\main\\scala\\Functions.scala 104:33]
    node _dTerm_T_1 = tail(_dTerm_T, 1) @[\\src\\main\\scala\\Functions.scala 104:33]
    node _dTerm_T_2 = asFixedPoint(_dTerm_T_1, 12) @[\\src\\main\\scala\\Functions.scala 104:33]
    node dTerm = mul(io.kd, _dTerm_T_2) @[\\src\\main\\scala\\Functions.scala 104:21]
    prevErrorReg <= errorReg @[\\src\\main\\scala\\Functions.scala 105:16]
    node _rawOutput_T = add(pTerm, integralReg) @[\\src\\main\\scala\\Functions.scala 107:25]
    node _rawOutput_T_1 = tail(_rawOutput_T, 1) @[\\src\\main\\scala\\Functions.scala 107:25]
    node _rawOutput_T_2 = asFixedPoint(_rawOutput_T_1, 24) @[\\src\\main\\scala\\Functions.scala 107:25]
    node _rawOutput_T_3 = add(_rawOutput_T_2, dTerm) @[\\src\\main\\scala\\Functions.scala 107:39]
    node _rawOutput_T_4 = tail(_rawOutput_T_3, 1) @[\\src\\main\\scala\\Functions.scala 107:39]
    node rawOutput = asFixedPoint(_rawOutput_T_4, 24) @[\\src\\main\\scala\\Functions.scala 107:39]
    node _io_controlOut_T = gt(rawOutput, asFixedPoint(UInt<13>("h800"), 12)) @[\\src\\main\\scala\\Functions.scala 108:34]
    node _io_controlOut_T_1 = lt(rawOutput, asFixedPoint(UInt<12>("h800"), 12)) @[\\src\\main\\scala\\Functions.scala 109:34]
    node _io_controlOut_T_2 = mux(_io_controlOut_T_1, asFixedPoint(UInt<12>("h800"), 12), rawOutput) @[\\src\\main\\scala\\Functions.scala 109:23]
    node _io_controlOut_T_3 = mux(_io_controlOut_T, asFixedPoint(UInt<13>("h800"), 12), _io_controlOut_T_2) @[\\src\\main\\scala\\Functions.scala 108:23]
    io.controlOut <= _io_controlOut_T_3 @[\\src\\main\\scala\\Functions.scala 108:17]

  module StuckDetector :
    input clock : Clock
    input reset : Reset
    output io : { flip externalOvercurrentInput : UInt<1>, flip clearShutdown : UInt<1>, is_stuck : UInt<1>, motorDisable : UInt<1>} @[\\src\\main\\scala\\Functions.scala 158:14]

    node maxCycles = mul(UInt<17>("h186a0"), UInt<8>("h96")) @[\\src\\main\\scala\\Functions.scala 165:44]
    reg durationReg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[\\src\\main\\scala\\Functions.scala 166:28]
    reg isStuckReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 167:28]
    when io.clearShutdown : @[\\src\\main\\scala\\Functions.scala 168:26]
      isStuckReg <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 168:39]
      durationReg <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 168:63]
    else :
      node _T = eq(isStuckReg, UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 169:10]
      when _T : @[\\src\\main\\scala\\Functions.scala 169:23]
        when io.externalOvercurrentInput : @[\\src\\main\\scala\\Functions.scala 170:41]
          node _T_1 = geq(durationReg, maxCycles) @[\\src\\main\\scala\\Functions.scala 171:26]
          when _T_1 : @[\\src\\main\\scala\\Functions.scala 171:40]
            isStuckReg <= UInt<1>("h1") @[\\src\\main\\scala\\Functions.scala 171:53]
          else :
            node _durationReg_T = add(durationReg, UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 171:104]
            node _durationReg_T_1 = tail(_durationReg_T, 1) @[\\src\\main\\scala\\Functions.scala 171:104]
            durationReg <= _durationReg_T_1 @[\\src\\main\\scala\\Functions.scala 171:89]
        else :
          durationReg <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 172:33]
    io.is_stuck <= isStuckReg @[\\src\\main\\scala\\Functions.scala 175:15]
    io.motorDisable <= isStuckReg @[\\src\\main\\scala\\Functions.scala 176:19]

  module MotorDriver :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip uart_rx : UInt<1>, flip photo_diode_A : UInt<1>, flip photo_diode_B : UInt<1>, flip over_current : UInt<1>, uart_tx : UInt<1>, T1 : UInt<1>, T2 : UInt<1>, T3 : UInt<1>, T4 : UInt<1>} @[\\src\\main\\scala\\MotorDriver.scala 6:16]

    inst rx of UartRx @[\\src\\main\\scala\\MotorDriver.scala 19:34]
    rx.clock <= clock
    rx.reset <= reset
    inst tx of UartTx @[\\src\\main\\scala\\MotorDriver.scala 20:34]
    tx.clock <= clock
    tx.reset <= reset
    inst rotation_counter of RotationCounter @[\\src\\main\\scala\\MotorDriver.scala 21:34]
    rotation_counter.clock <= clock
    rotation_counter.reset <= reset
    inst pwm_gen of DCMotorPwm @[\\src\\main\\scala\\MotorDriver.scala 22:34]
    pwm_gen.clock <= clock
    pwm_gen.reset <= reset
    inst pid of PIDController @[\\src\\main\\scala\\MotorDriver.scala 23:34]
    pid.clock <= clock
    pid.reset <= reset
    inst stuck_detector of StuckDetector @[\\src\\main\\scala\\MotorDriver.scala 24:34]
    stuck_detector.clock <= clock
    stuck_detector.reset <= reset
    reg target_position : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[\\src\\main\\scala\\MotorDriver.scala 26:34]
    reg manual_speed : UInt<10>, clock with :
      reset => (reset, UInt<10>("h200")) @[\\src\\main\\scala\\MotorDriver.scala 27:34]
    reg control_mode : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[\\src\\main\\scala\\MotorDriver.scala 28:34]
    reg manual_brake : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[\\src\\main\\scala\\MotorDriver.scala 29:34]
    rx.io.rx <= io.uart_rx @[\\src\\main\\scala\\MotorDriver.scala 31:14]
    reg cmdByte : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[\\src\\main\\scala\\MotorDriver.scala 32:26]
    reg isValueByte : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[\\src\\main\\scala\\MotorDriver.scala 33:30]
    when rx.io.done : @[\\src\\main\\scala\\MotorDriver.scala 35:22]
      node _T = eq(isValueByte, UInt<1>("h0")) @[\\src\\main\\scala\\MotorDriver.scala 36:14]
      when _T : @[\\src\\main\\scala\\MotorDriver.scala 36:28]
        cmdByte <= rx.io.data @[\\src\\main\\scala\\MotorDriver.scala 37:21]
        isValueByte <= UInt<1>("h1") @[\\src\\main\\scala\\MotorDriver.scala 38:25]
      else :
        node _T_1 = eq(UInt<1>("h1"), cmdByte) @[\\src\\main\\scala\\MotorDriver.scala 40:29]
        when _T_1 : @[\\src\\main\\scala\\MotorDriver.scala 40:29]
          target_position <= rx.io.data @[\\src\\main\\scala\\MotorDriver.scala 42:37]
          control_mode <= UInt<1>("h1") @[\\src\\main\\scala\\MotorDriver.scala 43:34]
          manual_brake <= UInt<1>("h0") @[\\src\\main\\scala\\MotorDriver.scala 44:34]
        else :
          node _T_2 = eq(UInt<2>("h2"), cmdByte) @[\\src\\main\\scala\\MotorDriver.scala 40:29]
          when _T_2 : @[\\src\\main\\scala\\MotorDriver.scala 40:29]
            control_mode <= UInt<1>("h0") @[\\src\\main\\scala\\MotorDriver.scala 47:34]
            node _T_3 = eq(UInt<1>("h0"), rx.io.data) @[\\src\\main\\scala\\MotorDriver.scala 48:40]
            when _T_3 : @[\\src\\main\\scala\\MotorDriver.scala 48:40]
              manual_speed <= UInt<10>("h200") @[\\src\\main\\scala\\MotorDriver.scala 49:48]
              manual_brake <= UInt<1>("h0") @[\\src\\main\\scala\\MotorDriver.scala 49:71]
            else :
              node _T_4 = eq(UInt<1>("h1"), rx.io.data) @[\\src\\main\\scala\\MotorDriver.scala 48:40]
              when _T_4 : @[\\src\\main\\scala\\MotorDriver.scala 48:40]
                manual_speed <= UInt<10>("h28a") @[\\src\\main\\scala\\MotorDriver.scala 50:48]
                manual_brake <= UInt<1>("h0") @[\\src\\main\\scala\\MotorDriver.scala 50:71]
              else :
                node _T_5 = eq(UInt<2>("h2"), rx.io.data) @[\\src\\main\\scala\\MotorDriver.scala 48:40]
                when _T_5 : @[\\src\\main\\scala\\MotorDriver.scala 48:40]
                  manual_speed <= UInt<10>("h384") @[\\src\\main\\scala\\MotorDriver.scala 51:48]
                  manual_brake <= UInt<1>("h0") @[\\src\\main\\scala\\MotorDriver.scala 51:71]
                else :
                  node _T_6 = eq(UInt<2>("h3"), rx.io.data) @[\\src\\main\\scala\\MotorDriver.scala 48:40]
                  when _T_6 : @[\\src\\main\\scala\\MotorDriver.scala 48:40]
                    manual_speed <= UInt<9>("h176") @[\\src\\main\\scala\\MotorDriver.scala 52:48]
                    manual_brake <= UInt<1>("h0") @[\\src\\main\\scala\\MotorDriver.scala 52:71]
                  else :
                    node _T_7 = eq(UInt<3>("h4"), rx.io.data) @[\\src\\main\\scala\\MotorDriver.scala 48:40]
                    when _T_7 : @[\\src\\main\\scala\\MotorDriver.scala 48:40]
                      manual_speed <= UInt<7>("h7c") @[\\src\\main\\scala\\MotorDriver.scala 53:48]
                      manual_brake <= UInt<1>("h0") @[\\src\\main\\scala\\MotorDriver.scala 53:71]
                    else :
                      node _T_8 = eq(UInt<3>("h5"), rx.io.data) @[\\src\\main\\scala\\MotorDriver.scala 48:40]
                      when _T_8 : @[\\src\\main\\scala\\MotorDriver.scala 48:40]
                        manual_brake <= UInt<1>("h1") @[\\src\\main\\scala\\MotorDriver.scala 54:48]
        isValueByte <= UInt<1>("h0") @[\\src\\main\\scala\\MotorDriver.scala 58:25]
    rotation_counter.io.signal_A <= io.photo_diode_A @[\\src\\main\\scala\\MotorDriver.scala 62:34]
    rotation_counter.io.signal_B <= io.photo_diode_B @[\\src\\main\\scala\\MotorDriver.scala 63:34]
    node _current_pos_m_T = mul(rotation_counter.io.turns, UInt<11>("h576")) @[\\src\\main\\scala\\MotorDriver.scala 65:52]
    node current_pos_m = shr(_current_pos_m_T, 20) @[\\src\\main\\scala\\MotorDriver.scala 65:62]
    node _pid_io_setPoint_T = asFixedPoint(target_position, 12) @[\\src\\main\\scala\\MotorDriver.scala 67:55]
    pid.io.setPoint <= _pid_io_setPoint_T @[\\src\\main\\scala\\MotorDriver.scala 67:24]
    node _pid_io_measuredVal_T = asFixedPoint(current_pos_m, 12) @[\\src\\main\\scala\\MotorDriver.scala 68:53]
    pid.io.measuredVal <= _pid_io_measuredVal_T @[\\src\\main\\scala\\MotorDriver.scala 68:24]
    node _pid_io_resetBuffer_T = eq(control_mode, UInt<1>("h0")) @[\\src\\main\\scala\\MotorDriver.scala 69:27]
    node _pid_io_resetBuffer_T_1 = or(_pid_io_resetBuffer_T, manual_brake) @[\\src\\main\\scala\\MotorDriver.scala 69:41]
    pid.io.resetBuffer <= _pid_io_resetBuffer_T_1 @[\\src\\main\\scala\\MotorDriver.scala 69:24]
    pid.io.kp <= asFixedPoint(UInt<20>("h50000"), 12) @[\\src\\main\\scala\\MotorDriver.scala 71:15]
    pid.io.ki <= asFixedPoint(UInt<14>("h1000"), 12) @[\\src\\main\\scala\\MotorDriver.scala 72:15]
    pid.io.kd <= asFixedPoint(UInt<1>("h0"), 12) @[\\src\\main\\scala\\MotorDriver.scala 73:15]
    node _pid_duty_shifted_T = add(pid.io.controlOut, asFixedPoint(UInt<13>("h800"), 12)) @[\\src\\main\\scala\\MotorDriver.scala 75:46]
    node _pid_duty_shifted_T_1 = tail(_pid_duty_shifted_T, 1) @[\\src\\main\\scala\\MotorDriver.scala 75:46]
    node pid_duty_shifted = asFixedPoint(_pid_duty_shifted_T_1, 12) @[\\src\\main\\scala\\MotorDriver.scala 75:46]
    node _pid_duty_T = asUInt(pid_duty_shifted) @[\\src\\main\\scala\\MotorDriver.scala 76:38]
    node pid_duty = shr(_pid_duty_T, 2) @[\\src\\main\\scala\\MotorDriver.scala 76:45]
    stuck_detector.io.externalOvercurrentInput <= io.over_current @[\\src\\main\\scala\\MotorDriver.scala 78:48]
    node _stuck_detector_io_clearShutdown_T = eq(cmdByte, UInt<8>("hff")) @[\\src\\main\\scala\\MotorDriver.scala 79:63]
    node _stuck_detector_io_clearShutdown_T_1 = and(rx.io.done, _stuck_detector_io_clearShutdown_T) @[\\src\\main\\scala\\MotorDriver.scala 79:52]
    stuck_detector.io.clearShutdown <= _stuck_detector_io_clearShutdown_T_1 @[\\src\\main\\scala\\MotorDriver.scala 79:37]
    node _pwm_gen_io_duty_cycle_T = mux(control_mode, pid_duty, manual_speed) @[\\src\\main\\scala\\MotorDriver.scala 81:33]
    pwm_gen.io.duty_cycle <= _pwm_gen_io_duty_cycle_T @[\\src\\main\\scala\\MotorDriver.scala 81:27]
    node _pwm_gen_io_brake_T = or(manual_brake, stuck_detector.io.motorDisable) @[\\src\\main\\scala\\MotorDriver.scala 82:38]
    pwm_gen.io.brake <= _pwm_gen_io_brake_T @[\\src\\main\\scala\\MotorDriver.scala 82:22]
    io.T1 <= pwm_gen.io.T1 @[\\src\\main\\scala\\MotorDriver.scala 84:11]
    io.T2 <= pwm_gen.io.T2 @[\\src\\main\\scala\\MotorDriver.scala 85:11]
    io.T3 <= pwm_gen.io.T3 @[\\src\\main\\scala\\MotorDriver.scala 86:11]
    io.T4 <= pwm_gen.io.T4 @[\\src\\main\\scala\\MotorDriver.scala 87:11]
    reg txTimer : UInt<24>, clock with :
      reset => (reset, UInt<24>("h0")) @[\\src\\main\\scala\\MotorDriver.scala 89:26]
    node _tx_io_data_T = bits(current_pos_m, 7, 0) @[\\src\\main\\scala\\MotorDriver.scala 90:33]
    tx.io.data <= _tx_io_data_T @[\\src\\main\\scala\\MotorDriver.scala 90:17]
    tx.io.start <= UInt<1>("h0") @[\\src\\main\\scala\\MotorDriver.scala 91:17]
    node _T_9 = geq(txTimer, UInt<24>("h989680")) @[\\src\\main\\scala\\MotorDriver.scala 92:18]
    when _T_9 : @[\\src\\main\\scala\\MotorDriver.scala 92:33]
      node _T_10 = eq(tx.io.busy, UInt<1>("h0")) @[\\src\\main\\scala\\MotorDriver.scala 93:14]
      when _T_10 : @[\\src\\main\\scala\\MotorDriver.scala 93:27]
        tx.io.start <= UInt<1>("h1") @[\\src\\main\\scala\\MotorDriver.scala 94:25]
        txTimer <= UInt<1>("h0") @[\\src\\main\\scala\\MotorDriver.scala 95:21]
    else :
      node _txTimer_T = add(txTimer, UInt<1>("h1")) @[\\src\\main\\scala\\MotorDriver.scala 97:38]
      node _txTimer_T_1 = tail(_txTimer_T, 1) @[\\src\\main\\scala\\MotorDriver.scala 97:38]
      txTimer <= _txTimer_T_1 @[\\src\\main\\scala\\MotorDriver.scala 97:27]
    io.uart_tx <= tx.io.tx @[\\src\\main\\scala\\MotorDriver.scala 98:16]

