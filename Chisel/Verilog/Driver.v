module UartRx(
  input        clock,
  input        reset,
  input        io_rx, // @[\\src\\main\\scala\\Functions.scala 71:14]
  output       io_done, // @[\\src\\main\\scala\\Functions.scala 71:14]
  output [7:0] io_data // @[\\src\\main\\scala\\Functions.scala 71:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg  rxReg_REG; // @[\\src\\main\\scala\\Functions.scala 78:33]
  reg  rxReg; // @[\\src\\main\\scala\\Functions.scala 78:25]
  reg [7:0] shiftReg; // @[\\src\\main\\scala\\Functions.scala 79:25]
  reg [31:0] cntReg; // @[\\src\\main\\scala\\Functions.scala 80:25]
  reg [3:0] bitsReg; // @[\\src\\main\\scala\\Functions.scala 81:25]
  reg [1:0] stateReg; // @[\\src\\main\\scala\\Functions.scala 83:25]
  wire [31:0] _cntReg_T_1 = cntReg + 32'h1; // @[\\src\\main\\scala\\Functions.scala 88:127]
  wire [9:0] _T_6 = 10'h364 - 10'h1; // @[\\src\\main\\scala\\Functions.scala 89:41]
  wire [31:0] _GEN_32 = {{22'd0}, _T_6}; // @[\\src\\main\\scala\\Functions.scala 89:29]
  wire  _T_7 = cntReg == _GEN_32; // @[\\src\\main\\scala\\Functions.scala 89:29]
  wire [7:0] _shiftReg_T_1 = {rxReg,shiftReg[7:1]}; // @[\\src\\main\\scala\\Functions.scala 89:80]
  wire [3:0] _bitsReg_T_1 = bitsReg + 4'h1; // @[\\src\\main\\scala\\Functions.scala 89:180]
  wire [1:0] _GEN_5 = bitsReg == 4'h7 ? 2'h3 : stateReg; // @[\\src\\main\\scala\\Functions.scala 89:{127,138} 83:25]
  wire [3:0] _GEN_6 = bitsReg == 4'h7 ? bitsReg : _bitsReg_T_1; // @[\\src\\main\\scala\\Functions.scala 89:127 81:25 89:169]
  wire [31:0] _GEN_7 = cntReg == _GEN_32 ? 32'h0 : _cntReg_T_1; // @[\\src\\main\\scala\\Functions.scala 89:{209,48,57}]
  wire [7:0] _GEN_8 = cntReg == _GEN_32 ? _shiftReg_T_1 : shiftReg; // @[\\src\\main\\scala\\Functions.scala 79:25 89:{48,74}]
  wire [1:0] _GEN_9 = cntReg == _GEN_32 ? _GEN_5 : stateReg; // @[\\src\\main\\scala\\Functions.scala 83:25 89:48]
  wire [3:0] _GEN_10 = cntReg == _GEN_32 ? _GEN_6 : bitsReg; // @[\\src\\main\\scala\\Functions.scala 81:25 89:48]
  wire [1:0] _GEN_11 = _T_7 ? 2'h0 : stateReg; // @[\\src\\main\\scala\\Functions.scala 83:25 90:{48,59}]
  wire [31:0] _GEN_13 = _T_7 ? cntReg : _cntReg_T_1; // @[\\src\\main\\scala\\Functions.scala 80:25 90:{108,48}]
  wire [1:0] _GEN_14 = 2'h3 == stateReg ? _GEN_11 : stateReg; // @[\\src\\main\\scala\\Functions.scala 86:20 83:25]
  wire [31:0] _GEN_16 = 2'h3 == stateReg ? _GEN_13 : cntReg; // @[\\src\\main\\scala\\Functions.scala 86:20 80:25]
  wire  _GEN_21 = 2'h2 == stateReg ? 1'h0 : 2'h3 == stateReg & _T_7; // @[\\src\\main\\scala\\Functions.scala 84:11 86:20]
  wire  _GEN_26 = 2'h1 == stateReg ? 1'h0 : _GEN_21; // @[\\src\\main\\scala\\Functions.scala 84:11 86:20]
  assign io_done = 2'h0 == stateReg ? 1'h0 : _GEN_26; // @[\\src\\main\\scala\\Functions.scala 84:11 86:20]
  assign io_data = shiftReg; // @[\\src\\main\\scala\\Functions.scala 85:11]
  always @(posedge clock) begin
    rxReg_REG <= io_rx; // @[\\src\\main\\scala\\Functions.scala 78:33]
    rxReg <= rxReg_REG; // @[\\src\\main\\scala\\Functions.scala 78:25]
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 79:25]
      shiftReg <= 8'h0; // @[\\src\\main\\scala\\Functions.scala 79:25]
    end else if (!(2'h0 == stateReg)) begin // @[\\src\\main\\scala\\Functions.scala 86:20]
      if (!(2'h1 == stateReg)) begin // @[\\src\\main\\scala\\Functions.scala 86:20]
        if (2'h2 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 86:20]
          shiftReg <= _GEN_8;
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 80:25]
      cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 80:25]
    end else if (2'h0 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 86:20]
      if (~rxReg) begin // @[\\src\\main\\scala\\Functions.scala 87:30]
        cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 87:59]
      end
    end else if (2'h1 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 86:20]
      if (cntReg == 32'h1b2) begin // @[\\src\\main\\scala\\Functions.scala 88:45]
        cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 88:73]
      end else begin
        cntReg <= _cntReg_T_1; // @[\\src\\main\\scala\\Functions.scala 88:117]
      end
    end else if (2'h2 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 86:20]
      cntReg <= _GEN_7;
    end else begin
      cntReg <= _GEN_16;
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 81:25]
      bitsReg <= 4'h0; // @[\\src\\main\\scala\\Functions.scala 81:25]
    end else if (!(2'h0 == stateReg)) begin // @[\\src\\main\\scala\\Functions.scala 86:20]
      if (2'h1 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 86:20]
        if (cntReg == 32'h1b2) begin // @[\\src\\main\\scala\\Functions.scala 88:45]
          bitsReg <= 4'h0; // @[\\src\\main\\scala\\Functions.scala 88:89]
        end
      end else if (2'h2 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 86:20]
        bitsReg <= _GEN_10;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 83:25]
      stateReg <= 2'h0; // @[\\src\\main\\scala\\Functions.scala 83:25]
    end else if (2'h0 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 86:20]
      if (~rxReg) begin // @[\\src\\main\\scala\\Functions.scala 87:30]
        stateReg <= 2'h1; // @[\\src\\main\\scala\\Functions.scala 87:41]
      end
    end else if (2'h1 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 86:20]
      if (cntReg == 32'h1b2) begin // @[\\src\\main\\scala\\Functions.scala 88:45]
        stateReg <= 2'h2; // @[\\src\\main\\scala\\Functions.scala 88:56]
      end
    end else if (2'h2 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 86:20]
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
  input  [7:0] io_data, // @[\\src\\main\\scala\\Functions.scala 95:14]
  input        io_start, // @[\\src\\main\\scala\\Functions.scala 95:14]
  output       io_tx, // @[\\src\\main\\scala\\Functions.scala 95:14]
  output       io_busy // @[\\src\\main\\scala\\Functions.scala 95:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [9:0] reg_; // @[\\src\\main\\scala\\Functions.scala 102:20]
  reg [31:0] cnt; // @[\\src\\main\\scala\\Functions.scala 103:20]
  reg [3:0] bits; // @[\\src\\main\\scala\\Functions.scala 104:21]
  reg  state; // @[\\src\\main\\scala\\Functions.scala 106:22]
  wire [9:0] _reg_T = {1'h1,io_data,1'h0}; // @[\\src\\main\\scala\\Functions.scala 110:44]
  wire  _GEN_3 = io_start | state; // @[\\src\\main\\scala\\Functions.scala 106:22 110:{32,96}]
  wire [9:0] _T_3 = 10'h364 - 10'h1; // @[\\src\\main\\scala\\Functions.scala 111:38]
  wire [31:0] _GEN_18 = {{22'd0}, _T_3}; // @[\\src\\main\\scala\\Functions.scala 111:26]
  wire [9:0] _reg_T_2 = {1'h1,reg_[9:1]}; // @[\\src\\main\\scala\\Functions.scala 111:69]
  wire [3:0] _bits_T_1 = bits + 4'h1; // @[\\src\\main\\scala\\Functions.scala 111:150]
  wire  _GEN_4 = bits == 4'h9 ? 1'h0 : state; // @[\\src\\main\\scala\\Functions.scala 111:{106,114} 106:22]
  wire [3:0] _GEN_5 = bits == 4'h9 ? bits : _bits_T_1; // @[\\src\\main\\scala\\Functions.scala 111:106 104:21 111:142]
  wire [31:0] _cnt_T_1 = cnt + 32'h1; // @[\\src\\main\\scala\\Functions.scala 111:183]
  assign io_tx = reg_[0]; // @[\\src\\main\\scala\\Functions.scala 107:15]
  assign io_busy = state; // @[\\src\\main\\scala\\Functions.scala 108:20]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 102:20]
      reg_ <= 10'h1; // @[\\src\\main\\scala\\Functions.scala 102:20]
    end else if (~state) begin // @[\\src\\main\\scala\\Functions.scala 109:17]
      if (io_start) begin // @[\\src\\main\\scala\\Functions.scala 110:32]
        reg_ <= _reg_T; // @[\\src\\main\\scala\\Functions.scala 110:38]
      end
    end else if (state) begin // @[\\src\\main\\scala\\Functions.scala 109:17]
      if (cnt == _GEN_18) begin // @[\\src\\main\\scala\\Functions.scala 111:45]
        reg_ <= _reg_T_2; // @[\\src\\main\\scala\\Functions.scala 111:63]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 103:20]
      cnt <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 103:20]
    end else if (~state) begin // @[\\src\\main\\scala\\Functions.scala 109:17]
      if (io_start) begin // @[\\src\\main\\scala\\Functions.scala 110:32]
        cnt <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 110:82]
      end
    end else if (state) begin // @[\\src\\main\\scala\\Functions.scala 109:17]
      if (cnt == _GEN_18) begin // @[\\src\\main\\scala\\Functions.scala 111:45]
        cnt <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 111:51]
      end else begin
        cnt <= _cnt_T_1; // @[\\src\\main\\scala\\Functions.scala 111:176]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 104:21]
      bits <= 4'h0; // @[\\src\\main\\scala\\Functions.scala 104:21]
    end else if (~state) begin // @[\\src\\main\\scala\\Functions.scala 109:17]
      if (io_start) begin // @[\\src\\main\\scala\\Functions.scala 110:32]
        bits <= 4'h0; // @[\\src\\main\\scala\\Functions.scala 110:70]
      end
    end else if (state) begin // @[\\src\\main\\scala\\Functions.scala 109:17]
      if (cnt == _GEN_18) begin // @[\\src\\main\\scala\\Functions.scala 111:45]
        bits <= _GEN_5;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 106:22]
      state <= 1'h0; // @[\\src\\main\\scala\\Functions.scala 106:22]
    end else if (~state) begin // @[\\src\\main\\scala\\Functions.scala 109:17]
      state <= _GEN_3;
    end else if (state) begin // @[\\src\\main\\scala\\Functions.scala 109:17]
      if (cnt == _GEN_18) begin // @[\\src\\main\\scala\\Functions.scala 111:45]
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
  input  [9:0] io_duty_cycle, // @[\\src\\main\\scala\\Functions.scala 24:14]
  input        io_brake, // @[\\src\\main\\scala\\Functions.scala 24:14]
  output       io_T1, // @[\\src\\main\\scala\\Functions.scala 24:14]
  output       io_T2, // @[\\src\\main\\scala\\Functions.scala 24:14]
  output       io_T3, // @[\\src\\main\\scala\\Functions.scala 24:14]
  output       io_T4 // @[\\src\\main\\scala\\Functions.scala 24:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] pwmCounter; // @[\\src\\main\\scala\\Functions.scala 35:29]
  wire [11:0] _T_1 = 12'hd05 - 12'h1; // @[\\src\\main\\scala\\Functions.scala 37:35]
  wire [31:0] _GEN_5 = {{20'd0}, _T_1}; // @[\\src\\main\\scala\\Functions.scala 37:19]
  wire [31:0] _pwmCounter_T_1 = pwmCounter + 32'h1; // @[\\src\\main\\scala\\Functions.scala 40:30]
  wire [21:0] _threshold_T = io_duty_cycle * 12'hd05; // @[\\src\\main\\scala\\Functions.scala 43:34]
  wire [11:0] threshold = _threshold_T[21:10]; // @[\\src\\main\\scala\\Functions.scala 43:50]
  wire [31:0] _GEN_6 = {{20'd0}, threshold}; // @[\\src\\main\\scala\\Functions.scala 44:30]
  wire  pwmSignal = pwmCounter < _GEN_6; // @[\\src\\main\\scala\\Functions.scala 44:30]
  wire  _conduct_T4_T = ~pwmSignal; // @[\\src\\main\\scala\\Functions.scala 59:19]
  wire  conduct_T2 = io_brake ? 1'h0 : pwmSignal; // @[\\src\\main\\scala\\Functions.scala 51:18 53:16 57:16]
  wire  conduct_T4 = io_brake ? 1'h0 : ~pwmSignal; // @[\\src\\main\\scala\\Functions.scala 51:18 55:16 59:16]
  assign io_T1 = io_brake | _conduct_T4_T; // @[\\src\\main\\scala\\Functions.scala 51:18 52:16 60:16]
  assign io_T2 = ~conduct_T2; // @[\\src\\main\\scala\\Functions.scala 65:12]
  assign io_T3 = io_brake | pwmSignal; // @[\\src\\main\\scala\\Functions.scala 51:18 54:16 58:16]
  assign io_T4 = ~conduct_T4; // @[\\src\\main\\scala\\Functions.scala 66:12]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 35:29]
      pwmCounter <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 35:29]
    end else if (pwmCounter >= _GEN_5) begin // @[\\src\\main\\scala\\Functions.scala 37:42]
      pwmCounter <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 38:16]
    end else begin
      pwmCounter <= _pwmCounter_T_1; // @[\\src\\main\\scala\\Functions.scala 40:16]
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
  input  [31:0] io_setPoint, // @[\\src\\main\\scala\\Functions.scala 273:14]
  input  [31:0] io_measuredVal, // @[\\src\\main\\scala\\Functions.scala 273:14]
  input         io_tick, // @[\\src\\main\\scala\\Functions.scala 273:14]
  input         io_resetBuffer, // @[\\src\\main\\scala\\Functions.scala 273:14]
  output [31:0] io_controlOut // @[\\src\\main\\scala\\Functions.scala 273:14]
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
  reg [31:0] integralReg; // @[\\src\\main\\scala\\Functions.scala 284:29]
  reg [31:0] prevErrorReg; // @[\\src\\main\\scala\\Functions.scala 285:29]
  reg [31:0] outputReg; // @[\\src\\main\\scala\\Functions.scala 286:29]
  reg  tick_s2; // @[\\src\\main\\scala\\Functions.scala 291:24]
  reg  tick_s3; // @[\\src\\main\\scala\\Functions.scala 292:24]
  wire [31:0] error = $signed(io_setPoint) - $signed(io_measuredVal); // @[\\src\\main\\scala\\Functions.scala 294:27]
  wire [63:0] _pTerm_s1_T = 32'sh99a * $signed(error); // @[\\src\\main\\scala\\Functions.scala 295:34]
  reg [63:0] pTerm_s1; // @[\\src\\main\\scala\\Functions.scala 295:27]
  wire [63:0] _iInc_s1_T = 32'sh1 * $signed(error); // @[\\src\\main\\scala\\Functions.scala 296:34]
  reg [63:0] iInc_s1; // @[\\src\\main\\scala\\Functions.scala 296:27]
  wire [31:0] _dDiff_s1_T_2 = $signed(error) - $signed(prevErrorReg); // @[\\src\\main\\scala\\Functions.scala 297:34]
  reg [31:0] dDiff_s1; // @[\\src\\main\\scala\\Functions.scala 297:27]
  wire [43:0] _GEN_15 = {$signed(integralReg), 12'h0}; // @[\\src\\main\\scala\\Functions.scala 299:41]
  wire [63:0] _GEN_16 = {{20{_GEN_15[43]}},_GEN_15}; // @[\\src\\main\\scala\\Functions.scala 299:41]
  wire [63:0] _iSum_s2_T_2 = $signed(_GEN_16) + $signed(iInc_s1); // @[\\src\\main\\scala\\Functions.scala 299:41]
  reg [63:0] iSum_s2; // @[\\src\\main\\scala\\Functions.scala 299:28]
  reg [63:0] pTerm_s2; // @[\\src\\main\\scala\\Functions.scala 300:28]
  wire [63:0] _dTerm_s2_T = 32'shc8000 * $signed(dDiff_s1); // @[\\src\\main\\scala\\Functions.scala 301:35]
  reg [63:0] dTerm_s2; // @[\\src\\main\\scala\\Functions.scala 301:28]
  reg [31:0] error_s2; // @[\\src\\main\\scala\\Functions.scala 302:28]
  wire [63:0] _iClamped_s3_T_2 = $signed(iSum_s2) < -64'sh800000 ? $signed(-64'sh800000) : $signed(iSum_s2); // @[\\src\\main\\scala\\Functions.scala 304:60]
  wire [63:0] iClamped_s3 = $signed(iSum_s2) > 64'sh800000 ? $signed(64'sh800000) : $signed(_iClamped_s3_T_2); // @[\\src\\main\\scala\\Functions.scala 304:24]
  wire [63:0] _rawOutput_s3_T_2 = $signed(pTerm_s2) + $signed(iClamped_s3); // @[\\src\\main\\scala\\Functions.scala 305:31]
  wire [63:0] rawOutput_s3 = $signed(_rawOutput_s3_T_2) + $signed(dTerm_s2); // @[\\src\\main\\scala\\Functions.scala 305:45]
  reg  tick_s4; // @[\\src\\main\\scala\\Functions.scala 307:24]
  reg [63:0] sum_s3; // @[\\src\\main\\scala\\Functions.scala 308:25]
  wire [63:0] _outputReg_T_2 = $signed(sum_s3) < -64'sh800000 ? $signed(-64'sh800000) : $signed(sum_s3); // @[\\src\\main\\scala\\Functions.scala 318:59]
  wire [63:0] _outputReg_T_3 = $signed(sum_s3) > 64'sh800000 ? $signed(64'sh800000) : $signed(_outputReg_T_2); // @[\\src\\main\\scala\\Functions.scala 318:24]
  wire [43:0] _GEN_17 = {$signed(outputReg), 12'h0}; // @[\\src\\main\\scala\\Functions.scala 317:24 318:18 286:29]
  wire [63:0] _GEN_8 = tick_s4 ? $signed(_outputReg_T_3) : $signed({{20{_GEN_17[43]}},_GEN_17}); // @[\\src\\main\\scala\\Functions.scala 317:24 318:18 286:29]
  wire [63:0] _GEN_9 = tick_s3 ? $signed(iClamped_s3) : $signed({{20{_GEN_15[43]}},_GEN_15}); // @[\\src\\main\\scala\\Functions.scala 314:24 315:18 284:29]
  wire [63:0] _GEN_11 = tick_s3 ? $signed({{20{_GEN_17[43]}},_GEN_17}) : $signed(_GEN_8); // @[\\src\\main\\scala\\Functions.scala 314:24 286:29]
  wire [63:0] _GEN_12 = io_resetBuffer ? $signed(64'sh0) : $signed(_GEN_9); // @[\\src\\main\\scala\\Functions.scala 310:24 311:18]
  wire [63:0] _GEN_14 = io_resetBuffer ? $signed(64'sh0) : $signed(_GEN_11); // @[\\src\\main\\scala\\Functions.scala 310:24 313:18]
  wire [51:0] _GEN_20 = reset ? $signed(52'sh0) : $signed(_GEN_12[63:12]); // @[\\src\\main\\scala\\Functions.scala 284:{29,29}]
  wire [51:0] _GEN_22 = reset ? $signed(52'sh0) : $signed(_GEN_14[63:12]); // @[\\src\\main\\scala\\Functions.scala 286:{29,29}]
  assign io_controlOut = outputReg; // @[\\src\\main\\scala\\Functions.scala 320:17]
  always @(posedge clock) begin
    integralReg <= _GEN_20[31:0]; // @[\\src\\main\\scala\\Functions.scala 284:{29,29}]
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 285:29]
      prevErrorReg <= 32'sh0; // @[\\src\\main\\scala\\Functions.scala 285:29]
    end else if (io_resetBuffer) begin // @[\\src\\main\\scala\\Functions.scala 310:24]
      prevErrorReg <= 32'sh0; // @[\\src\\main\\scala\\Functions.scala 312:18]
    end else if (tick_s3) begin // @[\\src\\main\\scala\\Functions.scala 314:24]
      prevErrorReg <= error_s2; // @[\\src\\main\\scala\\Functions.scala 316:18]
    end
    outputReg <= _GEN_22[31:0]; // @[\\src\\main\\scala\\Functions.scala 286:{29,29}]
    tick_s2 <= io_tick; // @[\\src\\main\\scala\\Functions.scala 291:24]
    tick_s3 <= tick_s2; // @[\\src\\main\\scala\\Functions.scala 292:24]
    if (io_tick) begin // @[\\src\\main\\scala\\Functions.scala 295:27]
      pTerm_s1 <= _pTerm_s1_T; // @[\\src\\main\\scala\\Functions.scala 295:27]
    end
    if (io_tick) begin // @[\\src\\main\\scala\\Functions.scala 296:27]
      iInc_s1 <= _iInc_s1_T; // @[\\src\\main\\scala\\Functions.scala 296:27]
    end
    if (io_tick) begin // @[\\src\\main\\scala\\Functions.scala 297:27]
      dDiff_s1 <= _dDiff_s1_T_2; // @[\\src\\main\\scala\\Functions.scala 297:27]
    end
    if (tick_s2) begin // @[\\src\\main\\scala\\Functions.scala 299:28]
      iSum_s2 <= _iSum_s2_T_2; // @[\\src\\main\\scala\\Functions.scala 299:28]
    end
    if (tick_s2) begin // @[\\src\\main\\scala\\Functions.scala 300:28]
      pTerm_s2 <= pTerm_s1; // @[\\src\\main\\scala\\Functions.scala 300:28]
    end
    if (tick_s2) begin // @[\\src\\main\\scala\\Functions.scala 301:28]
      dTerm_s2 <= _dTerm_s2_T; // @[\\src\\main\\scala\\Functions.scala 301:28]
    end
    if (tick_s2) begin // @[\\src\\main\\scala\\Functions.scala 302:28]
      error_s2 <= error; // @[\\src\\main\\scala\\Functions.scala 302:28]
    end
    tick_s4 <= tick_s3; // @[\\src\\main\\scala\\Functions.scala 307:24]
    if (tick_s3) begin // @[\\src\\main\\scala\\Functions.scala 308:25]
      sum_s3 <= rawOutput_s3; // @[\\src\\main\\scala\\Functions.scala 308:25]
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
  input   io_external_overcurrent_input, // @[\\src\\main\\scala\\Functions.scala 116:14]
  input   io_clear_shutdown, // @[\\src\\main\\scala\\Functions.scala 116:14]
  output  io_motor_disable // @[\\src\\main\\scala\\Functions.scala 116:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [22:0] maxCycles = 17'h186a0 * 6'h32; // @[\\src\\main\\scala\\Functions.scala 122:44]
  reg [31:0] durationReg; // @[\\src\\main\\scala\\Functions.scala 123:28]
  reg  isStuckReg; // @[\\src\\main\\scala\\Functions.scala 124:28]
  wire [31:0] _GEN_8 = {{9'd0}, maxCycles}; // @[\\src\\main\\scala\\Functions.scala 128:26]
  wire [31:0] _durationReg_T_1 = durationReg + 32'h1; // @[\\src\\main\\scala\\Functions.scala 128:104]
  wire  _GEN_0 = durationReg >= _GEN_8 | isStuckReg; // @[\\src\\main\\scala\\Functions.scala 124:28 128:{40,53}]
  wire [31:0] _GEN_1 = durationReg >= _GEN_8 ? durationReg : _durationReg_T_1; // @[\\src\\main\\scala\\Functions.scala 123:28 128:{40,89}]
  assign io_motor_disable = isStuckReg; // @[\\src\\main\\scala\\Functions.scala 132:20]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 123:28]
      durationReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 123:28]
    end else if (io_clear_shutdown) begin // @[\\src\\main\\scala\\Functions.scala 125:27]
      durationReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 125:64]
    end else if (~isStuckReg) begin // @[\\src\\main\\scala\\Functions.scala 126:23]
      if (io_external_overcurrent_input) begin // @[\\src\\main\\scala\\Functions.scala 127:43]
        durationReg <= _GEN_1;
      end else begin
        durationReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 129:33]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 124:28]
      isStuckReg <= 1'h0; // @[\\src\\main\\scala\\Functions.scala 124:28]
    end else if (io_clear_shutdown) begin // @[\\src\\main\\scala\\Functions.scala 125:27]
      isStuckReg <= 1'h0; // @[\\src\\main\\scala\\Functions.scala 125:40]
    end else if (~isStuckReg) begin // @[\\src\\main\\scala\\Functions.scala 126:23]
      if (io_external_overcurrent_input) begin // @[\\src\\main\\scala\\Functions.scala 127:43]
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
  input  [4:0] io_in, // @[\\src\\main\\scala\\Functions.scala 184:14]
  output [6:0] io_out // @[\\src\\main\\scala\\Functions.scala 184:14]
);
  wire [6:0] _io_out_T_33 = 5'h0 == io_in ? 7'h3f : 7'h0; // @[\\src\\main\\scala\\Functions.scala 189:46]
  wire [6:0] _io_out_T_35 = 5'h1 == io_in ? 7'h6 : _io_out_T_33; // @[\\src\\main\\scala\\Functions.scala 189:46]
  wire [6:0] _io_out_T_37 = 5'h2 == io_in ? 7'h5b : _io_out_T_35; // @[\\src\\main\\scala\\Functions.scala 189:46]
  wire [6:0] _io_out_T_39 = 5'h3 == io_in ? 7'h4f : _io_out_T_37; // @[\\src\\main\\scala\\Functions.scala 189:46]
  wire [6:0] _io_out_T_41 = 5'h4 == io_in ? 7'h66 : _io_out_T_39; // @[\\src\\main\\scala\\Functions.scala 189:46]
  wire [6:0] _io_out_T_43 = 5'h5 == io_in ? 7'h6d : _io_out_T_41; // @[\\src\\main\\scala\\Functions.scala 189:46]
  wire [6:0] _io_out_T_45 = 5'h6 == io_in ? 7'h7d : _io_out_T_43; // @[\\src\\main\\scala\\Functions.scala 189:46]
  wire [6:0] _io_out_T_47 = 5'h7 == io_in ? 7'h7 : _io_out_T_45; // @[\\src\\main\\scala\\Functions.scala 189:46]
  wire [6:0] _io_out_T_49 = 5'h8 == io_in ? 7'h7f : _io_out_T_47; // @[\\src\\main\\scala\\Functions.scala 189:46]
  wire [6:0] _io_out_T_51 = 5'h9 == io_in ? 7'h6f : _io_out_T_49; // @[\\src\\main\\scala\\Functions.scala 189:46]
  wire [6:0] _io_out_T_53 = 5'ha == io_in ? 7'h77 : _io_out_T_51; // @[\\src\\main\\scala\\Functions.scala 189:46]
  wire [6:0] _io_out_T_55 = 5'hb == io_in ? 7'h7c : _io_out_T_53; // @[\\src\\main\\scala\\Functions.scala 189:46]
  wire [6:0] _io_out_T_57 = 5'hc == io_in ? 7'h39 : _io_out_T_55; // @[\\src\\main\\scala\\Functions.scala 189:46]
  wire [6:0] _io_out_T_59 = 5'hd == io_in ? 7'h5e : _io_out_T_57; // @[\\src\\main\\scala\\Functions.scala 189:46]
  wire [6:0] _io_out_T_61 = 5'he == io_in ? 7'h79 : _io_out_T_59; // @[\\src\\main\\scala\\Functions.scala 189:46]
  wire [6:0] _io_out_T_63 = 5'hf == io_in ? 7'h71 : _io_out_T_61; // @[\\src\\main\\scala\\Functions.scala 189:46]
  wire [6:0] _io_out_T_65 = 5'h10 == io_in ? 7'h3c : _io_out_T_63; // @[\\src\\main\\scala\\Functions.scala 189:46]
  wire [6:0] _io_out_T_67 = 5'h11 == io_in ? 7'h76 : _io_out_T_65; // @[\\src\\main\\scala\\Functions.scala 189:46]
  wire [6:0] _io_out_T_69 = 5'h12 == io_in ? 7'h6 : _io_out_T_67; // @[\\src\\main\\scala\\Functions.scala 189:46]
  wire [6:0] _io_out_T_71 = 5'h13 == io_in ? 7'hf : _io_out_T_69; // @[\\src\\main\\scala\\Functions.scala 189:46]
  wire [6:0] _io_out_T_73 = 5'h14 == io_in ? 7'h38 : _io_out_T_71; // @[\\src\\main\\scala\\Functions.scala 189:46]
  wire [6:0] _io_out_T_75 = 5'h15 == io_in ? 7'h38 : _io_out_T_73; // @[\\src\\main\\scala\\Functions.scala 189:46]
  wire [6:0] _io_out_T_77 = 5'h16 == io_in ? 7'h70 : _io_out_T_75; // @[\\src\\main\\scala\\Functions.scala 189:46]
  wire [6:0] _io_out_T_79 = 5'h17 == io_in ? 7'h3f : _io_out_T_77; // @[\\src\\main\\scala\\Functions.scala 189:46]
  wire [6:0] _io_out_T_81 = 5'h18 == io_in ? 7'h73 : _io_out_T_79; // @[\\src\\main\\scala\\Functions.scala 189:46]
  wire [6:0] _io_out_T_83 = 5'h19 == io_in ? 7'h67 : _io_out_T_81; // @[\\src\\main\\scala\\Functions.scala 189:46]
  wire [6:0] _io_out_T_85 = 5'h1a == io_in ? 7'h31 : _io_out_T_83; // @[\\src\\main\\scala\\Functions.scala 189:46]
  wire [6:0] _io_out_T_87 = 5'h1b == io_in ? 7'h6d : _io_out_T_85; // @[\\src\\main\\scala\\Functions.scala 189:46]
  wire [6:0] _io_out_T_89 = 5'h1c == io_in ? 7'h78 : _io_out_T_87; // @[\\src\\main\\scala\\Functions.scala 189:46]
  wire [6:0] _io_out_T_91 = 5'h1d == io_in ? 7'h3e : _io_out_T_89; // @[\\src\\main\\scala\\Functions.scala 189:46]
  assign io_out = 5'h1e == io_in ? 7'h0 : _io_out_T_91; // @[\\src\\main\\scala\\Functions.scala 189:46]
endmodule
module DisplayMultiplexer(
  input         clock,
  input         reset,
  input  [19:0] io_disp_content, // @[\\src\\main\\scala\\Functions.scala 136:14]
  output [7:0]  io_seg, // @[\\src\\main\\scala\\Functions.scala 136:14]
  output [3:0]  io_an // @[\\src\\main\\scala\\Functions.scala 136:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [4:0] decoder_io_in; // @[\\src\\main\\scala\\Functions.scala 159:23]
  wire [6:0] decoder_io_out; // @[\\src\\main\\scala\\Functions.scala 159:23]
  reg [16:0] cnt; // @[\\src\\main\\scala\\Functions.scala 143:20]
  wire  _cnt_T = cnt == 17'h1869f; // @[\\src\\main\\scala\\Functions.scala 144:18]
  wire [16:0] _cnt_T_2 = cnt + 17'h1; // @[\\src\\main\\scala\\Functions.scala 144:54]
  reg [1:0] digit; // @[\\src\\main\\scala\\Functions.scala 147:22]
  wire [1:0] _digit_T_1 = digit + 2'h1; // @[\\src\\main\\scala\\Functions.scala 148:31]
  wire  _T = 2'h0 == digit; // @[\\src\\main\\scala\\Functions.scala 152:17]
  wire  _T_1 = 2'h1 == digit; // @[\\src\\main\\scala\\Functions.scala 152:17]
  wire  _T_2 = 2'h2 == digit; // @[\\src\\main\\scala\\Functions.scala 152:17]
  wire  _T_3 = 2'h3 == digit; // @[\\src\\main\\scala\\Functions.scala 152:17]
  wire [4:0] _GEN_1 = 2'h3 == digit ? io_disp_content[19:15] : 5'h0; // @[\\src\\main\\scala\\Functions.scala 151:14 152:17 156:26]
  wire [4:0] _GEN_2 = 2'h2 == digit ? io_disp_content[14:10] : _GEN_1; // @[\\src\\main\\scala\\Functions.scala 152:17 155:26]
  wire [4:0] _GEN_3 = 2'h1 == digit ? io_disp_content[9:5] : _GEN_2; // @[\\src\\main\\scala\\Functions.scala 152:17 154:26]
  wire [3:0] _currentDot_T = 4'h0 >> digit; // @[\\src\\main\\scala\\Functions.scala 163:27]
  wire  currentDot = _currentDot_T[0]; // @[\\src\\main\\scala\\Functions.scala 163:27]
  wire [7:0] fullSeg = {currentDot,decoder_io_out}; // @[\\src\\main\\scala\\Functions.scala 164:28]
  wire [3:0] _GEN_5 = _T_3 ? 4'h8 : 4'h1; // @[\\src\\main\\scala\\Functions.scala 167:17 171:22 166:27]
  wire [3:0] _GEN_6 = _T_2 ? 4'h4 : _GEN_5; // @[\\src\\main\\scala\\Functions.scala 167:17 170:22]
  wire [3:0] _GEN_7 = _T_1 ? 4'h2 : _GEN_6; // @[\\src\\main\\scala\\Functions.scala 167:17 169:22]
  wire [3:0] select = _T ? 4'h1 : _GEN_7; // @[\\src\\main\\scala\\Functions.scala 167:17 168:22]
  SevenSegDec decoder ( // @[\\src\\main\\scala\\Functions.scala 159:23]
    .io_in(decoder_io_in),
    .io_out(decoder_io_out)
  );
  assign io_seg = ~fullSeg; // @[\\src\\main\\scala\\Functions.scala 174:13]
  assign io_an = ~select; // @[\\src\\main\\scala\\Functions.scala 175:13]
  assign decoder_io_in = 2'h0 == digit ? io_disp_content[4:0] : _GEN_3; // @[\\src\\main\\scala\\Functions.scala 152:17 153:26]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 143:20]
      cnt <= 17'h0; // @[\\src\\main\\scala\\Functions.scala 143:20]
    end else if (cnt == 17'h1869f) begin // @[\\src\\main\\scala\\Functions.scala 144:13]
      cnt <= 17'h0;
    end else begin
      cnt <= _cnt_T_2;
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 147:22]
      digit <= 2'h0; // @[\\src\\main\\scala\\Functions.scala 147:22]
    end else if (_cnt_T) begin // @[\\src\\main\\scala\\Functions.scala 148:14]
      digit <= _digit_T_1; // @[\\src\\main\\scala\\Functions.scala 148:22]
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
  input         io_signal_A, // @[\\src\\main\\scala\\Functions.scala 6:14]
  input         io_signal_B, // @[\\src\\main\\scala\\Functions.scala 6:14]
  output [31:0] io_turns // @[\\src\\main\\scala\\Functions.scala 6:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg  aSync_REG; // @[\\src\\main\\scala\\Functions.scala 11:30]
  reg  aSync; // @[\\src\\main\\scala\\Functions.scala 11:22]
  reg  bSync_REG; // @[\\src\\main\\scala\\Functions.scala 12:30]
  reg  bSync; // @[\\src\\main\\scala\\Functions.scala 12:22]
  reg  aReg; // @[\\src\\main\\scala\\Functions.scala 13:22]
  wire  rise_A = aSync & ~aReg; // @[\\src\\main\\scala\\Functions.scala 14:22]
  reg [31:0] turns; // @[\\src\\main\\scala\\Functions.scala 15:22]
  wire [31:0] _turns_T_2 = $signed(turns) + 32'sh1; // @[\\src\\main\\scala\\Functions.scala 17:35]
  wire [31:0] _turns_T_5 = $signed(turns) - 32'sh1; // @[\\src\\main\\scala\\Functions.scala 18:35]
  assign io_turns = turns; // @[\\src\\main\\scala\\Functions.scala 20:12]
  always @(posedge clock) begin
    aSync_REG <= io_signal_A; // @[\\src\\main\\scala\\Functions.scala 11:30]
    aSync <= aSync_REG; // @[\\src\\main\\scala\\Functions.scala 11:22]
    bSync_REG <= io_signal_B; // @[\\src\\main\\scala\\Functions.scala 12:30]
    bSync <= bSync_REG; // @[\\src\\main\\scala\\Functions.scala 12:22]
    aReg <= aSync; // @[\\src\\main\\scala\\Functions.scala 13:22]
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 15:22]
      turns <= 32'sh0; // @[\\src\\main\\scala\\Functions.scala 15:22]
    end else if (rise_A) begin // @[\\src\\main\\scala\\Functions.scala 16:16]
      if (~bSync) begin // @[\\src\\main\\scala\\Functions.scala 17:18]
        turns <= _turns_T_2; // @[\\src\\main\\scala\\Functions.scala 17:26]
      end else begin
        turns <= _turns_T_5; // @[\\src\\main\\scala\\Functions.scala 18:26]
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
  input   io_btn_in, // @[\\src\\main\\scala\\Functions.scala 225:14]
  output  io_out // @[\\src\\main\\scala\\Functions.scala 225:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg  btn_sync_REG; // @[\\src\\main\\scala\\Functions.scala 230:33]
  reg  btn_sync; // @[\\src\\main\\scala\\Functions.scala 230:25]
  reg  btnDebReg; // @[\\src\\main\\scala\\Functions.scala 231:26]
  reg [31:0] cntReg; // @[\\src\\main\\scala\\Functions.scala 232:23]
  wire  tick = cntReg == 32'h1869f; // @[\\src\\main\\scala\\Functions.scala 233:21]
  wire [31:0] _cntReg_T_1 = cntReg + 32'h1; // @[\\src\\main\\scala\\Functions.scala 235:20]
  reg  btnCleanPrev; // @[\\src\\main\\scala\\Functions.scala 241:29]
  assign io_out = btnDebReg & ~btnCleanPrev; // @[\\src\\main\\scala\\Functions.scala 242:23]
  always @(posedge clock) begin
    btn_sync_REG <= io_btn_in; // @[\\src\\main\\scala\\Functions.scala 230:33]
    btn_sync <= btn_sync_REG; // @[\\src\\main\\scala\\Functions.scala 230:25]
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 231:26]
      btnDebReg <= 1'h0; // @[\\src\\main\\scala\\Functions.scala 231:26]
    end else if (tick) begin // @[\\src\\main\\scala\\Functions.scala 236:15]
      btnDebReg <= btn_sync; // @[\\src\\main\\scala\\Functions.scala 238:15]
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 232:23]
      cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 232:23]
    end else if (tick) begin // @[\\src\\main\\scala\\Functions.scala 236:15]
      cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 237:12]
    end else begin
      cntReg <= _cntReg_T_1; // @[\\src\\main\\scala\\Functions.scala 235:10]
    end
    btnCleanPrev <= btnDebReg; // @[\\src\\main\\scala\\Functions.scala 241:29]
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
module Driver(
  input        clock,
  input        reset,
  input        io_uart_rx, // @[\\src\\main\\scala\\Driver.scala 6:14]
  input        io_photo_sensor_A, // @[\\src\\main\\scala\\Driver.scala 6:14]
  input        io_photo_sensor_B, // @[\\src\\main\\scala\\Driver.scala 6:14]
  input        io_over_current_positive, // @[\\src\\main\\scala\\Driver.scala 6:14]
  input        io_over_current_negative, // @[\\src\\main\\scala\\Driver.scala 6:14]
  input        io_error_cleared, // @[\\src\\main\\scala\\Driver.scala 6:14]
  output       io_uart_tx, // @[\\src\\main\\scala\\Driver.scala 6:14]
  output       io_T1, // @[\\src\\main\\scala\\Driver.scala 6:14]
  output       io_T2, // @[\\src\\main\\scala\\Driver.scala 6:14]
  output       io_T3, // @[\\src\\main\\scala\\Driver.scala 6:14]
  output       io_T4, // @[\\src\\main\\scala\\Driver.scala 6:14]
  output [7:0] io_seg, // @[\\src\\main\\scala\\Driver.scala 6:14]
  output [3:0] io_an // @[\\src\\main\\scala\\Driver.scala 6:14]
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
  reg [63:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
`endif // RANDOMIZE_REG_INIT
  wire  rx_clock; // @[\\src\\main\\scala\\Driver.scala 25:36]
  wire  rx_reset; // @[\\src\\main\\scala\\Driver.scala 25:36]
  wire  rx_io_rx; // @[\\src\\main\\scala\\Driver.scala 25:36]
  wire  rx_io_done; // @[\\src\\main\\scala\\Driver.scala 25:36]
  wire [7:0] rx_io_data; // @[\\src\\main\\scala\\Driver.scala 25:36]
  wire  tx_clock; // @[\\src\\main\\scala\\Driver.scala 26:36]
  wire  tx_reset; // @[\\src\\main\\scala\\Driver.scala 26:36]
  wire [7:0] tx_io_data; // @[\\src\\main\\scala\\Driver.scala 26:36]
  wire  tx_io_start; // @[\\src\\main\\scala\\Driver.scala 26:36]
  wire  tx_io_tx; // @[\\src\\main\\scala\\Driver.scala 26:36]
  wire  tx_io_busy; // @[\\src\\main\\scala\\Driver.scala 26:36]
  wire  pwm_signal_clock; // @[\\src\\main\\scala\\Driver.scala 27:36]
  wire  pwm_signal_reset; // @[\\src\\main\\scala\\Driver.scala 27:36]
  wire [9:0] pwm_signal_io_duty_cycle; // @[\\src\\main\\scala\\Driver.scala 27:36]
  wire  pwm_signal_io_brake; // @[\\src\\main\\scala\\Driver.scala 27:36]
  wire  pwm_signal_io_T1; // @[\\src\\main\\scala\\Driver.scala 27:36]
  wire  pwm_signal_io_T2; // @[\\src\\main\\scala\\Driver.scala 27:36]
  wire  pwm_signal_io_T3; // @[\\src\\main\\scala\\Driver.scala 27:36]
  wire  pwm_signal_io_T4; // @[\\src\\main\\scala\\Driver.scala 27:36]
  wire  pid_clock; // @[\\src\\main\\scala\\Driver.scala 28:36]
  wire  pid_reset; // @[\\src\\main\\scala\\Driver.scala 28:36]
  wire [31:0] pid_io_setPoint; // @[\\src\\main\\scala\\Driver.scala 28:36]
  wire [31:0] pid_io_measuredVal; // @[\\src\\main\\scala\\Driver.scala 28:36]
  wire  pid_io_tick; // @[\\src\\main\\scala\\Driver.scala 28:36]
  wire  pid_io_resetBuffer; // @[\\src\\main\\scala\\Driver.scala 28:36]
  wire [31:0] pid_io_controlOut; // @[\\src\\main\\scala\\Driver.scala 28:36]
  wire  stuck_detector_clock; // @[\\src\\main\\scala\\Driver.scala 29:36]
  wire  stuck_detector_reset; // @[\\src\\main\\scala\\Driver.scala 29:36]
  wire  stuck_detector_io_external_overcurrent_input; // @[\\src\\main\\scala\\Driver.scala 29:36]
  wire  stuck_detector_io_clear_shutdown; // @[\\src\\main\\scala\\Driver.scala 29:36]
  wire  stuck_detector_io_motor_disable; // @[\\src\\main\\scala\\Driver.scala 29:36]
  wire  display_clock; // @[\\src\\main\\scala\\Driver.scala 30:36]
  wire  display_reset; // @[\\src\\main\\scala\\Driver.scala 30:36]
  wire [19:0] display_io_disp_content; // @[\\src\\main\\scala\\Driver.scala 30:36]
  wire [7:0] display_io_seg; // @[\\src\\main\\scala\\Driver.scala 30:36]
  wire [3:0] display_io_an; // @[\\src\\main\\scala\\Driver.scala 30:36]
  wire  rotations_clock; // @[\\src\\main\\scala\\Driver.scala 31:36]
  wire  rotations_reset; // @[\\src\\main\\scala\\Driver.scala 31:36]
  wire  rotations_io_signal_A; // @[\\src\\main\\scala\\Driver.scala 31:36]
  wire  rotations_io_signal_B; // @[\\src\\main\\scala\\Driver.scala 31:36]
  wire [31:0] rotations_io_turns; // @[\\src\\main\\scala\\Driver.scala 31:36]
  wire  error_clear_debounce_clock; // @[\\src\\main\\scala\\Driver.scala 32:36]
  wire  error_clear_debounce_reset; // @[\\src\\main\\scala\\Driver.scala 32:36]
  wire  error_clear_debounce_io_btn_in; // @[\\src\\main\\scala\\Driver.scala 32:36]
  wire  error_clear_debounce_io_out; // @[\\src\\main\\scala\\Driver.scala 32:36]
  reg [13:0] rotations_io_signal_A_cnt; // @[\\src\\main\\scala\\Driver.scala 36:23]
  reg  rotations_io_signal_A_out; // @[\\src\\main\\scala\\Driver.scala 37:23]
  wire [13:0] _rotations_io_signal_A_cnt_T_1 = rotations_io_signal_A_cnt + 14'h1; // @[\\src\\main\\scala\\Driver.scala 39:29]
  reg [13:0] rotations_io_signal_B_cnt; // @[\\src\\main\\scala\\Driver.scala 36:23]
  reg  rotations_io_signal_B_out; // @[\\src\\main\\scala\\Driver.scala 37:23]
  wire [13:0] _rotations_io_signal_B_cnt_T_1 = rotations_io_signal_B_cnt + 14'h1; // @[\\src\\main\\scala\\Driver.scala 39:29]
  reg [16:0] pid_timer; // @[\\src\\main\\scala\\Driver.scala 51:26]
  wire  pid_tick = pid_timer == 17'h1869f; // @[\\src\\main\\scala\\Driver.scala 52:29]
  wire [16:0] _pid_timer_T_1 = pid_timer + 17'h1; // @[\\src\\main\\scala\\Driver.scala 53:75]
  reg [31:0] target_position_cm; // @[\\src\\main\\scala\\Driver.scala 56:35]
  reg  control_mode; // @[\\src\\main\\scala\\Driver.scala 57:35]
  reg  manual_brake; // @[\\src\\main\\scala\\Driver.scala 58:35]
  reg  system_active; // @[\\src\\main\\scala\\Driver.scala 59:35]
  reg [31:0] initial_offset; // @[\\src\\main\\scala\\Driver.scala 60:35]
  wire [31:0] current_turns = $signed(rotations_io_turns) - $signed(initial_offset); // @[\\src\\main\\scala\\Driver.scala 62:42]
  wire [63:0] full_pos_calc = $signed(current_turns) * 32'sh222; // @[\\src\\main\\scala\\Driver.scala 65:56]
  reg [31:0] current_position_fixed_point; // @[\\src\\main\\scala\\Driver.scala 66:45]
  wire [19:0] _current_position_cm_T = current_position_fixed_point[31:12]; // @[\\src\\main\\scala\\Driver.scala 67:78]
  wire [19:0] current_position_cm = system_active ? $signed(_current_position_cm_T) : $signed(20'sh0); // @[\\src\\main\\scala\\Driver.scala 67:32]
  reg [1:0] uartState; // @[\\src\\main\\scala\\Driver.scala 70:26]
  reg [7:0] CMDByte; // @[\\src\\main\\scala\\Driver.scala 71:24]
  reg [9:0] manual_speed; // @[\\src\\main\\scala\\Driver.scala 79:35]
  reg [9:0] manual_ramped; // @[\\src\\main\\scala\\Driver.scala 80:35]
  reg [17:0] ramp_timer; // @[\\src\\main\\scala\\Driver.scala 83:35]
  wire  ramp_tick = ramp_timer == 18'h30d3f; // @[\\src\\main\\scala\\Driver.scala 84:39]
  wire [9:0] _manual_ramped_T_1 = manual_ramped + 10'h1; // @[\\src\\main\\scala\\Driver.scala 89:38]
  wire [9:0] _manual_ramped_T_3 = manual_ramped - 10'h1; // @[\\src\\main\\scala\\Driver.scala 91:38]
  wire [9:0] _GEN_8 = manual_ramped > manual_speed ? _manual_ramped_T_3 : manual_ramped; // @[\\src\\main\\scala\\Driver.scala 90:46 91:21 80:35]
  wire [17:0] _ramp_timer_T_1 = ramp_timer + 18'h1; // @[\\src\\main\\scala\\Driver.scala 93:42]
  wire  _T_2 = ~system_active; // @[\\src\\main\\scala\\Driver.scala 95:8]
  wire [9:0] _GEN_13 = ~system_active ? 10'h200 : manual_speed; // @[\\src\\main\\scala\\Driver.scala 95:24 97:19 79:35]
  wire [31:0] _GEN_15 = _T_2 ? $signed(rotations_io_turns) : $signed(initial_offset); // @[\\src\\main\\scala\\Driver.scala 108:{34,51} 60:35]
  wire [7:0] _target_position_cm_T = rx_io_data; // @[\\src\\main\\scala\\Driver.scala 109:48]
  wire  _T_11 = 8'h0 == rx_io_data; // @[\\src\\main\\scala\\Driver.scala 121:32]
  wire [9:0] _GEN_17 = 8'h4 == rx_io_data ? 10'h1c7 : _GEN_13; // @[\\src\\main\\scala\\Driver.scala 121:32 126:38]
  wire [9:0] _GEN_19 = 8'h3 == rx_io_data ? 10'h1e5 : _GEN_17; // @[\\src\\main\\scala\\Driver.scala 121:32 125:38]
  wire [9:0] _GEN_21 = 8'h2 == rx_io_data ? 10'h2ee : _GEN_19; // @[\\src\\main\\scala\\Driver.scala 121:32 124:38]
  wire [9:0] _GEN_23 = 8'h1 == rx_io_data ? 10'h2d0 : _GEN_21; // @[\\src\\main\\scala\\Driver.scala 121:32 123:38]
  wire [9:0] _GEN_26 = 8'h0 == rx_io_data ? 10'h200 : _GEN_23; // @[\\src\\main\\scala\\Driver.scala 121:32 122:62]
  wire [31:0] _GEN_28 = 8'h2 == CMDByte ? $signed(_GEN_15) : $signed(initial_offset); // @[\\src\\main\\scala\\Driver.scala 106:25 60:35]
  wire  _GEN_29 = 8'h2 == CMDByte | system_active; // @[\\src\\main\\scala\\Driver.scala 106:25 117:27 59:35]
  wire  _GEN_30 = 8'h2 == CMDByte ? 1'h0 : control_mode; // @[\\src\\main\\scala\\Driver.scala 106:25 118:26 57:35]
  wire  _GEN_31 = 8'h2 == CMDByte ? _T_11 : manual_brake; // @[\\src\\main\\scala\\Driver.scala 106:25 58:35]
  wire [9:0] _GEN_32 = 8'h2 == CMDByte ? _GEN_26 : _GEN_13; // @[\\src\\main\\scala\\Driver.scala 106:25]
  wire  _GEN_33 = 8'h2 == CMDByte ? 1'h0 : 8'hff == CMDByte; // @[\\src\\main\\scala\\Driver.scala 106:25 72:36]
  wire [31:0] _GEN_34 = 8'h1 == CMDByte ? $signed(_GEN_15) : $signed(_GEN_28); // @[\\src\\main\\scala\\Driver.scala 106:25]
  wire [31:0] _GEN_35 = 8'h1 == CMDByte ? $signed({{24{_target_position_cm_T[7]}},_target_position_cm_T}) : $signed(
    target_position_cm); // @[\\src\\main\\scala\\Driver.scala 106:25 109:32 56:35]
  wire  _GEN_36 = 8'h1 == CMDByte | _GEN_29; // @[\\src\\main\\scala\\Driver.scala 106:25 110:27]
  wire  _GEN_37 = 8'h1 == CMDByte | _GEN_30; // @[\\src\\main\\scala\\Driver.scala 106:25 111:26]
  wire  _GEN_38 = 8'h1 == CMDByte ? 1'h0 : _GEN_31; // @[\\src\\main\\scala\\Driver.scala 106:25 112:26]
  wire [9:0] _GEN_40 = 8'h1 == CMDByte ? _GEN_13 : _GEN_32; // @[\\src\\main\\scala\\Driver.scala 106:25]
  wire  _GEN_41 = 8'h1 == CMDByte ? 1'h0 : _GEN_33; // @[\\src\\main\\scala\\Driver.scala 106:25 72:36]
  wire [31:0] _GEN_42 = 2'h2 == uartState ? $signed(_GEN_34) : $signed(initial_offset); // @[\\src\\main\\scala\\Driver.scala 102:23 60:35]
  wire [31:0] _GEN_43 = 2'h2 == uartState ? $signed(_GEN_35) : $signed(target_position_cm); // @[\\src\\main\\scala\\Driver.scala 102:23 56:35]
  wire  _GEN_44 = 2'h2 == uartState ? _GEN_36 : system_active; // @[\\src\\main\\scala\\Driver.scala 102:23 59:35]
  wire  _GEN_45 = 2'h2 == uartState ? _GEN_37 : control_mode; // @[\\src\\main\\scala\\Driver.scala 102:23 57:35]
  wire  _GEN_46 = 2'h2 == uartState ? _GEN_38 : manual_brake; // @[\\src\\main\\scala\\Driver.scala 102:23 58:35]
  wire [9:0] _GEN_48 = 2'h2 == uartState ? _GEN_40 : _GEN_13; // @[\\src\\main\\scala\\Driver.scala 102:23]
  wire [1:0] _GEN_50 = 2'h2 == uartState ? 2'h0 : uartState; // @[\\src\\main\\scala\\Driver.scala 102:23 131:19 70:26]
  wire  _GEN_56 = 2'h1 == uartState ? control_mode : _GEN_45; // @[\\src\\main\\scala\\Driver.scala 102:23 57:35]
  wire  _GEN_60 = 2'h1 == uartState ? 1'h0 : 2'h2 == uartState & _GEN_41; // @[\\src\\main\\scala\\Driver.scala 102:23 72:36]
  wire  _GEN_66 = 2'h0 == uartState ? control_mode : _GEN_56; // @[\\src\\main\\scala\\Driver.scala 102:23 57:35]
  wire  _GEN_70 = 2'h0 == uartState ? 1'h0 : _GEN_60; // @[\\src\\main\\scala\\Driver.scala 102:23 72:36]
  wire  _GEN_76 = rx_io_done ? _GEN_66 : control_mode; // @[\\src\\main\\scala\\Driver.scala 101:21 57:35]
  wire  reset_triggered = rx_io_done & _GEN_70; // @[\\src\\main\\scala\\Driver.scala 101:21 72:36]
  wire [36:0] _target_turns_T = $signed(target_position_cm) * 5'shf; // @[\\src\\main\\scala\\Driver.scala 138:50]
  reg [37:0] target_turns; // @[\\src\\main\\scala\\Driver.scala 138:29]
  wire [37:0] _at_position_T_2 = $signed(target_turns) - 38'sh2; // @[\\src\\main\\scala\\Driver.scala 140:87]
  wire [37:0] _GEN_112 = {{6{current_turns[31]}},current_turns}; // @[\\src\\main\\scala\\Driver.scala 140:71]
  wire [37:0] _at_position_T_6 = $signed(target_turns) + 38'sh2; // @[\\src\\main\\scala\\Driver.scala 140:132]
  wire  _at_position_T_9 = system_active ? $signed(_GEN_112) >= $signed(_at_position_T_2) & $signed(_GEN_112) <=
    $signed(_at_position_T_6) : 1'h1; // @[\\src\\main\\scala\\Driver.scala 140:40]
  wire  at_position = control_mode & _at_position_T_9; // @[\\src\\main\\scala\\Driver.scala 140:34]
  wire [31:0] raw_pid_out = pid_io_controlOut; // @[\\src\\main\\scala\\Driver.scala 151:39]
  wire [27:0] _pid_offset_T_2 = raw_pid_out[31:4]; // @[\\src\\main\\scala\\Driver.scala 156:94]
  wire [27:0] _pid_offset_T_5 = $signed(_pid_offset_T_2) + 28'sh50; // @[\\src\\main\\scala\\Driver.scala 156:100]
  wire [22:0] _pid_offset_T_6 = raw_pid_out[31:9]; // @[\\src\\main\\scala\\Driver.scala 156:121]
  wire [22:0] _pid_offset_T_9 = $signed(_pid_offset_T_6) - 23'sha; // @[\\src\\main\\scala\\Driver.scala 156:127]
  reg [27:0] pid_offset; // @[\\src\\main\\scala\\Driver.scala 156:27]
  wire [27:0] pid_duty_raw = 28'sh200 + $signed(pid_offset); // @[\\src\\main\\scala\\Driver.scala 158:28]
  wire [27:0] _pid_duty_T_2 = 28'sh200 + $signed(pid_offset); // @[\\src\\main\\scala\\Driver.scala 159:119]
  wire [27:0] _pid_duty_T_3 = $signed(pid_duty_raw) < 28'sh0 ? 28'h0 : _pid_duty_T_2; // @[\\src\\main\\scala\\Driver.scala 159:80]
  wire [27:0] _pid_duty_T_4 = $signed(pid_duty_raw) > 28'sh3ff ? 28'h3ff : _pid_duty_T_3; // @[\\src\\main\\scala\\Driver.scala 159:45]
  wire [27:0] pid_duty = at_position ? 28'h200 : _pid_duty_T_4; // @[\\src\\main\\scala\\Driver.scala 159:21]
  wire [27:0] active_duty = control_mode ? pid_duty : {{18'd0}, manual_ramped}; // @[\\src\\main\\scala\\Driver.scala 161:24]
  wire  is_moving_back = active_duty < 28'h200; // @[\\src\\main\\scala\\Driver.scala 162:36]
  wire  is_moving_fwd = active_duty > 28'h200; // @[\\src\\main\\scala\\Driver.scala 163:35]
  wire  block_neg = system_active & $signed(current_position_cm) <= 20'sh0 & is_moving_back; // @[\\src\\main\\scala\\Driver.scala 165:75]
  wire  block_pos = system_active & $signed(current_position_cm) >= 20'sh5a & is_moving_fwd; // @[\\src\\main\\scala\\Driver.scala 166:76]
  reg [27:0] pwm_signal_io_duty_cycle_REG; // @[\\src\\main\\scala\\Driver.scala 168:38]
  wire  motor_stopped = manual_brake | stuck_detector_io_motor_disable | _T_2 | at_position | block_neg | block_pos; // @[\\src\\main\\scala\\Driver.scala 169:117]
  reg [23:0] txTimer; // @[\\src\\main\\scala\\Driver.scala 185:24]
  reg [1:0] txState; // @[\\src\\main\\scala\\Driver.scala 187:24]
  wire  _T_20 = ~tx_io_busy; // @[\\src\\main\\scala\\Driver.scala 193:14]
  wire [7:0] _GEN_85 = ~tx_io_busy ? 8'hff : 8'h0; // @[\\src\\main\\scala\\Driver.scala 188:14 193:27 194:22]
  wire [7:0] _GEN_88 = _T_20 ? current_position_cm[15:8] : 8'h0; // @[\\src\\main\\scala\\Driver.scala 188:14 199:27 200:22]
  wire [1:0] _GEN_90 = _T_20 ? 2'h2 : txState; // @[\\src\\main\\scala\\Driver.scala 199:27 202:19 187:24]
  wire [23:0] _GEN_91 = _T_20 ? 24'h0 : txTimer; // @[\\src\\main\\scala\\Driver.scala 199:27 203:19 185:24]
  wire [7:0] _GEN_92 = _T_20 ? current_position_cm[7:0] : 8'h0; // @[\\src\\main\\scala\\Driver.scala 188:14 206:27 207:22]
  wire [1:0] _GEN_94 = _T_20 ? 2'h0 : txState; // @[\\src\\main\\scala\\Driver.scala 206:27 209:19 187:24]
  wire [7:0] _GEN_96 = 2'h2 == txState ? _GEN_92 : 8'h0; // @[\\src\\main\\scala\\Driver.scala 188:14 191:21]
  wire  _GEN_97 = 2'h2 == txState & _T_20; // @[\\src\\main\\scala\\Driver.scala 189:15 191:21]
  wire [1:0] _GEN_98 = 2'h2 == txState ? _GEN_94 : txState; // @[\\src\\main\\scala\\Driver.scala 191:21 187:24]
  wire [23:0] _GEN_99 = 2'h2 == txState ? _GEN_91 : txTimer; // @[\\src\\main\\scala\\Driver.scala 191:21 185:24]
  wire [7:0] _GEN_100 = 2'h1 == txState ? _GEN_88 : _GEN_96; // @[\\src\\main\\scala\\Driver.scala 191:21]
  wire  _GEN_101 = 2'h1 == txState ? _T_20 : _GEN_97; // @[\\src\\main\\scala\\Driver.scala 191:21]
  wire [7:0] _GEN_104 = 2'h0 == txState ? _GEN_85 : _GEN_100; // @[\\src\\main\\scala\\Driver.scala 191:21]
  wire  _GEN_105 = 2'h0 == txState ? _T_20 : _GEN_101; // @[\\src\\main\\scala\\Driver.scala 191:21]
  wire [23:0] _txTimer_T_1 = txTimer + 24'h1; // @[\\src\\main\\scala\\Driver.scala 213:36]
  wire [18:0] _display_io_disp_content_T = control_mode ? 19'h57797 : 19'h56ade; // @[\\src\\main\\scala\\Driver.scala 221:66]
  wire [43:0] _GEN_114 = {$signed(target_position_cm), 12'h0}; // @[\\src\\main\\scala\\Driver.scala 143:19]
  UartRx rx ( // @[\\src\\main\\scala\\Driver.scala 25:36]
    .clock(rx_clock),
    .reset(rx_reset),
    .io_rx(rx_io_rx),
    .io_done(rx_io_done),
    .io_data(rx_io_data)
  );
  UartTx tx ( // @[\\src\\main\\scala\\Driver.scala 26:36]
    .clock(tx_clock),
    .reset(tx_reset),
    .io_data(tx_io_data),
    .io_start(tx_io_start),
    .io_tx(tx_io_tx),
    .io_busy(tx_io_busy)
  );
  DCMotorPwm pwm_signal ( // @[\\src\\main\\scala\\Driver.scala 27:36]
    .clock(pwm_signal_clock),
    .reset(pwm_signal_reset),
    .io_duty_cycle(pwm_signal_io_duty_cycle),
    .io_brake(pwm_signal_io_brake),
    .io_T1(pwm_signal_io_T1),
    .io_T2(pwm_signal_io_T2),
    .io_T3(pwm_signal_io_T3),
    .io_T4(pwm_signal_io_T4)
  );
  PIDController pid ( // @[\\src\\main\\scala\\Driver.scala 28:36]
    .clock(pid_clock),
    .reset(pid_reset),
    .io_setPoint(pid_io_setPoint),
    .io_measuredVal(pid_io_measuredVal),
    .io_tick(pid_io_tick),
    .io_resetBuffer(pid_io_resetBuffer),
    .io_controlOut(pid_io_controlOut)
  );
  StuckDetector stuck_detector ( // @[\\src\\main\\scala\\Driver.scala 29:36]
    .clock(stuck_detector_clock),
    .reset(stuck_detector_reset),
    .io_external_overcurrent_input(stuck_detector_io_external_overcurrent_input),
    .io_clear_shutdown(stuck_detector_io_clear_shutdown),
    .io_motor_disable(stuck_detector_io_motor_disable)
  );
  DisplayMultiplexer display ( // @[\\src\\main\\scala\\Driver.scala 30:36]
    .clock(display_clock),
    .reset(display_reset),
    .io_disp_content(display_io_disp_content),
    .io_seg(display_io_seg),
    .io_an(display_io_an)
  );
  RotationCounter rotations ( // @[\\src\\main\\scala\\Driver.scala 31:36]
    .clock(rotations_clock),
    .reset(rotations_reset),
    .io_signal_A(rotations_io_signal_A),
    .io_signal_B(rotations_io_signal_B),
    .io_turns(rotations_io_turns)
  );
  Debouncer error_clear_debounce ( // @[\\src\\main\\scala\\Driver.scala 32:36]
    .clock(error_clear_debounce_clock),
    .reset(error_clear_debounce_reset),
    .io_btn_in(error_clear_debounce_io_btn_in),
    .io_out(error_clear_debounce_io_out)
  );
  assign io_uart_tx = tx_io_tx; // @[\\src\\main\\scala\\Driver.scala 214:14]
  assign io_T1 = _T_2 ? 1'h0 : pwm_signal_io_T1; // @[\\src\\main\\scala\\Driver.scala 172:25 173:11 178:11]
  assign io_T2 = _T_2 | pwm_signal_io_T2; // @[\\src\\main\\scala\\Driver.scala 172:25 174:11 179:11]
  assign io_T3 = _T_2 ? 1'h0 : pwm_signal_io_T3; // @[\\src\\main\\scala\\Driver.scala 172:25 175:11 180:11]
  assign io_T4 = _T_2 | pwm_signal_io_T4; // @[\\src\\main\\scala\\Driver.scala 172:25 176:11 181:11]
  assign io_seg = display_io_seg; // @[\\src\\main\\scala\\Driver.scala 217:34]
  assign io_an = display_io_an; // @[\\src\\main\\scala\\Driver.scala 217:9]
  assign rx_clock = clock;
  assign rx_reset = reset;
  assign rx_io_rx = io_uart_rx; // @[\\src\\main\\scala\\Driver.scala 43:34]
  assign tx_clock = clock;
  assign tx_reset = reset;
  assign tx_io_data = txTimer >= 24'h2625a0 ? _GEN_104 : 8'h0; // @[\\src\\main\\scala\\Driver.scala 188:14 190:30]
  assign tx_io_start = txTimer >= 24'h2625a0 & _GEN_105; // @[\\src\\main\\scala\\Driver.scala 189:15 190:30]
  assign pwm_signal_clock = clock;
  assign pwm_signal_reset = reset;
  assign pwm_signal_io_duty_cycle = pwm_signal_io_duty_cycle_REG[9:0]; // @[\\src\\main\\scala\\Driver.scala 168:28]
  assign pwm_signal_io_brake = manual_brake | stuck_detector_io_motor_disable | _T_2 | at_position | block_neg |
    block_pos; // @[\\src\\main\\scala\\Driver.scala 169:117]
  assign pid_clock = clock;
  assign pid_reset = reset;
  assign pid_io_setPoint = _GEN_114[31:0]; // @[\\src\\main\\scala\\Driver.scala 143:19]
  assign pid_io_measuredVal = current_position_fixed_point; // @[\\src\\main\\scala\\Driver.scala 142:22]
  assign pid_io_tick = pid_timer == 17'h1869f; // @[\\src\\main\\scala\\Driver.scala 52:29]
  assign pid_io_resetBuffer = ~control_mode | manual_brake | _T_2 | at_position; // @[\\src\\main\\scala\\Driver.scala 145:73]
  assign stuck_detector_clock = clock;
  assign stuck_detector_reset = reset;
  assign stuck_detector_io_external_overcurrent_input = ~io_over_current_positive | ~io_over_current_negative; // @[\\src\\main\\scala\\Driver.scala 48:78]
  assign stuck_detector_io_clear_shutdown = error_clear_debounce_io_out | reset_triggered; // @[\\src\\main\\scala\\Driver.scala 135:68]
  assign display_clock = clock;
  assign display_reset = reset;
  assign display_io_disp_content = motor_stopped ? 20'hdf2f8 : {{1'd0}, _display_io_disp_content_T}; // @[\\src\\main\\scala\\Driver.scala 221:33]
  assign rotations_clock = clock;
  assign rotations_reset = reset;
  assign rotations_io_signal_A = rotations_io_signal_A_out; // @[\\src\\main\\scala\\Driver.scala 44:34]
  assign rotations_io_signal_B = rotations_io_signal_B_out; // @[\\src\\main\\scala\\Driver.scala 45:34]
  assign error_clear_debounce_clock = clock;
  assign error_clear_debounce_reset = reset;
  assign error_clear_debounce_io_btn_in = io_error_cleared; // @[\\src\\main\\scala\\Driver.scala 47:34]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\Driver.scala 36:23]
      rotations_io_signal_A_cnt <= 14'h0; // @[\\src\\main\\scala\\Driver.scala 36:23]
    end else if (io_photo_sensor_A == rotations_io_signal_A_out) begin // @[\\src\\main\\scala\\Driver.scala 38:24]
      rotations_io_signal_A_cnt <= 14'h0; // @[\\src\\main\\scala\\Driver.scala 38:30]
    end else begin
      rotations_io_signal_A_cnt <= _rotations_io_signal_A_cnt_T_1; // @[\\src\\main\\scala\\Driver.scala 39:22]
    end
    if (reset) begin // @[\\src\\main\\scala\\Driver.scala 37:23]
      rotations_io_signal_A_out <= 1'h0; // @[\\src\\main\\scala\\Driver.scala 37:23]
    end else if (!(io_photo_sensor_A == rotations_io_signal_A_out)) begin // @[\\src\\main\\scala\\Driver.scala 38:24]
      if (rotations_io_signal_A_cnt == 14'h3e8) begin // @[\\src\\main\\scala\\Driver.scala 39:57]
        rotations_io_signal_A_out <= io_photo_sensor_A; // @[\\src\\main\\scala\\Driver.scala 39:63]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Driver.scala 36:23]
      rotations_io_signal_B_cnt <= 14'h0; // @[\\src\\main\\scala\\Driver.scala 36:23]
    end else if (io_photo_sensor_B == rotations_io_signal_B_out) begin // @[\\src\\main\\scala\\Driver.scala 38:24]
      rotations_io_signal_B_cnt <= 14'h0; // @[\\src\\main\\scala\\Driver.scala 38:30]
    end else begin
      rotations_io_signal_B_cnt <= _rotations_io_signal_B_cnt_T_1; // @[\\src\\main\\scala\\Driver.scala 39:22]
    end
    if (reset) begin // @[\\src\\main\\scala\\Driver.scala 37:23]
      rotations_io_signal_B_out <= 1'h0; // @[\\src\\main\\scala\\Driver.scala 37:23]
    end else if (!(io_photo_sensor_B == rotations_io_signal_B_out)) begin // @[\\src\\main\\scala\\Driver.scala 38:24]
      if (rotations_io_signal_B_cnt == 14'h3e8) begin // @[\\src\\main\\scala\\Driver.scala 39:57]
        rotations_io_signal_B_out <= io_photo_sensor_B; // @[\\src\\main\\scala\\Driver.scala 39:63]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Driver.scala 51:26]
      pid_timer <= 17'h0; // @[\\src\\main\\scala\\Driver.scala 51:26]
    end else if (pid_tick) begin // @[\\src\\main\\scala\\Driver.scala 53:18]
      pid_timer <= 17'h0; // @[\\src\\main\\scala\\Driver.scala 53:30]
    end else begin
      pid_timer <= _pid_timer_T_1; // @[\\src\\main\\scala\\Driver.scala 53:62]
    end
    if (reset) begin // @[\\src\\main\\scala\\Driver.scala 56:35]
      target_position_cm <= 32'sh0; // @[\\src\\main\\scala\\Driver.scala 56:35]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\Driver.scala 101:21]
      if (!(2'h0 == uartState)) begin // @[\\src\\main\\scala\\Driver.scala 102:23]
        if (!(2'h1 == uartState)) begin // @[\\src\\main\\scala\\Driver.scala 102:23]
          target_position_cm <= _GEN_43;
        end
      end
    end
    control_mode <= reset | _GEN_76; // @[\\src\\main\\scala\\Driver.scala 57:{35,35}]
    if (reset) begin // @[\\src\\main\\scala\\Driver.scala 58:35]
      manual_brake <= 1'h0; // @[\\src\\main\\scala\\Driver.scala 58:35]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\Driver.scala 101:21]
      if (!(2'h0 == uartState)) begin // @[\\src\\main\\scala\\Driver.scala 102:23]
        if (!(2'h1 == uartState)) begin // @[\\src\\main\\scala\\Driver.scala 102:23]
          manual_brake <= _GEN_46;
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Driver.scala 59:35]
      system_active <= 1'h0; // @[\\src\\main\\scala\\Driver.scala 59:35]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\Driver.scala 101:21]
      if (!(2'h0 == uartState)) begin // @[\\src\\main\\scala\\Driver.scala 102:23]
        if (!(2'h1 == uartState)) begin // @[\\src\\main\\scala\\Driver.scala 102:23]
          system_active <= _GEN_44;
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Driver.scala 60:35]
      initial_offset <= 32'sh0; // @[\\src\\main\\scala\\Driver.scala 60:35]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\Driver.scala 101:21]
      if (!(2'h0 == uartState)) begin // @[\\src\\main\\scala\\Driver.scala 102:23]
        if (!(2'h1 == uartState)) begin // @[\\src\\main\\scala\\Driver.scala 102:23]
          initial_offset <= _GEN_42;
        end
      end
    end
    current_position_fixed_point <= full_pos_calc[31:0]; // @[\\src\\main\\scala\\Driver.scala 66:79]
    if (reset) begin // @[\\src\\main\\scala\\Driver.scala 70:26]
      uartState <= 2'h0; // @[\\src\\main\\scala\\Driver.scala 70:26]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\Driver.scala 101:21]
      if (2'h0 == uartState) begin // @[\\src\\main\\scala\\Driver.scala 102:23]
        if (rx_io_data == 8'haa) begin // @[\\src\\main\\scala\\Driver.scala 103:49]
          uartState <= 2'h1; // @[\\src\\main\\scala\\Driver.scala 103:61]
        end
      end else if (2'h1 == uartState) begin // @[\\src\\main\\scala\\Driver.scala 102:23]
        uartState <= 2'h2; // @[\\src\\main\\scala\\Driver.scala 104:51]
      end else begin
        uartState <= _GEN_50;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Driver.scala 71:24]
      CMDByte <= 8'h0; // @[\\src\\main\\scala\\Driver.scala 71:24]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\Driver.scala 101:21]
      if (!(2'h0 == uartState)) begin // @[\\src\\main\\scala\\Driver.scala 102:23]
        if (2'h1 == uartState) begin // @[\\src\\main\\scala\\Driver.scala 102:23]
          CMDByte <= rx_io_data; // @[\\src\\main\\scala\\Driver.scala 104:26]
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Driver.scala 79:35]
      manual_speed <= 10'h200; // @[\\src\\main\\scala\\Driver.scala 79:35]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\Driver.scala 101:21]
      if (2'h0 == uartState) begin // @[\\src\\main\\scala\\Driver.scala 102:23]
        manual_speed <= _GEN_13;
      end else if (2'h1 == uartState) begin // @[\\src\\main\\scala\\Driver.scala 102:23]
        manual_speed <= _GEN_13;
      end else begin
        manual_speed <= _GEN_48;
      end
    end else begin
      manual_speed <= _GEN_13;
    end
    if (reset) begin // @[\\src\\main\\scala\\Driver.scala 80:35]
      manual_ramped <= 10'h200; // @[\\src\\main\\scala\\Driver.scala 80:35]
    end else if (~system_active) begin // @[\\src\\main\\scala\\Driver.scala 95:24]
      manual_ramped <= 10'h200; // @[\\src\\main\\scala\\Driver.scala 96:19]
    end else if (ramp_tick) begin // @[\\src\\main\\scala\\Driver.scala 86:19]
      if (manual_ramped < manual_speed) begin // @[\\src\\main\\scala\\Driver.scala 88:40]
        manual_ramped <= _manual_ramped_T_1; // @[\\src\\main\\scala\\Driver.scala 89:21]
      end else begin
        manual_ramped <= _GEN_8;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Driver.scala 83:35]
      ramp_timer <= 18'h0; // @[\\src\\main\\scala\\Driver.scala 83:35]
    end else if (ramp_tick) begin // @[\\src\\main\\scala\\Driver.scala 86:19]
      ramp_timer <= 18'h0; // @[\\src\\main\\scala\\Driver.scala 87:16]
    end else begin
      ramp_timer <= _ramp_timer_T_1; // @[\\src\\main\\scala\\Driver.scala 93:28]
    end
    target_turns <= $signed(_target_turns_T) / 3'sh2; // @[\\src\\main\\scala\\Driver.scala 138:58]
    if ($signed(raw_pid_out) == 32'sh0) begin // @[\\src\\main\\scala\\Driver.scala 156:31]
      pid_offset <= 28'sh0;
    end else if ($signed(raw_pid_out) > 32'sh0) begin // @[\\src\\main\\scala\\Driver.scala 156:61]
      pid_offset <= _pid_offset_T_5;
    end else begin
      pid_offset <= {{5{_pid_offset_T_9[22]}},_pid_offset_T_9};
    end
    if (reset) begin // @[\\src\\main\\scala\\Driver.scala 168:38]
      pwm_signal_io_duty_cycle_REG <= 28'h200; // @[\\src\\main\\scala\\Driver.scala 168:38]
    end else if (block_neg | block_pos) begin // @[\\src\\main\\scala\\Driver.scala 168:42]
      pwm_signal_io_duty_cycle_REG <= 28'h200;
    end else if (control_mode) begin // @[\\src\\main\\scala\\Driver.scala 161:24]
      if (at_position) begin // @[\\src\\main\\scala\\Driver.scala 159:21]
        pwm_signal_io_duty_cycle_REG <= 28'h200;
      end else begin
        pwm_signal_io_duty_cycle_REG <= _pid_duty_T_4;
      end
    end else begin
      pwm_signal_io_duty_cycle_REG <= {{18'd0}, manual_ramped};
    end
    if (reset) begin // @[\\src\\main\\scala\\Driver.scala 185:24]
      txTimer <= 24'h0; // @[\\src\\main\\scala\\Driver.scala 185:24]
    end else if (txTimer >= 24'h2625a0) begin // @[\\src\\main\\scala\\Driver.scala 190:30]
      if (!(2'h0 == txState)) begin // @[\\src\\main\\scala\\Driver.scala 191:21]
        if (2'h1 == txState) begin // @[\\src\\main\\scala\\Driver.scala 191:21]
          txTimer <= _GEN_91;
        end else begin
          txTimer <= _GEN_99;
        end
      end
    end else begin
      txTimer <= _txTimer_T_1; // @[\\src\\main\\scala\\Driver.scala 213:25]
    end
    if (reset) begin // @[\\src\\main\\scala\\Driver.scala 187:24]
      txState <= 2'h0; // @[\\src\\main\\scala\\Driver.scala 187:24]
    end else if (txTimer >= 24'h2625a0) begin // @[\\src\\main\\scala\\Driver.scala 190:30]
      if (2'h0 == txState) begin // @[\\src\\main\\scala\\Driver.scala 191:21]
        if (~tx_io_busy) begin // @[\\src\\main\\scala\\Driver.scala 193:27]
          txState <= 2'h1; // @[\\src\\main\\scala\\Driver.scala 196:19]
        end
      end else if (2'h1 == txState) begin // @[\\src\\main\\scala\\Driver.scala 191:21]
        txState <= _GEN_90;
      end else begin
        txState <= _GEN_98;
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
  ramp_timer = _RAND_15[17:0];
  _RAND_16 = {2{`RANDOM}};
  target_turns = _RAND_16[37:0];
  _RAND_17 = {1{`RANDOM}};
  pid_offset = _RAND_17[27:0];
  _RAND_18 = {1{`RANDOM}};
  pwm_signal_io_duty_cycle_REG = _RAND_18[27:0];
  _RAND_19 = {1{`RANDOM}};
  txTimer = _RAND_19[23:0];
  _RAND_20 = {1{`RANDOM}};
  txState = _RAND_20[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
