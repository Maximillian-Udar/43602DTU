module UartRx(
  input        clock,
  input        reset,
  input        io_rx, // @[src/main/scala/Functions.scala 112:14]
  output       io_done, // @[src/main/scala/Functions.scala 112:14]
  output [7:0] io_data // @[src/main/scala/Functions.scala 112:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg  rxReg_REG; // @[src/main/scala/Functions.scala 119:33]
  reg  rxReg; // @[src/main/scala/Functions.scala 119:25]
  reg [7:0] shiftReg; // @[src/main/scala/Functions.scala 120:25]
  reg [31:0] cntReg; // @[src/main/scala/Functions.scala 121:25]
  reg [3:0] bitsReg; // @[src/main/scala/Functions.scala 122:25]
  reg [1:0] stateReg; // @[src/main/scala/Functions.scala 124:25]
  wire [31:0] _cntReg_T_1 = cntReg + 32'h1; // @[src/main/scala/Functions.scala 129:127]
  wire [9:0] _T_6 = 10'h364 - 10'h1; // @[src/main/scala/Functions.scala 130:41]
  wire [31:0] _GEN_32 = {{22'd0}, _T_6}; // @[src/main/scala/Functions.scala 130:29]
  wire  _T_7 = cntReg == _GEN_32; // @[src/main/scala/Functions.scala 130:29]
  wire [7:0] _shiftReg_T_1 = {rxReg,shiftReg[7:1]}; // @[src/main/scala/Functions.scala 130:80]
  wire [3:0] _bitsReg_T_1 = bitsReg + 4'h1; // @[src/main/scala/Functions.scala 130:180]
  wire [1:0] _GEN_5 = bitsReg == 4'h7 ? 2'h3 : stateReg; // @[src/main/scala/Functions.scala 130:{127,138} 124:25]
  wire [3:0] _GEN_6 = bitsReg == 4'h7 ? bitsReg : _bitsReg_T_1; // @[src/main/scala/Functions.scala 130:127 122:25 130:169]
  wire [31:0] _GEN_7 = cntReg == _GEN_32 ? 32'h0 : _cntReg_T_1; // @[src/main/scala/Functions.scala 130:{209,48,57}]
  wire [7:0] _GEN_8 = cntReg == _GEN_32 ? _shiftReg_T_1 : shiftReg; // @[src/main/scala/Functions.scala 120:25 130:{48,74}]
  wire [1:0] _GEN_9 = cntReg == _GEN_32 ? _GEN_5 : stateReg; // @[src/main/scala/Functions.scala 124:25 130:48]
  wire [3:0] _GEN_10 = cntReg == _GEN_32 ? _GEN_6 : bitsReg; // @[src/main/scala/Functions.scala 122:25 130:48]
  wire [1:0] _GEN_11 = _T_7 ? 2'h0 : stateReg; // @[src/main/scala/Functions.scala 124:25 131:{48,59}]
  wire [31:0] _GEN_13 = _T_7 ? cntReg : _cntReg_T_1; // @[src/main/scala/Functions.scala 121:25 131:{108,48}]
  wire [1:0] _GEN_14 = 2'h3 == stateReg ? _GEN_11 : stateReg; // @[src/main/scala/Functions.scala 127:20 124:25]
  wire [31:0] _GEN_16 = 2'h3 == stateReg ? _GEN_13 : cntReg; // @[src/main/scala/Functions.scala 127:20 121:25]
  wire  _GEN_21 = 2'h2 == stateReg ? 1'h0 : 2'h3 == stateReg & _T_7; // @[src/main/scala/Functions.scala 125:11 127:20]
  wire  _GEN_26 = 2'h1 == stateReg ? 1'h0 : _GEN_21; // @[src/main/scala/Functions.scala 125:11 127:20]
  assign io_done = 2'h0 == stateReg ? 1'h0 : _GEN_26; // @[src/main/scala/Functions.scala 125:11 127:20]
  assign io_data = shiftReg; // @[src/main/scala/Functions.scala 126:11]
  always @(posedge clock) begin
    rxReg_REG <= io_rx; // @[src/main/scala/Functions.scala 119:33]
    rxReg <= rxReg_REG; // @[src/main/scala/Functions.scala 119:25]
    if (reset) begin // @[src/main/scala/Functions.scala 120:25]
      shiftReg <= 8'h0; // @[src/main/scala/Functions.scala 120:25]
    end else if (!(2'h0 == stateReg)) begin // @[src/main/scala/Functions.scala 127:20]
      if (!(2'h1 == stateReg)) begin // @[src/main/scala/Functions.scala 127:20]
        if (2'h2 == stateReg) begin // @[src/main/scala/Functions.scala 127:20]
          shiftReg <= _GEN_8;
        end
      end
    end
    if (reset) begin // @[src/main/scala/Functions.scala 121:25]
      cntReg <= 32'h0; // @[src/main/scala/Functions.scala 121:25]
    end else if (2'h0 == stateReg) begin // @[src/main/scala/Functions.scala 127:20]
      if (~rxReg) begin // @[src/main/scala/Functions.scala 128:30]
        cntReg <= 32'h0; // @[src/main/scala/Functions.scala 128:59]
      end
    end else if (2'h1 == stateReg) begin // @[src/main/scala/Functions.scala 127:20]
      if (cntReg == 32'h1b2) begin // @[src/main/scala/Functions.scala 129:45]
        cntReg <= 32'h0; // @[src/main/scala/Functions.scala 129:73]
      end else begin
        cntReg <= _cntReg_T_1; // @[src/main/scala/Functions.scala 129:117]
      end
    end else if (2'h2 == stateReg) begin // @[src/main/scala/Functions.scala 127:20]
      cntReg <= _GEN_7;
    end else begin
      cntReg <= _GEN_16;
    end
    if (reset) begin // @[src/main/scala/Functions.scala 122:25]
      bitsReg <= 4'h0; // @[src/main/scala/Functions.scala 122:25]
    end else if (!(2'h0 == stateReg)) begin // @[src/main/scala/Functions.scala 127:20]
      if (2'h1 == stateReg) begin // @[src/main/scala/Functions.scala 127:20]
        if (cntReg == 32'h1b2) begin // @[src/main/scala/Functions.scala 129:45]
          bitsReg <= 4'h0; // @[src/main/scala/Functions.scala 129:89]
        end
      end else if (2'h2 == stateReg) begin // @[src/main/scala/Functions.scala 127:20]
        bitsReg <= _GEN_10;
      end
    end
    if (reset) begin // @[src/main/scala/Functions.scala 124:25]
      stateReg <= 2'h0; // @[src/main/scala/Functions.scala 124:25]
    end else if (2'h0 == stateReg) begin // @[src/main/scala/Functions.scala 127:20]
      if (~rxReg) begin // @[src/main/scala/Functions.scala 128:30]
        stateReg <= 2'h1; // @[src/main/scala/Functions.scala 128:41]
      end
    end else if (2'h1 == stateReg) begin // @[src/main/scala/Functions.scala 127:20]
      if (cntReg == 32'h1b2) begin // @[src/main/scala/Functions.scala 129:45]
        stateReg <= 2'h2; // @[src/main/scala/Functions.scala 129:56]
      end
    end else if (2'h2 == stateReg) begin // @[src/main/scala/Functions.scala 127:20]
      stateReg <= _GEN_9;
    end else begin
      stateReg <= _GEN_14;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  rxReg_REG = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  rxReg = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  shiftReg = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  cntReg = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  bitsReg = _RAND_4[3:0];
  _RAND_5 = {1{`RANDOM}};
  stateReg = _RAND_5[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module UartTx(
  input        clock,
  input        reset,
  input  [7:0] io_data, // @[src/main/scala/Functions.scala 136:14]
  input        io_start, // @[src/main/scala/Functions.scala 136:14]
  output       io_tx, // @[src/main/scala/Functions.scala 136:14]
  output       io_busy // @[src/main/scala/Functions.scala 136:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [9:0] reg_; // @[src/main/scala/Functions.scala 143:20]
  reg [31:0] cnt; // @[src/main/scala/Functions.scala 144:20]
  reg [3:0] bits; // @[src/main/scala/Functions.scala 145:21]
  reg  state; // @[src/main/scala/Functions.scala 147:22]
  wire [9:0] _reg_T = {1'h1,io_data,1'h0}; // @[src/main/scala/Functions.scala 151:44]
  wire  _GEN_3 = io_start | state; // @[src/main/scala/Functions.scala 147:22 151:{32,96}]
  wire [9:0] _T_3 = 10'h364 - 10'h1; // @[src/main/scala/Functions.scala 152:38]
  wire [31:0] _GEN_18 = {{22'd0}, _T_3}; // @[src/main/scala/Functions.scala 152:26]
  wire [9:0] _reg_T_2 = {1'h1,reg_[9:1]}; // @[src/main/scala/Functions.scala 152:69]
  wire [3:0] _bits_T_1 = bits + 4'h1; // @[src/main/scala/Functions.scala 152:150]
  wire  _GEN_4 = bits == 4'h9 ? 1'h0 : state; // @[src/main/scala/Functions.scala 152:{106,114} 147:22]
  wire [3:0] _GEN_5 = bits == 4'h9 ? bits : _bits_T_1; // @[src/main/scala/Functions.scala 152:106 145:21 152:142]
  wire [31:0] _cnt_T_1 = cnt + 32'h1; // @[src/main/scala/Functions.scala 152:183]
  assign io_tx = reg_[0]; // @[src/main/scala/Functions.scala 148:15]
  assign io_busy = state; // @[src/main/scala/Functions.scala 149:20]
  always @(posedge clock) begin
    if (reset) begin // @[src/main/scala/Functions.scala 143:20]
      reg_ <= 10'h1; // @[src/main/scala/Functions.scala 143:20]
    end else if (~state) begin // @[src/main/scala/Functions.scala 150:17]
      if (io_start) begin // @[src/main/scala/Functions.scala 151:32]
        reg_ <= _reg_T; // @[src/main/scala/Functions.scala 151:38]
      end
    end else if (state) begin // @[src/main/scala/Functions.scala 150:17]
      if (cnt == _GEN_18) begin // @[src/main/scala/Functions.scala 152:45]
        reg_ <= _reg_T_2; // @[src/main/scala/Functions.scala 152:63]
      end
    end
    if (reset) begin // @[src/main/scala/Functions.scala 144:20]
      cnt <= 32'h0; // @[src/main/scala/Functions.scala 144:20]
    end else if (~state) begin // @[src/main/scala/Functions.scala 150:17]
      if (io_start) begin // @[src/main/scala/Functions.scala 151:32]
        cnt <= 32'h0; // @[src/main/scala/Functions.scala 151:82]
      end
    end else if (state) begin // @[src/main/scala/Functions.scala 150:17]
      if (cnt == _GEN_18) begin // @[src/main/scala/Functions.scala 152:45]
        cnt <= 32'h0; // @[src/main/scala/Functions.scala 152:51]
      end else begin
        cnt <= _cnt_T_1; // @[src/main/scala/Functions.scala 152:176]
      end
    end
    if (reset) begin // @[src/main/scala/Functions.scala 145:21]
      bits <= 4'h0; // @[src/main/scala/Functions.scala 145:21]
    end else if (~state) begin // @[src/main/scala/Functions.scala 150:17]
      if (io_start) begin // @[src/main/scala/Functions.scala 151:32]
        bits <= 4'h0; // @[src/main/scala/Functions.scala 151:70]
      end
    end else if (state) begin // @[src/main/scala/Functions.scala 150:17]
      if (cnt == _GEN_18) begin // @[src/main/scala/Functions.scala 152:45]
        bits <= _GEN_5;
      end
    end
    if (reset) begin // @[src/main/scala/Functions.scala 147:22]
      state <= 1'h0; // @[src/main/scala/Functions.scala 147:22]
    end else if (~state) begin // @[src/main/scala/Functions.scala 150:17]
      state <= _GEN_3;
    end else if (state) begin // @[src/main/scala/Functions.scala 150:17]
      if (cnt == _GEN_18) begin // @[src/main/scala/Functions.scala 152:45]
        state <= _GEN_4;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg_ = _RAND_0[9:0];
  _RAND_1 = {1{`RANDOM}};
  cnt = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  bits = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  state = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module DCMotorPwm(
  input        clock,
  input        reset,
  input  [9:0] io_duty_cycle, // @[src/main/scala/Functions.scala 65:14]
  input        io_brake, // @[src/main/scala/Functions.scala 65:14]
  output       io_T1, // @[src/main/scala/Functions.scala 65:14]
  output       io_T2, // @[src/main/scala/Functions.scala 65:14]
  output       io_T3, // @[src/main/scala/Functions.scala 65:14]
  output       io_T4 // @[src/main/scala/Functions.scala 65:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] pwmCounter; // @[src/main/scala/Functions.scala 76:29]
  wire [11:0] _T_1 = 12'hfa0 - 12'h1; // @[src/main/scala/Functions.scala 78:35]
  wire [31:0] _GEN_5 = {{20'd0}, _T_1}; // @[src/main/scala/Functions.scala 78:19]
  wire [31:0] _pwmCounter_T_1 = pwmCounter + 32'h1; // @[src/main/scala/Functions.scala 81:30]
  wire [21:0] _threshold_T = io_duty_cycle * 12'hfa0; // @[src/main/scala/Functions.scala 84:34]
  wire [11:0] threshold = _threshold_T[21:10]; // @[src/main/scala/Functions.scala 84:50]
  wire [31:0] _GEN_6 = {{20'd0}, threshold}; // @[src/main/scala/Functions.scala 85:30]
  wire  pwmSignal = pwmCounter < _GEN_6; // @[src/main/scala/Functions.scala 85:30]
  wire  _conduct_T4_T = ~pwmSignal; // @[src/main/scala/Functions.scala 100:19]
  wire  conduct_T2 = io_brake ? 1'h0 : pwmSignal; // @[src/main/scala/Functions.scala 92:18 94:16 98:16]
  wire  conduct_T4 = io_brake ? 1'h0 : ~pwmSignal; // @[src/main/scala/Functions.scala 100:16 92:18 96:16]
  assign io_T1 = io_brake | _conduct_T4_T; // @[src/main/scala/Functions.scala 101:16 92:18 93:16]
  assign io_T2 = ~conduct_T2; // @[src/main/scala/Functions.scala 106:12]
  assign io_T3 = io_brake | pwmSignal; // @[src/main/scala/Functions.scala 92:18 95:16 99:16]
  assign io_T4 = ~conduct_T4; // @[src/main/scala/Functions.scala 107:12]
  always @(posedge clock) begin
    if (reset) begin // @[src/main/scala/Functions.scala 76:29]
      pwmCounter <= 32'h0; // @[src/main/scala/Functions.scala 76:29]
    end else if (pwmCounter >= _GEN_5) begin // @[src/main/scala/Functions.scala 78:42]
      pwmCounter <= 32'h0; // @[src/main/scala/Functions.scala 79:16]
    end else begin
      pwmCounter <= _pwmCounter_T_1; // @[src/main/scala/Functions.scala 81:16]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  pwmCounter = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module PIDController(
  input         clock,
  input         reset,
  input  [31:0] io_setPoint, // @[src/main/scala/Functions.scala 314:14]
  input  [31:0] io_measuredVal, // @[src/main/scala/Functions.scala 314:14]
  input         io_tick, // @[src/main/scala/Functions.scala 314:14]
  input         io_resetBuffer, // @[src/main/scala/Functions.scala 314:14]
  output [31:0] io_controlOut // @[src/main/scala/Functions.scala 314:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [63:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [63:0] _RAND_8;
  reg [63:0] _RAND_9;
  reg [63:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [63:0] _RAND_13;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] integralReg; // @[src/main/scala/Functions.scala 325:29]
  reg [31:0] prevErrorReg; // @[src/main/scala/Functions.scala 326:29]
  reg [31:0] outputReg; // @[src/main/scala/Functions.scala 327:29]
  reg  tick_s2; // @[src/main/scala/Functions.scala 332:24]
  reg  tick_s3; // @[src/main/scala/Functions.scala 333:24]
  wire [31:0] error = $signed(io_setPoint) - $signed(io_measuredVal); // @[src/main/scala/Functions.scala 335:27]
  wire [63:0] _pTerm_s1_T = 32'sh99a * $signed(error); // @[src/main/scala/Functions.scala 336:34]
  reg [63:0] pTerm_s1; // @[src/main/scala/Functions.scala 336:27]
  wire [63:0] _iInc_s1_T = 32'sh1 * $signed(error); // @[src/main/scala/Functions.scala 337:34]
  reg [63:0] iInc_s1; // @[src/main/scala/Functions.scala 337:27]
  wire [31:0] _dDiff_s1_T_2 = $signed(error) - $signed(prevErrorReg); // @[src/main/scala/Functions.scala 338:34]
  reg [31:0] dDiff_s1; // @[src/main/scala/Functions.scala 338:27]
  wire [43:0] _GEN_15 = {$signed(integralReg), 12'h0}; // @[src/main/scala/Functions.scala 340:41]
  wire [63:0] _GEN_16 = {{20{_GEN_15[43]}},_GEN_15}; // @[src/main/scala/Functions.scala 340:41]
  wire [63:0] _iSum_s2_T_2 = $signed(_GEN_16) + $signed(iInc_s1); // @[src/main/scala/Functions.scala 340:41]
  reg [63:0] iSum_s2; // @[src/main/scala/Functions.scala 340:28]
  reg [63:0] pTerm_s2; // @[src/main/scala/Functions.scala 341:28]
  wire [63:0] _dTerm_s2_T = 32'shc8000 * $signed(dDiff_s1); // @[src/main/scala/Functions.scala 342:35]
  reg [63:0] dTerm_s2; // @[src/main/scala/Functions.scala 342:28]
  reg [31:0] error_s2; // @[src/main/scala/Functions.scala 343:28]
  wire [63:0] _iClamped_s3_T_2 = $signed(iSum_s2) < -64'sh800000 ? $signed(-64'sh800000) : $signed(iSum_s2); // @[src/main/scala/Functions.scala 345:60]
  wire [63:0] iClamped_s3 = $signed(iSum_s2) > 64'sh800000 ? $signed(64'sh800000) : $signed(_iClamped_s3_T_2); // @[src/main/scala/Functions.scala 345:24]
  wire [63:0] _rawOutput_s3_T_2 = $signed(pTerm_s2) + $signed(iClamped_s3); // @[src/main/scala/Functions.scala 346:31]
  wire [63:0] rawOutput_s3 = $signed(_rawOutput_s3_T_2) + $signed(dTerm_s2); // @[src/main/scala/Functions.scala 346:45]
  reg  tick_s4; // @[src/main/scala/Functions.scala 348:24]
  reg [63:0] sum_s3; // @[src/main/scala/Functions.scala 349:25]
  wire [63:0] _outputReg_T_2 = $signed(sum_s3) < -64'sh800000 ? $signed(-64'sh800000) : $signed(sum_s3); // @[src/main/scala/Functions.scala 359:59]
  wire [63:0] _outputReg_T_3 = $signed(sum_s3) > 64'sh800000 ? $signed(64'sh800000) : $signed(_outputReg_T_2); // @[src/main/scala/Functions.scala 359:24]
  wire [43:0] _GEN_17 = {$signed(outputReg), 12'h0}; // @[src/main/scala/Functions.scala 358:24 359:18 327:29]
  wire [63:0] _GEN_8 = tick_s4 ? $signed(_outputReg_T_3) : $signed({{20{_GEN_17[43]}},_GEN_17}); // @[src/main/scala/Functions.scala 358:24 359:18 327:29]
  wire [63:0] _GEN_9 = tick_s3 ? $signed(iClamped_s3) : $signed({{20{_GEN_15[43]}},_GEN_15}); // @[src/main/scala/Functions.scala 355:24 356:18 325:29]
  wire [63:0] _GEN_11 = tick_s3 ? $signed({{20{_GEN_17[43]}},_GEN_17}) : $signed(_GEN_8); // @[src/main/scala/Functions.scala 355:24 327:29]
  wire [63:0] _GEN_12 = io_resetBuffer ? $signed(64'sh0) : $signed(_GEN_9); // @[src/main/scala/Functions.scala 351:24 352:18]
  wire [63:0] _GEN_14 = io_resetBuffer ? $signed(64'sh0) : $signed(_GEN_11); // @[src/main/scala/Functions.scala 351:24 354:18]
  wire [51:0] _GEN_20 = reset ? $signed(52'sh0) : $signed(_GEN_12[63:12]); // @[src/main/scala/Functions.scala 325:{29,29}]
  wire [51:0] _GEN_22 = reset ? $signed(52'sh0) : $signed(_GEN_14[63:12]); // @[src/main/scala/Functions.scala 327:{29,29}]
  assign io_controlOut = outputReg; // @[src/main/scala/Functions.scala 361:17]
  always @(posedge clock) begin
    integralReg <= _GEN_20[31:0]; // @[src/main/scala/Functions.scala 325:{29,29}]
    if (reset) begin // @[src/main/scala/Functions.scala 326:29]
      prevErrorReg <= 32'sh0; // @[src/main/scala/Functions.scala 326:29]
    end else if (io_resetBuffer) begin // @[src/main/scala/Functions.scala 351:24]
      prevErrorReg <= 32'sh0; // @[src/main/scala/Functions.scala 353:18]
    end else if (tick_s3) begin // @[src/main/scala/Functions.scala 355:24]
      prevErrorReg <= error_s2; // @[src/main/scala/Functions.scala 357:18]
    end
    outputReg <= _GEN_22[31:0]; // @[src/main/scala/Functions.scala 327:{29,29}]
    tick_s2 <= io_tick; // @[src/main/scala/Functions.scala 332:24]
    tick_s3 <= tick_s2; // @[src/main/scala/Functions.scala 333:24]
    if (io_tick) begin // @[src/main/scala/Functions.scala 336:27]
      pTerm_s1 <= _pTerm_s1_T; // @[src/main/scala/Functions.scala 336:27]
    end
    if (io_tick) begin // @[src/main/scala/Functions.scala 337:27]
      iInc_s1 <= _iInc_s1_T; // @[src/main/scala/Functions.scala 337:27]
    end
    if (io_tick) begin // @[src/main/scala/Functions.scala 338:27]
      dDiff_s1 <= _dDiff_s1_T_2; // @[src/main/scala/Functions.scala 338:27]
    end
    if (tick_s2) begin // @[src/main/scala/Functions.scala 340:28]
      iSum_s2 <= _iSum_s2_T_2; // @[src/main/scala/Functions.scala 340:28]
    end
    if (tick_s2) begin // @[src/main/scala/Functions.scala 341:28]
      pTerm_s2 <= pTerm_s1; // @[src/main/scala/Functions.scala 341:28]
    end
    if (tick_s2) begin // @[src/main/scala/Functions.scala 342:28]
      dTerm_s2 <= _dTerm_s2_T; // @[src/main/scala/Functions.scala 342:28]
    end
    if (tick_s2) begin // @[src/main/scala/Functions.scala 343:28]
      error_s2 <= error; // @[src/main/scala/Functions.scala 343:28]
    end
    tick_s4 <= tick_s3; // @[src/main/scala/Functions.scala 348:24]
    if (tick_s3) begin // @[src/main/scala/Functions.scala 349:25]
      sum_s3 <= rawOutput_s3; // @[src/main/scala/Functions.scala 349:25]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  integralReg = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  prevErrorReg = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  outputReg = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  tick_s2 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  tick_s3 = _RAND_4[0:0];
  _RAND_5 = {2{`RANDOM}};
  pTerm_s1 = _RAND_5[63:0];
  _RAND_6 = {2{`RANDOM}};
  iInc_s1 = _RAND_6[63:0];
  _RAND_7 = {1{`RANDOM}};
  dDiff_s1 = _RAND_7[31:0];
  _RAND_8 = {2{`RANDOM}};
  iSum_s2 = _RAND_8[63:0];
  _RAND_9 = {2{`RANDOM}};
  pTerm_s2 = _RAND_9[63:0];
  _RAND_10 = {2{`RANDOM}};
  dTerm_s2 = _RAND_10[63:0];
  _RAND_11 = {1{`RANDOM}};
  error_s2 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  tick_s4 = _RAND_12[0:0];
  _RAND_13 = {2{`RANDOM}};
  sum_s3 = _RAND_13[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module StuckDetector(
  input   clock,
  input   reset,
  input   io_external_overcurrent_input, // @[src/main/scala/Functions.scala 157:14]
  input   io_clear_shutdown, // @[src/main/scala/Functions.scala 157:14]
  output  io_motor_disable // @[src/main/scala/Functions.scala 157:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [22:0] maxCycles = 17'h186a0 * 6'h32; // @[src/main/scala/Functions.scala 163:44]
  reg [31:0] durationReg; // @[src/main/scala/Functions.scala 164:28]
  reg  isStuckReg; // @[src/main/scala/Functions.scala 165:28]
  wire [31:0] _GEN_8 = {{9'd0}, maxCycles}; // @[src/main/scala/Functions.scala 169:26]
  wire [31:0] _durationReg_T_1 = durationReg + 32'h1; // @[src/main/scala/Functions.scala 169:104]
  wire  _GEN_0 = durationReg >= _GEN_8 | isStuckReg; // @[src/main/scala/Functions.scala 165:28 169:{40,53}]
  wire [31:0] _GEN_1 = durationReg >= _GEN_8 ? durationReg : _durationReg_T_1; // @[src/main/scala/Functions.scala 164:28 169:{40,89}]
  assign io_motor_disable = isStuckReg; // @[src/main/scala/Functions.scala 173:20]
  always @(posedge clock) begin
    if (reset) begin // @[src/main/scala/Functions.scala 164:28]
      durationReg <= 32'h0; // @[src/main/scala/Functions.scala 164:28]
    end else if (io_clear_shutdown) begin // @[src/main/scala/Functions.scala 166:27]
      durationReg <= 32'h0; // @[src/main/scala/Functions.scala 166:64]
    end else if (~isStuckReg) begin // @[src/main/scala/Functions.scala 167:23]
      if (io_external_overcurrent_input) begin // @[src/main/scala/Functions.scala 168:43]
        durationReg <= _GEN_1;
      end else begin
        durationReg <= 32'h0; // @[src/main/scala/Functions.scala 170:33]
      end
    end
    if (reset) begin // @[src/main/scala/Functions.scala 165:28]
      isStuckReg <= 1'h0; // @[src/main/scala/Functions.scala 165:28]
    end else if (io_clear_shutdown) begin // @[src/main/scala/Functions.scala 166:27]
      isStuckReg <= 1'h0; // @[src/main/scala/Functions.scala 166:40]
    end else if (~isStuckReg) begin // @[src/main/scala/Functions.scala 167:23]
      if (io_external_overcurrent_input) begin // @[src/main/scala/Functions.scala 168:43]
        isStuckReg <= _GEN_0;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  durationReg = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  isStuckReg = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SevenSegDec(
  input  [4:0] io_in, // @[src/main/scala/Functions.scala 225:14]
  output [6:0] io_out // @[src/main/scala/Functions.scala 225:14]
);
  wire [6:0] _io_out_T_33 = 5'h0 == io_in ? 7'h3f : 7'h0; // @[src/main/scala/Functions.scala 230:46]
  wire [6:0] _io_out_T_35 = 5'h1 == io_in ? 7'h6 : _io_out_T_33; // @[src/main/scala/Functions.scala 230:46]
  wire [6:0] _io_out_T_37 = 5'h2 == io_in ? 7'h5b : _io_out_T_35; // @[src/main/scala/Functions.scala 230:46]
  wire [6:0] _io_out_T_39 = 5'h3 == io_in ? 7'h4f : _io_out_T_37; // @[src/main/scala/Functions.scala 230:46]
  wire [6:0] _io_out_T_41 = 5'h4 == io_in ? 7'h66 : _io_out_T_39; // @[src/main/scala/Functions.scala 230:46]
  wire [6:0] _io_out_T_43 = 5'h5 == io_in ? 7'h6d : _io_out_T_41; // @[src/main/scala/Functions.scala 230:46]
  wire [6:0] _io_out_T_45 = 5'h6 == io_in ? 7'h7d : _io_out_T_43; // @[src/main/scala/Functions.scala 230:46]
  wire [6:0] _io_out_T_47 = 5'h7 == io_in ? 7'h7 : _io_out_T_45; // @[src/main/scala/Functions.scala 230:46]
  wire [6:0] _io_out_T_49 = 5'h8 == io_in ? 7'h7f : _io_out_T_47; // @[src/main/scala/Functions.scala 230:46]
  wire [6:0] _io_out_T_51 = 5'h9 == io_in ? 7'h6f : _io_out_T_49; // @[src/main/scala/Functions.scala 230:46]
  wire [6:0] _io_out_T_53 = 5'ha == io_in ? 7'h77 : _io_out_T_51; // @[src/main/scala/Functions.scala 230:46]
  wire [6:0] _io_out_T_55 = 5'hb == io_in ? 7'h7c : _io_out_T_53; // @[src/main/scala/Functions.scala 230:46]
  wire [6:0] _io_out_T_57 = 5'hc == io_in ? 7'h39 : _io_out_T_55; // @[src/main/scala/Functions.scala 230:46]
  wire [6:0] _io_out_T_59 = 5'hd == io_in ? 7'h5e : _io_out_T_57; // @[src/main/scala/Functions.scala 230:46]
  wire [6:0] _io_out_T_61 = 5'he == io_in ? 7'h79 : _io_out_T_59; // @[src/main/scala/Functions.scala 230:46]
  wire [6:0] _io_out_T_63 = 5'hf == io_in ? 7'h71 : _io_out_T_61; // @[src/main/scala/Functions.scala 230:46]
  wire [6:0] _io_out_T_65 = 5'h10 == io_in ? 7'h3c : _io_out_T_63; // @[src/main/scala/Functions.scala 230:46]
  wire [6:0] _io_out_T_67 = 5'h11 == io_in ? 7'h76 : _io_out_T_65; // @[src/main/scala/Functions.scala 230:46]
  wire [6:0] _io_out_T_69 = 5'h12 == io_in ? 7'h6 : _io_out_T_67; // @[src/main/scala/Functions.scala 230:46]
  wire [6:0] _io_out_T_71 = 5'h13 == io_in ? 7'hf : _io_out_T_69; // @[src/main/scala/Functions.scala 230:46]
  wire [6:0] _io_out_T_73 = 5'h14 == io_in ? 7'h38 : _io_out_T_71; // @[src/main/scala/Functions.scala 230:46]
  wire [6:0] _io_out_T_75 = 5'h15 == io_in ? 7'h37 : _io_out_T_73; // @[src/main/scala/Functions.scala 230:46]
  wire [6:0] _io_out_T_77 = 5'h16 == io_in ? 7'h54 : _io_out_T_75; // @[src/main/scala/Functions.scala 230:46]
  wire [6:0] _io_out_T_79 = 5'h17 == io_in ? 7'h3f : _io_out_T_77; // @[src/main/scala/Functions.scala 230:46]
  wire [6:0] _io_out_T_81 = 5'h18 == io_in ? 7'h73 : _io_out_T_79; // @[src/main/scala/Functions.scala 230:46]
  wire [6:0] _io_out_T_83 = 5'h19 == io_in ? 7'h67 : _io_out_T_81; // @[src/main/scala/Functions.scala 230:46]
  wire [6:0] _io_out_T_85 = 5'h1a == io_in ? 7'h31 : _io_out_T_83; // @[src/main/scala/Functions.scala 230:46]
  wire [6:0] _io_out_T_87 = 5'h1b == io_in ? 7'h6d : _io_out_T_85; // @[src/main/scala/Functions.scala 230:46]
  wire [6:0] _io_out_T_89 = 5'h1c == io_in ? 7'h78 : _io_out_T_87; // @[src/main/scala/Functions.scala 230:46]
  wire [6:0] _io_out_T_91 = 5'h1d == io_in ? 7'h3e : _io_out_T_89; // @[src/main/scala/Functions.scala 230:46]
  assign io_out = 5'h1e == io_in ? 7'h0 : _io_out_T_91; // @[src/main/scala/Functions.scala 230:46]
endmodule
module DisplayMultiplexer(
  input         clock,
  input         reset,
  input  [19:0] io_disp_content, // @[src/main/scala/Functions.scala 177:14]
  output [7:0]  io_seg, // @[src/main/scala/Functions.scala 177:14]
  output [3:0]  io_an // @[src/main/scala/Functions.scala 177:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [4:0] decoder_io_in; // @[src/main/scala/Functions.scala 200:23]
  wire [6:0] decoder_io_out; // @[src/main/scala/Functions.scala 200:23]
  reg [16:0] cnt; // @[src/main/scala/Functions.scala 184:20]
  wire  _cnt_T = cnt == 17'h1869f; // @[src/main/scala/Functions.scala 185:18]
  wire [16:0] _cnt_T_2 = cnt + 17'h1; // @[src/main/scala/Functions.scala 185:54]
  reg [1:0] digit; // @[src/main/scala/Functions.scala 188:22]
  wire [1:0] _digit_T_1 = digit + 2'h1; // @[src/main/scala/Functions.scala 189:31]
  wire  _T = 2'h0 == digit; // @[src/main/scala/Functions.scala 193:17]
  wire  _T_1 = 2'h1 == digit; // @[src/main/scala/Functions.scala 193:17]
  wire  _T_2 = 2'h2 == digit; // @[src/main/scala/Functions.scala 193:17]
  wire  _T_3 = 2'h3 == digit; // @[src/main/scala/Functions.scala 193:17]
  wire [4:0] _GEN_1 = 2'h3 == digit ? io_disp_content[19:15] : 5'h0; // @[src/main/scala/Functions.scala 192:14 193:17 197:26]
  wire [4:0] _GEN_2 = 2'h2 == digit ? io_disp_content[14:10] : _GEN_1; // @[src/main/scala/Functions.scala 193:17 196:26]
  wire [4:0] _GEN_3 = 2'h1 == digit ? io_disp_content[9:5] : _GEN_2; // @[src/main/scala/Functions.scala 193:17 195:26]
  wire [3:0] _currentDot_T = 4'h0 >> digit; // @[src/main/scala/Functions.scala 204:27]
  wire  currentDot = _currentDot_T[0]; // @[src/main/scala/Functions.scala 204:27]
  wire [7:0] fullSeg = {currentDot,decoder_io_out}; // @[src/main/scala/Functions.scala 205:28]
  wire [3:0] _GEN_5 = _T_3 ? 4'h8 : 4'h1; // @[src/main/scala/Functions.scala 208:17 212:22 207:27]
  wire [3:0] _GEN_6 = _T_2 ? 4'h4 : _GEN_5; // @[src/main/scala/Functions.scala 208:17 211:22]
  wire [3:0] _GEN_7 = _T_1 ? 4'h2 : _GEN_6; // @[src/main/scala/Functions.scala 208:17 210:22]
  wire [3:0] select = _T ? 4'h1 : _GEN_7; // @[src/main/scala/Functions.scala 208:17 209:22]
  SevenSegDec decoder ( // @[src/main/scala/Functions.scala 200:23]
    .io_in(decoder_io_in),
    .io_out(decoder_io_out)
  );
  assign io_seg = ~fullSeg; // @[src/main/scala/Functions.scala 215:13]
  assign io_an = ~select; // @[src/main/scala/Functions.scala 216:13]
  assign decoder_io_in = 2'h0 == digit ? io_disp_content[4:0] : _GEN_3; // @[src/main/scala/Functions.scala 193:17 194:26]
  always @(posedge clock) begin
    if (reset) begin // @[src/main/scala/Functions.scala 184:20]
      cnt <= 17'h0; // @[src/main/scala/Functions.scala 184:20]
    end else if (cnt == 17'h1869f) begin // @[src/main/scala/Functions.scala 185:13]
      cnt <= 17'h0;
    end else begin
      cnt <= _cnt_T_2;
    end
    if (reset) begin // @[src/main/scala/Functions.scala 188:22]
      digit <= 2'h0; // @[src/main/scala/Functions.scala 188:22]
    end else if (_cnt_T) begin // @[src/main/scala/Functions.scala 189:14]
      digit <= _digit_T_1; // @[src/main/scala/Functions.scala 189:22]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  cnt = _RAND_0[16:0];
  _RAND_1 = {1{`RANDOM}};
  digit = _RAND_1[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module RotationCounter(
  input         clock,
  input         reset,
  input         io_signal_A, // @[src/main/scala/Functions.scala 6:14]
  input         io_signal_B, // @[src/main/scala/Functions.scala 6:14]
  output [31:0] io_turns, // @[src/main/scala/Functions.scala 6:14]
  output [31:0] io_total_rotations, // @[src/main/scala/Functions.scala 6:14]
  output        io_pulse // @[src/main/scala/Functions.scala 6:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg  aSync_REG; // @[src/main/scala/Functions.scala 13:30]
  reg  aSync; // @[src/main/scala/Functions.scala 13:22]
  reg  bSync_REG; // @[src/main/scala/Functions.scala 14:30]
  reg  bSync; // @[src/main/scala/Functions.scala 14:22]
  reg  aReg; // @[src/main/scala/Functions.scala 15:22]
  wire  rise_A = aSync & ~aReg; // @[src/main/scala/Functions.scala 16:22]
  reg [31:0] turns; // @[src/main/scala/Functions.scala 17:22]
  reg [31:0] total_rotations; // @[src/main/scala/Functions.scala 18:32]
  wire [31:0] _total_rotations_T_1 = total_rotations + 32'h1; // @[src/main/scala/Functions.scala 20:40]
  wire [31:0] _turns_T_2 = $signed(turns) + 32'sh1; // @[src/main/scala/Functions.scala 21:35]
  wire [31:0] _turns_T_5 = $signed(turns) - 32'sh1; // @[src/main/scala/Functions.scala 22:35]
  assign io_turns = turns; // @[src/main/scala/Functions.scala 25:12]
  assign io_total_rotations = total_rotations; // @[src/main/scala/Functions.scala 26:22]
  assign io_pulse = aSync & ~aReg; // @[src/main/scala/Functions.scala 16:22]
  always @(posedge clock) begin
    aSync_REG <= io_signal_A; // @[src/main/scala/Functions.scala 13:30]
    aSync <= aSync_REG; // @[src/main/scala/Functions.scala 13:22]
    bSync_REG <= io_signal_B; // @[src/main/scala/Functions.scala 14:30]
    bSync <= bSync_REG; // @[src/main/scala/Functions.scala 14:22]
    aReg <= aSync; // @[src/main/scala/Functions.scala 15:22]
    if (reset) begin // @[src/main/scala/Functions.scala 17:22]
      turns <= 32'sh0; // @[src/main/scala/Functions.scala 17:22]
    end else if (rise_A) begin // @[src/main/scala/Functions.scala 19:16]
      if (~bSync) begin // @[src/main/scala/Functions.scala 21:18]
        turns <= _turns_T_2; // @[src/main/scala/Functions.scala 21:26]
      end else begin
        turns <= _turns_T_5; // @[src/main/scala/Functions.scala 22:26]
      end
    end
    if (reset) begin // @[src/main/scala/Functions.scala 18:32]
      total_rotations <= 32'h0; // @[src/main/scala/Functions.scala 18:32]
    end else if (rise_A) begin // @[src/main/scala/Functions.scala 19:16]
      total_rotations <= _total_rotations_T_1; // @[src/main/scala/Functions.scala 20:21]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  aSync_REG = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  aSync = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  bSync_REG = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  bSync = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  aReg = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  turns = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  total_rotations = _RAND_6[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Debouncer(
  input   clock,
  input   reset,
  input   io_btn_in, // @[src/main/scala/Functions.scala 266:14]
  output  io_out // @[src/main/scala/Functions.scala 266:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg  btn_sync_REG; // @[src/main/scala/Functions.scala 271:33]
  reg  btn_sync; // @[src/main/scala/Functions.scala 271:25]
  reg  btnDebReg; // @[src/main/scala/Functions.scala 272:26]
  reg [31:0] cntReg; // @[src/main/scala/Functions.scala 273:23]
  wire  tick = cntReg == 32'h1869f; // @[src/main/scala/Functions.scala 274:21]
  wire [31:0] _cntReg_T_1 = cntReg + 32'h1; // @[src/main/scala/Functions.scala 276:20]
  reg  btnCleanPrev; // @[src/main/scala/Functions.scala 282:29]
  assign io_out = btnDebReg & ~btnCleanPrev; // @[src/main/scala/Functions.scala 283:23]
  always @(posedge clock) begin
    btn_sync_REG <= io_btn_in; // @[src/main/scala/Functions.scala 271:33]
    btn_sync <= btn_sync_REG; // @[src/main/scala/Functions.scala 271:25]
    if (reset) begin // @[src/main/scala/Functions.scala 272:26]
      btnDebReg <= 1'h0; // @[src/main/scala/Functions.scala 272:26]
    end else if (tick) begin // @[src/main/scala/Functions.scala 277:15]
      btnDebReg <= btn_sync; // @[src/main/scala/Functions.scala 279:15]
    end
    if (reset) begin // @[src/main/scala/Functions.scala 273:23]
      cntReg <= 32'h0; // @[src/main/scala/Functions.scala 273:23]
    end else if (tick) begin // @[src/main/scala/Functions.scala 277:15]
      cntReg <= 32'h0; // @[src/main/scala/Functions.scala 278:12]
    end else begin
      cntReg <= _cntReg_T_1; // @[src/main/scala/Functions.scala 276:10]
    end
    btnCleanPrev <= btnDebReg; // @[src/main/scala/Functions.scala 282:29]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  btn_sync_REG = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  btn_sync = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  btnDebReg = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  cntReg = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  btnCleanPrev = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module EncoderStuckDetector(
  input   clock,
  input   reset,
  input   io_moving_requested, // @[src/main/scala/Functions.scala 30:14]
  input   io_pulse_detected, // @[src/main/scala/Functions.scala 30:14]
  input   io_clear_shutdown, // @[src/main/scala/Functions.scala 30:14]
  output  io_motor_disable // @[src/main/scala/Functions.scala 30:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [24:0] maxCycles = 17'h186a0 * 8'hc8; // @[src/main/scala/Functions.scala 38:44]
  reg [31:0] timer; // @[src/main/scala/Functions.scala 39:28]
  reg  isStuck; // @[src/main/scala/Functions.scala 40:28]
  wire [31:0] _GEN_8 = {{7'd0}, maxCycles}; // @[src/main/scala/Functions.scala 50:20]
  wire [31:0] _timer_T_1 = timer + 32'h1; // @[src/main/scala/Functions.scala 53:26]
  wire  _GEN_0 = timer >= _GEN_8 | isStuck; // @[src/main/scala/Functions.scala 50:34 51:19 40:28]
  wire [31:0] _GEN_1 = timer >= _GEN_8 ? timer : _timer_T_1; // @[src/main/scala/Functions.scala 39:28 50:34 53:17]
  assign io_motor_disable = isStuck; // @[src/main/scala/Functions.scala 60:20]
  always @(posedge clock) begin
    if (reset) begin // @[src/main/scala/Functions.scala 39:28]
      timer <= 32'h0; // @[src/main/scala/Functions.scala 39:28]
    end else if (io_clear_shutdown) begin // @[src/main/scala/Functions.scala 42:27]
      timer <= 32'h0; // @[src/main/scala/Functions.scala 44:11]
    end else if (~isStuck & io_moving_requested) begin // @[src/main/scala/Functions.scala 46:43]
      if (io_pulse_detected) begin // @[src/main/scala/Functions.scala 47:31]
        timer <= 32'h0; // @[src/main/scala/Functions.scala 48:15]
      end else begin
        timer <= _GEN_1;
      end
    end else begin
      timer <= 32'h0; // @[src/main/scala/Functions.scala 57:13]
    end
    if (reset) begin // @[src/main/scala/Functions.scala 40:28]
      isStuck <= 1'h0; // @[src/main/scala/Functions.scala 40:28]
    end else if (io_clear_shutdown) begin // @[src/main/scala/Functions.scala 42:27]
      isStuck <= 1'h0; // @[src/main/scala/Functions.scala 43:13]
    end else if (~isStuck & io_moving_requested) begin // @[src/main/scala/Functions.scala 46:43]
      if (!(io_pulse_detected)) begin // @[src/main/scala/Functions.scala 47:31]
        isStuck <= _GEN_0;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  timer = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  isStuck = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Driver(
  input        clock,
  input        reset,
  input        io_uart_rx, // @[src/main/scala/Driver.scala 6:14]
  input        io_photo_sensor_A, // @[src/main/scala/Driver.scala 6:14]
  input        io_photo_sensor_B, // @[src/main/scala/Driver.scala 6:14]
  input        io_over_current_positive, // @[src/main/scala/Driver.scala 6:14]
  input        io_over_current_negative, // @[src/main/scala/Driver.scala 6:14]
  input        io_error_cleared, // @[src/main/scala/Driver.scala 6:14]
  input        io_detector_toggle, // @[src/main/scala/Driver.scala 6:14]
  output       io_uart_tx, // @[src/main/scala/Driver.scala 6:14]
  output       io_T1, // @[src/main/scala/Driver.scala 6:14]
  output       io_T2, // @[src/main/scala/Driver.scala 6:14]
  output       io_T3, // @[src/main/scala/Driver.scala 6:14]
  output       io_T4, // @[src/main/scala/Driver.scala 6:14]
  output [7:0] io_seg, // @[src/main/scala/Driver.scala 6:14]
  output [3:0] io_an // @[src/main/scala/Driver.scala 6:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [63:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
`endif // RANDOMIZE_REG_INIT
  wire  rx_clock; // @[src/main/scala/Driver.scala 26:36]
  wire  rx_reset; // @[src/main/scala/Driver.scala 26:36]
  wire  rx_io_rx; // @[src/main/scala/Driver.scala 26:36]
  wire  rx_io_done; // @[src/main/scala/Driver.scala 26:36]
  wire [7:0] rx_io_data; // @[src/main/scala/Driver.scala 26:36]
  wire  tx_clock; // @[src/main/scala/Driver.scala 27:36]
  wire  tx_reset; // @[src/main/scala/Driver.scala 27:36]
  wire [7:0] tx_io_data; // @[src/main/scala/Driver.scala 27:36]
  wire  tx_io_start; // @[src/main/scala/Driver.scala 27:36]
  wire  tx_io_tx; // @[src/main/scala/Driver.scala 27:36]
  wire  tx_io_busy; // @[src/main/scala/Driver.scala 27:36]
  wire  pwm_signal_clock; // @[src/main/scala/Driver.scala 28:36]
  wire  pwm_signal_reset; // @[src/main/scala/Driver.scala 28:36]
  wire [9:0] pwm_signal_io_duty_cycle; // @[src/main/scala/Driver.scala 28:36]
  wire  pwm_signal_io_brake; // @[src/main/scala/Driver.scala 28:36]
  wire  pwm_signal_io_T1; // @[src/main/scala/Driver.scala 28:36]
  wire  pwm_signal_io_T2; // @[src/main/scala/Driver.scala 28:36]
  wire  pwm_signal_io_T3; // @[src/main/scala/Driver.scala 28:36]
  wire  pwm_signal_io_T4; // @[src/main/scala/Driver.scala 28:36]
  wire  pid_clock; // @[src/main/scala/Driver.scala 29:36]
  wire  pid_reset; // @[src/main/scala/Driver.scala 29:36]
  wire [31:0] pid_io_setPoint; // @[src/main/scala/Driver.scala 29:36]
  wire [31:0] pid_io_measuredVal; // @[src/main/scala/Driver.scala 29:36]
  wire  pid_io_tick; // @[src/main/scala/Driver.scala 29:36]
  wire  pid_io_resetBuffer; // @[src/main/scala/Driver.scala 29:36]
  wire [31:0] pid_io_controlOut; // @[src/main/scala/Driver.scala 29:36]
  wire  stuck_detector_clock; // @[src/main/scala/Driver.scala 30:36]
  wire  stuck_detector_reset; // @[src/main/scala/Driver.scala 30:36]
  wire  stuck_detector_io_external_overcurrent_input; // @[src/main/scala/Driver.scala 30:36]
  wire  stuck_detector_io_clear_shutdown; // @[src/main/scala/Driver.scala 30:36]
  wire  stuck_detector_io_motor_disable; // @[src/main/scala/Driver.scala 30:36]
  wire  display_clock; // @[src/main/scala/Driver.scala 31:36]
  wire  display_reset; // @[src/main/scala/Driver.scala 31:36]
  wire [19:0] display_io_disp_content; // @[src/main/scala/Driver.scala 31:36]
  wire [7:0] display_io_seg; // @[src/main/scala/Driver.scala 31:36]
  wire [3:0] display_io_an; // @[src/main/scala/Driver.scala 31:36]
  wire  rotations_clock; // @[src/main/scala/Driver.scala 32:36]
  wire  rotations_reset; // @[src/main/scala/Driver.scala 32:36]
  wire  rotations_io_signal_A; // @[src/main/scala/Driver.scala 32:36]
  wire  rotations_io_signal_B; // @[src/main/scala/Driver.scala 32:36]
  wire [31:0] rotations_io_turns; // @[src/main/scala/Driver.scala 32:36]
  wire [31:0] rotations_io_total_rotations; // @[src/main/scala/Driver.scala 32:36]
  wire  rotations_io_pulse; // @[src/main/scala/Driver.scala 32:36]
  wire  error_clear_debounce_clock; // @[src/main/scala/Driver.scala 33:36]
  wire  error_clear_debounce_reset; // @[src/main/scala/Driver.scala 33:36]
  wire  error_clear_debounce_io_btn_in; // @[src/main/scala/Driver.scala 33:36]
  wire  error_clear_debounce_io_out; // @[src/main/scala/Driver.scala 33:36]
  wire  encoder_stuck_clock; // @[src/main/scala/Driver.scala 34:36]
  wire  encoder_stuck_reset; // @[src/main/scala/Driver.scala 34:36]
  wire  encoder_stuck_io_moving_requested; // @[src/main/scala/Driver.scala 34:36]
  wire  encoder_stuck_io_pulse_detected; // @[src/main/scala/Driver.scala 34:36]
  wire  encoder_stuck_io_clear_shutdown; // @[src/main/scala/Driver.scala 34:36]
  wire  encoder_stuck_io_motor_disable; // @[src/main/scala/Driver.scala 34:36]
  reg [13:0] rotations_io_signal_A_cnt; // @[src/main/scala/Driver.scala 38:23]
  reg  rotations_io_signal_A_out; // @[src/main/scala/Driver.scala 39:23]
  wire [13:0] _rotations_io_signal_A_cnt_T_1 = rotations_io_signal_A_cnt + 14'h1; // @[src/main/scala/Driver.scala 41:29]
  reg [13:0] rotations_io_signal_B_cnt; // @[src/main/scala/Driver.scala 38:23]
  reg  rotations_io_signal_B_out; // @[src/main/scala/Driver.scala 39:23]
  wire [13:0] _rotations_io_signal_B_cnt_T_1 = rotations_io_signal_B_cnt + 14'h1; // @[src/main/scala/Driver.scala 41:29]
  reg [16:0] pid_timer; // @[src/main/scala/Driver.scala 53:26]
  wire  pid_tick = pid_timer == 17'h1869f; // @[src/main/scala/Driver.scala 54:29]
  wire [16:0] _pid_timer_T_1 = pid_timer + 17'h1; // @[src/main/scala/Driver.scala 55:75]
  reg [31:0] target_position_cm; // @[src/main/scala/Driver.scala 58:35]
  reg  control_mode; // @[src/main/scala/Driver.scala 59:35]
  reg  manual_brake; // @[src/main/scala/Driver.scala 60:35]
  reg  system_active; // @[src/main/scala/Driver.scala 61:35]
  reg [31:0] initial_offset; // @[src/main/scala/Driver.scala 62:35]
  wire [31:0] current_turns = $signed(rotations_io_turns) - $signed(initial_offset); // @[src/main/scala/Driver.scala 64:42]
  wire [63:0] full_pos_calc = $signed(current_turns) * 32'sh222; // @[src/main/scala/Driver.scala 67:56]
  reg [31:0] current_position_fixed_point; // @[src/main/scala/Driver.scala 68:45]
  wire [19:0] _current_position_cm_T = current_position_fixed_point[31:12]; // @[src/main/scala/Driver.scala 69:78]
  wire [19:0] current_position_cm = system_active ? $signed(_current_position_cm_T) : $signed(20'sh0); // @[src/main/scala/Driver.scala 69:32]
  reg [1:0] uartState; // @[src/main/scala/Driver.scala 72:26]
  reg [7:0] CMDByte; // @[src/main/scala/Driver.scala 73:24]
  reg [9:0] manual_speed; // @[src/main/scala/Driver.scala 81:35]
  reg [9:0] manual_ramped; // @[src/main/scala/Driver.scala 82:35]
  reg [16:0] ramp_timer; // @[src/main/scala/Driver.scala 85:35]
  wire  ramp_tick = ramp_timer == 17'h1869f; // @[src/main/scala/Driver.scala 86:39]
  wire [9:0] _manual_ramped_T_1 = manual_ramped + 10'h1; // @[src/main/scala/Driver.scala 93:38]
  wire [9:0] _manual_ramped_T_3 = manual_ramped - 10'h1; // @[src/main/scala/Driver.scala 95:38]
  wire [9:0] _GEN_8 = manual_ramped > manual_speed ? _manual_ramped_T_3 : manual_ramped; // @[src/main/scala/Driver.scala 94:46 95:21 82:35]
  wire [16:0] _ramp_timer_T_1 = ramp_timer + 17'h1; // @[src/main/scala/Driver.scala 97:42]
  wire  _T_2 = ~system_active; // @[src/main/scala/Driver.scala 99:8]
  wire [9:0] _GEN_13 = ~system_active ? 10'h200 : manual_speed; // @[src/main/scala/Driver.scala 101:19 99:24 81:35]
  wire [31:0] _GEN_15 = _T_2 ? $signed(rotations_io_turns) : $signed(initial_offset); // @[src/main/scala/Driver.scala 112:{34,51} 62:35]
  wire [7:0] _target_position_cm_T = rx_io_data; // @[src/main/scala/Driver.scala 113:48]
  wire  _T_11 = 8'h0 == rx_io_data; // @[src/main/scala/Driver.scala 125:32]
  wire [9:0] _GEN_17 = 8'h4 == rx_io_data ? 10'h14f : _GEN_13; // @[src/main/scala/Driver.scala 125:32 130:38]
  wire [9:0] _GEN_19 = 8'h3 == rx_io_data ? 10'h181 : _GEN_17; // @[src/main/scala/Driver.scala 125:32 129:38]
  wire [9:0] _GEN_21 = 8'h2 == rx_io_data ? 10'h2da : _GEN_19; // @[src/main/scala/Driver.scala 125:32 128:38]
  wire [9:0] _GEN_23 = 8'h1 == rx_io_data ? 10'h2d0 : _GEN_21; // @[src/main/scala/Driver.scala 125:32 127:38]
  wire [9:0] _GEN_26 = 8'h0 == rx_io_data ? 10'h200 : _GEN_23; // @[src/main/scala/Driver.scala 125:32 126:62]
  wire [31:0] _GEN_28 = 8'h2 == CMDByte ? $signed(_GEN_15) : $signed(initial_offset); // @[src/main/scala/Driver.scala 110:25 62:35]
  wire  _GEN_29 = 8'h2 == CMDByte | system_active; // @[src/main/scala/Driver.scala 110:25 122:27 61:35]
  wire  _GEN_30 = 8'h2 == CMDByte ? 1'h0 : control_mode; // @[src/main/scala/Driver.scala 110:25 123:26 59:35]
  wire  _GEN_31 = 8'h2 == CMDByte ? _T_11 : manual_brake; // @[src/main/scala/Driver.scala 110:25 60:35]
  wire [9:0] _GEN_32 = 8'h2 == CMDByte ? _GEN_26 : _GEN_13; // @[src/main/scala/Driver.scala 110:25]
  wire  _GEN_34 = 8'h2 == CMDByte ? 1'h0 : 8'hff == CMDByte; // @[src/main/scala/Driver.scala 110:25 74:36]
  wire [31:0] _GEN_35 = 8'h1 == CMDByte ? $signed(_GEN_15) : $signed(_GEN_28); // @[src/main/scala/Driver.scala 110:25]
  wire [31:0] _GEN_36 = 8'h1 == CMDByte ? $signed({{24{_target_position_cm_T[7]}},_target_position_cm_T}) : $signed(
    target_position_cm); // @[src/main/scala/Driver.scala 110:25 113:32 58:35]
  wire  _GEN_37 = 8'h1 == CMDByte | _GEN_29; // @[src/main/scala/Driver.scala 110:25 114:27]
  wire  _GEN_38 = 8'h1 == CMDByte | _GEN_30; // @[src/main/scala/Driver.scala 110:25 115:26]
  wire  _GEN_39 = 8'h1 == CMDByte ? 1'h0 : _GEN_31; // @[src/main/scala/Driver.scala 110:25 116:26]
  wire  _GEN_41 = 8'h1 == CMDByte | 8'h2 == CMDByte; // @[src/main/scala/Driver.scala 110:25 118:27]
  wire [9:0] _GEN_42 = 8'h1 == CMDByte ? _GEN_13 : _GEN_32; // @[src/main/scala/Driver.scala 110:25]
  wire  _GEN_43 = 8'h1 == CMDByte ? 1'h0 : _GEN_34; // @[src/main/scala/Driver.scala 110:25 74:36]
  wire [31:0] _GEN_44 = 2'h2 == uartState ? $signed(_GEN_35) : $signed(initial_offset); // @[src/main/scala/Driver.scala 106:23 62:35]
  wire [31:0] _GEN_45 = 2'h2 == uartState ? $signed(_GEN_36) : $signed(target_position_cm); // @[src/main/scala/Driver.scala 106:23 58:35]
  wire  _GEN_46 = 2'h2 == uartState ? _GEN_37 : system_active; // @[src/main/scala/Driver.scala 106:23 61:35]
  wire  _GEN_47 = 2'h2 == uartState ? _GEN_38 : control_mode; // @[src/main/scala/Driver.scala 106:23 59:35]
  wire  _GEN_48 = 2'h2 == uartState ? _GEN_39 : manual_brake; // @[src/main/scala/Driver.scala 106:23 60:35]
  wire [9:0] _GEN_51 = 2'h2 == uartState ? _GEN_42 : _GEN_13; // @[src/main/scala/Driver.scala 106:23]
  wire [1:0] _GEN_53 = 2'h2 == uartState ? 2'h0 : uartState; // @[src/main/scala/Driver.scala 106:23 136:19 72:26]
  wire  _GEN_59 = 2'h1 == uartState ? control_mode : _GEN_47; // @[src/main/scala/Driver.scala 106:23 59:35]
  wire  _GEN_62 = 2'h1 == uartState ? 1'h0 : 2'h2 == uartState & _GEN_41; // @[src/main/scala/Driver.scala 106:23 87:34]
  wire  _GEN_64 = 2'h1 == uartState ? 1'h0 : 2'h2 == uartState & _GEN_43; // @[src/main/scala/Driver.scala 106:23 74:36]
  wire  _GEN_70 = 2'h0 == uartState ? control_mode : _GEN_59; // @[src/main/scala/Driver.scala 106:23 59:35]
  wire  _GEN_73 = 2'h0 == uartState ? 1'h0 : _GEN_62; // @[src/main/scala/Driver.scala 106:23 87:34]
  wire  _GEN_75 = 2'h0 == uartState ? 1'h0 : _GEN_64; // @[src/main/scala/Driver.scala 106:23 74:36]
  wire  _GEN_81 = rx_io_done ? _GEN_70 : control_mode; // @[src/main/scala/Driver.scala 105:21 59:35]
  wire  new_cmd_pulse = rx_io_done & _GEN_73; // @[src/main/scala/Driver.scala 105:21 87:34]
  wire  reset_triggered = rx_io_done & _GEN_75; // @[src/main/scala/Driver.scala 105:21 74:36]
  reg [27:0] grace_timer; // @[src/main/scala/Driver.scala 144:28]
  wire  _T_17 = grace_timer < 28'hbebc200; // @[src/main/scala/Driver.scala 148:26]
  wire [27:0] _grace_timer_T_1 = grace_timer + 28'h1; // @[src/main/scala/Driver.scala 149:32]
  reg [25:0] stillness_timer; // @[src/main/scala/Driver.scala 155:32]
  wire [25:0] _stillness_timer_T_1 = stillness_timer + 26'h1; // @[src/main/scala/Driver.scala 160:40]
  wire  motor_is_still = stillness_timer == 26'h1c9c380; // @[src/main/scala/Driver.scala 163:40]
  wire [36:0] _target_turns_T = $signed(target_position_cm) * 5'shf; // @[src/main/scala/Driver.scala 166:50]
  reg [37:0] target_turns; // @[src/main/scala/Driver.scala 166:29]
  wire [37:0] _in_tolerance_zone_T_2 = $signed(target_turns) - 38'sh1; // @[src/main/scala/Driver.scala 169:58]
  wire [37:0] _GEN_154 = {{6{current_turns[31]}},current_turns}; // @[src/main/scala/Driver.scala 169:42]
  wire [37:0] _in_tolerance_zone_T_6 = $signed(target_turns) + 38'sh1; // @[src/main/scala/Driver.scala 170:58]
  wire  _in_tolerance_zone_T_7 = $signed(_GEN_154) <= $signed(_in_tolerance_zone_T_6); // @[src/main/scala/Driver.scala 170:42]
  wire  _in_tolerance_zone_T_8 = $signed(_GEN_154) >= $signed(_in_tolerance_zone_T_2) & _in_tolerance_zone_T_7; // @[src/main/scala/Driver.scala 169:70]
  wire  _in_tolerance_zone_T_9 = system_active ? _in_tolerance_zone_T_8 : 1'h1; // @[src/main/scala/Driver.scala 168:46]
  wire  in_tolerance_zone = control_mode & _in_tolerance_zone_T_9; // @[src/main/scala/Driver.scala 168:40]
  wire  at_position = in_tolerance_zone & ($signed(_GEN_154) == $signed(target_turns) | motor_is_still); // @[src/main/scala/Driver.scala 172:39]
  wire [31:0] raw_pid_out = pid_io_controlOut; // @[src/main/scala/Driver.scala 183:39]
  wire [27:0] _pid_offset_T_2 = raw_pid_out[31:4]; // @[src/main/scala/Driver.scala 188:94]
  wire [27:0] _pid_offset_T_5 = $signed(_pid_offset_T_2) + 28'sh50; // @[src/main/scala/Driver.scala 188:100]
  wire [28:0] _pid_offset_T_6 = raw_pid_out[31:3]; // @[src/main/scala/Driver.scala 188:121]
  wire [28:0] _pid_offset_T_9 = $signed(_pid_offset_T_6) - 29'sha; // @[src/main/scala/Driver.scala 188:127]
  reg [28:0] pid_offset; // @[src/main/scala/Driver.scala 188:27]
  wire [28:0] pid_duty_raw = 29'sh200 + $signed(pid_offset); // @[src/main/scala/Driver.scala 190:28]
  wire [28:0] _pid_duty_T_2 = 29'sh200 + $signed(pid_offset); // @[src/main/scala/Driver.scala 191:119]
  wire [28:0] _pid_duty_T_3 = $signed(pid_duty_raw) < 29'sh0 ? 29'h0 : _pid_duty_T_2; // @[src/main/scala/Driver.scala 191:80]
  wire [28:0] _pid_duty_T_4 = $signed(pid_duty_raw) > 29'sh3ff ? 29'h3ff : _pid_duty_T_3; // @[src/main/scala/Driver.scala 191:45]
  wire [28:0] pid_duty = at_position ? 29'h200 : _pid_duty_T_4; // @[src/main/scala/Driver.scala 191:21]
  wire [28:0] active_duty = control_mode ? pid_duty : {{19'd0}, manual_ramped}; // @[src/main/scala/Driver.scala 193:24]
  wire  is_moving_back = active_duty < 29'h200; // @[src/main/scala/Driver.scala 194:36]
  wire  is_moving_fwd = active_duty > 29'h200; // @[src/main/scala/Driver.scala 195:35]
  wire  block_neg = system_active & $signed(current_position_cm) <= 20'sh0 & is_moving_back; // @[src/main/scala/Driver.scala 197:75]
  wire  block_pos = system_active & $signed(current_position_cm) >= 20'sh5a & is_moving_fwd; // @[src/main/scala/Driver.scala 198:76]
  wire  active_stuck = ~io_detector_toggle ? encoder_stuck_io_motor_disable : stuck_detector_io_motor_disable; // @[src/main/scala/Driver.scala 206:25]
  reg [28:0] pwm_signal_io_duty_cycle_REG; // @[src/main/scala/Driver.scala 209:38]
  wire  motor_stopped = manual_brake | _T_2 | at_position | block_neg | block_pos | active_stuck; // @[src/main/scala/Driver.scala 210:95]
  reg [23:0] txTimer; // @[src/main/scala/Driver.scala 226:24]
  reg [2:0] txState; // @[src/main/scala/Driver.scala 228:24]
  wire  _T_23 = ~tx_io_busy; // @[src/main/scala/Driver.scala 234:14]
  wire [7:0] _GEN_95 = ~tx_io_busy ? 8'hff : 8'h0; // @[src/main/scala/Driver.scala 229:14 234:27 235:22]
  wire [7:0] _GEN_98 = _T_23 ? current_position_cm[15:8] : 8'h0; // @[src/main/scala/Driver.scala 229:14 240:27 241:22]
  wire [2:0] _GEN_100 = _T_23 ? 3'h2 : txState; // @[src/main/scala/Driver.scala 240:27 243:19 228:24]
  wire [23:0] _GEN_101 = _T_23 ? 24'h0 : txTimer; // @[src/main/scala/Driver.scala 240:27 244:19 226:24]
  wire [7:0] _GEN_102 = _T_23 ? current_position_cm[7:0] : 8'h0; // @[src/main/scala/Driver.scala 229:14 247:27 248:22]
  wire [2:0] _GEN_104 = _T_23 ? 3'h3 : txState; // @[src/main/scala/Driver.scala 247:27 250:19 228:24]
  wire [7:0] _GEN_106 = _T_23 ? rotations_io_total_rotations[31:24] : 8'h0; // @[src/main/scala/Driver.scala 229:14 254:27 255:22]
  wire [2:0] _GEN_108 = _T_23 ? 3'h4 : txState; // @[src/main/scala/Driver.scala 254:27 257:19 228:24]
  wire [7:0] _GEN_110 = _T_23 ? rotations_io_total_rotations[23:16] : 8'h0; // @[src/main/scala/Driver.scala 229:14 261:27 262:22]
  wire [2:0] _GEN_112 = _T_23 ? 3'h5 : txState; // @[src/main/scala/Driver.scala 261:27 264:19 228:24]
  wire [7:0] _GEN_114 = _T_23 ? rotations_io_total_rotations[15:8] : 8'h0; // @[src/main/scala/Driver.scala 229:14 268:27 269:22]
  wire [2:0] _GEN_116 = _T_23 ? 3'h6 : txState; // @[src/main/scala/Driver.scala 268:27 271:19 228:24]
  wire [7:0] _GEN_118 = _T_23 ? rotations_io_total_rotations[7:0] : 8'h0; // @[src/main/scala/Driver.scala 229:14 275:27 276:22]
  wire [2:0] _GEN_120 = _T_23 ? 3'h0 : txState; // @[src/main/scala/Driver.scala 275:27 278:19 228:24]
  wire [7:0] _GEN_122 = 3'h6 == txState ? _GEN_118 : 8'h0; // @[src/main/scala/Driver.scala 229:14 232:21]
  wire  _GEN_123 = 3'h6 == txState & _T_23; // @[src/main/scala/Driver.scala 230:15 232:21]
  wire [2:0] _GEN_124 = 3'h6 == txState ? _GEN_120 : txState; // @[src/main/scala/Driver.scala 232:21 228:24]
  wire [23:0] _GEN_125 = 3'h6 == txState ? _GEN_101 : txTimer; // @[src/main/scala/Driver.scala 232:21 226:24]
  wire [7:0] _GEN_126 = 3'h5 == txState ? _GEN_114 : _GEN_122; // @[src/main/scala/Driver.scala 232:21]
  wire  _GEN_127 = 3'h5 == txState ? _T_23 : _GEN_123; // @[src/main/scala/Driver.scala 232:21]
  wire [2:0] _GEN_128 = 3'h5 == txState ? _GEN_116 : _GEN_124; // @[src/main/scala/Driver.scala 232:21]
  wire [23:0] _GEN_129 = 3'h5 == txState ? _GEN_101 : _GEN_125; // @[src/main/scala/Driver.scala 232:21]
  wire [7:0] _GEN_130 = 3'h4 == txState ? _GEN_110 : _GEN_126; // @[src/main/scala/Driver.scala 232:21]
  wire  _GEN_131 = 3'h4 == txState ? _T_23 : _GEN_127; // @[src/main/scala/Driver.scala 232:21]
  wire [2:0] _GEN_132 = 3'h4 == txState ? _GEN_112 : _GEN_128; // @[src/main/scala/Driver.scala 232:21]
  wire [23:0] _GEN_133 = 3'h4 == txState ? _GEN_101 : _GEN_129; // @[src/main/scala/Driver.scala 232:21]
  wire [7:0] _GEN_134 = 3'h3 == txState ? _GEN_106 : _GEN_130; // @[src/main/scala/Driver.scala 232:21]
  wire  _GEN_135 = 3'h3 == txState ? _T_23 : _GEN_131; // @[src/main/scala/Driver.scala 232:21]
  wire [2:0] _GEN_136 = 3'h3 == txState ? _GEN_108 : _GEN_132; // @[src/main/scala/Driver.scala 232:21]
  wire [23:0] _GEN_137 = 3'h3 == txState ? _GEN_101 : _GEN_133; // @[src/main/scala/Driver.scala 232:21]
  wire [7:0] _GEN_138 = 3'h2 == txState ? _GEN_102 : _GEN_134; // @[src/main/scala/Driver.scala 232:21]
  wire  _GEN_139 = 3'h2 == txState ? _T_23 : _GEN_135; // @[src/main/scala/Driver.scala 232:21]
  wire [2:0] _GEN_140 = 3'h2 == txState ? _GEN_104 : _GEN_136; // @[src/main/scala/Driver.scala 232:21]
  wire [23:0] _GEN_141 = 3'h2 == txState ? _GEN_101 : _GEN_137; // @[src/main/scala/Driver.scala 232:21]
  wire [7:0] _GEN_142 = 3'h1 == txState ? _GEN_98 : _GEN_138; // @[src/main/scala/Driver.scala 232:21]
  wire  _GEN_143 = 3'h1 == txState ? _T_23 : _GEN_139; // @[src/main/scala/Driver.scala 232:21]
  wire [7:0] _GEN_146 = 3'h0 == txState ? _GEN_95 : _GEN_142; // @[src/main/scala/Driver.scala 232:21]
  wire  _GEN_147 = 3'h0 == txState ? _T_23 : _GEN_143; // @[src/main/scala/Driver.scala 232:21]
  wire [23:0] _txTimer_T_1 = txTimer + 24'h1; // @[src/main/scala/Driver.scala 282:36]
  wire [18:0] _display_io_disp_content_T = control_mode ? 19'h57797 : 19'h56ade; // @[src/main/scala/Driver.scala 297:33]
  wire [19:0] _display_io_disp_content_T_1 = motor_stopped ? 20'hdf2f8 : {{1'd0}, _display_io_disp_content_T}; // @[src/main/scala/Driver.scala 296:33]
  wire [43:0] _GEN_157 = {$signed(target_position_cm), 12'h0}; // @[src/main/scala/Driver.scala 175:19]
  UartRx rx ( // @[src/main/scala/Driver.scala 26:36]
    .clock(rx_clock),
    .reset(rx_reset),
    .io_rx(rx_io_rx),
    .io_done(rx_io_done),
    .io_data(rx_io_data)
  );
  UartTx tx ( // @[src/main/scala/Driver.scala 27:36]
    .clock(tx_clock),
    .reset(tx_reset),
    .io_data(tx_io_data),
    .io_start(tx_io_start),
    .io_tx(tx_io_tx),
    .io_busy(tx_io_busy)
  );
  DCMotorPwm pwm_signal ( // @[src/main/scala/Driver.scala 28:36]
    .clock(pwm_signal_clock),
    .reset(pwm_signal_reset),
    .io_duty_cycle(pwm_signal_io_duty_cycle),
    .io_brake(pwm_signal_io_brake),
    .io_T1(pwm_signal_io_T1),
    .io_T2(pwm_signal_io_T2),
    .io_T3(pwm_signal_io_T3),
    .io_T4(pwm_signal_io_T4)
  );
  PIDController pid ( // @[src/main/scala/Driver.scala 29:36]
    .clock(pid_clock),
    .reset(pid_reset),
    .io_setPoint(pid_io_setPoint),
    .io_measuredVal(pid_io_measuredVal),
    .io_tick(pid_io_tick),
    .io_resetBuffer(pid_io_resetBuffer),
    .io_controlOut(pid_io_controlOut)
  );
  StuckDetector stuck_detector ( // @[src/main/scala/Driver.scala 30:36]
    .clock(stuck_detector_clock),
    .reset(stuck_detector_reset),
    .io_external_overcurrent_input(stuck_detector_io_external_overcurrent_input),
    .io_clear_shutdown(stuck_detector_io_clear_shutdown),
    .io_motor_disable(stuck_detector_io_motor_disable)
  );
  DisplayMultiplexer display ( // @[src/main/scala/Driver.scala 31:36]
    .clock(display_clock),
    .reset(display_reset),
    .io_disp_content(display_io_disp_content),
    .io_seg(display_io_seg),
    .io_an(display_io_an)
  );
  RotationCounter rotations ( // @[src/main/scala/Driver.scala 32:36]
    .clock(rotations_clock),
    .reset(rotations_reset),
    .io_signal_A(rotations_io_signal_A),
    .io_signal_B(rotations_io_signal_B),
    .io_turns(rotations_io_turns),
    .io_total_rotations(rotations_io_total_rotations),
    .io_pulse(rotations_io_pulse)
  );
  Debouncer error_clear_debounce ( // @[src/main/scala/Driver.scala 33:36]
    .clock(error_clear_debounce_clock),
    .reset(error_clear_debounce_reset),
    .io_btn_in(error_clear_debounce_io_btn_in),
    .io_out(error_clear_debounce_io_out)
  );
  EncoderStuckDetector encoder_stuck ( // @[src/main/scala/Driver.scala 34:36]
    .clock(encoder_stuck_clock),
    .reset(encoder_stuck_reset),
    .io_moving_requested(encoder_stuck_io_moving_requested),
    .io_pulse_detected(encoder_stuck_io_pulse_detected),
    .io_clear_shutdown(encoder_stuck_io_clear_shutdown),
    .io_motor_disable(encoder_stuck_io_motor_disable)
  );
  assign io_uart_tx = tx_io_tx; // @[src/main/scala/Driver.scala 283:14]
  assign io_T1 = _T_2 ? 1'h0 : pwm_signal_io_T1; // @[src/main/scala/Driver.scala 213:25 214:11 219:11]
  assign io_T2 = _T_2 | pwm_signal_io_T2; // @[src/main/scala/Driver.scala 213:25 215:11 220:11]
  assign io_T3 = _T_2 ? 1'h0 : pwm_signal_io_T3; // @[src/main/scala/Driver.scala 213:25 216:11 221:11]
  assign io_T4 = _T_2 | pwm_signal_io_T4; // @[src/main/scala/Driver.scala 213:25 217:11 222:11]
  assign io_seg = display_io_seg; // @[src/main/scala/Driver.scala 288:34]
  assign io_an = display_io_an; // @[src/main/scala/Driver.scala 288:9]
  assign rx_clock = clock;
  assign rx_reset = reset;
  assign rx_io_rx = io_uart_rx; // @[src/main/scala/Driver.scala 45:34]
  assign tx_clock = clock;
  assign tx_reset = reset;
  assign tx_io_data = txTimer >= 24'h2625a0 ? _GEN_146 : 8'h0; // @[src/main/scala/Driver.scala 229:14 231:30]
  assign tx_io_start = txTimer >= 24'h2625a0 & _GEN_147; // @[src/main/scala/Driver.scala 230:15 231:30]
  assign pwm_signal_clock = clock;
  assign pwm_signal_reset = reset;
  assign pwm_signal_io_duty_cycle = pwm_signal_io_duty_cycle_REG[9:0]; // @[src/main/scala/Driver.scala 209:28]
  assign pwm_signal_io_brake = manual_brake | _T_2 | at_position | block_neg | block_pos | active_stuck; // @[src/main/scala/Driver.scala 210:95]
  assign pid_clock = clock;
  assign pid_reset = reset;
  assign pid_io_setPoint = _GEN_157[31:0]; // @[src/main/scala/Driver.scala 175:19]
  assign pid_io_measuredVal = current_position_fixed_point; // @[src/main/scala/Driver.scala 174:22]
  assign pid_io_tick = pid_timer == 17'h1869f; // @[src/main/scala/Driver.scala 54:29]
  assign pid_io_resetBuffer = ~control_mode | manual_brake | _T_2 | at_position; // @[src/main/scala/Driver.scala 177:73]
  assign stuck_detector_clock = clock;
  assign stuck_detector_reset = reset;
  assign stuck_detector_io_external_overcurrent_input = io_over_current_positive | io_over_current_negative; // @[src/main/scala/Driver.scala 51:77]
  assign stuck_detector_io_clear_shutdown = error_clear_debounce_io_out | reset_triggered; // @[src/main/scala/Driver.scala 140:68]
  assign display_clock = clock;
  assign display_reset = reset;
  assign display_io_disp_content = stuck_detector_io_motor_disable ? 20'h7af9e : _display_io_disp_content_T_1; // @[src/main/scala/Driver.scala 295:33]
  assign rotations_clock = clock;
  assign rotations_reset = reset;
  assign rotations_io_signal_A = rotations_io_signal_A_out; // @[src/main/scala/Driver.scala 46:34]
  assign rotations_io_signal_B = rotations_io_signal_B_out; // @[src/main/scala/Driver.scala 47:34]
  assign error_clear_debounce_clock = clock;
  assign error_clear_debounce_reset = reset;
  assign error_clear_debounce_io_btn_in = io_error_cleared; // @[src/main/scala/Driver.scala 49:34]
  assign encoder_stuck_clock = clock;
  assign encoder_stuck_reset = reset;
  assign encoder_stuck_io_moving_requested = system_active & ~at_position & ~manual_brake & active_duty != 29'h200 & ~
    _T_17; // @[src/main/scala/Driver.scala 202:94]
  assign encoder_stuck_io_pulse_detected = rotations_io_pulse; // @[src/main/scala/Driver.scala 204:35]
  assign encoder_stuck_io_clear_shutdown = error_clear_debounce_io_out | reset_triggered; // @[src/main/scala/Driver.scala 205:69]
  always @(posedge clock) begin
    if (reset) begin // @[src/main/scala/Driver.scala 38:23]
      rotations_io_signal_A_cnt <= 14'h0; // @[src/main/scala/Driver.scala 38:23]
    end else if (io_photo_sensor_A == rotations_io_signal_A_out) begin // @[src/main/scala/Driver.scala 40:24]
      rotations_io_signal_A_cnt <= 14'h0; // @[src/main/scala/Driver.scala 40:30]
    end else begin
      rotations_io_signal_A_cnt <= _rotations_io_signal_A_cnt_T_1; // @[src/main/scala/Driver.scala 41:22]
    end
    if (reset) begin // @[src/main/scala/Driver.scala 39:23]
      rotations_io_signal_A_out <= 1'h0; // @[src/main/scala/Driver.scala 39:23]
    end else if (!(io_photo_sensor_A == rotations_io_signal_A_out)) begin // @[src/main/scala/Driver.scala 40:24]
      if (rotations_io_signal_A_cnt == 14'h3e8) begin // @[src/main/scala/Driver.scala 41:57]
        rotations_io_signal_A_out <= io_photo_sensor_A; // @[src/main/scala/Driver.scala 41:63]
      end
    end
    if (reset) begin // @[src/main/scala/Driver.scala 38:23]
      rotations_io_signal_B_cnt <= 14'h0; // @[src/main/scala/Driver.scala 38:23]
    end else if (io_photo_sensor_B == rotations_io_signal_B_out) begin // @[src/main/scala/Driver.scala 40:24]
      rotations_io_signal_B_cnt <= 14'h0; // @[src/main/scala/Driver.scala 40:30]
    end else begin
      rotations_io_signal_B_cnt <= _rotations_io_signal_B_cnt_T_1; // @[src/main/scala/Driver.scala 41:22]
    end
    if (reset) begin // @[src/main/scala/Driver.scala 39:23]
      rotations_io_signal_B_out <= 1'h0; // @[src/main/scala/Driver.scala 39:23]
    end else if (!(io_photo_sensor_B == rotations_io_signal_B_out)) begin // @[src/main/scala/Driver.scala 40:24]
      if (rotations_io_signal_B_cnt == 14'h3e8) begin // @[src/main/scala/Driver.scala 41:57]
        rotations_io_signal_B_out <= io_photo_sensor_B; // @[src/main/scala/Driver.scala 41:63]
      end
    end
    if (reset) begin // @[src/main/scala/Driver.scala 53:26]
      pid_timer <= 17'h0; // @[src/main/scala/Driver.scala 53:26]
    end else if (pid_tick) begin // @[src/main/scala/Driver.scala 55:18]
      pid_timer <= 17'h0; // @[src/main/scala/Driver.scala 55:30]
    end else begin
      pid_timer <= _pid_timer_T_1; // @[src/main/scala/Driver.scala 55:62]
    end
    if (reset) begin // @[src/main/scala/Driver.scala 58:35]
      target_position_cm <= 32'sh0; // @[src/main/scala/Driver.scala 58:35]
    end else if (rx_io_done) begin // @[src/main/scala/Driver.scala 105:21]
      if (!(2'h0 == uartState)) begin // @[src/main/scala/Driver.scala 106:23]
        if (!(2'h1 == uartState)) begin // @[src/main/scala/Driver.scala 106:23]
          target_position_cm <= _GEN_45;
        end
      end
    end
    control_mode <= reset | _GEN_81; // @[src/main/scala/Driver.scala 59:{35,35}]
    if (reset) begin // @[src/main/scala/Driver.scala 60:35]
      manual_brake <= 1'h0; // @[src/main/scala/Driver.scala 60:35]
    end else if (rx_io_done) begin // @[src/main/scala/Driver.scala 105:21]
      if (!(2'h0 == uartState)) begin // @[src/main/scala/Driver.scala 106:23]
        if (!(2'h1 == uartState)) begin // @[src/main/scala/Driver.scala 106:23]
          manual_brake <= _GEN_48;
        end
      end
    end
    if (reset) begin // @[src/main/scala/Driver.scala 61:35]
      system_active <= 1'h0; // @[src/main/scala/Driver.scala 61:35]
    end else if (rx_io_done) begin // @[src/main/scala/Driver.scala 105:21]
      if (!(2'h0 == uartState)) begin // @[src/main/scala/Driver.scala 106:23]
        if (!(2'h1 == uartState)) begin // @[src/main/scala/Driver.scala 106:23]
          system_active <= _GEN_46;
        end
      end
    end
    if (reset) begin // @[src/main/scala/Driver.scala 62:35]
      initial_offset <= 32'sh0; // @[src/main/scala/Driver.scala 62:35]
    end else if (rx_io_done) begin // @[src/main/scala/Driver.scala 105:21]
      if (!(2'h0 == uartState)) begin // @[src/main/scala/Driver.scala 106:23]
        if (!(2'h1 == uartState)) begin // @[src/main/scala/Driver.scala 106:23]
          initial_offset <= _GEN_44;
        end
      end
    end
    current_position_fixed_point <= full_pos_calc[31:0]; // @[src/main/scala/Driver.scala 68:79]
    if (reset) begin // @[src/main/scala/Driver.scala 72:26]
      uartState <= 2'h0; // @[src/main/scala/Driver.scala 72:26]
    end else if (rx_io_done) begin // @[src/main/scala/Driver.scala 105:21]
      if (2'h0 == uartState) begin // @[src/main/scala/Driver.scala 106:23]
        if (rx_io_data == 8'haa) begin // @[src/main/scala/Driver.scala 107:49]
          uartState <= 2'h1; // @[src/main/scala/Driver.scala 107:61]
        end
      end else if (2'h1 == uartState) begin // @[src/main/scala/Driver.scala 106:23]
        uartState <= 2'h2; // @[src/main/scala/Driver.scala 108:51]
      end else begin
        uartState <= _GEN_53;
      end
    end
    if (reset) begin // @[src/main/scala/Driver.scala 73:24]
      CMDByte <= 8'h0; // @[src/main/scala/Driver.scala 73:24]
    end else if (rx_io_done) begin // @[src/main/scala/Driver.scala 105:21]
      if (!(2'h0 == uartState)) begin // @[src/main/scala/Driver.scala 106:23]
        if (2'h1 == uartState) begin // @[src/main/scala/Driver.scala 106:23]
          CMDByte <= rx_io_data; // @[src/main/scala/Driver.scala 108:26]
        end
      end
    end
    if (reset) begin // @[src/main/scala/Driver.scala 81:35]
      manual_speed <= 10'h200; // @[src/main/scala/Driver.scala 81:35]
    end else if (rx_io_done) begin // @[src/main/scala/Driver.scala 105:21]
      if (2'h0 == uartState) begin // @[src/main/scala/Driver.scala 106:23]
        manual_speed <= _GEN_13;
      end else if (2'h1 == uartState) begin // @[src/main/scala/Driver.scala 106:23]
        manual_speed <= _GEN_13;
      end else begin
        manual_speed <= _GEN_51;
      end
    end else begin
      manual_speed <= _GEN_13;
    end
    if (reset) begin // @[src/main/scala/Driver.scala 82:35]
      manual_ramped <= 10'h200; // @[src/main/scala/Driver.scala 82:35]
    end else if (~system_active) begin // @[src/main/scala/Driver.scala 99:24]
      manual_ramped <= 10'h200; // @[src/main/scala/Driver.scala 100:19]
    end else if (ramp_tick) begin // @[src/main/scala/Driver.scala 90:19]
      if (manual_ramped < manual_speed) begin // @[src/main/scala/Driver.scala 92:40]
        manual_ramped <= _manual_ramped_T_1; // @[src/main/scala/Driver.scala 93:21]
      end else begin
        manual_ramped <= _GEN_8;
      end
    end
    if (reset) begin // @[src/main/scala/Driver.scala 85:35]
      ramp_timer <= 17'h0; // @[src/main/scala/Driver.scala 85:35]
    end else if (ramp_tick) begin // @[src/main/scala/Driver.scala 90:19]
      ramp_timer <= 17'h0; // @[src/main/scala/Driver.scala 91:16]
    end else begin
      ramp_timer <= _ramp_timer_T_1; // @[src/main/scala/Driver.scala 97:28]
    end
    if (reset) begin // @[src/main/scala/Driver.scala 144:28]
      grace_timer <= 28'hbebc200; // @[src/main/scala/Driver.scala 144:28]
    end else if (new_cmd_pulse) begin // @[src/main/scala/Driver.scala 146:23]
      grace_timer <= 28'h0; // @[src/main/scala/Driver.scala 147:17]
    end else if (grace_timer < 28'hbebc200) begin // @[src/main/scala/Driver.scala 148:41]
      grace_timer <= _grace_timer_T_1; // @[src/main/scala/Driver.scala 149:17]
    end
    if (reset) begin // @[src/main/scala/Driver.scala 155:32]
      stillness_timer <= 26'h0; // @[src/main/scala/Driver.scala 155:32]
    end else if (rotations_io_pulse | new_cmd_pulse) begin // @[src/main/scala/Driver.scala 157:45]
      stillness_timer <= 26'h0; // @[src/main/scala/Driver.scala 158:21]
    end else if (stillness_timer < 26'h1c9c380) begin // @[src/main/scala/Driver.scala 159:49]
      stillness_timer <= _stillness_timer_T_1; // @[src/main/scala/Driver.scala 160:21]
    end
    target_turns <= $signed(_target_turns_T) / 3'sh2; // @[src/main/scala/Driver.scala 166:58]
    if ($signed(raw_pid_out) == 32'sh0) begin // @[src/main/scala/Driver.scala 188:31]
      pid_offset <= 29'sh0;
    end else if ($signed(raw_pid_out) > 32'sh0) begin // @[src/main/scala/Driver.scala 188:61]
      pid_offset <= {{1{_pid_offset_T_5[27]}},_pid_offset_T_5};
    end else begin
      pid_offset <= _pid_offset_T_9;
    end
    if (reset) begin // @[src/main/scala/Driver.scala 209:38]
      pwm_signal_io_duty_cycle_REG <= 29'h200; // @[src/main/scala/Driver.scala 209:38]
    end else if (block_neg | block_pos) begin // @[src/main/scala/Driver.scala 209:42]
      pwm_signal_io_duty_cycle_REG <= 29'h200;
    end else if (control_mode) begin // @[src/main/scala/Driver.scala 193:24]
      if (at_position) begin // @[src/main/scala/Driver.scala 191:21]
        pwm_signal_io_duty_cycle_REG <= 29'h200;
      end else begin
        pwm_signal_io_duty_cycle_REG <= _pid_duty_T_4;
      end
    end else begin
      pwm_signal_io_duty_cycle_REG <= {{19'd0}, manual_ramped};
    end
    if (reset) begin // @[src/main/scala/Driver.scala 226:24]
      txTimer <= 24'h0; // @[src/main/scala/Driver.scala 226:24]
    end else if (txTimer >= 24'h2625a0) begin // @[src/main/scala/Driver.scala 231:30]
      if (!(3'h0 == txState)) begin // @[src/main/scala/Driver.scala 232:21]
        if (3'h1 == txState) begin // @[src/main/scala/Driver.scala 232:21]
          txTimer <= _GEN_101;
        end else begin
          txTimer <= _GEN_141;
        end
      end
    end else begin
      txTimer <= _txTimer_T_1; // @[src/main/scala/Driver.scala 282:25]
    end
    if (reset) begin // @[src/main/scala/Driver.scala 228:24]
      txState <= 3'h0; // @[src/main/scala/Driver.scala 228:24]
    end else if (txTimer >= 24'h2625a0) begin // @[src/main/scala/Driver.scala 231:30]
      if (3'h0 == txState) begin // @[src/main/scala/Driver.scala 232:21]
        if (~tx_io_busy) begin // @[src/main/scala/Driver.scala 234:27]
          txState <= 3'h1; // @[src/main/scala/Driver.scala 237:19]
        end
      end else if (3'h1 == txState) begin // @[src/main/scala/Driver.scala 232:21]
        txState <= _GEN_100;
      end else begin
        txState <= _GEN_140;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  rotations_io_signal_A_cnt = _RAND_0[13:0];
  _RAND_1 = {1{`RANDOM}};
  rotations_io_signal_A_out = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  rotations_io_signal_B_cnt = _RAND_2[13:0];
  _RAND_3 = {1{`RANDOM}};
  rotations_io_signal_B_out = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  pid_timer = _RAND_4[16:0];
  _RAND_5 = {1{`RANDOM}};
  target_position_cm = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  control_mode = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  manual_brake = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  system_active = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  initial_offset = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  current_position_fixed_point = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  uartState = _RAND_11[1:0];
  _RAND_12 = {1{`RANDOM}};
  CMDByte = _RAND_12[7:0];
  _RAND_13 = {1{`RANDOM}};
  manual_speed = _RAND_13[9:0];
  _RAND_14 = {1{`RANDOM}};
  manual_ramped = _RAND_14[9:0];
  _RAND_15 = {1{`RANDOM}};
  ramp_timer = _RAND_15[16:0];
  _RAND_16 = {1{`RANDOM}};
  grace_timer = _RAND_16[27:0];
  _RAND_17 = {1{`RANDOM}};
  stillness_timer = _RAND_17[25:0];
  _RAND_18 = {2{`RANDOM}};
  target_turns = _RAND_18[37:0];
  _RAND_19 = {1{`RANDOM}};
  pid_offset = _RAND_19[28:0];
  _RAND_20 = {1{`RANDOM}};
  pwm_signal_io_duty_cycle_REG = _RAND_20[28:0];
  _RAND_21 = {1{`RANDOM}};
  txTimer = _RAND_21[23:0];
  _RAND_22 = {1{`RANDOM}};
  txState = _RAND_22[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
