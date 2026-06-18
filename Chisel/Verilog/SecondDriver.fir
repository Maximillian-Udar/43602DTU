FIRRTL version 1.2.0
circuit SecondDriver :
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


  module DCMotorPwm :
    input clock : Clock
    input reset : Reset
    output io : { flip duty_cycle : UInt<10>, flip brake : UInt<1>, T1 : UInt<1>, T2 : UInt<1>, T3 : UInt<1>, T4 : UInt<1>} @[\\src\\main\\scala\\Functions.scala 24:14]

    reg pwmCounter : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[\\src\\main\\scala\\Functions.scala 35:29]
    node _T = sub(UInt<13>("h11c1"), UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 37:35]
    node _T_1 = tail(_T, 1) @[\\src\\main\\scala\\Functions.scala 37:35]
    node _T_2 = geq(pwmCounter, _T_1) @[\\src\\main\\scala\\Functions.scala 37:19]
    when _T_2 : @[\\src\\main\\scala\\Functions.scala 37:42]
      pwmCounter <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 38:16]
    else :
      node _pwmCounter_T = add(pwmCounter, UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 40:30]
      node _pwmCounter_T_1 = tail(_pwmCounter_T, 1) @[\\src\\main\\scala\\Functions.scala 40:30]
      pwmCounter <= _pwmCounter_T_1 @[\\src\\main\\scala\\Functions.scala 40:16]
    node _threshold_T = mul(io.duty_cycle, UInt<13>("h11c1")) @[\\src\\main\\scala\\Functions.scala 43:34]
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
    output io : { flip setPoint : Fixed<32><<12>>, flip measuredVal : Fixed<32><<12>>, flip kp : Fixed<32><<12>>, flip ki : Fixed<32><<12>>, flip kd : Fixed<32><<12>>, flip tick : UInt<1>, flip resetBuffer : UInt<1>, controlOut : Fixed<32><<12>>} @[\\src\\main\\scala\\Functions.scala 71:14]

    reg integralReg : Fixed<32><<12>>, clock with :
      reset => (reset, asFixedPoint(UInt<32>("h0"), 12)) @[\\src\\main\\scala\\Functions.scala 82:29]
    reg prevErrorReg : Fixed<32><<12>>, clock with :
      reset => (reset, asFixedPoint(UInt<32>("h0"), 12)) @[\\src\\main\\scala\\Functions.scala 83:29]
    reg outputReg : Fixed<32><<12>>, clock with :
      reset => (reset, asFixedPoint(UInt<32>("h0"), 12)) @[\\src\\main\\scala\\Functions.scala 84:29]
    node _error_T = sub(io.setPoint, io.measuredVal) @[\\src\\main\\scala\\Functions.scala 89:27]
    node _error_T_1 = tail(_error_T, 1) @[\\src\\main\\scala\\Functions.scala 89:27]
    node error = asFixedPoint(_error_T_1, 12) @[\\src\\main\\scala\\Functions.scala 89:27]
    when io.resetBuffer : @[\\src\\main\\scala\\Functions.scala 91:24]
      integralReg <= asFixedPoint(UInt<32>("h0"), 12) @[\\src\\main\\scala\\Functions.scala 92:18]
      prevErrorReg <= asFixedPoint(UInt<32>("h0"), 12) @[\\src\\main\\scala\\Functions.scala 93:18]
      outputReg <= asFixedPoint(UInt<32>("h0"), 12) @[\\src\\main\\scala\\Functions.scala 94:18]
    else :
      when io.tick : @[\\src\\main\\scala\\Functions.scala 95:24]
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
        node _dTerm_T = sub(error, prevErrorReg) @[\\src\\main\\scala\\Functions.scala 102:40]
        node _dTerm_T_1 = tail(_dTerm_T, 1) @[\\src\\main\\scala\\Functions.scala 102:40]
        node _dTerm_T_2 = asFixedPoint(_dTerm_T_1, 12) @[\\src\\main\\scala\\Functions.scala 102:40]
        node _dTerm_T_3 = mul(io.kd, _dTerm_T_2) @[\\src\\main\\scala\\Functions.scala 102:31]
        reg dTerm : Fixed<<24>>, clock with :
          reset => (UInt<1>("h0"), dTerm) @[\\src\\main\\scala\\Functions.scala 102:24]
        dTerm <= _dTerm_T_3 @[\\src\\main\\scala\\Functions.scala 102:24]
        prevErrorReg <= error @[\\src\\main\\scala\\Functions.scala 103:18]
        node _rawOutput_T = add(pTerm, integralReg) @[\\src\\main\\scala\\Functions.scala 105:35]
        node _rawOutput_T_1 = tail(_rawOutput_T, 1) @[\\src\\main\\scala\\Functions.scala 105:35]
        node _rawOutput_T_2 = asFixedPoint(_rawOutput_T_1, 24) @[\\src\\main\\scala\\Functions.scala 105:35]
        node _rawOutput_T_3 = add(_rawOutput_T_2, dTerm) @[\\src\\main\\scala\\Functions.scala 105:49]
        node _rawOutput_T_4 = tail(_rawOutput_T_3, 1) @[\\src\\main\\scala\\Functions.scala 105:49]
        node _rawOutput_T_5 = asFixedPoint(_rawOutput_T_4, 24) @[\\src\\main\\scala\\Functions.scala 105:49]
        reg rawOutput : Fixed<<24>>, clock with :
          reset => (UInt<1>("h0"), rawOutput) @[\\src\\main\\scala\\Functions.scala 105:28]
        rawOutput <= _rawOutput_T_5 @[\\src\\main\\scala\\Functions.scala 105:28]
        node _outputReg_T = gt(rawOutput, asFixedPoint(UInt<32>("h800"), 12)) @[\\src\\main\\scala\\Functions.scala 106:32]
        node _outputReg_T_1 = lt(rawOutput, asFixedPoint(UInt<32>("hfffff800"), 12)) @[\\src\\main\\scala\\Functions.scala 107:32]
        node _outputReg_T_2 = mux(_outputReg_T_1, asFixedPoint(UInt<32>("hfffff800"), 12), rawOutput) @[\\src\\main\\scala\\Functions.scala 107:21]
        node _outputReg_T_3 = mux(_outputReg_T, asFixedPoint(UInt<32>("h800"), 12), _outputReg_T_2) @[\\src\\main\\scala\\Functions.scala 106:21]
        outputReg <= _outputReg_T_3 @[\\src\\main\\scala\\Functions.scala 106:15]
    io.controlOut <= outputReg @[\\src\\main\\scala\\Functions.scala 109:17]

  module StuckDetector :
    input clock : Clock
    input reset : Reset
    output io : { flip external_overcurrent_input : UInt<1>, flip clear_shutdown : UInt<1>, motor_disable : UInt<1>} @[\\src\\main\\scala\\Functions.scala 158:14]

    node maxCycles = mul(UInt<17>("h186a0"), UInt<8>("h96")) @[\\src\\main\\scala\\Functions.scala 164:44]
    reg durationReg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[\\src\\main\\scala\\Functions.scala 165:28]
    reg isStuckReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 166:28]
    when io.clear_shutdown : @[\\src\\main\\scala\\Functions.scala 167:27]
      isStuckReg <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 167:40]
      durationReg <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 167:64]
    else :
      node _T = eq(isStuckReg, UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 168:10]
      when _T : @[\\src\\main\\scala\\Functions.scala 168:23]
        when io.external_overcurrent_input : @[\\src\\main\\scala\\Functions.scala 169:43]
          node _T_1 = geq(durationReg, maxCycles) @[\\src\\main\\scala\\Functions.scala 170:26]
          when _T_1 : @[\\src\\main\\scala\\Functions.scala 170:40]
            isStuckReg <= UInt<1>("h1") @[\\src\\main\\scala\\Functions.scala 170:53]
          else :
            node _durationReg_T = add(durationReg, UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 170:104]
            node _durationReg_T_1 = tail(_durationReg_T, 1) @[\\src\\main\\scala\\Functions.scala 170:104]
            durationReg <= _durationReg_T_1 @[\\src\\main\\scala\\Functions.scala 170:89]
        else :
          durationReg <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 171:33]
    io.motor_disable <= isStuckReg @[\\src\\main\\scala\\Functions.scala 174:20]

  module SevenSegDec :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<5>, out : UInt<7>} @[\\src\\main\\scala\\Functions.scala 226:14]

    node _io_out_T = asUInt(io.in) @[\\src\\main\\scala\\Functions.scala 231:29]
    node _io_out_T_1 = asUInt(UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 232:18]
    node _io_out_T_2 = asUInt(UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 233:18]
    node _io_out_T_3 = asUInt(UInt<2>("h2")) @[\\src\\main\\scala\\Functions.scala 234:18]
    node _io_out_T_4 = asUInt(UInt<2>("h3")) @[\\src\\main\\scala\\Functions.scala 235:18]
    node _io_out_T_5 = asUInt(UInt<3>("h4")) @[\\src\\main\\scala\\Functions.scala 236:18]
    node _io_out_T_6 = asUInt(UInt<3>("h5")) @[\\src\\main\\scala\\Functions.scala 237:18]
    node _io_out_T_7 = asUInt(UInt<3>("h6")) @[\\src\\main\\scala\\Functions.scala 238:18]
    node _io_out_T_8 = asUInt(UInt<3>("h7")) @[\\src\\main\\scala\\Functions.scala 239:18]
    node _io_out_T_9 = asUInt(UInt<4>("h8")) @[\\src\\main\\scala\\Functions.scala 240:18]
    node _io_out_T_10 = asUInt(UInt<4>("h9")) @[\\src\\main\\scala\\Functions.scala 241:18]
    node _io_out_T_11 = asUInt(UInt<4>("ha")) @[\\src\\main\\scala\\Functions.scala 242:17]
    node _io_out_T_12 = asUInt(UInt<4>("hb")) @[\\src\\main\\scala\\Functions.scala 243:17]
    node _io_out_T_13 = asUInt(UInt<4>("hc")) @[\\src\\main\\scala\\Functions.scala 244:17]
    node _io_out_T_14 = asUInt(UInt<4>("hd")) @[\\src\\main\\scala\\Functions.scala 245:17]
    node _io_out_T_15 = asUInt(UInt<4>("he")) @[\\src\\main\\scala\\Functions.scala 246:17]
    node _io_out_T_16 = asUInt(UInt<4>("hf")) @[\\src\\main\\scala\\Functions.scala 247:17]
    node _io_out_T_17 = asUInt(UInt<5>("h10")) @[\\src\\main\\scala\\Functions.scala 248:17]
    node _io_out_T_18 = asUInt(UInt<5>("h11")) @[\\src\\main\\scala\\Functions.scala 249:17]
    node _io_out_T_19 = asUInt(UInt<5>("h12")) @[\\src\\main\\scala\\Functions.scala 250:17]
    node _io_out_T_20 = asUInt(UInt<5>("h13")) @[\\src\\main\\scala\\Functions.scala 251:17]
    node _io_out_T_21 = asUInt(UInt<5>("h14")) @[\\src\\main\\scala\\Functions.scala 252:17]
    node _io_out_T_22 = asUInt(UInt<5>("h15")) @[\\src\\main\\scala\\Functions.scala 253:17]
    node _io_out_T_23 = asUInt(UInt<5>("h16")) @[\\src\\main\\scala\\Functions.scala 254:17]
    node _io_out_T_24 = asUInt(UInt<5>("h17")) @[\\src\\main\\scala\\Functions.scala 255:17]
    node _io_out_T_25 = asUInt(UInt<5>("h18")) @[\\src\\main\\scala\\Functions.scala 256:17]
    node _io_out_T_26 = asUInt(UInt<5>("h19")) @[\\src\\main\\scala\\Functions.scala 257:17]
    node _io_out_T_27 = asUInt(UInt<5>("h1a")) @[\\src\\main\\scala\\Functions.scala 258:17]
    node _io_out_T_28 = asUInt(UInt<5>("h1b")) @[\\src\\main\\scala\\Functions.scala 259:17]
    node _io_out_T_29 = asUInt(UInt<5>("h1c")) @[\\src\\main\\scala\\Functions.scala 260:17]
    node _io_out_T_30 = asUInt(UInt<5>("h1d")) @[\\src\\main\\scala\\Functions.scala 261:17]
    node _io_out_T_31 = asUInt(UInt<5>("h1e")) @[\\src\\main\\scala\\Functions.scala 262:21]
    node _io_out_T_32 = eq(_io_out_T_1, _io_out_T) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_33 = mux(_io_out_T_32, UInt<6>("h3f"), UInt<7>("h0")) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_34 = eq(_io_out_T_2, _io_out_T) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_35 = mux(_io_out_T_34, UInt<3>("h6"), _io_out_T_33) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_36 = eq(_io_out_T_3, _io_out_T) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_37 = mux(_io_out_T_36, UInt<7>("h5b"), _io_out_T_35) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_38 = eq(_io_out_T_4, _io_out_T) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_39 = mux(_io_out_T_38, UInt<7>("h4f"), _io_out_T_37) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_40 = eq(_io_out_T_5, _io_out_T) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_41 = mux(_io_out_T_40, UInt<7>("h66"), _io_out_T_39) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_42 = eq(_io_out_T_6, _io_out_T) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_43 = mux(_io_out_T_42, UInt<7>("h6d"), _io_out_T_41) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_44 = eq(_io_out_T_7, _io_out_T) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_45 = mux(_io_out_T_44, UInt<7>("h7d"), _io_out_T_43) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_46 = eq(_io_out_T_8, _io_out_T) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_47 = mux(_io_out_T_46, UInt<3>("h7"), _io_out_T_45) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_48 = eq(_io_out_T_9, _io_out_T) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_49 = mux(_io_out_T_48, UInt<7>("h7f"), _io_out_T_47) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_50 = eq(_io_out_T_10, _io_out_T) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_51 = mux(_io_out_T_50, UInt<7>("h6f"), _io_out_T_49) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_52 = eq(_io_out_T_11, _io_out_T) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_53 = mux(_io_out_T_52, UInt<7>("h77"), _io_out_T_51) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_54 = eq(_io_out_T_12, _io_out_T) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_55 = mux(_io_out_T_54, UInt<7>("h7c"), _io_out_T_53) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_56 = eq(_io_out_T_13, _io_out_T) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_57 = mux(_io_out_T_56, UInt<6>("h39"), _io_out_T_55) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_58 = eq(_io_out_T_14, _io_out_T) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_59 = mux(_io_out_T_58, UInt<7>("h5e"), _io_out_T_57) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_60 = eq(_io_out_T_15, _io_out_T) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_61 = mux(_io_out_T_60, UInt<7>("h79"), _io_out_T_59) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_62 = eq(_io_out_T_16, _io_out_T) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_63 = mux(_io_out_T_62, UInt<7>("h71"), _io_out_T_61) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_64 = eq(_io_out_T_17, _io_out_T) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_65 = mux(_io_out_T_64, UInt<6>("h3c"), _io_out_T_63) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_66 = eq(_io_out_T_18, _io_out_T) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_67 = mux(_io_out_T_66, UInt<7>("h76"), _io_out_T_65) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_68 = eq(_io_out_T_19, _io_out_T) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_69 = mux(_io_out_T_68, UInt<3>("h6"), _io_out_T_67) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_70 = eq(_io_out_T_20, _io_out_T) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_71 = mux(_io_out_T_70, UInt<4>("hf"), _io_out_T_69) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_72 = eq(_io_out_T_21, _io_out_T) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_73 = mux(_io_out_T_72, UInt<6>("h38"), _io_out_T_71) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_74 = eq(_io_out_T_22, _io_out_T) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_75 = mux(_io_out_T_74, UInt<6>("h38"), _io_out_T_73) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_76 = eq(_io_out_T_23, _io_out_T) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_77 = mux(_io_out_T_76, UInt<7>("h70"), _io_out_T_75) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_78 = eq(_io_out_T_24, _io_out_T) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_79 = mux(_io_out_T_78, UInt<6>("h3f"), _io_out_T_77) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_80 = eq(_io_out_T_25, _io_out_T) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_81 = mux(_io_out_T_80, UInt<7>("h73"), _io_out_T_79) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_82 = eq(_io_out_T_26, _io_out_T) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_83 = mux(_io_out_T_82, UInt<7>("h67"), _io_out_T_81) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_84 = eq(_io_out_T_27, _io_out_T) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_85 = mux(_io_out_T_84, UInt<6>("h31"), _io_out_T_83) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_86 = eq(_io_out_T_28, _io_out_T) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_87 = mux(_io_out_T_86, UInt<7>("h6d"), _io_out_T_85) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_88 = eq(_io_out_T_29, _io_out_T) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_89 = mux(_io_out_T_88, UInt<7>("h78"), _io_out_T_87) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_90 = eq(_io_out_T_30, _io_out_T) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_91 = mux(_io_out_T_90, UInt<6>("h3e"), _io_out_T_89) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_92 = eq(_io_out_T_31, _io_out_T) @[\\src\\main\\scala\\Functions.scala 231:46]
    node _io_out_T_93 = mux(_io_out_T_92, UInt<1>("h0"), _io_out_T_91) @[\\src\\main\\scala\\Functions.scala 231:46]
    io.out <= _io_out_T_93 @[\\src\\main\\scala\\Functions.scala 231:10]

  module DisplayMultiplexer :
    input clock : Clock
    input reset : Reset
    output io : { flip disp_content : UInt<20>, flip dots : UInt<4>, seg : UInt<8>, an : UInt<4>} @[\\src\\main\\scala\\Functions.scala 178:14]

    reg cnt : UInt<17>, clock with :
      reset => (reset, UInt<17>("h0")) @[\\src\\main\\scala\\Functions.scala 185:20]
    node _cnt_T = eq(cnt, UInt<17>("h1869f")) @[\\src\\main\\scala\\Functions.scala 186:18]
    node _cnt_T_1 = add(cnt, UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 186:54]
    node _cnt_T_2 = tail(_cnt_T_1, 1) @[\\src\\main\\scala\\Functions.scala 186:54]
    node _cnt_T_3 = mux(_cnt_T, UInt<1>("h0"), _cnt_T_2) @[\\src\\main\\scala\\Functions.scala 186:13]
    cnt <= _cnt_T_3 @[\\src\\main\\scala\\Functions.scala 186:7]
    node tick = eq(cnt, UInt<17>("h1869f")) @[\\src\\main\\scala\\Functions.scala 187:18]
    reg digit : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[\\src\\main\\scala\\Functions.scala 189:22]
    when tick : @[\\src\\main\\scala\\Functions.scala 190:14]
      node _digit_T = add(digit, UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 190:31]
      node _digit_T_1 = tail(_digit_T, 1) @[\\src\\main\\scala\\Functions.scala 190:31]
      digit <= _digit_T_1 @[\\src\\main\\scala\\Functions.scala 190:22]
    wire currentRaw : UInt<5> @[\\src\\main\\scala\\Functions.scala 192:24]
    currentRaw <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 193:14]
    node _T = eq(UInt<1>("h0"), digit) @[\\src\\main\\scala\\Functions.scala 194:17]
    when _T : @[\\src\\main\\scala\\Functions.scala 194:17]
      node _currentRaw_T = bits(io.disp_content, 4, 0) @[\\src\\main\\scala\\Functions.scala 195:44]
      currentRaw <= _currentRaw_T @[\\src\\main\\scala\\Functions.scala 195:26]
    else :
      node _T_1 = eq(UInt<1>("h1"), digit) @[\\src\\main\\scala\\Functions.scala 194:17]
      when _T_1 : @[\\src\\main\\scala\\Functions.scala 194:17]
        node _currentRaw_T_1 = bits(io.disp_content, 9, 5) @[\\src\\main\\scala\\Functions.scala 196:44]
        currentRaw <= _currentRaw_T_1 @[\\src\\main\\scala\\Functions.scala 196:26]
      else :
        node _T_2 = eq(UInt<2>("h2"), digit) @[\\src\\main\\scala\\Functions.scala 194:17]
        when _T_2 : @[\\src\\main\\scala\\Functions.scala 194:17]
          node _currentRaw_T_2 = bits(io.disp_content, 14, 10) @[\\src\\main\\scala\\Functions.scala 197:44]
          currentRaw <= _currentRaw_T_2 @[\\src\\main\\scala\\Functions.scala 197:26]
        else :
          node _T_3 = eq(UInt<2>("h3"), digit) @[\\src\\main\\scala\\Functions.scala 194:17]
          when _T_3 : @[\\src\\main\\scala\\Functions.scala 194:17]
            node _currentRaw_T_3 = bits(io.disp_content, 19, 15) @[\\src\\main\\scala\\Functions.scala 198:44]
            currentRaw <= _currentRaw_T_3 @[\\src\\main\\scala\\Functions.scala 198:26]
    inst decoder of SevenSegDec @[\\src\\main\\scala\\Functions.scala 201:23]
    decoder.clock <= clock
    decoder.reset <= reset
    wire _decoder_io_in_WIRE : UInt<5> @[\\src\\main\\scala\\Functions.scala 202:29]
    _decoder_io_in_WIRE <= currentRaw @[\\src\\main\\scala\\Functions.scala 202:29]
    wire _decoder_io_in_WIRE_1 : UInt<5> @[\\src\\main\\scala\\Functions.scala 202:29]
    _decoder_io_in_WIRE_1 <= _decoder_io_in_WIRE @[\\src\\main\\scala\\Functions.scala 202:29]
    decoder.io.in <= _decoder_io_in_WIRE_1 @[\\src\\main\\scala\\Functions.scala 202:17]
    node _currentDot_T = dshr(io.dots, digit) @[\\src\\main\\scala\\Functions.scala 205:27]
    node currentDot = bits(_currentDot_T, 0, 0) @[\\src\\main\\scala\\Functions.scala 205:27]
    node fullSeg = cat(currentDot, decoder.io.out) @[\\src\\main\\scala\\Functions.scala 206:28]
    wire select : UInt<4> @[\\src\\main\\scala\\Functions.scala 208:27]
    select <= UInt<4>("h1") @[\\src\\main\\scala\\Functions.scala 208:27]
    node _T_4 = eq(UInt<1>("h0"), digit) @[\\src\\main\\scala\\Functions.scala 209:17]
    when _T_4 : @[\\src\\main\\scala\\Functions.scala 209:17]
      select <= UInt<1>("h1") @[\\src\\main\\scala\\Functions.scala 210:22]
    else :
      node _T_5 = eq(UInt<1>("h1"), digit) @[\\src\\main\\scala\\Functions.scala 209:17]
      when _T_5 : @[\\src\\main\\scala\\Functions.scala 209:17]
        select <= UInt<2>("h2") @[\\src\\main\\scala\\Functions.scala 211:22]
      else :
        node _T_6 = eq(UInt<2>("h2"), digit) @[\\src\\main\\scala\\Functions.scala 209:17]
        when _T_6 : @[\\src\\main\\scala\\Functions.scala 209:17]
          select <= UInt<3>("h4") @[\\src\\main\\scala\\Functions.scala 212:22]
        else :
          node _T_7 = eq(UInt<2>("h3"), digit) @[\\src\\main\\scala\\Functions.scala 209:17]
          when _T_7 : @[\\src\\main\\scala\\Functions.scala 209:17]
            select <= UInt<4>("h8") @[\\src\\main\\scala\\Functions.scala 213:22]
    node _io_seg_T = not(fullSeg) @[\\src\\main\\scala\\Functions.scala 216:13]
    io.seg <= _io_seg_T @[\\src\\main\\scala\\Functions.scala 216:10]
    node _io_an_T = not(select) @[\\src\\main\\scala\\Functions.scala 217:13]
    io.an <= _io_an_T @[\\src\\main\\scala\\Functions.scala 217:10]

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

  module Debouncer :
    input clock : Clock
    input reset : Reset
    output io : { flip btn_in : UInt<1>, out : UInt<1>, state : UInt<1>} @[\\src\\main\\scala\\Functions.scala 267:14]

    reg btn_sync_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), btn_sync_REG) @[\\src\\main\\scala\\Functions.scala 272:33]
    btn_sync_REG <= io.btn_in @[\\src\\main\\scala\\Functions.scala 272:33]
    reg btn_sync : UInt<1>, clock with :
      reset => (UInt<1>("h0"), btn_sync) @[\\src\\main\\scala\\Functions.scala 272:25]
    btn_sync <= btn_sync_REG @[\\src\\main\\scala\\Functions.scala 272:25]
    reg btnDebReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 273:26]
    reg cntReg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[\\src\\main\\scala\\Functions.scala 274:23]
    node tick = eq(cntReg, UInt<17>("h1869f")) @[\\src\\main\\scala\\Functions.scala 275:21]
    node _cntReg_T = add(cntReg, UInt<1>("h1")) @[\\src\\main\\scala\\Functions.scala 277:20]
    node _cntReg_T_1 = tail(_cntReg_T, 1) @[\\src\\main\\scala\\Functions.scala 277:20]
    cntReg <= _cntReg_T_1 @[\\src\\main\\scala\\Functions.scala 277:10]
    when tick : @[\\src\\main\\scala\\Functions.scala 278:15]
      cntReg <= UInt<1>("h0") @[\\src\\main\\scala\\Functions.scala 279:12]
      btnDebReg <= btn_sync @[\\src\\main\\scala\\Functions.scala 280:15]
    reg btnCleanPrev : UInt<1>, clock with :
      reset => (UInt<1>("h0"), btnCleanPrev) @[\\src\\main\\scala\\Functions.scala 283:29]
    btnCleanPrev <= btnDebReg @[\\src\\main\\scala\\Functions.scala 283:29]
    node _io_out_T = eq(btnCleanPrev, UInt<1>("h0")) @[\\src\\main\\scala\\Functions.scala 284:26]
    node _io_out_T_1 = and(btnDebReg, _io_out_T) @[\\src\\main\\scala\\Functions.scala 284:23]
    io.out <= _io_out_T_1 @[\\src\\main\\scala\\Functions.scala 284:10]
    io.state <= btnDebReg @[\\src\\main\\scala\\Functions.scala 285:12]

  module SecondDriver :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip uart_rx : UInt<1>, flip photo_sensor_A : UInt<1>, flip photo_sensor_B : UInt<1>, flip over_current_positive : UInt<1>, flip over_current_negative : UInt<1>, flip error_cleared : UInt<1>, uart_tx : UInt<1>, T1 : UInt<1>, T2 : UInt<1>, T3 : UInt<1>, T4 : UInt<1>, seg : UInt<8>, an : UInt<4>} @[\\src\\main\\scala\\SecondDriver.scala 6:14]

    inst rx of UartRx @[\\src\\main\\scala\\SecondDriver.scala 29:18]
    rx.clock <= clock
    rx.reset <= reset
    inst tx of UartTx @[\\src\\main\\scala\\SecondDriver.scala 30:18]
    tx.clock <= clock
    tx.reset <= reset
    inst pwm_signal of DCMotorPwm @[\\src\\main\\scala\\SecondDriver.scala 31:26]
    pwm_signal.clock <= clock
    pwm_signal.reset <= reset
    inst pid of PIDController @[\\src\\main\\scala\\SecondDriver.scala 32:19]
    pid.clock <= clock
    pid.reset <= reset
    inst stuck_detector of StuckDetector @[\\src\\main\\scala\\SecondDriver.scala 33:30]
    stuck_detector.clock <= clock
    stuck_detector.reset <= reset
    inst display of DisplayMultiplexer @[\\src\\main\\scala\\SecondDriver.scala 34:23]
    display.clock <= clock
    display.reset <= reset
    inst rotations of RotationCounter @[\\src\\main\\scala\\SecondDriver.scala 35:25]
    rotations.clock <= clock
    rotations.reset <= reset
    inst error_clear_debounce of Debouncer @[\\src\\main\\scala\\SecondDriver.scala 36:36]
    error_clear_debounce.clock <= clock
    error_clear_debounce.reset <= reset
    rx.io.rx <= io.uart_rx @[\\src\\main\\scala\\SecondDriver.scala 49:12]
    reg rotations_io_signal_A_cnt : UInt<14>, clock with :
      reset => (reset, UInt<14>("h0")) @[\\src\\main\\scala\\SecondDriver.scala 41:23]
    reg rotations_io_signal_A_out : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[\\src\\main\\scala\\SecondDriver.scala 42:23]
    node _rotations_io_signal_A_T = eq(io.photo_sensor_A, rotations_io_signal_A_out) @[\\src\\main\\scala\\SecondDriver.scala 43:15]
    when _rotations_io_signal_A_T : @[\\src\\main\\scala\\SecondDriver.scala 43:24]
      rotations_io_signal_A_cnt <= UInt<1>("h0") @[\\src\\main\\scala\\SecondDriver.scala 43:30]
    else :
      node _rotations_io_signal_A_cnt_T = add(rotations_io_signal_A_cnt, UInt<1>("h1")) @[\\src\\main\\scala\\SecondDriver.scala 44:29]
      node _rotations_io_signal_A_cnt_T_1 = tail(_rotations_io_signal_A_cnt_T, 1) @[\\src\\main\\scala\\SecondDriver.scala 44:29]
      rotations_io_signal_A_cnt <= _rotations_io_signal_A_cnt_T_1 @[\\src\\main\\scala\\SecondDriver.scala 44:22]
      node _rotations_io_signal_A_T_1 = eq(rotations_io_signal_A_cnt, UInt<7>("h64")) @[\\src\\main\\scala\\SecondDriver.scala 44:45]
      when _rotations_io_signal_A_T_1 : @[\\src\\main\\scala\\SecondDriver.scala 44:56]
        rotations_io_signal_A_out <= io.photo_sensor_A @[\\src\\main\\scala\\SecondDriver.scala 44:62]
    rotations.io.signal_A <= rotations_io_signal_A_out @[\\src\\main\\scala\\SecondDriver.scala 50:25]
    reg rotations_io_signal_B_cnt : UInt<14>, clock with :
      reset => (reset, UInt<14>("h0")) @[\\src\\main\\scala\\SecondDriver.scala 41:23]
    reg rotations_io_signal_B_out : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[\\src\\main\\scala\\SecondDriver.scala 42:23]
    node _rotations_io_signal_B_T = eq(io.photo_sensor_B, rotations_io_signal_B_out) @[\\src\\main\\scala\\SecondDriver.scala 43:15]
    when _rotations_io_signal_B_T : @[\\src\\main\\scala\\SecondDriver.scala 43:24]
      rotations_io_signal_B_cnt <= UInt<1>("h0") @[\\src\\main\\scala\\SecondDriver.scala 43:30]
    else :
      node _rotations_io_signal_B_cnt_T = add(rotations_io_signal_B_cnt, UInt<1>("h1")) @[\\src\\main\\scala\\SecondDriver.scala 44:29]
      node _rotations_io_signal_B_cnt_T_1 = tail(_rotations_io_signal_B_cnt_T, 1) @[\\src\\main\\scala\\SecondDriver.scala 44:29]
      rotations_io_signal_B_cnt <= _rotations_io_signal_B_cnt_T_1 @[\\src\\main\\scala\\SecondDriver.scala 44:22]
      node _rotations_io_signal_B_T_1 = eq(rotations_io_signal_B_cnt, UInt<7>("h64")) @[\\src\\main\\scala\\SecondDriver.scala 44:45]
      when _rotations_io_signal_B_T_1 : @[\\src\\main\\scala\\SecondDriver.scala 44:56]
        rotations_io_signal_B_out <= io.photo_sensor_B @[\\src\\main\\scala\\SecondDriver.scala 44:62]
    rotations.io.signal_B <= rotations_io_signal_B_out @[\\src\\main\\scala\\SecondDriver.scala 51:25]
    display.io.dots <= UInt<1>("h0") @[\\src\\main\\scala\\SecondDriver.scala 52:19]
    node _stuck_detector_io_external_overcurrent_input_T = or(io.over_current_positive, io.over_current_negative) @[\\src\\main\\scala\\SecondDriver.scala 53:76]
    stuck_detector.io.external_overcurrent_input <= _stuck_detector_io_external_overcurrent_input_T @[\\src\\main\\scala\\SecondDriver.scala 53:48]
    error_clear_debounce.io.btn_in <= io.error_cleared @[\\src\\main\\scala\\SecondDriver.scala 54:34]
    reg pid_timer : UInt<17>, clock with :
      reset => (reset, UInt<17>("h0")) @[\\src\\main\\scala\\SecondDriver.scala 56:26]
    node pid_tick = eq(pid_timer, UInt<17>("h1869f")) @[\\src\\main\\scala\\SecondDriver.scala 57:29]
    when pid_tick : @[\\src\\main\\scala\\SecondDriver.scala 59:18]
      pid_timer <= UInt<1>("h0") @[\\src\\main\\scala\\SecondDriver.scala 60:15]
    else :
      node _pid_timer_T = add(pid_timer, UInt<1>("h1")) @[\\src\\main\\scala\\SecondDriver.scala 62:28]
      node _pid_timer_T_1 = tail(_pid_timer_T, 1) @[\\src\\main\\scala\\SecondDriver.scala 62:28]
      pid_timer <= _pid_timer_T_1 @[\\src\\main\\scala\\SecondDriver.scala 62:15]
    node _current_position_fixed_point_T = asFixedPoint(rotations.io.turns, 0) @[\\src\\main\\scala\\SecondDriver.scala 67:69]
    node current_position_fixed_point = mul(_current_position_fixed_point_T, asFixedPoint(UInt<32>("h222"), 12)) @[\\src\\main\\scala\\SecondDriver.scala 67:76]
    node _current_position_cm_T = shr(current_position_fixed_point, 12) @[\\src\\main\\scala\\SecondDriver.scala 68:59]
    node current_position_cm = asSInt(_current_position_cm_T) @[\\src\\main\\scala\\SecondDriver.scala 68:69]
    reg target_position_cm : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("h0"))) @[\\src\\main\\scala\\SecondDriver.scala 71:35]
    reg manual_speed : UInt<10>, clock with :
      reset => (reset, UInt<10>("h200")) @[\\src\\main\\scala\\SecondDriver.scala 72:29]
    reg control_mode : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[\\src\\main\\scala\\SecondDriver.scala 73:29]
    reg manual_brake : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[\\src\\main\\scala\\SecondDriver.scala 74:29]
    reg system_active : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[\\src\\main\\scala\\SecondDriver.scala 75:30]
    reg uartState : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[\\src\\main\\scala\\SecondDriver.scala 79:26]
    reg CMDByte : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[\\src\\main\\scala\\SecondDriver.scala 80:24]
    wire reset_triggered : UInt<1> @[\\src\\main\\scala\\SecondDriver.scala 81:36]
    reset_triggered <= UInt<1>("h0") @[\\src\\main\\scala\\SecondDriver.scala 81:36]
    when rx.io.done : @[\\src\\main\\scala\\SecondDriver.scala 83:21]
      node _T = eq(UInt<2>("h0"), uartState) @[\\src\\main\\scala\\SecondDriver.scala 84:23]
      when _T : @[\\src\\main\\scala\\SecondDriver.scala 84:23]
        node _T_1 = eq(rx.io.data, UInt<8>("haa")) @[\\src\\main\\scala\\SecondDriver.scala 85:37]
        when _T_1 : @[\\src\\main\\scala\\SecondDriver.scala 85:49]
          uartState <= UInt<2>("h1") @[\\src\\main\\scala\\SecondDriver.scala 85:61]
      else :
        node _T_2 = eq(UInt<2>("h1"), uartState) @[\\src\\main\\scala\\SecondDriver.scala 84:23]
        when _T_2 : @[\\src\\main\\scala\\SecondDriver.scala 84:23]
          CMDByte <= rx.io.data @[\\src\\main\\scala\\SecondDriver.scala 86:26]
          uartState <= UInt<2>("h2") @[\\src\\main\\scala\\SecondDriver.scala 86:51]
        else :
          node _T_3 = eq(UInt<2>("h2"), uartState) @[\\src\\main\\scala\\SecondDriver.scala 84:23]
          when _T_3 : @[\\src\\main\\scala\\SecondDriver.scala 84:23]
            node _T_4 = eq(UInt<1>("h1"), CMDByte) @[\\src\\main\\scala\\SecondDriver.scala 88:25]
            when _T_4 : @[\\src\\main\\scala\\SecondDriver.scala 88:25]
              node _target_position_cm_T = mul(rx.io.data, UInt<7>("h64")) @[\\src\\main\\scala\\SecondDriver.scala 89:58]
              node _target_position_cm_T_1 = asSInt(_target_position_cm_T) @[\\src\\main\\scala\\SecondDriver.scala 89:67]
              target_position_cm <= _target_position_cm_T_1 @[\\src\\main\\scala\\SecondDriver.scala 89:43]
              system_active <= UInt<1>("h1") @[\\src\\main\\scala\\SecondDriver.scala 89:89]
              manual_brake <= UInt<1>("h0") @[\\src\\main\\scala\\SecondDriver.scala 89:113]
            else :
              node _T_5 = eq(UInt<2>("h2"), CMDByte) @[\\src\\main\\scala\\SecondDriver.scala 88:25]
              when _T_5 : @[\\src\\main\\scala\\SecondDriver.scala 88:25]
                control_mode <= UInt<1>("h0") @[\\src\\main\\scala\\SecondDriver.scala 91:26]
                manual_brake <= UInt<1>("h0") @[\\src\\main\\scala\\SecondDriver.scala 92:26]
                node _T_6 = eq(UInt<1>("h0"), rx.io.data) @[\\src\\main\\scala\\SecondDriver.scala 93:32]
                when _T_6 : @[\\src\\main\\scala\\SecondDriver.scala 93:32]
                  manual_brake <= UInt<1>("h1") @[\\src\\main\\scala\\SecondDriver.scala 94:38]
                else :
                  node _T_7 = eq(UInt<1>("h1"), rx.io.data) @[\\src\\main\\scala\\SecondDriver.scala 93:32]
                  when _T_7 : @[\\src\\main\\scala\\SecondDriver.scala 93:32]
                    manual_speed <= UInt<10>("h2bc") @[\\src\\main\\scala\\SecondDriver.scala 95:38]
                    manual_brake <= UInt<1>("h0") @[\\src\\main\\scala\\SecondDriver.scala 95:61]
                  else :
                    node _T_8 = eq(UInt<2>("h2"), rx.io.data) @[\\src\\main\\scala\\SecondDriver.scala 93:32]
                    when _T_8 : @[\\src\\main\\scala\\SecondDriver.scala 93:32]
                      manual_speed <= UInt<10>("h320") @[\\src\\main\\scala\\SecondDriver.scala 96:38]
                      manual_brake <= UInt<1>("h0") @[\\src\\main\\scala\\SecondDriver.scala 96:61]
                    else :
                      node _T_9 = eq(UInt<2>("h3"), rx.io.data) @[\\src\\main\\scala\\SecondDriver.scala 93:32]
                      when _T_9 : @[\\src\\main\\scala\\SecondDriver.scala 93:32]
                        manual_speed <= UInt<9>("h12c") @[\\src\\main\\scala\\SecondDriver.scala 97:38]
                        manual_brake <= UInt<1>("h0") @[\\src\\main\\scala\\SecondDriver.scala 97:61]
                      else :
                        node _T_10 = eq(UInt<3>("h4"), rx.io.data) @[\\src\\main\\scala\\SecondDriver.scala 93:32]
                        when _T_10 : @[\\src\\main\\scala\\SecondDriver.scala 93:32]
                          manual_speed <= UInt<8>("hc8") @[\\src\\main\\scala\\SecondDriver.scala 98:38]
                          manual_brake <= UInt<1>("h0") @[\\src\\main\\scala\\SecondDriver.scala 98:61]
              else :
                node _T_11 = eq(UInt<8>("hff"), CMDByte) @[\\src\\main\\scala\\SecondDriver.scala 88:25]
                when _T_11 : @[\\src\\main\\scala\\SecondDriver.scala 88:25]
                  reset_triggered <= UInt<1>("h1") @[\\src\\main\\scala\\SecondDriver.scala 101:38]
            uartState <= UInt<2>("h0") @[\\src\\main\\scala\\SecondDriver.scala 103:19]
    node _stuck_detector_io_clear_shutdown_T = or(error_clear_debounce.io.out, reset_triggered) @[\\src\\main\\scala\\SecondDriver.scala 107:68]
    stuck_detector.io.clear_shutdown <= _stuck_detector_io_clear_shutdown_T @[\\src\\main\\scala\\SecondDriver.scala 107:36]
    node _at_position_T = sub(target_position_cm, asSInt(UInt<2>("h1"))) @[\\src\\main\\scala\\SecondDriver.scala 110:80]
    node _at_position_T_1 = tail(_at_position_T, 1) @[\\src\\main\\scala\\SecondDriver.scala 110:80]
    node _at_position_T_2 = asSInt(_at_position_T_1) @[\\src\\main\\scala\\SecondDriver.scala 110:80]
    node _at_position_T_3 = geq(current_position_cm, _at_position_T_2) @[\\src\\main\\scala\\SecondDriver.scala 110:58]
    node _at_position_T_4 = add(target_position_cm, asSInt(UInt<2>("h1"))) @[\\src\\main\\scala\\SecondDriver.scala 110:131]
    node _at_position_T_5 = tail(_at_position_T_4, 1) @[\\src\\main\\scala\\SecondDriver.scala 110:131]
    node _at_position_T_6 = asSInt(_at_position_T_5) @[\\src\\main\\scala\\SecondDriver.scala 110:131]
    node _at_position_T_7 = leq(current_position_cm, _at_position_T_6) @[\\src\\main\\scala\\SecondDriver.scala 110:109]
    node _at_position_T_8 = and(_at_position_T_3, _at_position_T_7) @[\\src\\main\\scala\\SecondDriver.scala 110:86]
    node at_position = and(control_mode, _at_position_T_8) @[\\src\\main\\scala\\SecondDriver.scala 110:34]
    pid.io.measuredVal <= current_position_fixed_point @[\\src\\main\\scala\\SecondDriver.scala 111:22]
    node _pid_io_setPoint_T = asFixedPoint(target_position_cm, 12) @[\\src\\main\\scala\\SecondDriver.scala 112:53]
    pid.io.setPoint <= _pid_io_setPoint_T @[\\src\\main\\scala\\SecondDriver.scala 112:19]
    pid.io.tick <= UInt<1>("h1") @[\\src\\main\\scala\\SecondDriver.scala 113:15]
    node _pid_io_resetBuffer_T = eq(control_mode, UInt<1>("h0")) @[\\src\\main\\scala\\SecondDriver.scala 114:25]
    node _pid_io_resetBuffer_T_1 = or(_pid_io_resetBuffer_T, manual_brake) @[\\src\\main\\scala\\SecondDriver.scala 114:39]
    node _pid_io_resetBuffer_T_2 = eq(system_active, UInt<1>("h0")) @[\\src\\main\\scala\\SecondDriver.scala 114:58]
    node _pid_io_resetBuffer_T_3 = or(_pid_io_resetBuffer_T_1, _pid_io_resetBuffer_T_2) @[\\src\\main\\scala\\SecondDriver.scala 114:55]
    node _pid_io_resetBuffer_T_4 = or(_pid_io_resetBuffer_T_3, at_position) @[\\src\\main\\scala\\SecondDriver.scala 114:73]
    pid.io.resetBuffer <= _pid_io_resetBuffer_T_4 @[\\src\\main\\scala\\SecondDriver.scala 114:22]
    pid.io.kp <= asFixedPoint(UInt<32>("h1000"), 12) @[\\src\\main\\scala\\SecondDriver.scala 116:13]
    pid.io.ki <= asFixedPoint(UInt<32>("h800"), 12) @[\\src\\main\\scala\\SecondDriver.scala 117:13]
    pid.io.kd <= asFixedPoint(UInt<32>("h19a"), 12) @[\\src\\main\\scala\\SecondDriver.scala 118:13]
    node _pid_duty_raw_T = add(pid.io.controlOut, asFixedPoint(UInt<13>("h800"), 12)) @[\\src\\main\\scala\\SecondDriver.scala 120:42]
    node _pid_duty_raw_T_1 = tail(_pid_duty_raw_T, 1) @[\\src\\main\\scala\\SecondDriver.scala 120:42]
    node _pid_duty_raw_T_2 = asFixedPoint(_pid_duty_raw_T_1, 12) @[\\src\\main\\scala\\SecondDriver.scala 120:42]
    node _pid_duty_raw_T_3 = mul(_pid_duty_raw_T_2, asFixedPoint(UInt<23>("h3ff000"), 12)) @[\\src\\main\\scala\\SecondDriver.scala 120:61]
    node _pid_duty_raw_T_4 = shr(_pid_duty_raw_T_3, 12) @[\\src\\main\\scala\\SecondDriver.scala 120:80]
    node pid_duty_raw = asUInt(_pid_duty_raw_T_4) @[\\src\\main\\scala\\SecondDriver.scala 120:90]
    node _pid_duty_T = gt(pid_duty_raw, UInt<10>("h3ff")) @[\\src\\main\\scala\\SecondDriver.scala 121:59]
    node _pid_duty_T_1 = bits(pid_duty_raw, 9, 0) @[\\src\\main\\scala\\SecondDriver.scala 121:89]
    node _pid_duty_T_2 = mux(_pid_duty_T, UInt<10>("h3ff"), _pid_duty_T_1) @[\\src\\main\\scala\\SecondDriver.scala 121:45]
    node pid_duty = mux(at_position, UInt<10>("h200"), _pid_duty_T_2) @[\\src\\main\\scala\\SecondDriver.scala 121:21]
    node _pwm_signal_io_duty_cycle_T = mux(control_mode, pid_duty, manual_speed) @[\\src\\main\\scala\\SecondDriver.scala 123:34]
    pwm_signal.io.duty_cycle <= _pwm_signal_io_duty_cycle_T @[\\src\\main\\scala\\SecondDriver.scala 123:28]
    node _motor_stopped_T = or(manual_brake, stuck_detector.io.motor_disable) @[\\src\\main\\scala\\SecondDriver.scala 124:36]
    node _motor_stopped_T_1 = eq(system_active, UInt<1>("h0")) @[\\src\\main\\scala\\SecondDriver.scala 124:74]
    node _motor_stopped_T_2 = or(_motor_stopped_T, _motor_stopped_T_1) @[\\src\\main\\scala\\SecondDriver.scala 124:71]
    node motor_stopped = or(_motor_stopped_T_2, at_position) @[\\src\\main\\scala\\SecondDriver.scala 124:89]
    pwm_signal.io.brake <= motor_stopped @[\\src\\main\\scala\\SecondDriver.scala 125:23]
    node _T_12 = eq(system_active, UInt<1>("h0")) @[\\src\\main\\scala\\SecondDriver.scala 128:9]
    when _T_12 : @[\\src\\main\\scala\\SecondDriver.scala 128:25]
      io.T1 <= UInt<1>("h0") @[\\src\\main\\scala\\SecondDriver.scala 129:11]
      io.T2 <= UInt<1>("h1") @[\\src\\main\\scala\\SecondDriver.scala 130:11]
      io.T3 <= UInt<1>("h0") @[\\src\\main\\scala\\SecondDriver.scala 131:11]
      io.T4 <= UInt<1>("h1") @[\\src\\main\\scala\\SecondDriver.scala 132:11]
    else :
      io.T1 <= pwm_signal.io.T1 @[\\src\\main\\scala\\SecondDriver.scala 134:11]
      io.T2 <= pwm_signal.io.T2 @[\\src\\main\\scala\\SecondDriver.scala 135:11]
      io.T3 <= pwm_signal.io.T3 @[\\src\\main\\scala\\SecondDriver.scala 136:11]
      io.T4 <= pwm_signal.io.T4 @[\\src\\main\\scala\\SecondDriver.scala 137:11]
    reg txTimer : UInt<24>, clock with :
      reset => (reset, UInt<24>("h0")) @[\\src\\main\\scala\\SecondDriver.scala 141:24]
    reg txState : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[\\src\\main\\scala\\SecondDriver.scala 143:24]
    tx.io.data <= UInt<1>("h0") @[\\src\\main\\scala\\SecondDriver.scala 144:14]
    tx.io.start <= UInt<1>("h0") @[\\src\\main\\scala\\SecondDriver.scala 145:15]
    node _T_13 = geq(txTimer, UInt<22>("h2625a0")) @[\\src\\main\\scala\\SecondDriver.scala 146:16]
    when _T_13 : @[\\src\\main\\scala\\SecondDriver.scala 146:30]
      node _T_14 = eq(UInt<2>("h0"), txState) @[\\src\\main\\scala\\SecondDriver.scala 147:21]
      when _T_14 : @[\\src\\main\\scala\\SecondDriver.scala 147:21]
        node _T_15 = eq(tx.io.busy, UInt<1>("h0")) @[\\src\\main\\scala\\SecondDriver.scala 149:14]
        when _T_15 : @[\\src\\main\\scala\\SecondDriver.scala 149:27]
          tx.io.data <= UInt<8>("hff") @[\\src\\main\\scala\\SecondDriver.scala 150:22]
          tx.io.start <= UInt<1>("h1") @[\\src\\main\\scala\\SecondDriver.scala 151:23]
          txState <= UInt<2>("h1") @[\\src\\main\\scala\\SecondDriver.scala 152:19]
      else :
        node _T_16 = eq(UInt<2>("h1"), txState) @[\\src\\main\\scala\\SecondDriver.scala 147:21]
        when _T_16 : @[\\src\\main\\scala\\SecondDriver.scala 147:21]
          node _T_17 = eq(tx.io.busy, UInt<1>("h0")) @[\\src\\main\\scala\\SecondDriver.scala 155:14]
          when _T_17 : @[\\src\\main\\scala\\SecondDriver.scala 155:27]
            node _tx_io_data_T = bits(current_position_cm, 15, 8) @[\\src\\main\\scala\\SecondDriver.scala 156:44]
            tx.io.data <= _tx_io_data_T @[\\src\\main\\scala\\SecondDriver.scala 156:22]
            tx.io.start <= UInt<1>("h1") @[\\src\\main\\scala\\SecondDriver.scala 157:23]
            txState <= UInt<2>("h2") @[\\src\\main\\scala\\SecondDriver.scala 158:19]
            txTimer <= UInt<1>("h0") @[\\src\\main\\scala\\SecondDriver.scala 159:19]
        else :
          node _T_18 = eq(UInt<2>("h2"), txState) @[\\src\\main\\scala\\SecondDriver.scala 147:21]
          when _T_18 : @[\\src\\main\\scala\\SecondDriver.scala 147:21]
            node _T_19 = eq(tx.io.busy, UInt<1>("h0")) @[\\src\\main\\scala\\SecondDriver.scala 162:14]
            when _T_19 : @[\\src\\main\\scala\\SecondDriver.scala 162:27]
              node _tx_io_data_T_1 = bits(current_position_cm, 7, 0) @[\\src\\main\\scala\\SecondDriver.scala 163:44]
              tx.io.data <= _tx_io_data_T_1 @[\\src\\main\\scala\\SecondDriver.scala 163:22]
              tx.io.start <= UInt<1>("h1") @[\\src\\main\\scala\\SecondDriver.scala 164:23]
              txState <= UInt<2>("h0") @[\\src\\main\\scala\\SecondDriver.scala 165:19]
              txTimer <= UInt<1>("h0") @[\\src\\main\\scala\\SecondDriver.scala 166:19]
    else :
      node _txTimer_T = add(txTimer, UInt<1>("h1")) @[\\src\\main\\scala\\SecondDriver.scala 170:36]
      node _txTimer_T_1 = tail(_txTimer_T, 1) @[\\src\\main\\scala\\SecondDriver.scala 170:36]
      txTimer <= _txTimer_T_1 @[\\src\\main\\scala\\SecondDriver.scala 170:25]
    io.uart_tx <= tx.io.tx @[\\src\\main\\scala\\SecondDriver.scala 171:14]
    io.an <= display.io.an @[\\src\\main\\scala\\SecondDriver.scala 174:9]
    io.seg <= display.io.seg @[\\src\\main\\scala\\SecondDriver.scala 175:10]
    node _letters_AUTO_T = asUInt(UInt<4>("ha")) @[\\src\\main\\scala\\SecondDriver.scala 176:38]
    node _letters_AUTO_T_1 = asUInt(UInt<5>("h1d")) @[\\src\\main\\scala\\SecondDriver.scala 176:58]
    node _letters_AUTO_T_2 = asUInt(UInt<5>("h1c")) @[\\src\\main\\scala\\SecondDriver.scala 176:77]
    node _letters_AUTO_T_3 = asUInt(UInt<5>("h17")) @[\\src\\main\\scala\\SecondDriver.scala 176:97]
    node letters_AUTO_lo = cat(_letters_AUTO_T_2, _letters_AUTO_T_3) @[\\src\\main\\scala\\SecondDriver.scala 176:25]
    node letters_AUTO_hi = cat(_letters_AUTO_T, _letters_AUTO_T_1) @[\\src\\main\\scala\\SecondDriver.scala 176:25]
    node letters_AUTO = cat(letters_AUTO_hi, letters_AUTO_lo) @[\\src\\main\\scala\\SecondDriver.scala 176:25]
    node _letters_STOP_T = asUInt(UInt<5>("h1b")) @[\\src\\main\\scala\\SecondDriver.scala 177:38]
    node _letters_STOP_T_1 = asUInt(UInt<5>("h1c")) @[\\src\\main\\scala\\SecondDriver.scala 177:58]
    node _letters_STOP_T_2 = asUInt(UInt<5>("h17")) @[\\src\\main\\scala\\SecondDriver.scala 177:78]
    node _letters_STOP_T_3 = asUInt(UInt<5>("h18")) @[\\src\\main\\scala\\SecondDriver.scala 177:98]
    node letters_STOP_lo = cat(_letters_STOP_T_2, _letters_STOP_T_3) @[\\src\\main\\scala\\SecondDriver.scala 177:25]
    node letters_STOP_hi = cat(_letters_STOP_T, _letters_STOP_T_1) @[\\src\\main\\scala\\SecondDriver.scala 177:25]
    node letters_STOP = cat(letters_STOP_hi, letters_STOP_lo) @[\\src\\main\\scala\\SecondDriver.scala 177:25]
    node _display_io_disp_content_T = mux(motor_stopped, letters_STOP, letters_AUTO) @[\\src\\main\\scala\\SecondDriver.scala 178:33]
    display.io.disp_content <= _display_io_disp_content_T @[\\src\\main\\scala\\SecondDriver.scala 178:27]

