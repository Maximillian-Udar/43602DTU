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
    output io : { flip signal_A : UInt<1>, flip signal_B : UInt<1>, turns : SInt<32>} @[\\src\\main\\scala\\Functions.scala 6:14]

    reg aSync_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), aSync_REG) @[\\src\\main\\scala\\Functions.scala 11:30]
    aSync_REG <= io.signal_A @[\\src\\main\\scala\\Functions.scala 11:30]
    reg aSync : UInt<1>, clock with :
      reset => (UInt<1>("h0"), aSync) @[\\src\\main\\scala\\Functions.scala 11:22]
    aSync <= aSync_REG @[\\src\\main\\scala\\Functions.scala 11:22]
    reg bSync_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), bSync_REG) @[\\src\\main\\scala\\Functions.scala 12:30]
    bSync_REG <= io.signal_B @[\\src\\main\\scala\\Functions.scala 12:30]
    reg bSync : UInt<1>, clock with :
      reset => (UInt<1>("h0"), bSync) @[\\src\\main\\scala\\Functions.scala 12:22]
    bSync <= bSync_REG @[\\src\\main\\scala\\Functions.scala 12:22]
    reg aReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), aReg) @[\\src\\main\\scala\\Functions.scala 13:22]
    aReg <= aSync @[\\src\\main\\scala\\Functions.scala 13:22]
    node _rise_A_T = eq(aReg, UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 14:25]
    node rise_A = and(aSync, _rise_A_T) @[\\src\\main\\scala\\Functions.scala 14:22]
    reg turns : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("h0"))) @[\\src\\main\\scala\\Functions.scala 15:22]
    when rise_A : @[\\src\\main\\scala\\Functions.scala 16:16]
      node _T = eq(bSync, UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 17:10]
      when _T : @[\\src\\main\\scala\\Functions.scala 17:18]
        node _turns_T = add(turns, asSInt(UInt<2>("h1"))) @[\\src\\main\\scala\\Functions.scala 17:35]
        node _turns_T_1 = tail(_turns_T, 1) @[\\src\\main\\scala\\Functions.scala 17:35]
        node _turns_T_2 = asSInt(_turns_T_1) @[\\src\\main\\scala\\Functions.scala 17:35]
        turns <= _turns_T_2 @[\\src\\main\\scala\\Functions.scala 17:26]
      else :
        node _turns_T_3 = sub(turns, asSInt(UInt<2>("h1"))) @[\\src\\main\\scala\\Functions.scala 18:35]
        node _turns_T_4 = tail(_turns_T_3, 1) @[\\src\\main\\scala\\Functions.scala 18:35]
        node _turns_T_5 = asSInt(_turns_T_4) @[\\src\\main\\scala\\Functions.scala 18:35]
        turns <= _turns_T_5 @[\\src\\main\\scala\\Functions.scala 18:26]
    io.turns <= turns @[\\src\\main\\scala\\Functions.scala 20:12]

  module DCMotorPwm :
    input clock : Clock
    input reset : Reset
    output io : { flip duty_cycle : UInt<10>, flip brake : UInt<1>, T1 : UInt<1>, T2 : UInt<1>, T3 : UInt<1>, T4 : UInt<1>} @[\\src\\main\\scala\\Functions.scala 24:14]

    reg pwmCounter : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[\\src\\main\\scala\\Functions.scala 35:29]
    node _T = sub(UInt<13>("h1388"), UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 37:35]
    node _T_1 = tail(_T, 1) @[\\src\\main\\scala\\Functions.scala 37:35]
    node _T_2 = geq(pwmCounter, _T_1) @[\\src\\main\\scala\\Functions.scala 37:19]
    when _T_2 : @[\\src\\main\\scala\\Functions.scala 37:42]
      pwmCounter <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 38:16]
    else :
      node _pwmCounter_T = add(pwmCounter, UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 40:30]
      node _pwmCounter_T_1 = tail(_pwmCounter_T, 1) @[\\src\\main\\scala\\Functions.scala 40:30]
      pwmCounter <= _pwmCounter_T_1 @[\\src\\main\\scala\\Functions.scala 40:16]
    node _threshold_T = mul(io.duty_cycle, UInt<13>("h1388")) @[\\src\\main\\scala\\Functions.scala 43:34]
    node threshold = shr(_threshold_T, 10) @[\\src\\main\\scala\\Functions.scala 43:50]
    node pwmSignal = lt(pwmCounter, threshold) @[\\src\\main\\scala\\Functions.scala 44:30]
    wire conduct_T1 : UInt<1> @[\\src\\main\\scala\\Functions.scala 46:24]
    wire conduct_T2 : UInt<1> @[\\src\\main\\scala\\Functions.scala 47:24]
    wire conduct_T3 : UInt<1> @[\\src\\main\\scala\\Functions.scala 48:24]
    wire conduct_T4 : UInt<1> @[\\src\\main\\scala\\Functions.scala 49:24]
    when io.brake : @[\\src\\main\\scala\\Functions.scala 51:18]
      conduct_T1 <= UInt<1>("h1") @[\\src\\main\\scala\\Functions.scala 52:16]
      conduct_T2 <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 53:16]
      conduct_T3 <= UInt<1>("h1") @[\\src\\main\\scala\\Functions.scala 54:16]
      conduct_T4 <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 55:16]
    else :
      conduct_T2 <= pwmSignal @[\\src\\main\\scala\\Functions.scala 57:16]
      conduct_T3 <= pwmSignal @[\\src\\main\\scala\\Functions.scala 58:16]
      node _conduct_T4_T = eq(pwmSignal, UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 59:19]
      conduct_T4 <= _conduct_T4_T @[\\src\\main\\scala\\Functions.scala 59:16]
      node _conduct_T1_T = eq(pwmSignal, UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 60:19]
      conduct_T1 <= _conduct_T1_T @[\\src\\main\\scala\\Functions.scala 60:16]
    io.T1 <= conduct_T1 @[\\src\\main\\scala\\Functions.scala 63:9]
    io.T3 <= conduct_T3 @[\\src\\main\\scala\\Functions.scala 64:9]
    node _io_T2_T = eq(conduct_T2, UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 65:12]
    io.T2 <= _io_T2_T @[\\src\\main\\scala\\Functions.scala 65:9]
    node _io_T4_T = eq(conduct_T4, UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 66:12]
    io.T4 <= _io_T4_T @[\\src\\main\\scala\\Functions.scala 66:9]

  module PIDController :
    input clock : Clock
    input reset : Reset
    output io : { flip setPoint : Fixed<32><<12>>, flip measuredVal : Fixed<32><<12>>, flip kp : Fixed<32><<12>>, flip ki : Fixed<32><<12>>, flip kd : Fixed<32><<12>>, flip tick : UInt<1>, flip resetBuffer : UInt<1>, controlOut : Fixed<32><<12>>} @[\\src\\main\\scala\\Functions.scala 70:14]

    reg integralReg : Fixed<32><<12>>, clock with :
      reset => (reset, asFixedPoint(UInt<32>("h0"), 12)) @[\\src\\main\\scala\\Functions.scala 81:29]
    reg prevErrorReg : Fixed<32><<12>>, clock with :
      reset => (reset, asFixedPoint(UInt<32>("h0"), 12)) @[\\src\\main\\scala\\Functions.scala 82:29]
    reg outputReg : Fixed<32><<12>>, clock with :
      reset => (reset, asFixedPoint(UInt<32>("h0"), 12)) @[\\src\\main\\scala\\Functions.scala 83:29]
    node _error_T = sub(io.setPoint, io.measuredVal) @[\\src\\main\\scala\\Functions.scala 88:27]
    node _error_T_1 = tail(_error_T, 1) @[\\src\\main\\scala\\Functions.scala 88:27]
    node error = asFixedPoint(_error_T_1, 12) @[\\src\\main\\scala\\Functions.scala 88:27]
    when io.resetBuffer : @[\\src\\main\\scala\\Functions.scala 90:24]
      integralReg <= asFixedPoint(UInt<32>("h0"), 12) @[\\src\\main\\scala\\Functions.scala 91:18]
      prevErrorReg <= asFixedPoint(UInt<32>("h0"), 12) @[\\src\\main\\scala\\Functions.scala 92:18]
      outputReg <= asFixedPoint(UInt<32>("h0"), 12) @[\\src\\main\\scala\\Functions.scala 93:18]
    else :
      when io.tick : @[\\src\\main\\scala\\Functions.scala 94:24]
        node _pTerm_T = mul(io.kp, error) @[\\src\\main\\scala\\Functions.scala 96:31]
        reg pTerm : Fixed<<24>>, clock with :
          reset => (UInt<1>("h0"), pTerm) @[\\src\\main\\scala\\Functions.scala 96:24]
        pTerm <= _pTerm_T @[\\src\\main\\scala\\Functions.scala 96:24]
        node _iTermNext_T = mul(io.ki, error) @[\\src\\main\\scala\\Functions.scala 97:35]
        reg iTermNext : Fixed<<24>>, clock with :
          reset => (UInt<1>("h0"), iTermNext) @[\\src\\main\\scala\\Functions.scala 97:28]
        iTermNext <= _iTermNext_T @[\\src\\main\\scala\\Functions.scala 97:28]
        node _nextSum_T = add(integralReg, iTermNext) @[\\src\\main\\scala\\Functions.scala 98:41]
        node _nextSum_T_1 = tail(_nextSum_T, 1) @[\\src\\main\\scala\\Functions.scala 98:41]
        node _nextSum_T_2 = asFixedPoint(_nextSum_T_1, 24) @[\\src\\main\\scala\\Functions.scala 98:41]
        reg nextSum : Fixed<<24>>, clock with :
          reset => (UInt<1>("h0"), nextSum) @[\\src\\main\\scala\\Functions.scala 98:28]
        nextSum <= _nextSum_T_2 @[\\src\\main\\scala\\Functions.scala 98:28]
        node _integralReg_T = gt(nextSum, asFixedPoint(UInt<32>("h800"), 12)) @[\\src\\main\\scala\\Functions.scala 99:32]
        node _integralReg_T_1 = lt(nextSum, asFixedPoint(UInt<32>("hfffff800"), 12)) @[\\src\\main\\scala\\Functions.scala 100:32]
        node _integralReg_T_2 = mux(_integralReg_T_1, asFixedPoint(UInt<32>("hfffff800"), 12), nextSum) @[\\src\\main\\scala\\Functions.scala 100:23]
        node _integralReg_T_3 = mux(_integralReg_T, asFixedPoint(UInt<32>("h800"), 12), _integralReg_T_2) @[\\src\\main\\scala\\Functions.scala 99:23]
        integralReg <= _integralReg_T_3 @[\\src\\main\\scala\\Functions.scala 99:17]
        node _dTerm_T = sub(error, prevErrorReg) @[\\src\\main\\scala\\Functions.scala 103:40]
        node _dTerm_T_1 = tail(_dTerm_T, 1) @[\\src\\main\\scala\\Functions.scala 103:40]
        node _dTerm_T_2 = asFixedPoint(_dTerm_T_1, 12) @[\\src\\main\\scala\\Functions.scala 103:40]
        node _dTerm_T_3 = mul(io.kd, _dTerm_T_2) @[\\src\\main\\scala\\Functions.scala 103:31]
        reg dTerm : Fixed<<24>>, clock with :
          reset => (UInt<1>("h0"), dTerm) @[\\src\\main\\scala\\Functions.scala 103:24]
        dTerm <= _dTerm_T_3 @[\\src\\main\\scala\\Functions.scala 103:24]
        prevErrorReg <= error @[\\src\\main\\scala\\Functions.scala 104:18]
        node _rawOutput_T = add(pTerm, integralReg) @[\\src\\main\\scala\\Functions.scala 107:35]
        node _rawOutput_T_1 = tail(_rawOutput_T, 1) @[\\src\\main\\scala\\Functions.scala 107:35]
        node _rawOutput_T_2 = asFixedPoint(_rawOutput_T_1, 24) @[\\src\\main\\scala\\Functions.scala 107:35]
        node _rawOutput_T_3 = add(_rawOutput_T_2, dTerm) @[\\src\\main\\scala\\Functions.scala 107:49]
        node _rawOutput_T_4 = tail(_rawOutput_T_3, 1) @[\\src\\main\\scala\\Functions.scala 107:49]
        node _rawOutput_T_5 = asFixedPoint(_rawOutput_T_4, 24) @[\\src\\main\\scala\\Functions.scala 107:49]
        reg rawOutput : Fixed<<24>>, clock with :
          reset => (UInt<1>("h0"), rawOutput) @[\\src\\main\\scala\\Functions.scala 107:28]
        rawOutput <= _rawOutput_T_5 @[\\src\\main\\scala\\Functions.scala 107:28]
        node _outputReg_T = gt(rawOutput, asFixedPoint(UInt<32>("h800"), 12)) @[\\src\\main\\scala\\Functions.scala 108:32]
        node _outputReg_T_1 = lt(rawOutput, asFixedPoint(UInt<32>("hfffff800"), 12)) @[\\src\\main\\scala\\Functions.scala 109:32]
        node _outputReg_T_2 = mux(_outputReg_T_1, asFixedPoint(UInt<32>("hfffff800"), 12), rawOutput) @[\\src\\main\\scala\\Functions.scala 109:21]
        node _outputReg_T_3 = mux(_outputReg_T, asFixedPoint(UInt<32>("h800"), 12), _outputReg_T_2) @[\\src\\main\\scala\\Functions.scala 108:21]
        outputReg <= _outputReg_T_3 @[\\src\\main\\scala\\Functions.scala 108:15]
    io.controlOut <= outputReg @[\\src\\main\\scala\\Functions.scala 111:17]

  module StuckDetector :
    input clock : Clock
    input reset : Reset
    output io : { flip external_overcurrent_input : UInt<1>, flip clear_shutdown : UInt<1>, motor_disable : UInt<1>} @[\\src\\main\\scala\\Functions.scala 160:14]

    node maxCycles = mul(UInt<17>("h186a0"), UInt<8>("h96")) @[\\src\\main\\scala\\Functions.scala 166:44]
    reg durationReg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[\\src\\main\\scala\\Functions.scala 167:28]
    reg isStuckReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 168:28]
    when io.clear_shutdown : @[\\src\\main\\scala\\Functions.scala 169:27]
      isStuckReg <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 169:40]
      durationReg <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 169:64]
    else :
      node _T = eq(isStuckReg, UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 170:10]
      when _T : @[\\src\\main\\scala\\Functions.scala 170:23]
        when io.external_overcurrent_input : @[\\src\\main\\scala\\Functions.scala 171:43]
          node _T_1 = geq(durationReg, maxCycles) @[\\src\\main\\scala\\Functions.scala 172:26]
          when _T_1 : @[\\src\\main\\scala\\Functions.scala 172:40]
            isStuckReg <= UInt<1>("h1") @[\\src\\main\\scala\\Functions.scala 172:53]
          else :
            node _durationReg_T = add(durationReg, UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 172:104]
            node _durationReg_T_1 = tail(_durationReg_T, 1) @[\\src\\main\\scala\\Functions.scala 172:104]
            durationReg <= _durationReg_T_1 @[\\src\\main\\scala\\Functions.scala 172:89]
        else :
          durationReg <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 173:33]
    io.motor_disable <= isStuckReg @[\\src\\main\\scala\\Functions.scala 176:20]

  module SevenSegDec :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<5>, out : UInt<7>} @[\\src\\main\\scala\\Functions.scala 228:14]

    node _io_out_T = asUInt(io.in) @[\\src\\main\\scala\\Functions.scala 233:29]
    node _io_out_T_1 = asUInt(UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 234:18]
    node _io_out_T_2 = asUInt(UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 235:18]
    node _io_out_T_3 = asUInt(UInt<2>("h2")) @[\\src\\main\\scala\\Functions.scala 236:18]
    node _io_out_T_4 = asUInt(UInt<2>("h3")) @[\\src\\main\\scala\\Functions.scala 237:18]
    node _io_out_T_5 = asUInt(UInt<3>("h4")) @[\\src\\main\\scala\\Functions.scala 238:18]
    node _io_out_T_6 = asUInt(UInt<3>("h5")) @[\\src\\main\\scala\\Functions.scala 239:18]
    node _io_out_T_7 = asUInt(UInt<3>("h6")) @[\\src\\main\\scala\\Functions.scala 240:18]
    node _io_out_T_8 = asUInt(UInt<3>("h7")) @[\\src\\main\\scala\\Functions.scala 241:18]
    node _io_out_T_9 = asUInt(UInt<4>("h8")) @[\\src\\main\\scala\\Functions.scala 242:18]
    node _io_out_T_10 = asUInt(UInt<4>("h9")) @[\\src\\main\\scala\\Functions.scala 243:18]
    node _io_out_T_11 = asUInt(UInt<4>("ha")) @[\\src\\main\\scala\\Functions.scala 244:17]
    node _io_out_T_12 = asUInt(UInt<4>("hb")) @[\\src\\main\\scala\\Functions.scala 245:17]
    node _io_out_T_13 = asUInt(UInt<4>("hc")) @[\\src\\main\\scala\\Functions.scala 246:17]
    node _io_out_T_14 = asUInt(UInt<4>("hd")) @[\\src\\main\\scala\\Functions.scala 247:17]
    node _io_out_T_15 = asUInt(UInt<4>("he")) @[\\src\\main\\scala\\Functions.scala 248:17]
    node _io_out_T_16 = asUInt(UInt<4>("hf")) @[\\src\\main\\scala\\Functions.scala 249:17]
    node _io_out_T_17 = asUInt(UInt<5>("h10")) @[\\src\\main\\scala\\Functions.scala 250:17]
    node _io_out_T_18 = asUInt(UInt<5>("h11")) @[\\src\\main\\scala\\Functions.scala 251:17]
    node _io_out_T_19 = asUInt(UInt<5>("h12")) @[\\src\\main\\scala\\Functions.scala 252:17]
    node _io_out_T_20 = asUInt(UInt<5>("h13")) @[\\src\\main\\scala\\Functions.scala 253:17]
    node _io_out_T_21 = asUInt(UInt<5>("h14")) @[\\src\\main\\scala\\Functions.scala 254:17]
    node _io_out_T_22 = asUInt(UInt<5>("h15")) @[\\src\\main\\scala\\Functions.scala 255:17]
    node _io_out_T_23 = asUInt(UInt<5>("h16")) @[\\src\\main\\scala\\Functions.scala 256:17]
    node _io_out_T_24 = asUInt(UInt<5>("h17")) @[\\src\\main\\scala\\Functions.scala 257:17]
    node _io_out_T_25 = asUInt(UInt<5>("h18")) @[\\src\\main\\scala\\Functions.scala 258:17]
    node _io_out_T_26 = asUInt(UInt<5>("h19")) @[\\src\\main\\scala\\Functions.scala 259:17]
    node _io_out_T_27 = asUInt(UInt<5>("h1a")) @[\\src\\main\\scala\\Functions.scala 260:17]
    node _io_out_T_28 = asUInt(UInt<5>("h1b")) @[\\src\\main\\scala\\Functions.scala 261:17]
    node _io_out_T_29 = asUInt(UInt<5>("h1c")) @[\\src\\main\\scala\\Functions.scala 262:17]
    node _io_out_T_30 = asUInt(UInt<5>("h1d")) @[\\src\\main\\scala\\Functions.scala 263:17]
    node _io_out_T_31 = asUInt(UInt<5>("h1e")) @[\\src\\main\\scala\\Functions.scala 264:21]
    node _io_out_T_32 = eq(_io_out_T_1, _io_out_T) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_33 = mux(_io_out_T_32, UInt<6>("h3f"), UInt<7>("h0")) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_34 = eq(_io_out_T_2, _io_out_T) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_35 = mux(_io_out_T_34, UInt<3>("h6"), _io_out_T_33) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_36 = eq(_io_out_T_3, _io_out_T) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_37 = mux(_io_out_T_36, UInt<7>("h5b"), _io_out_T_35) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_38 = eq(_io_out_T_4, _io_out_T) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_39 = mux(_io_out_T_38, UInt<7>("h4f"), _io_out_T_37) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_40 = eq(_io_out_T_5, _io_out_T) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_41 = mux(_io_out_T_40, UInt<7>("h66"), _io_out_T_39) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_42 = eq(_io_out_T_6, _io_out_T) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_43 = mux(_io_out_T_42, UInt<7>("h6d"), _io_out_T_41) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_44 = eq(_io_out_T_7, _io_out_T) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_45 = mux(_io_out_T_44, UInt<7>("h7d"), _io_out_T_43) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_46 = eq(_io_out_T_8, _io_out_T) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_47 = mux(_io_out_T_46, UInt<3>("h7"), _io_out_T_45) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_48 = eq(_io_out_T_9, _io_out_T) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_49 = mux(_io_out_T_48, UInt<7>("h7f"), _io_out_T_47) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_50 = eq(_io_out_T_10, _io_out_T) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_51 = mux(_io_out_T_50, UInt<7>("h6f"), _io_out_T_49) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_52 = eq(_io_out_T_11, _io_out_T) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_53 = mux(_io_out_T_52, UInt<7>("h77"), _io_out_T_51) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_54 = eq(_io_out_T_12, _io_out_T) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_55 = mux(_io_out_T_54, UInt<7>("h7c"), _io_out_T_53) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_56 = eq(_io_out_T_13, _io_out_T) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_57 = mux(_io_out_T_56, UInt<6>("h39"), _io_out_T_55) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_58 = eq(_io_out_T_14, _io_out_T) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_59 = mux(_io_out_T_58, UInt<7>("h5e"), _io_out_T_57) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_60 = eq(_io_out_T_15, _io_out_T) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_61 = mux(_io_out_T_60, UInt<7>("h79"), _io_out_T_59) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_62 = eq(_io_out_T_16, _io_out_T) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_63 = mux(_io_out_T_62, UInt<7>("h71"), _io_out_T_61) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_64 = eq(_io_out_T_17, _io_out_T) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_65 = mux(_io_out_T_64, UInt<6>("h3c"), _io_out_T_63) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_66 = eq(_io_out_T_18, _io_out_T) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_67 = mux(_io_out_T_66, UInt<7>("h76"), _io_out_T_65) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_68 = eq(_io_out_T_19, _io_out_T) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_69 = mux(_io_out_T_68, UInt<3>("h6"), _io_out_T_67) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_70 = eq(_io_out_T_20, _io_out_T) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_71 = mux(_io_out_T_70, UInt<4>("hf"), _io_out_T_69) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_72 = eq(_io_out_T_21, _io_out_T) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_73 = mux(_io_out_T_72, UInt<6>("h38"), _io_out_T_71) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_74 = eq(_io_out_T_22, _io_out_T) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_75 = mux(_io_out_T_74, UInt<6>("h38"), _io_out_T_73) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_76 = eq(_io_out_T_23, _io_out_T) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_77 = mux(_io_out_T_76, UInt<7>("h70"), _io_out_T_75) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_78 = eq(_io_out_T_24, _io_out_T) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_79 = mux(_io_out_T_78, UInt<6>("h3f"), _io_out_T_77) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_80 = eq(_io_out_T_25, _io_out_T) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_81 = mux(_io_out_T_80, UInt<7>("h73"), _io_out_T_79) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_82 = eq(_io_out_T_26, _io_out_T) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_83 = mux(_io_out_T_82, UInt<7>("h67"), _io_out_T_81) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_84 = eq(_io_out_T_27, _io_out_T) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_85 = mux(_io_out_T_84, UInt<6>("h31"), _io_out_T_83) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_86 = eq(_io_out_T_28, _io_out_T) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_87 = mux(_io_out_T_86, UInt<7>("h6d"), _io_out_T_85) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_88 = eq(_io_out_T_29, _io_out_T) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_89 = mux(_io_out_T_88, UInt<7>("h78"), _io_out_T_87) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_90 = eq(_io_out_T_30, _io_out_T) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_91 = mux(_io_out_T_90, UInt<6>("h3e"), _io_out_T_89) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_92 = eq(_io_out_T_31, _io_out_T) @[\\src\\main\\scala\\Functions.scala 233:46]
    node _io_out_T_93 = mux(_io_out_T_92, UInt<1>("h0"), _io_out_T_91) @[\\src\\main\\scala\\Functions.scala 233:46]
    io.out <= _io_out_T_93 @[\\src\\main\\scala\\Functions.scala 233:10]

  module DisplayMultiplexer :
    input clock : Clock
    input reset : Reset
    output io : { flip disp_content : UInt<20>, flip dots : UInt<4>, seg : UInt<8>, an : UInt<4>} @[\\src\\main\\scala\\Functions.scala 180:14]

    reg cnt : UInt<17>, clock with :
      reset => (reset, UInt<17>("h0")) @[\\src\\main\\scala\\Functions.scala 187:20]
    node _cnt_T = eq(cnt, UInt<17>("h1869f")) @[\\src\\main\\scala\\Functions.scala 188:18]
    node _cnt_T_1 = add(cnt, UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 188:54]
    node _cnt_T_2 = tail(_cnt_T_1, 1) @[\\src\\main\\scala\\Functions.scala 188:54]
    node _cnt_T_3 = mux(_cnt_T, UInt<1>("h0"), _cnt_T_2) @[\\src\\main\\scala\\Functions.scala 188:13]
    cnt <= _cnt_T_3 @[\\src\\main\\scala\\Functions.scala 188:7]
    node tick = eq(cnt, UInt<17>("h1869f")) @[\\src\\main\\scala\\Functions.scala 189:18]
    reg digit : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[\\src\\main\\scala\\Functions.scala 191:22]
    when tick : @[\\src\\main\\scala\\Functions.scala 192:14]
      node _digit_T = add(digit, UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 192:31]
      node _digit_T_1 = tail(_digit_T, 1) @[\\src\\main\\scala\\Functions.scala 192:31]
      digit <= _digit_T_1 @[\\src\\main\\scala\\Functions.scala 192:22]
    wire currentRaw : UInt<5> @[\\src\\main\\scala\\Functions.scala 194:24]
    currentRaw <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 195:14]
    node _T = eq(UInt<1>("h0"), digit) @[\\src\\main\\scala\\Functions.scala 196:17]
    when _T : @[\\src\\main\\scala\\Functions.scala 196:17]
      node _currentRaw_T = bits(io.disp_content, 4, 0) @[\\src\\main\\scala\\Functions.scala 197:44]
      currentRaw <= _currentRaw_T @[\\src\\main\\scala\\Functions.scala 197:26]
    else :
      node _T_1 = eq(UInt<1>("h1"), digit) @[\\src\\main\\scala\\Functions.scala 196:17]
      when _T_1 : @[\\src\\main\\scala\\Functions.scala 196:17]
        node _currentRaw_T_1 = bits(io.disp_content, 9, 5) @[\\src\\main\\scala\\Functions.scala 198:44]
        currentRaw <= _currentRaw_T_1 @[\\src\\main\\scala\\Functions.scala 198:26]
      else :
        node _T_2 = eq(UInt<2>("h2"), digit) @[\\src\\main\\scala\\Functions.scala 196:17]
        when _T_2 : @[\\src\\main\\scala\\Functions.scala 196:17]
          node _currentRaw_T_2 = bits(io.disp_content, 14, 10) @[\\src\\main\\scala\\Functions.scala 199:44]
          currentRaw <= _currentRaw_T_2 @[\\src\\main\\scala\\Functions.scala 199:26]
        else :
          node _T_3 = eq(UInt<2>("h3"), digit) @[\\src\\main\\scala\\Functions.scala 196:17]
          when _T_3 : @[\\src\\main\\scala\\Functions.scala 196:17]
            node _currentRaw_T_3 = bits(io.disp_content, 19, 15) @[\\src\\main\\scala\\Functions.scala 200:44]
            currentRaw <= _currentRaw_T_3 @[\\src\\main\\scala\\Functions.scala 200:26]
    inst decoder of SevenSegDec @[\\src\\main\\scala\\Functions.scala 203:23]
    decoder.clock <= clock
    decoder.reset <= reset
    wire _decoder_io_in_WIRE : UInt<5> @[\\src\\main\\scala\\Functions.scala 204:29]
    _decoder_io_in_WIRE <= currentRaw @[\\src\\main\\scala\\Functions.scala 204:29]
    wire _decoder_io_in_WIRE_1 : UInt<5> @[\\src\\main\\scala\\Functions.scala 204:29]
    _decoder_io_in_WIRE_1 <= _decoder_io_in_WIRE @[\\src\\main\\scala\\Functions.scala 204:29]
    decoder.io.in <= _decoder_io_in_WIRE_1 @[\\src\\main\\scala\\Functions.scala 204:17]
    node _currentDot_T = dshr(io.dots, digit) @[\\src\\main\\scala\\Functions.scala 207:27]
    node currentDot = bits(_currentDot_T, 0, 0) @[\\src\\main\\scala\\Functions.scala 207:27]
    node fullSeg = cat(currentDot, decoder.io.out) @[\\src\\main\\scala\\Functions.scala 208:28]
    wire select : UInt<4> @[\\src\\main\\scala\\Functions.scala 210:27]
    select <= UInt<4>("h1") @[\\src\\main\\scala\\Functions.scala 210:27]
    node _T_4 = eq(UInt<1>("h0"), digit) @[\\src\\main\\scala\\Functions.scala 211:17]
    when _T_4 : @[\\src\\main\\scala\\Functions.scala 211:17]
      select <= UInt<1>("h1") @[\\src\\main\\scala\\Functions.scala 212:22]
    else :
      node _T_5 = eq(UInt<1>("h1"), digit) @[\\src\\main\\scala\\Functions.scala 211:17]
      when _T_5 : @[\\src\\main\\scala\\Functions.scala 211:17]
        select <= UInt<2>("h2") @[\\src\\main\\scala\\Functions.scala 213:22]
      else :
        node _T_6 = eq(UInt<2>("h2"), digit) @[\\src\\main\\scala\\Functions.scala 211:17]
        when _T_6 : @[\\src\\main\\scala\\Functions.scala 211:17]
          select <= UInt<3>("h4") @[\\src\\main\\scala\\Functions.scala 214:22]
        else :
          node _T_7 = eq(UInt<2>("h3"), digit) @[\\src\\main\\scala\\Functions.scala 211:17]
          when _T_7 : @[\\src\\main\\scala\\Functions.scala 211:17]
            select <= UInt<4>("h8") @[\\src\\main\\scala\\Functions.scala 215:22]
    node _io_seg_T = not(fullSeg) @[\\src\\main\\scala\\Functions.scala 218:13]
    io.seg <= _io_seg_T @[\\src\\main\\scala\\Functions.scala 218:10]
    node _io_an_T = not(select) @[\\src\\main\\scala\\Functions.scala 219:13]
    io.an <= _io_an_T @[\\src\\main\\scala\\Functions.scala 219:10]

  module MotorDriver :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip uart_rx : UInt<1>, flip photo_sensor_A : UInt<1>, flip photo_sensor_B : UInt<1>, flip over_current_positive : UInt<1>, flip over_current_negative : UInt<1>, flip error_cleared : UInt<1>, uart_tx : UInt<1>, T1 : UInt<1>, T2 : UInt<1>, T3 : UInt<1>, T4 : UInt<1>, seg : UInt<8>, an : UInt<4>} @[\\src\\main\\scala\\MotorDriver.scala 6:14]

    inst rx of UartRx @[\\src\\main\\scala\\MotorDriver.scala 31:32]
    rx.clock <= clock
    rx.reset <= reset
    inst tx of UartTx @[\\src\\main\\scala\\MotorDriver.scala 32:32]
    tx.clock <= clock
    tx.reset <= reset
    inst rotation_counter of RotationCounter @[\\src\\main\\scala\\MotorDriver.scala 33:32]
    rotation_counter.clock <= clock
    rotation_counter.reset <= reset
    inst pwm_gen of DCMotorPwm @[\\src\\main\\scala\\MotorDriver.scala 34:32]
    pwm_gen.clock <= clock
    pwm_gen.reset <= reset
    inst pid of PIDController @[\\src\\main\\scala\\MotorDriver.scala 35:32]
    pid.clock <= clock
    pid.reset <= reset
    inst stuck_detector of StuckDetector @[\\src\\main\\scala\\MotorDriver.scala 36:32]
    stuck_detector.clock <= clock
    stuck_detector.reset <= reset
    inst disp_mux of DisplayMultiplexer @[\\src\\main\\scala\\MotorDriver.scala 37:32]
    disp_mux.clock <= clock
    disp_mux.reset <= reset
    reg target_pos_cm : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("h0"))) @[\\src\\main\\scala\\MotorDriver.scala 41:30]
    reg manual_speed : UInt<10>, clock with :
      reset => (reset, UInt<10>("h200")) @[\\src\\main\\scala\\MotorDriver.scala 42:30]
    reg control_mode : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[\\src\\main\\scala\\MotorDriver.scala 43:30]
    reg manual_brake : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[\\src\\main\\scala\\MotorDriver.scala 44:30]
    rx.io.rx <= io.uart_rx @[\\src\\main\\scala\\MotorDriver.scala 48:12]
    reg uartState : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[\\src\\main\\scala\\MotorDriver.scala 50:26]
    reg cmdByte : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[\\src\\main\\scala\\MotorDriver.scala 51:26]
    reg pid_timer : UInt<17>, clock with :
      reset => (reset, UInt<17>("h0")) @[\\src\\main\\scala\\MotorDriver.scala 52:26]
    node pid_tick = eq(pid_timer, UInt<17>("h1869f")) @[\\src\\main\\scala\\MotorDriver.scala 53:29]
    pid.io.tick <= UInt<1>("h1") @[\\src\\main\\scala\\MotorDriver.scala 54:15]
    when pid_tick : @[\\src\\main\\scala\\MotorDriver.scala 56:18]
      pid_timer <= UInt<1>("h0") @[\\src\\main\\scala\\MotorDriver.scala 57:15]
    else :
      node _pid_timer_T = add(pid_timer, UInt<1>("h1")) @[\\src\\main\\scala\\MotorDriver.scala 59:28]
      node _pid_timer_T_1 = tail(_pid_timer_T, 1) @[\\src\\main\\scala\\MotorDriver.scala 59:28]
      pid_timer <= _pid_timer_T_1 @[\\src\\main\\scala\\MotorDriver.scala 59:15]
    when rx.io.done : @[\\src\\main\\scala\\MotorDriver.scala 62:20]
      node _T = eq(UInt<2>("h0"), uartState) @[\\src\\main\\scala\\MotorDriver.scala 63:23]
      when _T : @[\\src\\main\\scala\\MotorDriver.scala 63:23]
        node _T_1 = eq(rx.io.data, UInt<8>("haa")) @[\\src\\main\\scala\\MotorDriver.scala 64:37]
        when _T_1 : @[\\src\\main\\scala\\MotorDriver.scala 64:49]
          uartState <= UInt<2>("h1") @[\\src\\main\\scala\\MotorDriver.scala 64:61]
      else :
        node _T_2 = eq(UInt<2>("h1"), uartState) @[\\src\\main\\scala\\MotorDriver.scala 63:23]
        when _T_2 : @[\\src\\main\\scala\\MotorDriver.scala 63:23]
          cmdByte <= rx.io.data @[\\src\\main\\scala\\MotorDriver.scala 65:29]
          uartState <= UInt<2>("h2") @[\\src\\main\\scala\\MotorDriver.scala 65:54]
        else :
          node _T_3 = eq(UInt<2>("h2"), uartState) @[\\src\\main\\scala\\MotorDriver.scala 63:23]
          when _T_3 : @[\\src\\main\\scala\\MotorDriver.scala 63:23]
            node _T_4 = eq(UInt<1>("h1"), cmdByte) @[\\src\\main\\scala\\MotorDriver.scala 67:25]
            when _T_4 : @[\\src\\main\\scala\\MotorDriver.scala 67:25]
              node _target_pos_cm_T = mul(rx.io.data, UInt<7>("h64")) @[\\src\\main\\scala\\MotorDriver.scala 69:42]
              node _target_pos_cm_T_1 = asSInt(_target_pos_cm_T) @[\\src\\main\\scala\\MotorDriver.scala 69:51]
              target_pos_cm <= _target_pos_cm_T_1 @[\\src\\main\\scala\\MotorDriver.scala 69:27]
              control_mode <= UInt<1>("h1") @[\\src\\main\\scala\\MotorDriver.scala 70:27]
              manual_brake <= UInt<1>("h0") @[\\src\\main\\scala\\MotorDriver.scala 71:27]
            else :
              node _T_5 = eq(UInt<2>("h2"), cmdByte) @[\\src\\main\\scala\\MotorDriver.scala 67:25]
              when _T_5 : @[\\src\\main\\scala\\MotorDriver.scala 67:25]
                control_mode <= UInt<1>("h0") @[\\src\\main\\scala\\MotorDriver.scala 74:26]
                manual_brake <= UInt<1>("h0") @[\\src\\main\\scala\\MotorDriver.scala 75:26]
                node _T_6 = eq(UInt<1>("h0"), rx.io.data) @[\\src\\main\\scala\\MotorDriver.scala 76:32]
                when _T_6 : @[\\src\\main\\scala\\MotorDriver.scala 76:32]
                  manual_speed <= UInt<10>("h200") @[\\src\\main\\scala\\MotorDriver.scala 77:38]
                  manual_brake <= UInt<1>("h1") @[\\src\\main\\scala\\MotorDriver.scala 77:61]
                else :
                  node _T_7 = eq(UInt<1>("h1"), rx.io.data) @[\\src\\main\\scala\\MotorDriver.scala 76:32]
                  when _T_7 : @[\\src\\main\\scala\\MotorDriver.scala 76:32]
                    manual_speed <= UInt<10>("h280") @[\\src\\main\\scala\\MotorDriver.scala 78:38]
                  else :
                    node _T_8 = eq(UInt<2>("h2"), rx.io.data) @[\\src\\main\\scala\\MotorDriver.scala 76:32]
                    when _T_8 : @[\\src\\main\\scala\\MotorDriver.scala 76:32]
                      manual_speed <= UInt<10>("h320") @[\\src\\main\\scala\\MotorDriver.scala 79:38]
                    else :
                      node _T_9 = eq(UInt<2>("h3"), rx.io.data) @[\\src\\main\\scala\\MotorDriver.scala 76:32]
                      when _T_9 : @[\\src\\main\\scala\\MotorDriver.scala 76:32]
                        manual_speed <= UInt<9>("h17c") @[\\src\\main\\scala\\MotorDriver.scala 80:38]
                      else :
                        node _T_10 = eq(UInt<3>("h4"), rx.io.data) @[\\src\\main\\scala\\MotorDriver.scala 76:32]
                        when _T_10 : @[\\src\\main\\scala\\MotorDriver.scala 76:32]
                          manual_speed <= UInt<8>("haa") @[\\src\\main\\scala\\MotorDriver.scala 81:38]
                        else :
                          node _T_11 = eq(UInt<3>("h5"), rx.io.data) @[\\src\\main\\scala\\MotorDriver.scala 76:32]
                          when _T_11 : @[\\src\\main\\scala\\MotorDriver.scala 76:32]
                            manual_brake <= UInt<1>("h1") @[\\src\\main\\scala\\MotorDriver.scala 82:38]
            uartState <= UInt<2>("h0") @[\\src\\main\\scala\\MotorDriver.scala 86:19]
    reg rotation_counter_io_signal_A_cnt : UInt<14>, clock with :
      reset => (reset, UInt<14>("h0")) @[\\src\\main\\scala\\MotorDriver.scala 24:23]
    reg rotation_counter_io_signal_A_out : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[\\src\\main\\scala\\MotorDriver.scala 25:23]
    node _rotation_counter_io_signal_A_T = eq(io.photo_sensor_A, rotation_counter_io_signal_A_out) @[\\src\\main\\scala\\MotorDriver.scala 26:15]
    when _rotation_counter_io_signal_A_T : @[\\src\\main\\scala\\MotorDriver.scala 26:24]
      rotation_counter_io_signal_A_cnt <= UInt<1>("h0") @[\\src\\main\\scala\\MotorDriver.scala 26:30]
    else :
      node _rotation_counter_io_signal_A_cnt_T = add(rotation_counter_io_signal_A_cnt, UInt<1>("h1")) @[\\src\\main\\scala\\MotorDriver.scala 27:29]
      node _rotation_counter_io_signal_A_cnt_T_1 = tail(_rotation_counter_io_signal_A_cnt_T, 1) @[\\src\\main\\scala\\MotorDriver.scala 27:29]
      rotation_counter_io_signal_A_cnt <= _rotation_counter_io_signal_A_cnt_T_1 @[\\src\\main\\scala\\MotorDriver.scala 27:22]
      node _rotation_counter_io_signal_A_T_1 = eq(rotation_counter_io_signal_A_cnt, UInt<7>("h64")) @[\\src\\main\\scala\\MotorDriver.scala 27:45]
      when _rotation_counter_io_signal_A_T_1 : @[\\src\\main\\scala\\MotorDriver.scala 27:56]
        rotation_counter_io_signal_A_out <= io.photo_sensor_A @[\\src\\main\\scala\\MotorDriver.scala 27:62]
    rotation_counter.io.signal_A <= rotation_counter_io_signal_A_out @[\\src\\main\\scala\\MotorDriver.scala 92:32]
    reg rotation_counter_io_signal_B_cnt : UInt<14>, clock with :
      reset => (reset, UInt<14>("h0")) @[\\src\\main\\scala\\MotorDriver.scala 24:23]
    reg rotation_counter_io_signal_B_out : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[\\src\\main\\scala\\MotorDriver.scala 25:23]
    node _rotation_counter_io_signal_B_T = eq(io.photo_sensor_B, rotation_counter_io_signal_B_out) @[\\src\\main\\scala\\MotorDriver.scala 26:15]
    when _rotation_counter_io_signal_B_T : @[\\src\\main\\scala\\MotorDriver.scala 26:24]
      rotation_counter_io_signal_B_cnt <= UInt<1>("h0") @[\\src\\main\\scala\\MotorDriver.scala 26:30]
    else :
      node _rotation_counter_io_signal_B_cnt_T = add(rotation_counter_io_signal_B_cnt, UInt<1>("h1")) @[\\src\\main\\scala\\MotorDriver.scala 27:29]
      node _rotation_counter_io_signal_B_cnt_T_1 = tail(_rotation_counter_io_signal_B_cnt_T, 1) @[\\src\\main\\scala\\MotorDriver.scala 27:29]
      rotation_counter_io_signal_B_cnt <= _rotation_counter_io_signal_B_cnt_T_1 @[\\src\\main\\scala\\MotorDriver.scala 27:22]
      node _rotation_counter_io_signal_B_T_1 = eq(rotation_counter_io_signal_B_cnt, UInt<7>("h64")) @[\\src\\main\\scala\\MotorDriver.scala 27:45]
      when _rotation_counter_io_signal_B_T_1 : @[\\src\\main\\scala\\MotorDriver.scala 27:56]
        rotation_counter_io_signal_B_out <= io.photo_sensor_B @[\\src\\main\\scala\\MotorDriver.scala 27:62]
    rotation_counter.io.signal_B <= rotation_counter_io_signal_B_out @[\\src\\main\\scala\\MotorDriver.scala 93:32]
    node _current_pos_cm_T = mul(rotation_counter.io.turns, asSInt(UInt<9>("h88"))) @[\\src\\main\\scala\\MotorDriver.scala 96:31]
    node current_pos_cm = shr(_current_pos_cm_T, 10) @[\\src\\main\\scala\\MotorDriver.scala 96:40]
    node _pid_io_setPoint_T = asFixedPoint(target_pos_cm, 12) @[\\src\\main\\scala\\MotorDriver.scala 99:51]
    pid.io.setPoint <= _pid_io_setPoint_T @[\\src\\main\\scala\\MotorDriver.scala 99:22]
    node _pid_io_measuredVal_T = asFixedPoint(current_pos_cm, 12) @[\\src\\main\\scala\\MotorDriver.scala 100:52]
    pid.io.measuredVal <= _pid_io_measuredVal_T @[\\src\\main\\scala\\MotorDriver.scala 100:22]
    node _pid_io_resetBuffer_T = eq(control_mode, UInt<1>("h0")) @[\\src\\main\\scala\\MotorDriver.scala 101:25]
    node _pid_io_resetBuffer_T_1 = or(_pid_io_resetBuffer_T, manual_brake) @[\\src\\main\\scala\\MotorDriver.scala 101:39]
    pid.io.resetBuffer <= _pid_io_resetBuffer_T_1 @[\\src\\main\\scala\\MotorDriver.scala 101:22]
    pid.io.kp <= asFixedPoint(UInt<32>("h1000"), 12) @[\\src\\main\\scala\\MotorDriver.scala 104:13]
    pid.io.ki <= asFixedPoint(UInt<32>("h800"), 12) @[\\src\\main\\scala\\MotorDriver.scala 105:13]
    pid.io.kd <= asFixedPoint(UInt<32>("h19a"), 12) @[\\src\\main\\scala\\MotorDriver.scala 106:13]
    node _pid_duty_shifted_T = add(pid.io.controlOut, asFixedPoint(UInt<32>("h800"), 12)) @[\\src\\main\\scala\\MotorDriver.scala 109:44]
    node _pid_duty_shifted_T_1 = tail(_pid_duty_shifted_T, 1) @[\\src\\main\\scala\\MotorDriver.scala 109:44]
    node pid_duty_shifted = asFixedPoint(_pid_duty_shifted_T_1, 12) @[\\src\\main\\scala\\MotorDriver.scala 109:44]
    node _raw_duty_T = asUInt(pid_duty_shifted) @[\\src\\main\\scala\\MotorDriver.scala 110:36]
    node raw_duty = dshr(_raw_duty_T, UInt<2>("h2")) @[\\src\\main\\scala\\MotorDriver.scala 110:43]
    node _pid_duty_T = gt(raw_duty, UInt<10>("h3ff")) @[\\src\\main\\scala\\MotorDriver.scala 111:31]
    node _pid_duty_T_1 = bits(raw_duty, 9, 0) @[\\src\\main\\scala\\MotorDriver.scala 111:57]
    node pid_duty = mux(_pid_duty_T, UInt<10>("h3ff"), _pid_duty_T_1) @[\\src\\main\\scala\\MotorDriver.scala 111:21]
    node _stuck_detector_io_external_overcurrent_input_T = or(io.over_current_positive, io.over_current_negative) @[\\src\\main\\scala\\MotorDriver.scala 114:77]
    stuck_detector.io.external_overcurrent_input <= _stuck_detector_io_external_overcurrent_input_T @[\\src\\main\\scala\\MotorDriver.scala 114:48]
    node _stuck_detector_io_clear_shutdown_T = eq(cmdByte, UInt<8>("hff")) @[\\src\\main\\scala\\MotorDriver.scala 115:63]
    node _stuck_detector_io_clear_shutdown_T_1 = and(rx.io.done, _stuck_detector_io_clear_shutdown_T) @[\\src\\main\\scala\\MotorDriver.scala 115:52]
    node _stuck_detector_io_clear_shutdown_T_2 = or(_stuck_detector_io_clear_shutdown_T_1, io.error_cleared) @[\\src\\main\\scala\\MotorDriver.scala 115:75]
    stuck_detector.io.clear_shutdown <= _stuck_detector_io_clear_shutdown_T_2 @[\\src\\main\\scala\\MotorDriver.scala 115:36]
    node brake_active = or(stuck_detector.io.motor_disable, manual_brake) @[\\src\\main\\scala\\MotorDriver.scala 117:55]
    node _pwm_gen_io_duty_cycle_T = mux(control_mode, pid_duty, manual_speed) @[\\src\\main\\scala\\MotorDriver.scala 118:31]
    pwm_gen.io.duty_cycle <= _pwm_gen_io_duty_cycle_T @[\\src\\main\\scala\\MotorDriver.scala 118:25]
    pwm_gen.io.brake <= brake_active @[\\src\\main\\scala\\MotorDriver.scala 119:25]
    io.T1 <= pwm_gen.io.T1 @[\\src\\main\\scala\\MotorDriver.scala 121:9]
    io.T2 <= pwm_gen.io.T2 @[\\src\\main\\scala\\MotorDriver.scala 121:33]
    io.T3 <= pwm_gen.io.T3 @[\\src\\main\\scala\\MotorDriver.scala 122:9]
    io.T4 <= pwm_gen.io.T4 @[\\src\\main\\scala\\MotorDriver.scala 122:33]
    reg txTimer : UInt<24>, clock with :
      reset => (reset, UInt<24>("h0")) @[\\src\\main\\scala\\MotorDriver.scala 125:24]
    reg txState : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[\\src\\main\\scala\\MotorDriver.scala 127:24]
    tx.io.data <= UInt<1>("h0") @[\\src\\main\\scala\\MotorDriver.scala 128:14]
    tx.io.start <= UInt<1>("h0") @[\\src\\main\\scala\\MotorDriver.scala 128:34]
    node _T_12 = geq(txTimer, UInt<23>("h4c4b40")) @[\\src\\main\\scala\\MotorDriver.scala 129:16]
    when _T_12 : @[\\src\\main\\scala\\MotorDriver.scala 129:30]
      node _T_13 = eq(UInt<1>("h0"), txState) @[\\src\\main\\scala\\MotorDriver.scala 130:21]
      when _T_13 : @[\\src\\main\\scala\\MotorDriver.scala 130:21]
        node _T_14 = eq(tx.io.busy, UInt<1>("h0")) @[\\src\\main\\scala\\MotorDriver.scala 132:14]
        when _T_14 : @[\\src\\main\\scala\\MotorDriver.scala 132:27]
          node _tx_io_data_T = asUInt(rotation_counter.io.turns) @[\\src\\main\\scala\\MotorDriver.scala 133:31]
          tx.io.data <= _tx_io_data_T @[\\src\\main\\scala\\MotorDriver.scala 133:22]
          tx.io.start <= UInt<1>("h1") @[\\src\\main\\scala\\MotorDriver.scala 134:23]
          txState <= UInt<1>("h1") @[\\src\\main\\scala\\MotorDriver.scala 135:19]
      else :
        node _T_15 = eq(UInt<1>("h1"), txState) @[\\src\\main\\scala\\MotorDriver.scala 130:21]
        when _T_15 : @[\\src\\main\\scala\\MotorDriver.scala 130:21]
          node _T_16 = eq(tx.io.busy, UInt<1>("h0")) @[\\src\\main\\scala\\MotorDriver.scala 139:14]
          when _T_16 : @[\\src\\main\\scala\\MotorDriver.scala 139:27]
            node _tx_io_data_T_1 = asUInt(rotation_counter.io.turns) @[\\src\\main\\scala\\MotorDriver.scala 140:31]
            tx.io.data <= _tx_io_data_T_1 @[\\src\\main\\scala\\MotorDriver.scala 140:22]
            tx.io.start <= UInt<1>("h1") @[\\src\\main\\scala\\MotorDriver.scala 141:23]
            txState <= UInt<1>("h0") @[\\src\\main\\scala\\MotorDriver.scala 142:19]
            txTimer <= UInt<1>("h0") @[\\src\\main\\scala\\MotorDriver.scala 143:19]
    else :
      node _txTimer_T = add(txTimer, UInt<1>("h1")) @[\\src\\main\\scala\\MotorDriver.scala 147:36]
      node _txTimer_T_1 = tail(_txTimer_T, 1) @[\\src\\main\\scala\\MotorDriver.scala 147:36]
      txTimer <= _txTimer_T_1 @[\\src\\main\\scala\\MotorDriver.scala 147:25]
    io.uart_tx <= tx.io.tx @[\\src\\main\\scala\\MotorDriver.scala 148:14]
    io.an <= disp_mux.io.an @[\\src\\main\\scala\\MotorDriver.scala 151:9]
    io.seg <= disp_mux.io.seg @[\\src\\main\\scala\\MotorDriver.scala 151:35]
    disp_mux.io.dots <= UInt<1>("h0") @[\\src\\main\\scala\\MotorDriver.scala 152:20]
    node _disp_mux_io_disp_content_T = asUInt(UInt<5>("h1b")) @[\\src\\main\\scala\\MotorDriver.scala 154:21]
    node _disp_mux_io_disp_content_T_1 = asUInt(UInt<5>("h1c")) @[\\src\\main\\scala\\MotorDriver.scala 154:41]
    node _disp_mux_io_disp_content_T_2 = asUInt(UInt<5>("h17")) @[\\src\\main\\scala\\MotorDriver.scala 154:61]
    node _disp_mux_io_disp_content_T_3 = asUInt(UInt<5>("h18")) @[\\src\\main\\scala\\MotorDriver.scala 154:81]
    node disp_mux_io_disp_content_lo = cat(_disp_mux_io_disp_content_T_2, _disp_mux_io_disp_content_T_3) @[\\src\\main\\scala\\MotorDriver.scala 154:8]
    node disp_mux_io_disp_content_hi = cat(_disp_mux_io_disp_content_T, _disp_mux_io_disp_content_T_1) @[\\src\\main\\scala\\MotorDriver.scala 154:8]
    node _disp_mux_io_disp_content_T_4 = cat(disp_mux_io_disp_content_hi, disp_mux_io_disp_content_lo) @[\\src\\main\\scala\\MotorDriver.scala 154:8]
    node _disp_mux_io_disp_content_T_5 = asUInt(UInt<4>("ha")) @[\\src\\main\\scala\\MotorDriver.scala 155:39]
    node _disp_mux_io_disp_content_T_6 = asUInt(UInt<5>("h1d")) @[\\src\\main\\scala\\MotorDriver.scala 155:59]
    node _disp_mux_io_disp_content_T_7 = asUInt(UInt<5>("h1c")) @[\\src\\main\\scala\\MotorDriver.scala 155:79]
    node _disp_mux_io_disp_content_T_8 = asUInt(UInt<5>("h17")) @[\\src\\main\\scala\\MotorDriver.scala 155:99]
    node disp_mux_io_disp_content_lo_1 = cat(_disp_mux_io_disp_content_T_7, _disp_mux_io_disp_content_T_8) @[\\src\\main\\scala\\MotorDriver.scala 155:26]
    node disp_mux_io_disp_content_hi_1 = cat(_disp_mux_io_disp_content_T_5, _disp_mux_io_disp_content_T_6) @[\\src\\main\\scala\\MotorDriver.scala 155:26]
    node _disp_mux_io_disp_content_T_9 = cat(disp_mux_io_disp_content_hi_1, disp_mux_io_disp_content_lo_1) @[\\src\\main\\scala\\MotorDriver.scala 155:26]
    node _disp_mux_io_disp_content_T_10 = asUInt(UInt<5>("h1e")) @[\\src\\main\\scala\\MotorDriver.scala 156:43]
    node _disp_mux_io_disp_content_T_11 = asUInt(UInt<5>("h1e")) @[\\src\\main\\scala\\MotorDriver.scala 156:67]
    node _disp_mux_io_disp_content_T_12 = asUInt(UInt<5>("h1e")) @[\\src\\main\\scala\\MotorDriver.scala 156:91]
    node _disp_mux_io_disp_content_T_13 = asUInt(UInt<5>("h1e")) @[\\src\\main\\scala\\MotorDriver.scala 156:115]
    node disp_mux_io_disp_content_lo_2 = cat(_disp_mux_io_disp_content_T_12, _disp_mux_io_disp_content_T_13) @[\\src\\main\\scala\\MotorDriver.scala 156:26]
    node disp_mux_io_disp_content_hi_2 = cat(_disp_mux_io_disp_content_T_10, _disp_mux_io_disp_content_T_11) @[\\src\\main\\scala\\MotorDriver.scala 156:26]
    node _disp_mux_io_disp_content_T_14 = cat(disp_mux_io_disp_content_hi_2, disp_mux_io_disp_content_lo_2) @[\\src\\main\\scala\\MotorDriver.scala 156:26]
    node _disp_mux_io_disp_content_T_15 = mux(control_mode, _disp_mux_io_disp_content_T_9, _disp_mux_io_disp_content_T_14) @[\\src\\main\\scala\\MotorDriver.scala 155:8]
    node _disp_mux_io_disp_content_T_16 = mux(brake_active, _disp_mux_io_disp_content_T_4, _disp_mux_io_disp_content_T_15) @[\\src\\main\\scala\\MotorDriver.scala 153:34]
    disp_mux.io.disp_content <= _disp_mux_io_disp_content_T_16 @[\\src\\main\\scala\\MotorDriver.scala 153:28]

