module UartRx(
  input        clock,
  input        reset,
  input        io_rx, // @[src/main/scala/Functions.scala 72:14]
  output       io_done, // @[src/main/scala/Functions.scala 72:14]
  output [7:0] io_data // @[src/main/scala/Functions.scala 72:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg  rxReg_REG; // @[src/main/scala/Functions.scala 79:33]
  reg  rxReg; // @[src/main/scala/Functions.scala 79:25]
  reg [7:0] shiftReg; // @[src/main/scala/Functions.scala 80:25]
  reg [31:0] cntReg; // @[src/main/scala/Functions.scala 81:25]
  reg [3:0] bitsReg; // @[src/main/scala/Functions.scala 82:25]
  reg [1:0] stateReg; // @[src/main/scala/Functions.scala 84:25]
  wire [31:0] _cntReg_T_1 = cntReg + 32'h1; // @[src/main/scala/Functions.scala 89:127]
  wire [9:0] _T_6 = 10'h364 - 10'h1; // @[src/main/scala/Functions.scala 90:41]
  wire [31:0] _GEN_32 = {{22'd0}, _T_6}; // @[src/main/scala/Functions.scala 90:29]
  wire  _T_7 = cntReg == _GEN_32; // @[src/main/scala/Functions.scala 90:29]
  wire [7:0] _shiftReg_T_1 = {rxReg,shiftReg[7:1]}; // @[src/main/scala/Functions.scala 90:80]
  wire [3:0] _bitsReg_T_1 = bitsReg + 4'h1; // @[src/main/scala/Functions.scala 90:180]
  wire [1:0] _GEN_5 = bitsReg == 4'h7 ? 2'h3 : stateReg; // @[src/main/scala/Functions.scala 90:{127,138} 84:25]
  wire [3:0] _GEN_6 = bitsReg == 4'h7 ? bitsReg : _bitsReg_T_1; // @[src/main/scala/Functions.scala 90:127 82:25 90:169]
  wire [31:0] _GEN_7 = cntReg == _GEN_32 ? 32'h0 : _cntReg_T_1; // @[src/main/scala/Functions.scala 90:{209,48,57}]
  wire [7:0] _GEN_8 = cntReg == _GEN_32 ? _shiftReg_T_1 : shiftReg; // @[src/main/scala/Functions.scala 80:25 90:{48,74}]
  wire [1:0] _GEN_9 = cntReg == _GEN_32 ? _GEN_5 : stateReg; // @[src/main/scala/Functions.scala 84:25 90:48]
  wire [3:0] _GEN_10 = cntReg == _GEN_32 ? _GEN_6 : bitsReg; // @[src/main/scala/Functions.scala 82:25 90:48]
  wire [1:0] _GEN_11 = _T_7 ? 2'h0 : stateReg; // @[src/main/scala/Functions.scala 84:25 91:{48,59}]
  wire [31:0] _GEN_13 = _T_7 ? cntReg : _cntReg_T_1; // @[src/main/scala/Functions.scala 81:25 91:{108,48}]
  wire [1:0] _GEN_14 = 2'h3 == stateReg ? _GEN_11 : stateReg; // @[src/main/scala/Functions.scala 87:20 84:25]
  wire [31:0] _GEN_16 = 2'h3 == stateReg ? _GEN_13 : cntReg; // @[src/main/scala/Functions.scala 87:20 81:25]
  wire  _GEN_21 = 2'h2 == stateReg ? 1'h0 : 2'h3 == stateReg & _T_7; // @[src/main/scala/Functions.scala 85:11 87:20]
  wire  _GEN_26 = 2'h1 == stateReg ? 1'h0 : _GEN_21; // @[src/main/scala/Functions.scala 85:11 87:20]
  assign io_done = 2'h0 == stateReg ? 1'h0 : _GEN_26; // @[src/main/scala/Functions.scala 85:11 87:20]
  assign io_data = shiftReg; // @[src/main/scala/Functions.scala 86:11]
  always @(posedge clock) begin
    rxReg_REG <= io_rx; // @[src/main/scala/Functions.scala 79:33]
    rxReg <= rxReg_REG; // @[src/main/scala/Functions.scala 79:25]
    if (reset) begin // @[src/main/scala/Functions.scala 80:25]
      shiftReg <= 8'h0; // @[src/main/scala/Functions.scala 80:25]
    end else if (!(2'h0 == stateReg)) begin // @[src/main/scala/Functions.scala 87:20]
      if (!(2'h1 == stateReg)) begin // @[src/main/scala/Functions.scala 87:20]
        if (2'h2 == stateReg) begin // @[src/main/scala/Functions.scala 87:20]
          shiftReg <= _GEN_8;
        end
      end
    end
    if (reset) begin // @[src/main/scala/Functions.scala 81:25]
      cntReg <= 32'h0; // @[src/main/scala/Functions.scala 81:25]
    end else if (2'h0 == stateReg) begin // @[src/main/scala/Functions.scala 87:20]
      if (~rxReg) begin // @[src/main/scala/Functions.scala 88:30]
        cntReg <= 32'h0; // @[src/main/scala/Functions.scala 88:59]
      end
    end else if (2'h1 == stateReg) begin // @[src/main/scala/Functions.scala 87:20]
      if (cntReg == 32'h1b2) begin // @[src/main/scala/Functions.scala 89:45]
        cntReg <= 32'h0; // @[src/main/scala/Functions.scala 89:73]
      end else begin
        cntReg <= _cntReg_T_1; // @[src/main/scala/Functions.scala 89:117]
      end
    end else if (2'h2 == stateReg) begin // @[src/main/scala/Functions.scala 87:20]
      cntReg <= _GEN_7;
    end else begin
      cntReg <= _GEN_16;
    end
    if (reset) begin // @[src/main/scala/Functions.scala 82:25]
      bitsReg <= 4'h0; // @[src/main/scala/Functions.scala 82:25]
    end else if (!(2'h0 == stateReg)) begin // @[src/main/scala/Functions.scala 87:20]
      if (2'h1 == stateReg) begin // @[src/main/scala/Functions.scala 87:20]
        if (cntReg == 32'h1b2) begin // @[src/main/scala/Functions.scala 89:45]
          bitsReg <= 4'h0; // @[src/main/scala/Functions.scala 89:89]
        end
      end else if (2'h2 == stateReg) begin // @[src/main/scala/Functions.scala 87:20]
        bitsReg <= _GEN_10;
      end
    end
    if (reset) begin // @[src/main/scala/Functions.scala 84:25]
      stateReg <= 2'h0; // @[src/main/scala/Functions.scala 84:25]
    end else if (2'h0 == stateReg) begin // @[src/main/scala/Functions.scala 87:20]
      if (~rxReg) begin // @[src/main/scala/Functions.scala 88:30]
        stateReg <= 2'h1; // @[src/main/scala/Functions.scala 88:41]
      end
    end else if (2'h1 == stateReg) begin // @[src/main/scala/Functions.scala 87:20]
      if (cntReg == 32'h1b2) begin // @[src/main/scala/Functions.scala 89:45]
        stateReg <= 2'h2; // @[src/main/scala/Functions.scala 89:56]
      end
    end else if (2'h2 == stateReg) begin // @[src/main/scala/Functions.scala 87:20]
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
  input  [7:0] io_data, // @[src/main/scala/Functions.scala 96:14]
  input        io_start, // @[src/main/scala/Functions.scala 96:14]
  output       io_tx, // @[src/main/scala/Functions.scala 96:14]
  output       io_busy // @[src/main/scala/Functions.scala 96:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [9:0] reg_; // @[src/main/scala/Functions.scala 103:20]
  reg [31:0] cnt; // @[src/main/scala/Functions.scala 104:20]
  reg [3:0] bits; // @[src/main/scala/Functions.scala 105:21]
  reg  state; // @[src/main/scala/Functions.scala 107:22]
  wire [9:0] _reg_T = {1'h1,io_data,1'h0}; // @[src/main/scala/Functions.scala 111:44]
  wire  _GEN_3 = io_start | state; // @[src/main/scala/Functions.scala 107:22 111:{32,96}]
  wire [9:0] _T_3 = 10'h364 - 10'h1; // @[src/main/scala/Functions.scala 112:38]
  wire [31:0] _GEN_18 = {{22'd0}, _T_3}; // @[src/main/scala/Functions.scala 112:26]
  wire [9:0] _reg_T_2 = {1'h1,reg_[9:1]}; // @[src/main/scala/Functions.scala 112:69]
  wire [3:0] _bits_T_1 = bits + 4'h1; // @[src/main/scala/Functions.scala 112:150]
  wire  _GEN_4 = bits == 4'h9 ? 1'h0 : state; // @[src/main/scala/Functions.scala 112:{106,114} 107:22]
  wire [3:0] _GEN_5 = bits == 4'h9 ? bits : _bits_T_1; // @[src/main/scala/Functions.scala 112:106 105:21 112:142]
  wire [31:0] _cnt_T_1 = cnt + 32'h1; // @[src/main/scala/Functions.scala 112:183]
  assign io_tx = reg_[0]; // @[src/main/scala/Functions.scala 108:15]
  assign io_busy = state; // @[src/main/scala/Functions.scala 109:20]
  always @(posedge clock) begin
    if (reset) begin // @[src/main/scala/Functions.scala 103:20]
      reg_ <= 10'h1; // @[src/main/scala/Functions.scala 103:20]
    end else if (~state) begin // @[src/main/scala/Functions.scala 110:17]
      if (io_start) begin // @[src/main/scala/Functions.scala 111:32]
        reg_ <= _reg_T; // @[src/main/scala/Functions.scala 111:38]
      end
    end else if (state) begin // @[src/main/scala/Functions.scala 110:17]
      if (cnt == _GEN_18) begin // @[src/main/scala/Functions.scala 112:45]
        reg_ <= _reg_T_2; // @[src/main/scala/Functions.scala 112:63]
      end
    end
    if (reset) begin // @[src/main/scala/Functions.scala 104:20]
      cnt <= 32'h0; // @[src/main/scala/Functions.scala 104:20]
    end else if (~state) begin // @[src/main/scala/Functions.scala 110:17]
      if (io_start) begin // @[src/main/scala/Functions.scala 111:32]
        cnt <= 32'h0; // @[src/main/scala/Functions.scala 111:82]
      end
    end else if (state) begin // @[src/main/scala/Functions.scala 110:17]
      if (cnt == _GEN_18) begin // @[src/main/scala/Functions.scala 112:45]
        cnt <= 32'h0; // @[src/main/scala/Functions.scala 112:51]
      end else begin
        cnt <= _cnt_T_1; // @[src/main/scala/Functions.scala 112:176]
      end
    end
    if (reset) begin // @[src/main/scala/Functions.scala 105:21]
      bits <= 4'h0; // @[src/main/scala/Functions.scala 105:21]
    end else if (~state) begin // @[src/main/scala/Functions.scala 110:17]
      if (io_start) begin // @[src/main/scala/Functions.scala 111:32]
        bits <= 4'h0; // @[src/main/scala/Functions.scala 111:70]
      end
    end else if (state) begin // @[src/main/scala/Functions.scala 110:17]
      if (cnt == _GEN_18) begin // @[src/main/scala/Functions.scala 112:45]
        bits <= _GEN_5;
      end
    end
    if (reset) begin // @[src/main/scala/Functions.scala 107:22]
      state <= 1'h0; // @[src/main/scala/Functions.scala 107:22]
    end else if (~state) begin // @[src/main/scala/Functions.scala 110:17]
      state <= _GEN_3;
    end else if (state) begin // @[src/main/scala/Functions.scala 110:17]
      if (cnt == _GEN_18) begin // @[src/main/scala/Functions.scala 112:45]
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
  input  [9:0] io_duty_cycle, // @[src/main/scala/Functions.scala 24:14]
  input        io_brake, // @[src/main/scala/Functions.scala 24:14]
  output       io_T1, // @[src/main/scala/Functions.scala 24:14]
  output       io_T2, // @[src/main/scala/Functions.scala 24:14]
  output       io_T3, // @[src/main/scala/Functions.scala 24:14]
  output       io_T4 // @[src/main/scala/Functions.scala 24:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] pwmCounter; // @[src/main/scala/Functions.scala 35:29]
  wire [12:0] _T_1 = 13'h11c1 - 13'h1; // @[src/main/scala/Functions.scala 37:35]
  wire [31:0] _GEN_5 = {{19'd0}, _T_1}; // @[src/main/scala/Functions.scala 37:19]
  wire [31:0] _pwmCounter_T_1 = pwmCounter + 32'h1; // @[src/main/scala/Functions.scala 40:30]
  wire [22:0] _threshold_T = io_duty_cycle * 13'h11c1; // @[src/main/scala/Functions.scala 43:34]
  wire [12:0] threshold = _threshold_T[22:10]; // @[src/main/scala/Functions.scala 43:50]
  wire [31:0] _GEN_6 = {{19'd0}, threshold}; // @[src/main/scala/Functions.scala 44:30]
  wire  pwmSignal = pwmCounter < _GEN_6; // @[src/main/scala/Functions.scala 44:30]
  wire  _conduct_T4_T = ~pwmSignal; // @[src/main/scala/Functions.scala 59:19]
  wire  conduct_T2 = io_brake ? 1'h0 : pwmSignal; // @[src/main/scala/Functions.scala 51:18 53:16 57:16]
  wire  conduct_T4 = io_brake ? 1'h0 : ~pwmSignal; // @[src/main/scala/Functions.scala 51:18 55:16 59:16]
  assign io_T1 = io_brake | _conduct_T4_T; // @[src/main/scala/Functions.scala 51:18 52:16 60:16]
  assign io_T2 = ~conduct_T2; // @[src/main/scala/Functions.scala 65:12]
  assign io_T3 = io_brake | pwmSignal; // @[src/main/scala/Functions.scala 51:18 54:16 58:16]
  assign io_T4 = ~conduct_T4; // @[src/main/scala/Functions.scala 66:12]
  always @(posedge clock) begin
    if (reset) begin // @[src/main/scala/Functions.scala 35:29]
      pwmCounter <= 32'h0; // @[src/main/scala/Functions.scala 35:29]
    end else if (pwmCounter >= _GEN_5) begin // @[src/main/scala/Functions.scala 37:42]
      pwmCounter <= 32'h0; // @[src/main/scala/Functions.scala 38:16]
    end else begin
      pwmCounter <= _pwmCounter_T_1; // @[src/main/scala/Functions.scala 40:16]
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
  input  [31:0] io_setPoint, // @[src/main/scala/Functions.scala 274:14]
  input  [31:0] io_measuredVal, // @[src/main/scala/Functions.scala 274:14]
  input         io_tick, // @[src/main/scala/Functions.scala 274:14]
  input         io_resetBuffer, // @[src/main/scala/Functions.scala 274:14]
  output [31:0] io_controlOut // @[src/main/scala/Functions.scala 274:14]
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
  reg [31:0] integralReg; // @[src/main/scala/Functions.scala 285:29]
  reg [31:0] prevErrorReg; // @[src/main/scala/Functions.scala 286:29]
  reg [31:0] outputReg; // @[src/main/scala/Functions.scala 287:29]
  reg  tick_s2; // @[src/main/scala/Functions.scala 292:24]
  reg  tick_s3; // @[src/main/scala/Functions.scala 293:24]
  wire [31:0] error = $signed(io_setPoint) - $signed(io_measuredVal); // @[src/main/scala/Functions.scala 295:27]
  wire [63:0] _pTerm_s1_T = 32'sha000 * $signed(error); // @[src/main/scala/Functions.scala 296:34]
  reg [63:0] pTerm_s1; // @[src/main/scala/Functions.scala 296:27]
  wire [63:0] _iInc_s1_T = 32'sh0 * $signed(error); // @[src/main/scala/Functions.scala 297:34]
  reg [63:0] iInc_s1; // @[src/main/scala/Functions.scala 297:27]
  wire [31:0] _dDiff_s1_T_2 = $signed(error) - $signed(prevErrorReg); // @[src/main/scala/Functions.scala 298:34]
  reg [31:0] dDiff_s1; // @[src/main/scala/Functions.scala 298:27]
  wire [43:0] _GEN_15 = {$signed(integralReg), 12'h0}; // @[src/main/scala/Functions.scala 300:41]
  wire [63:0] _GEN_16 = {{20{_GEN_15[43]}},_GEN_15}; // @[src/main/scala/Functions.scala 300:41]
  wire [63:0] _iSum_s2_T_2 = $signed(_GEN_16) + $signed(iInc_s1); // @[src/main/scala/Functions.scala 300:41]
  reg [63:0] iSum_s2; // @[src/main/scala/Functions.scala 300:28]
  reg [63:0] pTerm_s2; // @[src/main/scala/Functions.scala 301:28]
  wire [63:0] _dTerm_s2_T = 32'shfa0000 * $signed(dDiff_s1); // @[src/main/scala/Functions.scala 302:35]
  reg [63:0] dTerm_s2; // @[src/main/scala/Functions.scala 302:28]
  reg [31:0] error_s2; // @[src/main/scala/Functions.scala 303:28]
  wire [63:0] _iClamped_s3_T_2 = $signed(iSum_s2) < -64'sh800000 ? $signed(-64'sh800000) : $signed(iSum_s2); // @[src/main/scala/Functions.scala 305:60]
  wire [63:0] iClamped_s3 = $signed(iSum_s2) > 64'sh800000 ? $signed(64'sh800000) : $signed(_iClamped_s3_T_2); // @[src/main/scala/Functions.scala 305:24]
  wire [63:0] _rawOutput_s3_T_2 = $signed(pTerm_s2) + $signed(iClamped_s3); // @[src/main/scala/Functions.scala 306:31]
  wire [63:0] rawOutput_s3 = $signed(_rawOutput_s3_T_2) + $signed(dTerm_s2); // @[src/main/scala/Functions.scala 306:45]
  reg  tick_s4; // @[src/main/scala/Functions.scala 308:24]
  reg [63:0] sum_s3; // @[src/main/scala/Functions.scala 309:25]
  wire [63:0] _outputReg_T_2 = $signed(sum_s3) < -64'sh800000 ? $signed(-64'sh800000) : $signed(sum_s3); // @[src/main/scala/Functions.scala 319:59]
  wire [63:0] _outputReg_T_3 = $signed(sum_s3) > 64'sh800000 ? $signed(64'sh800000) : $signed(_outputReg_T_2); // @[src/main/scala/Functions.scala 319:24]
  wire [43:0] _GEN_17 = {$signed(outputReg), 12'h0}; // @[src/main/scala/Functions.scala 318:24 319:18 287:29]
  wire [63:0] _GEN_8 = tick_s4 ? $signed(_outputReg_T_3) : $signed({{20{_GEN_17[43]}},_GEN_17}); // @[src/main/scala/Functions.scala 318:24 319:18 287:29]
  wire [63:0] _GEN_9 = tick_s3 ? $signed(iClamped_s3) : $signed({{20{_GEN_15[43]}},_GEN_15}); // @[src/main/scala/Functions.scala 315:24 316:18 285:29]
  wire [63:0] _GEN_11 = tick_s3 ? $signed({{20{_GEN_17[43]}},_GEN_17}) : $signed(_GEN_8); // @[src/main/scala/Functions.scala 315:24 287:29]
  wire [63:0] _GEN_12 = io_resetBuffer ? $signed(64'sh0) : $signed(_GEN_9); // @[src/main/scala/Functions.scala 311:24 312:18]
  wire [63:0] _GEN_14 = io_resetBuffer ? $signed(64'sh0) : $signed(_GEN_11); // @[src/main/scala/Functions.scala 311:24 314:18]
  wire [51:0] _GEN_20 = reset ? $signed(52'sh0) : $signed(_GEN_12[63:12]); // @[src/main/scala/Functions.scala 285:{29,29}]
  wire [51:0] _GEN_22 = reset ? $signed(52'sh0) : $signed(_GEN_14[63:12]); // @[src/main/scala/Functions.scala 287:{29,29}]
  assign io_controlOut = outputReg; // @[src/main/scala/Functions.scala 321:17]
  always @(posedge clock) begin
    integralReg <= _GEN_20[31:0]; // @[src/main/scala/Functions.scala 285:{29,29}]
    if (reset) begin // @[src/main/scala/Functions.scala 286:29]
      prevErrorReg <= 32'sh0; // @[src/main/scala/Functions.scala 286:29]
    end else if (io_resetBuffer) begin // @[src/main/scala/Functions.scala 311:24]
      prevErrorReg <= 32'sh0; // @[src/main/scala/Functions.scala 313:18]
    end else if (tick_s3) begin // @[src/main/scala/Functions.scala 315:24]
      prevErrorReg <= error_s2; // @[src/main/scala/Functions.scala 317:18]
    end
    outputReg <= _GEN_22[31:0]; // @[src/main/scala/Functions.scala 287:{29,29}]
    tick_s2 <= io_tick; // @[src/main/scala/Functions.scala 292:24]
    tick_s3 <= tick_s2; // @[src/main/scala/Functions.scala 293:24]
    if (io_tick) begin // @[src/main/scala/Functions.scala 296:27]
      pTerm_s1 <= _pTerm_s1_T; // @[src/main/scala/Functions.scala 296:27]
    end
    if (io_tick) begin // @[src/main/scala/Functions.scala 297:27]
      iInc_s1 <= _iInc_s1_T; // @[src/main/scala/Functions.scala 297:27]
    end
    if (io_tick) begin // @[src/main/scala/Functions.scala 298:27]
      dDiff_s1 <= _dDiff_s1_T_2; // @[src/main/scala/Functions.scala 298:27]
    end
    if (tick_s2) begin // @[src/main/scala/Functions.scala 300:28]
      iSum_s2 <= _iSum_s2_T_2; // @[src/main/scala/Functions.scala 300:28]
    end
    if (tick_s2) begin // @[src/main/scala/Functions.scala 301:28]
      pTerm_s2 <= pTerm_s1; // @[src/main/scala/Functions.scala 301:28]
    end
    if (tick_s2) begin // @[src/main/scala/Functions.scala 302:28]
      dTerm_s2 <= _dTerm_s2_T; // @[src/main/scala/Functions.scala 302:28]
    end
    if (tick_s2) begin // @[src/main/scala/Functions.scala 303:28]
      error_s2 <= error; // @[src/main/scala/Functions.scala 303:28]
    end
    tick_s4 <= tick_s3; // @[src/main/scala/Functions.scala 308:24]
    if (tick_s3) begin // @[src/main/scala/Functions.scala 309:25]
      sum_s3 <= rawOutput_s3; // @[src/main/scala/Functions.scala 309:25]
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
  input   io_external_overcurrent_input, // @[src/main/scala/Functions.scala 117:14]
  input   io_clear_shutdown, // @[src/main/scala/Functions.scala 117:14]
  output  io_motor_disable // @[src/main/scala/Functions.scala 117:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [24:0] maxCycles = 17'h186a0 * 8'h96; // @[src/main/scala/Functions.scala 123:44]
  reg [31:0] durationReg; // @[src/main/scala/Functions.scala 124:28]
  reg  isStuckReg; // @[src/main/scala/Functions.scala 125:28]
  wire [31:0] _GEN_8 = {{7'd0}, maxCycles}; // @[src/main/scala/Functions.scala 129:26]
  wire [31:0] _durationReg_T_1 = durationReg + 32'h1; // @[src/main/scala/Functions.scala 129:104]
  wire  _GEN_0 = durationReg >= _GEN_8 | isStuckReg; // @[src/main/scala/Functions.scala 125:28 129:{40,53}]
  wire [31:0] _GEN_1 = durationReg >= _GEN_8 ? durationReg : _durationReg_T_1; // @[src/main/scala/Functions.scala 124:28 129:{40,89}]
  assign io_motor_disable = isStuckReg; // @[src/main/scala/Functions.scala 133:20]
  always @(posedge clock) begin
    if (reset) begin // @[src/main/scala/Functions.scala 124:28]
      durationReg <= 32'h0; // @[src/main/scala/Functions.scala 124:28]
    end else if (io_clear_shutdown) begin // @[src/main/scala/Functions.scala 126:27]
      durationReg <= 32'h0; // @[src/main/scala/Functions.scala 126:64]
    end else if (~isStuckReg) begin // @[src/main/scala/Functions.scala 127:23]
      if (io_external_overcurrent_input) begin // @[src/main/scala/Functions.scala 128:43]
        durationReg <= _GEN_1;
      end else begin
        durationReg <= 32'h0; // @[src/main/scala/Functions.scala 130:33]
      end
    end
    if (reset) begin // @[src/main/scala/Functions.scala 125:28]
      isStuckReg <= 1'h0; // @[src/main/scala/Functions.scala 125:28]
    end else if (io_clear_shutdown) begin // @[src/main/scala/Functions.scala 126:27]
      isStuckReg <= 1'h0; // @[src/main/scala/Functions.scala 126:40]
    end else if (~isStuckReg) begin // @[src/main/scala/Functions.scala 127:23]
      if (io_external_overcurrent_input) begin // @[src/main/scala/Functions.scala 128:43]
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
  input  [4:0] io_in, // @[src/main/scala/Functions.scala 185:14]
  output [6:0] io_out // @[src/main/scala/Functions.scala 185:14]
);
  wire [6:0] _io_out_T_33 = 5'h0 == io_in ? 7'h3f : 7'h0; // @[src/main/scala/Functions.scala 190:46]
  wire [6:0] _io_out_T_35 = 5'h1 == io_in ? 7'h6 : _io_out_T_33; // @[src/main/scala/Functions.scala 190:46]
  wire [6:0] _io_out_T_37 = 5'h2 == io_in ? 7'h5b : _io_out_T_35; // @[src/main/scala/Functions.scala 190:46]
  wire [6:0] _io_out_T_39 = 5'h3 == io_in ? 7'h4f : _io_out_T_37; // @[src/main/scala/Functions.scala 190:46]
  wire [6:0] _io_out_T_41 = 5'h4 == io_in ? 7'h66 : _io_out_T_39; // @[src/main/scala/Functions.scala 190:46]
  wire [6:0] _io_out_T_43 = 5'h5 == io_in ? 7'h6d : _io_out_T_41; // @[src/main/scala/Functions.scala 190:46]
  wire [6:0] _io_out_T_45 = 5'h6 == io_in ? 7'h7d : _io_out_T_43; // @[src/main/scala/Functions.scala 190:46]
  wire [6:0] _io_out_T_47 = 5'h7 == io_in ? 7'h7 : _io_out_T_45; // @[src/main/scala/Functions.scala 190:46]
  wire [6:0] _io_out_T_49 = 5'h8 == io_in ? 7'h7f : _io_out_T_47; // @[src/main/scala/Functions.scala 190:46]
  wire [6:0] _io_out_T_51 = 5'h9 == io_in ? 7'h6f : _io_out_T_49; // @[src/main/scala/Functions.scala 190:46]
  wire [6:0] _io_out_T_53 = 5'ha == io_in ? 7'h77 : _io_out_T_51; // @[src/main/scala/Functions.scala 190:46]
  wire [6:0] _io_out_T_55 = 5'hb == io_in ? 7'h7c : _io_out_T_53; // @[src/main/scala/Functions.scala 190:46]
  wire [6:0] _io_out_T_57 = 5'hc == io_in ? 7'h39 : _io_out_T_55; // @[src/main/scala/Functions.scala 190:46]
  wire [6:0] _io_out_T_59 = 5'hd == io_in ? 7'h5e : _io_out_T_57; // @[src/main/scala/Functions.scala 190:46]
  wire [6:0] _io_out_T_61 = 5'he == io_in ? 7'h79 : _io_out_T_59; // @[src/main/scala/Functions.scala 190:46]
  wire [6:0] _io_out_T_63 = 5'hf == io_in ? 7'h71 : _io_out_T_61; // @[src/main/scala/Functions.scala 190:46]
  wire [6:0] _io_out_T_65 = 5'h10 == io_in ? 7'h3c : _io_out_T_63; // @[src/main/scala/Functions.scala 190:46]
  wire [6:0] _io_out_T_67 = 5'h11 == io_in ? 7'h76 : _io_out_T_65; // @[src/main/scala/Functions.scala 190:46]
  wire [6:0] _io_out_T_69 = 5'h12 == io_in ? 7'h6 : _io_out_T_67; // @[src/main/scala/Functions.scala 190:46]
  wire [6:0] _io_out_T_71 = 5'h13 == io_in ? 7'hf : _io_out_T_69; // @[src/main/scala/Functions.scala 190:46]
  wire [6:0] _io_out_T_73 = 5'h14 == io_in ? 7'h38 : _io_out_T_71; // @[src/main/scala/Functions.scala 190:46]
  wire [6:0] _io_out_T_75 = 5'h15 == io_in ? 7'h38 : _io_out_T_73; // @[src/main/scala/Functions.scala 190:46]
  wire [6:0] _io_out_T_77 = 5'h16 == io_in ? 7'h70 : _io_out_T_75; // @[src/main/scala/Functions.scala 190:46]
  wire [6:0] _io_out_T_79 = 5'h17 == io_in ? 7'h3f : _io_out_T_77; // @[src/main/scala/Functions.scala 190:46]
  wire [6:0] _io_out_T_81 = 5'h18 == io_in ? 7'h73 : _io_out_T_79; // @[src/main/scala/Functions.scala 190:46]
  wire [6:0] _io_out_T_83 = 5'h19 == io_in ? 7'h67 : _io_out_T_81; // @[src/main/scala/Functions.scala 190:46]
  wire [6:0] _io_out_T_85 = 5'h1a == io_in ? 7'h31 : _io_out_T_83; // @[src/main/scala/Functions.scala 190:46]
  wire [6:0] _io_out_T_87 = 5'h1b == io_in ? 7'h6d : _io_out_T_85; // @[src/main/scala/Functions.scala 190:46]
  wire [6:0] _io_out_T_89 = 5'h1c == io_in ? 7'h78 : _io_out_T_87; // @[src/main/scala/Functions.scala 190:46]
  wire [6:0] _io_out_T_91 = 5'h1d == io_in ? 7'h3e : _io_out_T_89; // @[src/main/scala/Functions.scala 190:46]
  assign io_out = 5'h1e == io_in ? 7'h0 : _io_out_T_91; // @[src/main/scala/Functions.scala 190:46]
endmodule
module DisplayMultiplexer(
  input         clock,
  input         reset,
  input  [19:0] io_disp_content, // @[src/main/scala/Functions.scala 137:14]
  output [7:0]  io_seg, // @[src/main/scala/Functions.scala 137:14]
  output [3:0]  io_an // @[src/main/scala/Functions.scala 137:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [4:0] decoder_io_in; // @[src/main/scala/Functions.scala 160:23]
  wire [6:0] decoder_io_out; // @[src/main/scala/Functions.scala 160:23]
  reg [16:0] cnt; // @[src/main/scala/Functions.scala 144:20]
  wire  _cnt_T = cnt == 17'h1869f; // @[src/main/scala/Functions.scala 145:18]
  wire [16:0] _cnt_T_2 = cnt + 17'h1; // @[src/main/scala/Functions.scala 145:54]
  reg [1:0] digit; // @[src/main/scala/Functions.scala 148:22]
  wire [1:0] _digit_T_1 = digit + 2'h1; // @[src/main/scala/Functions.scala 149:31]
  wire  _T = 2'h0 == digit; // @[src/main/scala/Functions.scala 153:17]
  wire  _T_1 = 2'h1 == digit; // @[src/main/scala/Functions.scala 153:17]
  wire  _T_2 = 2'h2 == digit; // @[src/main/scala/Functions.scala 153:17]
  wire  _T_3 = 2'h3 == digit; // @[src/main/scala/Functions.scala 153:17]
  wire [4:0] _GEN_1 = 2'h3 == digit ? io_disp_content[19:15] : 5'h0; // @[src/main/scala/Functions.scala 152:14 153:17 157:26]
  wire [4:0] _GEN_2 = 2'h2 == digit ? io_disp_content[14:10] : _GEN_1; // @[src/main/scala/Functions.scala 153:17 156:26]
  wire [4:0] _GEN_3 = 2'h1 == digit ? io_disp_content[9:5] : _GEN_2; // @[src/main/scala/Functions.scala 153:17 155:26]
  wire [3:0] _currentDot_T = 4'h0 >> digit; // @[src/main/scala/Functions.scala 164:27]
  wire  currentDot = _currentDot_T[0]; // @[src/main/scala/Functions.scala 164:27]
  wire [7:0] fullSeg = {currentDot,decoder_io_out}; // @[src/main/scala/Functions.scala 165:28]
  wire [3:0] _GEN_5 = _T_3 ? 4'h8 : 4'h1; // @[src/main/scala/Functions.scala 168:17 172:22 167:27]
  wire [3:0] _GEN_6 = _T_2 ? 4'h4 : _GEN_5; // @[src/main/scala/Functions.scala 168:17 171:22]
  wire [3:0] _GEN_7 = _T_1 ? 4'h2 : _GEN_6; // @[src/main/scala/Functions.scala 168:17 170:22]
  wire [3:0] select = _T ? 4'h1 : _GEN_7; // @[src/main/scala/Functions.scala 168:17 169:22]
  SevenSegDec decoder ( // @[src/main/scala/Functions.scala 160:23]
    .io_in(decoder_io_in),
    .io_out(decoder_io_out)
  );
  assign io_seg = ~fullSeg; // @[src/main/scala/Functions.scala 175:13]
  assign io_an = ~select; // @[src/main/scala/Functions.scala 176:13]
  assign decoder_io_in = 2'h0 == digit ? io_disp_content[4:0] : _GEN_3; // @[src/main/scala/Functions.scala 153:17 154:26]
  always @(posedge clock) begin
    if (reset) begin // @[src/main/scala/Functions.scala 144:20]
      cnt <= 17'h0; // @[src/main/scala/Functions.scala 144:20]
    end else if (cnt == 17'h1869f) begin // @[src/main/scala/Functions.scala 145:13]
      cnt <= 17'h0;
    end else begin
      cnt <= _cnt_T_2;
    end
    if (reset) begin // @[src/main/scala/Functions.scala 148:22]
      digit <= 2'h0; // @[src/main/scala/Functions.scala 148:22]
    end else if (_cnt_T) begin // @[src/main/scala/Functions.scala 149:14]
      digit <= _digit_T_1; // @[src/main/scala/Functions.scala 149:22]
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
  output [31:0] io_turns // @[src/main/scala/Functions.scala 6:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg  aSync_REG; // @[src/main/scala/Functions.scala 11:30]
  reg  aSync; // @[src/main/scala/Functions.scala 11:22]
  reg  bSync_REG; // @[src/main/scala/Functions.scala 12:30]
  reg  bSync; // @[src/main/scala/Functions.scala 12:22]
  reg  aReg; // @[src/main/scala/Functions.scala 13:22]
  wire  rise_A = aSync & ~aReg; // @[src/main/scala/Functions.scala 14:22]
  reg [31:0] turns; // @[src/main/scala/Functions.scala 15:22]
  wire [31:0] _turns_T_2 = $signed(turns) + 32'sh1; // @[src/main/scala/Functions.scala 17:35]
  wire [31:0] _turns_T_5 = $signed(turns) - 32'sh1; // @[src/main/scala/Functions.scala 18:35]
  assign io_turns = turns; // @[src/main/scala/Functions.scala 20:12]
  always @(posedge clock) begin
    aSync_REG <= io_signal_A; // @[src/main/scala/Functions.scala 11:30]
    aSync <= aSync_REG; // @[src/main/scala/Functions.scala 11:22]
    bSync_REG <= io_signal_B; // @[src/main/scala/Functions.scala 12:30]
    bSync <= bSync_REG; // @[src/main/scala/Functions.scala 12:22]
    aReg <= aSync; // @[src/main/scala/Functions.scala 13:22]
    if (reset) begin // @[src/main/scala/Functions.scala 15:22]
      turns <= 32'sh0; // @[src/main/scala/Functions.scala 15:22]
    end else if (rise_A) begin // @[src/main/scala/Functions.scala 16:16]
      if (~bSync) begin // @[src/main/scala/Functions.scala 17:18]
        turns <= _turns_T_2; // @[src/main/scala/Functions.scala 17:26]
      end else begin
        turns <= _turns_T_5; // @[src/main/scala/Functions.scala 18:26]
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
  input   io_btn_in, // @[src/main/scala/Functions.scala 226:14]
  output  io_out // @[src/main/scala/Functions.scala 226:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg  btn_sync_REG; // @[src/main/scala/Functions.scala 231:33]
  reg  btn_sync; // @[src/main/scala/Functions.scala 231:25]
  reg  btnDebReg; // @[src/main/scala/Functions.scala 232:26]
  reg [31:0] cntReg; // @[src/main/scala/Functions.scala 233:23]
  wire  tick = cntReg == 32'h1869f; // @[src/main/scala/Functions.scala 234:21]
  wire [31:0] _cntReg_T_1 = cntReg + 32'h1; // @[src/main/scala/Functions.scala 236:20]
  reg  btnCleanPrev; // @[src/main/scala/Functions.scala 242:29]
  assign io_out = btnDebReg & ~btnCleanPrev; // @[src/main/scala/Functions.scala 243:23]
  always @(posedge clock) begin
    btn_sync_REG <= io_btn_in; // @[src/main/scala/Functions.scala 231:33]
    btn_sync <= btn_sync_REG; // @[src/main/scala/Functions.scala 231:25]
    if (reset) begin // @[src/main/scala/Functions.scala 232:26]
      btnDebReg <= 1'h0; // @[src/main/scala/Functions.scala 232:26]
    end else if (tick) begin // @[src/main/scala/Functions.scala 237:15]
      btnDebReg <= btn_sync; // @[src/main/scala/Functions.scala 239:15]
    end
    if (reset) begin // @[src/main/scala/Functions.scala 233:23]
      cntReg <= 32'h0; // @[src/main/scala/Functions.scala 233:23]
    end else if (tick) begin // @[src/main/scala/Functions.scala 237:15]
      cntReg <= 32'h0; // @[src/main/scala/Functions.scala 238:12]
    end else begin
      cntReg <= _cntReg_T_1; // @[src/main/scala/Functions.scala 236:10]
    end
    btnCleanPrev <= btnDebReg; // @[src/main/scala/Functions.scala 242:29]
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
module SecondDriver(
  input        clock,
  input        reset,
  input        io_uart_rx, // @[src/main/scala/SecondDriver.scala 6:14]
  input        io_photo_sensor_A, // @[src/main/scala/SecondDriver.scala 6:14]
  input        io_photo_sensor_B, // @[src/main/scala/SecondDriver.scala 6:14]
  input        io_over_current_positive, // @[src/main/scala/SecondDriver.scala 6:14]
  input        io_over_current_negative, // @[src/main/scala/SecondDriver.scala 6:14]
  input        io_error_cleared, // @[src/main/scala/SecondDriver.scala 6:14]
  output       io_uart_tx, // @[src/main/scala/SecondDriver.scala 6:14]
  output       io_T1, // @[src/main/scala/SecondDriver.scala 6:14]
  output       io_T2, // @[src/main/scala/SecondDriver.scala 6:14]
  output       io_T3, // @[src/main/scala/SecondDriver.scala 6:14]
  output       io_T4, // @[src/main/scala/SecondDriver.scala 6:14]
  output [7:0] io_seg, // @[src/main/scala/SecondDriver.scala 6:14]
  output [3:0] io_an // @[src/main/scala/SecondDriver.scala 6:14]
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
  reg [63:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
`endif // RANDOMIZE_REG_INIT
  wire  rx_clock; // @[src/main/scala/SecondDriver.scala 25:18]
  wire  rx_reset; // @[src/main/scala/SecondDriver.scala 25:18]
  wire  rx_io_rx; // @[src/main/scala/SecondDriver.scala 25:18]
  wire  rx_io_done; // @[src/main/scala/SecondDriver.scala 25:18]
  wire [7:0] rx_io_data; // @[src/main/scala/SecondDriver.scala 25:18]
  wire  tx_clock; // @[src/main/scala/SecondDriver.scala 26:18]
  wire  tx_reset; // @[src/main/scala/SecondDriver.scala 26:18]
  wire [7:0] tx_io_data; // @[src/main/scala/SecondDriver.scala 26:18]
  wire  tx_io_start; // @[src/main/scala/SecondDriver.scala 26:18]
  wire  tx_io_tx; // @[src/main/scala/SecondDriver.scala 26:18]
  wire  tx_io_busy; // @[src/main/scala/SecondDriver.scala 26:18]
  wire  pwm_signal_clock; // @[src/main/scala/SecondDriver.scala 27:26]
  wire  pwm_signal_reset; // @[src/main/scala/SecondDriver.scala 27:26]
  wire [9:0] pwm_signal_io_duty_cycle; // @[src/main/scala/SecondDriver.scala 27:26]
  wire  pwm_signal_io_brake; // @[src/main/scala/SecondDriver.scala 27:26]
  wire  pwm_signal_io_T1; // @[src/main/scala/SecondDriver.scala 27:26]
  wire  pwm_signal_io_T2; // @[src/main/scala/SecondDriver.scala 27:26]
  wire  pwm_signal_io_T3; // @[src/main/scala/SecondDriver.scala 27:26]
  wire  pwm_signal_io_T4; // @[src/main/scala/SecondDriver.scala 27:26]
  wire  pid_clock; // @[src/main/scala/SecondDriver.scala 28:19]
  wire  pid_reset; // @[src/main/scala/SecondDriver.scala 28:19]
  wire [31:0] pid_io_setPoint; // @[src/main/scala/SecondDriver.scala 28:19]
  wire [31:0] pid_io_measuredVal; // @[src/main/scala/SecondDriver.scala 28:19]
  wire  pid_io_tick; // @[src/main/scala/SecondDriver.scala 28:19]
  wire  pid_io_resetBuffer; // @[src/main/scala/SecondDriver.scala 28:19]
  wire [31:0] pid_io_controlOut; // @[src/main/scala/SecondDriver.scala 28:19]
  wire  stuck_detector_clock; // @[src/main/scala/SecondDriver.scala 29:30]
  wire  stuck_detector_reset; // @[src/main/scala/SecondDriver.scala 29:30]
  wire  stuck_detector_io_external_overcurrent_input; // @[src/main/scala/SecondDriver.scala 29:30]
  wire  stuck_detector_io_clear_shutdown; // @[src/main/scala/SecondDriver.scala 29:30]
  wire  stuck_detector_io_motor_disable; // @[src/main/scala/SecondDriver.scala 29:30]
  wire  display_clock; // @[src/main/scala/SecondDriver.scala 30:23]
  wire  display_reset; // @[src/main/scala/SecondDriver.scala 30:23]
  wire [19:0] display_io_disp_content; // @[src/main/scala/SecondDriver.scala 30:23]
  wire [7:0] display_io_seg; // @[src/main/scala/SecondDriver.scala 30:23]
  wire [3:0] display_io_an; // @[src/main/scala/SecondDriver.scala 30:23]
  wire  rotations_clock; // @[src/main/scala/SecondDriver.scala 31:25]
  wire  rotations_reset; // @[src/main/scala/SecondDriver.scala 31:25]
  wire  rotations_io_signal_A; // @[src/main/scala/SecondDriver.scala 31:25]
  wire  rotations_io_signal_B; // @[src/main/scala/SecondDriver.scala 31:25]
  wire [31:0] rotations_io_turns; // @[src/main/scala/SecondDriver.scala 31:25]
  wire  error_clear_debounce_clock; // @[src/main/scala/SecondDriver.scala 32:36]
  wire  error_clear_debounce_reset; // @[src/main/scala/SecondDriver.scala 32:36]
  wire  error_clear_debounce_io_btn_in; // @[src/main/scala/SecondDriver.scala 32:36]
  wire  error_clear_debounce_io_out; // @[src/main/scala/SecondDriver.scala 32:36]
  reg [13:0] rotations_io_signal_A_cnt; // @[src/main/scala/SecondDriver.scala 36:23]
  reg  rotations_io_signal_A_out; // @[src/main/scala/SecondDriver.scala 37:23]
  wire [13:0] _rotations_io_signal_A_cnt_T_1 = rotations_io_signal_A_cnt + 14'h1; // @[src/main/scala/SecondDriver.scala 39:29]
  reg [13:0] rotations_io_signal_B_cnt; // @[src/main/scala/SecondDriver.scala 36:23]
  reg  rotations_io_signal_B_out; // @[src/main/scala/SecondDriver.scala 37:23]
  wire [13:0] _rotations_io_signal_B_cnt_T_1 = rotations_io_signal_B_cnt + 14'h1; // @[src/main/scala/SecondDriver.scala 39:29]
  reg [16:0] pid_timer; // @[src/main/scala/SecondDriver.scala 50:26]
  wire  pid_tick = pid_timer == 17'h1869f; // @[src/main/scala/SecondDriver.scala 51:29]
  wire [16:0] _pid_timer_T_1 = pid_timer + 17'h1; // @[src/main/scala/SecondDriver.scala 52:75]
  reg [31:0] target_position_cm; // @[src/main/scala/SecondDriver.scala 55:35]
  reg [9:0] manual_speed; // @[src/main/scala/SecondDriver.scala 56:29]
  reg  control_mode; // @[src/main/scala/SecondDriver.scala 57:29]
  reg  manual_brake; // @[src/main/scala/SecondDriver.scala 58:29]
  reg  system_active; // @[src/main/scala/SecondDriver.scala 59:30]
  reg [31:0] initial_offset; // @[src/main/scala/SecondDriver.scala 60:31]
  wire [31:0] current_turns = $signed(rotations_io_turns) - $signed(initial_offset); // @[src/main/scala/SecondDriver.scala 62:42]
  wire [63:0] full_pos_calc = $signed(current_turns) * 32'sh222; // @[src/main/scala/SecondDriver.scala 65:56]
  reg [31:0] current_position_fixed_point; // @[src/main/scala/SecondDriver.scala 66:45]
  wire [19:0] _current_position_cm_T = current_position_fixed_point[31:12]; // @[src/main/scala/SecondDriver.scala 67:78]
  wire [19:0] current_position_cm = system_active ? $signed(_current_position_cm_T) : $signed(20'sh0); // @[src/main/scala/SecondDriver.scala 67:32]
  reg [1:0] uartState; // @[src/main/scala/SecondDriver.scala 70:26]
  reg [7:0] CMDByte; // @[src/main/scala/SecondDriver.scala 71:24]
  reg  target_updated; // @[src/main/scala/SecondDriver.scala 74:31]
  wire  _GEN_7 = pid_tick ? 1'h0 : target_updated; // @[src/main/scala/SecondDriver.scala 75:18 74:31 75:35]
  wire  _T_5 = ~system_active; // @[src/main/scala/SecondDriver.scala 85:18]
  wire [31:0] _GEN_9 = ~system_active ? $signed(rotations_io_turns) : $signed(initial_offset); // @[src/main/scala/SecondDriver.scala 60:31 85:{34,51}]
  wire [7:0] _target_position_cm_T = rx_io_data; // @[src/main/scala/SecondDriver.scala 86:48]
  wire  _T_7 = 8'h0 == rx_io_data; // @[src/main/scala/SecondDriver.scala 95:32]
  wire [9:0] _GEN_10 = 8'h4 == rx_io_data ? 10'hc8 : manual_speed; // @[src/main/scala/SecondDriver.scala 95:32 100:38 56:29]
  wire [9:0] _GEN_12 = 8'h3 == rx_io_data ? 10'h12c : _GEN_10; // @[src/main/scala/SecondDriver.scala 95:32 99:38]
  wire [9:0] _GEN_14 = 8'h2 == rx_io_data ? 10'h320 : _GEN_12; // @[src/main/scala/SecondDriver.scala 95:32 98:38]
  wire [9:0] _GEN_16 = 8'h1 == rx_io_data ? 10'h2bc : _GEN_14; // @[src/main/scala/SecondDriver.scala 95:32 97:38]
  wire [9:0] _GEN_19 = 8'h0 == rx_io_data ? manual_speed : _GEN_16; // @[src/main/scala/SecondDriver.scala 56:29 95:32]
  wire  _GEN_21 = 8'h2 == CMDByte ? 1'h0 : control_mode; // @[src/main/scala/SecondDriver.scala 83:25 93:26 57:29]
  wire  _GEN_22 = 8'h2 == CMDByte ? _T_7 : manual_brake; // @[src/main/scala/SecondDriver.scala 83:25 58:29]
  wire [9:0] _GEN_23 = 8'h2 == CMDByte ? _GEN_19 : manual_speed; // @[src/main/scala/SecondDriver.scala 83:25 56:29]
  wire  _GEN_24 = 8'h2 == CMDByte ? 1'h0 : 8'hff == CMDByte; // @[src/main/scala/SecondDriver.scala 83:25 72:36]
  wire [31:0] _GEN_25 = 8'h1 == CMDByte ? $signed(_GEN_9) : $signed(initial_offset); // @[src/main/scala/SecondDriver.scala 83:25 60:31]
  wire [31:0] _GEN_26 = 8'h1 == CMDByte ? $signed({{24{_target_position_cm_T[7]}},_target_position_cm_T}) : $signed(
    target_position_cm); // @[src/main/scala/SecondDriver.scala 83:25 86:32 55:35]
  wire  _GEN_27 = 8'h1 == CMDByte | system_active; // @[src/main/scala/SecondDriver.scala 83:25 87:27 59:30]
  wire  _GEN_28 = 8'h1 == CMDByte | _GEN_21; // @[src/main/scala/SecondDriver.scala 83:25 88:26]
  wire  _GEN_29 = 8'h1 == CMDByte ? 1'h0 : _GEN_22; // @[src/main/scala/SecondDriver.scala 83:25 89:26]
  wire  _GEN_30 = 8'h1 == CMDByte | _GEN_7; // @[src/main/scala/SecondDriver.scala 83:25 90:28]
  wire [9:0] _GEN_31 = 8'h1 == CMDByte ? manual_speed : _GEN_23; // @[src/main/scala/SecondDriver.scala 83:25 56:29]
  wire  _GEN_32 = 8'h1 == CMDByte ? 1'h0 : _GEN_24; // @[src/main/scala/SecondDriver.scala 83:25 72:36]
  wire [31:0] _GEN_33 = 2'h2 == uartState ? $signed(_GEN_25) : $signed(initial_offset); // @[src/main/scala/SecondDriver.scala 79:23 60:31]
  wire [31:0] _GEN_34 = 2'h2 == uartState ? $signed(_GEN_26) : $signed(target_position_cm); // @[src/main/scala/SecondDriver.scala 79:23 55:35]
  wire  _GEN_35 = 2'h2 == uartState ? _GEN_27 : system_active; // @[src/main/scala/SecondDriver.scala 79:23 59:30]
  wire  _GEN_36 = 2'h2 == uartState ? _GEN_28 : control_mode; // @[src/main/scala/SecondDriver.scala 79:23 57:29]
  wire  _GEN_37 = 2'h2 == uartState ? _GEN_29 : manual_brake; // @[src/main/scala/SecondDriver.scala 79:23 58:29]
  wire  _GEN_38 = 2'h2 == uartState ? _GEN_30 : _GEN_7; // @[src/main/scala/SecondDriver.scala 79:23]
  wire [9:0] _GEN_39 = 2'h2 == uartState ? _GEN_31 : manual_speed; // @[src/main/scala/SecondDriver.scala 79:23 56:29]
  wire [1:0] _GEN_41 = 2'h2 == uartState ? 2'h0 : uartState; // @[src/main/scala/SecondDriver.scala 105:19 79:23 70:26]
  wire  _GEN_47 = 2'h1 == uartState ? control_mode : _GEN_36; // @[src/main/scala/SecondDriver.scala 79:23 57:29]
  wire  _GEN_51 = 2'h1 == uartState ? 1'h0 : 2'h2 == uartState & _GEN_32; // @[src/main/scala/SecondDriver.scala 79:23 72:36]
  wire  _GEN_57 = 2'h0 == uartState ? control_mode : _GEN_47; // @[src/main/scala/SecondDriver.scala 79:23 57:29]
  wire  _GEN_61 = 2'h0 == uartState ? 1'h0 : _GEN_51; // @[src/main/scala/SecondDriver.scala 79:23 72:36]
  wire  _GEN_67 = rx_io_done ? _GEN_57 : control_mode; // @[src/main/scala/SecondDriver.scala 78:21 57:29]
  wire  reset_triggered = rx_io_done & _GEN_61; // @[src/main/scala/SecondDriver.scala 78:21 72:36]
  wire [36:0] _target_turns_T = $signed(target_position_cm) * 5'shf; // @[src/main/scala/SecondDriver.scala 112:50]
  reg [37:0] target_turns; // @[src/main/scala/SecondDriver.scala 112:29]
  wire [37:0] _at_position_T_2 = $signed(target_turns) - 38'sh1; // @[src/main/scala/SecondDriver.scala 113:87]
  wire [37:0] _GEN_103 = {{6{current_turns[31]}},current_turns}; // @[src/main/scala/SecondDriver.scala 113:71]
  wire [37:0] _at_position_T_6 = $signed(target_turns) + 38'sh1; // @[src/main/scala/SecondDriver.scala 113:126]
  wire  _at_position_T_9 = system_active ? $signed(_GEN_103) >= $signed(_at_position_T_2) & $signed(_GEN_103) <=
    $signed(_at_position_T_6) : 1'h1; // @[src/main/scala/SecondDriver.scala 113:40]
  wire  at_position = control_mode & _at_position_T_9; // @[src/main/scala/SecondDriver.scala 113:34]
  wire [31:0] _pid_offset_T = pid_io_controlOut; // @[src/main/scala/SecondDriver.scala 124:46]
  reg [29:0] pid_offset; // @[src/main/scala/SecondDriver.scala 124:27]
  wire [29:0] pid_duty_raw = 30'sh200 + $signed(pid_offset); // @[src/main/scala/SecondDriver.scala 125:28]
  wire [29:0] _pid_duty_T_2 = 30'sh200 + $signed(pid_offset); // @[src/main/scala/SecondDriver.scala 126:119]
  wire [29:0] _pid_duty_T_3 = $signed(pid_duty_raw) < 30'sh0 ? 30'h0 : _pid_duty_T_2; // @[src/main/scala/SecondDriver.scala 126:80]
  wire [29:0] _pid_duty_T_4 = $signed(pid_duty_raw) > 30'sh3ff ? 30'h3ff : _pid_duty_T_3; // @[src/main/scala/SecondDriver.scala 126:45]
  wire [29:0] pid_duty = at_position ? 30'h200 : _pid_duty_T_4; // @[src/main/scala/SecondDriver.scala 126:21]
  wire [29:0] active_duty = control_mode ? pid_duty : {{20'd0}, manual_speed}; // @[src/main/scala/SecondDriver.scala 128:24]
  wire  is_moving_back = active_duty < 30'h200; // @[src/main/scala/SecondDriver.scala 129:36]
  wire  is_moving_fwd = active_duty > 30'h200; // @[src/main/scala/SecondDriver.scala 130:35]
  wire  _block_neg_T_3 = ~at_position; // @[src/main/scala/SecondDriver.scala 132:96]
  wire  block_neg = system_active & $signed(current_position_cm) <= 20'sh0 & is_moving_back & ~at_position; // @[src/main/scala/SecondDriver.scala 132:93]
  wire  block_pos = $signed(current_position_cm) >= 20'sh5a & is_moving_fwd & _block_neg_T_3; // @[src/main/scala/SecondDriver.scala 133:66]
  reg [29:0] pwm_signal_io_duty_cycle_REG; // @[src/main/scala/SecondDriver.scala 135:38]
  wire  motor_stopped = manual_brake | stuck_detector_io_motor_disable | _T_5 | at_position | block_neg | block_pos; // @[src/main/scala/SecondDriver.scala 136:117]
  reg [23:0] txTimer; // @[src/main/scala/SecondDriver.scala 147:24]
  reg [1:0] txState; // @[src/main/scala/SecondDriver.scala 149:24]
  wire  _T_16 = ~tx_io_busy; // @[src/main/scala/SecondDriver.scala 153:24]
  wire [7:0] _GEN_76 = ~tx_io_busy ? 8'hff : 8'h0; // @[src/main/scala/SecondDriver.scala 150:14 153:{37,50}]
  wire [7:0] _GEN_79 = _T_16 ? current_position_cm[15:8] : 8'h0; // @[src/main/scala/SecondDriver.scala 150:14 154:{37,50}]
  wire [1:0] _GEN_81 = _T_16 ? 2'h2 : txState; // @[src/main/scala/SecondDriver.scala 154:119 149:24 154:37]
  wire [23:0] _GEN_82 = _T_16 ? 24'h0 : txTimer; // @[src/main/scala/SecondDriver.scala 154:136 147:24 154:37]
  wire [7:0] _GEN_83 = _T_16 ? current_position_cm[7:0] : 8'h0; // @[src/main/scala/SecondDriver.scala 150:14 155:{36,49}]
  wire [1:0] _GEN_85 = _T_16 ? 2'h0 : txState; // @[src/main/scala/SecondDriver.scala 155:117 149:24 155:36]
  wire [7:0] _GEN_87 = 2'h2 == txState ? _GEN_83 : 8'h0; // @[src/main/scala/SecondDriver.scala 150:14 152:21]
  wire  _GEN_88 = 2'h2 == txState & _T_16; // @[src/main/scala/SecondDriver.scala 152:21 150:34]
  wire [1:0] _GEN_89 = 2'h2 == txState ? _GEN_85 : txState; // @[src/main/scala/SecondDriver.scala 152:21 149:24]
  wire [23:0] _GEN_90 = 2'h2 == txState ? _GEN_82 : txTimer; // @[src/main/scala/SecondDriver.scala 152:21 147:24]
  wire [7:0] _GEN_91 = 2'h1 == txState ? _GEN_79 : _GEN_87; // @[src/main/scala/SecondDriver.scala 152:21]
  wire  _GEN_92 = 2'h1 == txState ? _T_16 : _GEN_88; // @[src/main/scala/SecondDriver.scala 152:21]
  wire [7:0] _GEN_95 = 2'h0 == txState ? _GEN_76 : _GEN_91; // @[src/main/scala/SecondDriver.scala 152:21]
  wire  _GEN_96 = 2'h0 == txState ? _T_16 : _GEN_92; // @[src/main/scala/SecondDriver.scala 152:21]
  wire [23:0] _txTimer_T_1 = txTimer + 24'h1; // @[src/main/scala/SecondDriver.scala 157:36]
  wire [43:0] _GEN_105 = {$signed(target_position_cm), 12'h0}; // @[src/main/scala/SecondDriver.scala 116:19]
  UartRx rx ( // @[src/main/scala/SecondDriver.scala 25:18]
    .clock(rx_clock),
    .reset(rx_reset),
    .io_rx(rx_io_rx),
    .io_done(rx_io_done),
    .io_data(rx_io_data)
  );
  UartTx tx ( // @[src/main/scala/SecondDriver.scala 26:18]
    .clock(tx_clock),
    .reset(tx_reset),
    .io_data(tx_io_data),
    .io_start(tx_io_start),
    .io_tx(tx_io_tx),
    .io_busy(tx_io_busy)
  );
  DCMotorPwm pwm_signal ( // @[src/main/scala/SecondDriver.scala 27:26]
    .clock(pwm_signal_clock),
    .reset(pwm_signal_reset),
    .io_duty_cycle(pwm_signal_io_duty_cycle),
    .io_brake(pwm_signal_io_brake),
    .io_T1(pwm_signal_io_T1),
    .io_T2(pwm_signal_io_T2),
    .io_T3(pwm_signal_io_T3),
    .io_T4(pwm_signal_io_T4)
  );
  PIDController pid ( // @[src/main/scala/SecondDriver.scala 28:19]
    .clock(pid_clock),
    .reset(pid_reset),
    .io_setPoint(pid_io_setPoint),
    .io_measuredVal(pid_io_measuredVal),
    .io_tick(pid_io_tick),
    .io_resetBuffer(pid_io_resetBuffer),
    .io_controlOut(pid_io_controlOut)
  );
  StuckDetector stuck_detector ( // @[src/main/scala/SecondDriver.scala 29:30]
    .clock(stuck_detector_clock),
    .reset(stuck_detector_reset),
    .io_external_overcurrent_input(stuck_detector_io_external_overcurrent_input),
    .io_clear_shutdown(stuck_detector_io_clear_shutdown),
    .io_motor_disable(stuck_detector_io_motor_disable)
  );
  DisplayMultiplexer display ( // @[src/main/scala/SecondDriver.scala 30:23]
    .clock(display_clock),
    .reset(display_reset),
    .io_disp_content(display_io_disp_content),
    .io_seg(display_io_seg),
    .io_an(display_io_an)
  );
  RotationCounter rotations ( // @[src/main/scala/SecondDriver.scala 31:25]
    .clock(rotations_clock),
    .reset(rotations_reset),
    .io_signal_A(rotations_io_signal_A),
    .io_signal_B(rotations_io_signal_B),
    .io_turns(rotations_io_turns)
  );
  Debouncer error_clear_debounce ( // @[src/main/scala/SecondDriver.scala 32:36]
    .clock(error_clear_debounce_clock),
    .reset(error_clear_debounce_reset),
    .io_btn_in(error_clear_debounce_io_btn_in),
    .io_out(error_clear_debounce_io_out)
  );
  assign io_uart_tx = tx_io_tx; // @[src/main/scala/SecondDriver.scala 158:14]
  assign io_T1 = _T_5 ? 1'h0 : pwm_signal_io_T1; // @[src/main/scala/SecondDriver.scala 140:25 141:11 143:11]
  assign io_T2 = _T_5 | pwm_signal_io_T2; // @[src/main/scala/SecondDriver.scala 140:25 141:29 143:38]
  assign io_T3 = _T_5 ? 1'h0 : pwm_signal_io_T3; // @[src/main/scala/SecondDriver.scala 140:25 141:46 143:65]
  assign io_T4 = _T_5 | pwm_signal_io_T4; // @[src/main/scala/SecondDriver.scala 140:25 141:64 143:92]
  assign io_seg = display_io_seg; // @[src/main/scala/SecondDriver.scala 161:34]
  assign io_an = display_io_an; // @[src/main/scala/SecondDriver.scala 161:9]
  assign rx_clock = clock;
  assign rx_reset = reset;
  assign rx_io_rx = io_uart_rx; // @[src/main/scala/SecondDriver.scala 43:12]
  assign tx_clock = clock;
  assign tx_reset = reset;
  assign tx_io_data = txTimer >= 24'h2625a0 ? _GEN_95 : 8'h0; // @[src/main/scala/SecondDriver.scala 150:14 151:30]
  assign tx_io_start = txTimer >= 24'h2625a0 & _GEN_96; // @[src/main/scala/SecondDriver.scala 151:30 150:34]
  assign pwm_signal_clock = clock;
  assign pwm_signal_reset = reset;
  assign pwm_signal_io_duty_cycle = pwm_signal_io_duty_cycle_REG[9:0]; // @[src/main/scala/SecondDriver.scala 135:28]
  assign pwm_signal_io_brake = manual_brake | stuck_detector_io_motor_disable | _T_5 | at_position | block_neg |
    block_pos; // @[src/main/scala/SecondDriver.scala 136:117]
  assign pid_clock = clock;
  assign pid_reset = reset;
  assign pid_io_setPoint = _GEN_105[31:0]; // @[src/main/scala/SecondDriver.scala 116:19]
  assign pid_io_measuredVal = current_position_fixed_point; // @[src/main/scala/SecondDriver.scala 115:22]
  assign pid_io_tick = pid_timer == 17'h1869f; // @[src/main/scala/SecondDriver.scala 51:29]
  assign pid_io_resetBuffer = ~control_mode | manual_brake | _T_5 | at_position | target_updated; // @[src/main/scala/SecondDriver.scala 118:88]
  assign stuck_detector_clock = clock;
  assign stuck_detector_reset = reset;
  assign stuck_detector_io_external_overcurrent_input = io_over_current_positive | io_over_current_negative; // @[src/main/scala/SecondDriver.scala 47:77]
  assign stuck_detector_io_clear_shutdown = error_clear_debounce_io_out | reset_triggered; // @[src/main/scala/SecondDriver.scala 109:68]
  assign display_clock = clock;
  assign display_reset = reset;
  assign display_io_disp_content = motor_stopped ? 20'hdf2f8 : 20'h57797; // @[src/main/scala/SecondDriver.scala 164:33]
  assign rotations_clock = clock;
  assign rotations_reset = reset;
  assign rotations_io_signal_A = rotations_io_signal_A_out; // @[src/main/scala/SecondDriver.scala 44:25]
  assign rotations_io_signal_B = rotations_io_signal_B_out; // @[src/main/scala/SecondDriver.scala 45:25]
  assign error_clear_debounce_clock = clock;
  assign error_clear_debounce_reset = reset;
  assign error_clear_debounce_io_btn_in = io_error_cleared; // @[src/main/scala/SecondDriver.scala 48:34]
  always @(posedge clock) begin
    if (reset) begin // @[src/main/scala/SecondDriver.scala 36:23]
      rotations_io_signal_A_cnt <= 14'h0; // @[src/main/scala/SecondDriver.scala 36:23]
    end else if (io_photo_sensor_A == rotations_io_signal_A_out) begin // @[src/main/scala/SecondDriver.scala 38:24]
      rotations_io_signal_A_cnt <= 14'h0; // @[src/main/scala/SecondDriver.scala 38:30]
    end else begin
      rotations_io_signal_A_cnt <= _rotations_io_signal_A_cnt_T_1; // @[src/main/scala/SecondDriver.scala 39:22]
    end
    if (reset) begin // @[src/main/scala/SecondDriver.scala 37:23]
      rotations_io_signal_A_out <= 1'h0; // @[src/main/scala/SecondDriver.scala 37:23]
    end else if (!(io_photo_sensor_A == rotations_io_signal_A_out)) begin // @[src/main/scala/SecondDriver.scala 38:24]
      if (rotations_io_signal_A_cnt == 14'h64) begin // @[src/main/scala/SecondDriver.scala 39:56]
        rotations_io_signal_A_out <= io_photo_sensor_A; // @[src/main/scala/SecondDriver.scala 39:62]
      end
    end
    if (reset) begin // @[src/main/scala/SecondDriver.scala 36:23]
      rotations_io_signal_B_cnt <= 14'h0; // @[src/main/scala/SecondDriver.scala 36:23]
    end else if (io_photo_sensor_B == rotations_io_signal_B_out) begin // @[src/main/scala/SecondDriver.scala 38:24]
      rotations_io_signal_B_cnt <= 14'h0; // @[src/main/scala/SecondDriver.scala 38:30]
    end else begin
      rotations_io_signal_B_cnt <= _rotations_io_signal_B_cnt_T_1; // @[src/main/scala/SecondDriver.scala 39:22]
    end
    if (reset) begin // @[src/main/scala/SecondDriver.scala 37:23]
      rotations_io_signal_B_out <= 1'h0; // @[src/main/scala/SecondDriver.scala 37:23]
    end else if (!(io_photo_sensor_B == rotations_io_signal_B_out)) begin // @[src/main/scala/SecondDriver.scala 38:24]
      if (rotations_io_signal_B_cnt == 14'h64) begin // @[src/main/scala/SecondDriver.scala 39:56]
        rotations_io_signal_B_out <= io_photo_sensor_B; // @[src/main/scala/SecondDriver.scala 39:62]
      end
    end
    if (reset) begin // @[src/main/scala/SecondDriver.scala 50:26]
      pid_timer <= 17'h0; // @[src/main/scala/SecondDriver.scala 50:26]
    end else if (pid_tick) begin // @[src/main/scala/SecondDriver.scala 52:18]
      pid_timer <= 17'h0; // @[src/main/scala/SecondDriver.scala 52:30]
    end else begin
      pid_timer <= _pid_timer_T_1; // @[src/main/scala/SecondDriver.scala 52:62]
    end
    if (reset) begin // @[src/main/scala/SecondDriver.scala 55:35]
      target_position_cm <= 32'sh0; // @[src/main/scala/SecondDriver.scala 55:35]
    end else if (rx_io_done) begin // @[src/main/scala/SecondDriver.scala 78:21]
      if (!(2'h0 == uartState)) begin // @[src/main/scala/SecondDriver.scala 79:23]
        if (!(2'h1 == uartState)) begin // @[src/main/scala/SecondDriver.scala 79:23]
          target_position_cm <= _GEN_34;
        end
      end
    end
    if (reset) begin // @[src/main/scala/SecondDriver.scala 56:29]
      manual_speed <= 10'h200; // @[src/main/scala/SecondDriver.scala 56:29]
    end else if (rx_io_done) begin // @[src/main/scala/SecondDriver.scala 78:21]
      if (!(2'h0 == uartState)) begin // @[src/main/scala/SecondDriver.scala 79:23]
        if (!(2'h1 == uartState)) begin // @[src/main/scala/SecondDriver.scala 79:23]
          manual_speed <= _GEN_39;
        end
      end
    end
    control_mode <= reset | _GEN_67; // @[src/main/scala/SecondDriver.scala 57:{29,29}]
    if (reset) begin // @[src/main/scala/SecondDriver.scala 58:29]
      manual_brake <= 1'h0; // @[src/main/scala/SecondDriver.scala 58:29]
    end else if (rx_io_done) begin // @[src/main/scala/SecondDriver.scala 78:21]
      if (!(2'h0 == uartState)) begin // @[src/main/scala/SecondDriver.scala 79:23]
        if (!(2'h1 == uartState)) begin // @[src/main/scala/SecondDriver.scala 79:23]
          manual_brake <= _GEN_37;
        end
      end
    end
    if (reset) begin // @[src/main/scala/SecondDriver.scala 59:30]
      system_active <= 1'h0; // @[src/main/scala/SecondDriver.scala 59:30]
    end else if (rx_io_done) begin // @[src/main/scala/SecondDriver.scala 78:21]
      if (!(2'h0 == uartState)) begin // @[src/main/scala/SecondDriver.scala 79:23]
        if (!(2'h1 == uartState)) begin // @[src/main/scala/SecondDriver.scala 79:23]
          system_active <= _GEN_35;
        end
      end
    end
    if (reset) begin // @[src/main/scala/SecondDriver.scala 60:31]
      initial_offset <= 32'sh0; // @[src/main/scala/SecondDriver.scala 60:31]
    end else if (rx_io_done) begin // @[src/main/scala/SecondDriver.scala 78:21]
      if (!(2'h0 == uartState)) begin // @[src/main/scala/SecondDriver.scala 79:23]
        if (!(2'h1 == uartState)) begin // @[src/main/scala/SecondDriver.scala 79:23]
          initial_offset <= _GEN_33;
        end
      end
    end
    current_position_fixed_point <= full_pos_calc[31:0]; // @[src/main/scala/SecondDriver.scala 66:79]
    if (reset) begin // @[src/main/scala/SecondDriver.scala 70:26]
      uartState <= 2'h0; // @[src/main/scala/SecondDriver.scala 70:26]
    end else if (rx_io_done) begin // @[src/main/scala/SecondDriver.scala 78:21]
      if (2'h0 == uartState) begin // @[src/main/scala/SecondDriver.scala 79:23]
        if (rx_io_data == 8'haa) begin // @[src/main/scala/SecondDriver.scala 80:49]
          uartState <= 2'h1; // @[src/main/scala/SecondDriver.scala 80:61]
        end
      end else if (2'h1 == uartState) begin // @[src/main/scala/SecondDriver.scala 79:23]
        uartState <= 2'h2; // @[src/main/scala/SecondDriver.scala 81:51]
      end else begin
        uartState <= _GEN_41;
      end
    end
    if (reset) begin // @[src/main/scala/SecondDriver.scala 71:24]
      CMDByte <= 8'h0; // @[src/main/scala/SecondDriver.scala 71:24]
    end else if (rx_io_done) begin // @[src/main/scala/SecondDriver.scala 78:21]
      if (!(2'h0 == uartState)) begin // @[src/main/scala/SecondDriver.scala 79:23]
        if (2'h1 == uartState) begin // @[src/main/scala/SecondDriver.scala 79:23]
          CMDByte <= rx_io_data; // @[src/main/scala/SecondDriver.scala 81:26]
        end
      end
    end
    if (reset) begin // @[src/main/scala/SecondDriver.scala 74:31]
      target_updated <= 1'h0; // @[src/main/scala/SecondDriver.scala 74:31]
    end else if (rx_io_done) begin // @[src/main/scala/SecondDriver.scala 78:21]
      if (2'h0 == uartState) begin // @[src/main/scala/SecondDriver.scala 79:23]
        target_updated <= _GEN_7;
      end else if (2'h1 == uartState) begin // @[src/main/scala/SecondDriver.scala 79:23]
        target_updated <= _GEN_7;
      end else begin
        target_updated <= _GEN_38;
      end
    end else begin
      target_updated <= _GEN_7;
    end
    target_turns <= $signed(_target_turns_T) / 3'sh2; // @[src/main/scala/SecondDriver.scala 112:58]
    pid_offset <= _pid_offset_T[31:2]; // @[src/main/scala/SecondDriver.scala 124:53]
    if (block_neg | block_pos) begin // @[src/main/scala/SecondDriver.scala 135:42]
      pwm_signal_io_duty_cycle_REG <= 30'h200;
    end else if (control_mode) begin // @[src/main/scala/SecondDriver.scala 128:24]
      if (at_position) begin // @[src/main/scala/SecondDriver.scala 126:21]
        pwm_signal_io_duty_cycle_REG <= 30'h200;
      end else if ($signed(pid_duty_raw) > 30'sh3ff) begin // @[src/main/scala/SecondDriver.scala 126:45]
        pwm_signal_io_duty_cycle_REG <= 30'h3ff;
      end else begin
        pwm_signal_io_duty_cycle_REG <= _pid_duty_T_3;
      end
    end else begin
      pwm_signal_io_duty_cycle_REG <= {{20'd0}, manual_speed};
    end
    if (reset) begin // @[src/main/scala/SecondDriver.scala 147:24]
      txTimer <= 24'h0; // @[src/main/scala/SecondDriver.scala 147:24]
    end else if (txTimer >= 24'h2625a0) begin // @[src/main/scala/SecondDriver.scala 151:30]
      if (!(2'h0 == txState)) begin // @[src/main/scala/SecondDriver.scala 152:21]
        if (2'h1 == txState) begin // @[src/main/scala/SecondDriver.scala 152:21]
          txTimer <= _GEN_82;
        end else begin
          txTimer <= _GEN_90;
        end
      end
    end else begin
      txTimer <= _txTimer_T_1; // @[src/main/scala/SecondDriver.scala 157:25]
    end
    if (reset) begin // @[src/main/scala/SecondDriver.scala 149:24]
      txState <= 2'h0; // @[src/main/scala/SecondDriver.scala 149:24]
    end else if (txTimer >= 24'h2625a0) begin // @[src/main/scala/SecondDriver.scala 151:30]
      if (2'h0 == txState) begin // @[src/main/scala/SecondDriver.scala 152:21]
        if (~tx_io_busy) begin // @[src/main/scala/SecondDriver.scala 153:37]
          txState <= 2'h1; // @[src/main/scala/SecondDriver.scala 153:92]
        end
      end else if (2'h1 == txState) begin // @[src/main/scala/SecondDriver.scala 152:21]
        txState <= _GEN_81;
      end else begin
        txState <= _GEN_89;
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
  manual_speed = _RAND_6[9:0];
  _RAND_7 = {1{`RANDOM}};
  control_mode = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  manual_brake = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  system_active = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  initial_offset = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  current_position_fixed_point = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  uartState = _RAND_12[1:0];
  _RAND_13 = {1{`RANDOM}};
  CMDByte = _RAND_13[7:0];
  _RAND_14 = {1{`RANDOM}};
  target_updated = _RAND_14[0:0];
  _RAND_15 = {2{`RANDOM}};
  target_turns = _RAND_15[37:0];
  _RAND_16 = {1{`RANDOM}};
  pid_offset = _RAND_16[29:0];
  _RAND_17 = {1{`RANDOM}};
  pwm_signal_io_duty_cycle_REG = _RAND_17[29:0];
  _RAND_18 = {1{`RANDOM}};
  txTimer = _RAND_18[23:0];
  _RAND_19 = {1{`RANDOM}};
  txState = _RAND_19[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
