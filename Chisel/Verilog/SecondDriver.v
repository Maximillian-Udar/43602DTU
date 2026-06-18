module UartRx(
  input        clock,
  input        reset,
  input        io_rx, // @[\\src\\main\\scala\\Functions.scala 123:14]
  output       io_done, // @[\\src\\main\\scala\\Functions.scala 123:14]
  output [7:0] io_data // @[\\src\\main\\scala\\Functions.scala 123:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg  rxReg_REG; // @[\\src\\main\\scala\\Functions.scala 130:33]
  reg  rxReg; // @[\\src\\main\\scala\\Functions.scala 130:25]
  reg [7:0] shiftReg; // @[\\src\\main\\scala\\Functions.scala 131:25]
  reg [31:0] cntReg; // @[\\src\\main\\scala\\Functions.scala 132:25]
  reg [3:0] bitsReg; // @[\\src\\main\\scala\\Functions.scala 133:25]
  reg [1:0] stateReg; // @[\\src\\main\\scala\\Functions.scala 135:25]
  wire [31:0] _cntReg_T_1 = cntReg + 32'h1; // @[\\src\\main\\scala\\Functions.scala 140:127]
  wire [9:0] _T_6 = 10'h364 - 10'h1; // @[\\src\\main\\scala\\Functions.scala 141:41]
  wire [31:0] _GEN_32 = {{22'd0}, _T_6}; // @[\\src\\main\\scala\\Functions.scala 141:29]
  wire  _T_7 = cntReg == _GEN_32; // @[\\src\\main\\scala\\Functions.scala 141:29]
  wire [7:0] _shiftReg_T_1 = {rxReg,shiftReg[7:1]}; // @[\\src\\main\\scala\\Functions.scala 141:80]
  wire [3:0] _bitsReg_T_1 = bitsReg + 4'h1; // @[\\src\\main\\scala\\Functions.scala 141:180]
  wire [1:0] _GEN_5 = bitsReg == 4'h7 ? 2'h3 : stateReg; // @[\\src\\main\\scala\\Functions.scala 141:{127,138} 135:25]
  wire [3:0] _GEN_6 = bitsReg == 4'h7 ? bitsReg : _bitsReg_T_1; // @[\\src\\main\\scala\\Functions.scala 141:127 133:25 141:169]
  wire [31:0] _GEN_7 = cntReg == _GEN_32 ? 32'h0 : _cntReg_T_1; // @[\\src\\main\\scala\\Functions.scala 141:{209,48,57}]
  wire [7:0] _GEN_8 = cntReg == _GEN_32 ? _shiftReg_T_1 : shiftReg; // @[\\src\\main\\scala\\Functions.scala 131:25 141:{48,74}]
  wire [1:0] _GEN_9 = cntReg == _GEN_32 ? _GEN_5 : stateReg; // @[\\src\\main\\scala\\Functions.scala 135:25 141:48]
  wire [3:0] _GEN_10 = cntReg == _GEN_32 ? _GEN_6 : bitsReg; // @[\\src\\main\\scala\\Functions.scala 133:25 141:48]
  wire [1:0] _GEN_11 = _T_7 ? 2'h0 : stateReg; // @[\\src\\main\\scala\\Functions.scala 135:25 142:{48,59}]
  wire [31:0] _GEN_13 = _T_7 ? cntReg : _cntReg_T_1; // @[\\src\\main\\scala\\Functions.scala 132:25 142:{108,48}]
  wire [1:0] _GEN_14 = 2'h3 == stateReg ? _GEN_11 : stateReg; // @[\\src\\main\\scala\\Functions.scala 138:20 135:25]
  wire [31:0] _GEN_16 = 2'h3 == stateReg ? _GEN_13 : cntReg; // @[\\src\\main\\scala\\Functions.scala 138:20 132:25]
  wire  _GEN_21 = 2'h2 == stateReg ? 1'h0 : 2'h3 == stateReg & _T_7; // @[\\src\\main\\scala\\Functions.scala 136:11 138:20]
  wire  _GEN_26 = 2'h1 == stateReg ? 1'h0 : _GEN_21; // @[\\src\\main\\scala\\Functions.scala 136:11 138:20]
  assign io_done = 2'h0 == stateReg ? 1'h0 : _GEN_26; // @[\\src\\main\\scala\\Functions.scala 136:11 138:20]
  assign io_data = shiftReg; // @[\\src\\main\\scala\\Functions.scala 137:11]
  always @(posedge clock) begin
    rxReg_REG <= io_rx; // @[\\src\\main\\scala\\Functions.scala 130:33]
    rxReg <= rxReg_REG; // @[\\src\\main\\scala\\Functions.scala 130:25]
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 131:25]
      shiftReg <= 8'h0; // @[\\src\\main\\scala\\Functions.scala 131:25]
    end else if (!(2'h0 == stateReg)) begin // @[\\src\\main\\scala\\Functions.scala 138:20]
      if (!(2'h1 == stateReg)) begin // @[\\src\\main\\scala\\Functions.scala 138:20]
        if (2'h2 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 138:20]
          shiftReg <= _GEN_8;
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 132:25]
      cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 132:25]
    end else if (2'h0 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 138:20]
      if (~rxReg) begin // @[\\src\\main\\scala\\Functions.scala 139:30]
        cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 139:59]
      end
    end else if (2'h1 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 138:20]
      if (cntReg == 32'h1b2) begin // @[\\src\\main\\scala\\Functions.scala 140:45]
        cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 140:73]
      end else begin
        cntReg <= _cntReg_T_1; // @[\\src\\main\\scala\\Functions.scala 140:117]
      end
    end else if (2'h2 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 138:20]
      cntReg <= _GEN_7;
    end else begin
      cntReg <= _GEN_16;
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 133:25]
      bitsReg <= 4'h0; // @[\\src\\main\\scala\\Functions.scala 133:25]
    end else if (!(2'h0 == stateReg)) begin // @[\\src\\main\\scala\\Functions.scala 138:20]
      if (2'h1 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 138:20]
        if (cntReg == 32'h1b2) begin // @[\\src\\main\\scala\\Functions.scala 140:45]
          bitsReg <= 4'h0; // @[\\src\\main\\scala\\Functions.scala 140:89]
        end
      end else if (2'h2 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 138:20]
        bitsReg <= _GEN_10;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 135:25]
      stateReg <= 2'h0; // @[\\src\\main\\scala\\Functions.scala 135:25]
    end else if (2'h0 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 138:20]
      if (~rxReg) begin // @[\\src\\main\\scala\\Functions.scala 139:30]
        stateReg <= 2'h1; // @[\\src\\main\\scala\\Functions.scala 139:41]
      end
    end else if (2'h1 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 138:20]
      if (cntReg == 32'h1b2) begin // @[\\src\\main\\scala\\Functions.scala 140:45]
        stateReg <= 2'h2; // @[\\src\\main\\scala\\Functions.scala 140:56]
      end
    end else if (2'h2 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 138:20]
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
  input  [7:0] io_data, // @[\\src\\main\\scala\\Functions.scala 147:14]
  input        io_start, // @[\\src\\main\\scala\\Functions.scala 147:14]
  output       io_tx, // @[\\src\\main\\scala\\Functions.scala 147:14]
  output       io_busy // @[\\src\\main\\scala\\Functions.scala 147:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [9:0] reg_; // @[\\src\\main\\scala\\Functions.scala 154:20]
  reg [31:0] cnt; // @[\\src\\main\\scala\\Functions.scala 155:20]
  reg [3:0] bits; // @[\\src\\main\\scala\\Functions.scala 156:21]
  reg  state; // @[\\src\\main\\scala\\Functions.scala 158:22]
  wire [9:0] _reg_T = {1'h1,io_data,1'h0}; // @[\\src\\main\\scala\\Functions.scala 162:44]
  wire  _GEN_3 = io_start | state; // @[\\src\\main\\scala\\Functions.scala 158:22 162:{32,96}]
  wire [9:0] _T_3 = 10'h364 - 10'h1; // @[\\src\\main\\scala\\Functions.scala 163:38]
  wire [31:0] _GEN_18 = {{22'd0}, _T_3}; // @[\\src\\main\\scala\\Functions.scala 163:26]
  wire [9:0] _reg_T_2 = {1'h1,reg_[9:1]}; // @[\\src\\main\\scala\\Functions.scala 163:69]
  wire [3:0] _bits_T_1 = bits + 4'h1; // @[\\src\\main\\scala\\Functions.scala 163:150]
  wire  _GEN_4 = bits == 4'h9 ? 1'h0 : state; // @[\\src\\main\\scala\\Functions.scala 163:{106,114} 158:22]
  wire [3:0] _GEN_5 = bits == 4'h9 ? bits : _bits_T_1; // @[\\src\\main\\scala\\Functions.scala 163:106 156:21 163:142]
  wire [31:0] _cnt_T_1 = cnt + 32'h1; // @[\\src\\main\\scala\\Functions.scala 163:183]
  assign io_tx = reg_[0]; // @[\\src\\main\\scala\\Functions.scala 159:15]
  assign io_busy = state; // @[\\src\\main\\scala\\Functions.scala 160:20]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 154:20]
      reg_ <= 10'h1; // @[\\src\\main\\scala\\Functions.scala 154:20]
    end else if (~state) begin // @[\\src\\main\\scala\\Functions.scala 161:17]
      if (io_start) begin // @[\\src\\main\\scala\\Functions.scala 162:32]
        reg_ <= _reg_T; // @[\\src\\main\\scala\\Functions.scala 162:38]
      end
    end else if (state) begin // @[\\src\\main\\scala\\Functions.scala 161:17]
      if (cnt == _GEN_18) begin // @[\\src\\main\\scala\\Functions.scala 163:45]
        reg_ <= _reg_T_2; // @[\\src\\main\\scala\\Functions.scala 163:63]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 155:20]
      cnt <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 155:20]
    end else if (~state) begin // @[\\src\\main\\scala\\Functions.scala 161:17]
      if (io_start) begin // @[\\src\\main\\scala\\Functions.scala 162:32]
        cnt <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 162:82]
      end
    end else if (state) begin // @[\\src\\main\\scala\\Functions.scala 161:17]
      if (cnt == _GEN_18) begin // @[\\src\\main\\scala\\Functions.scala 163:45]
        cnt <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 163:51]
      end else begin
        cnt <= _cnt_T_1; // @[\\src\\main\\scala\\Functions.scala 163:176]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 156:21]
      bits <= 4'h0; // @[\\src\\main\\scala\\Functions.scala 156:21]
    end else if (~state) begin // @[\\src\\main\\scala\\Functions.scala 161:17]
      if (io_start) begin // @[\\src\\main\\scala\\Functions.scala 162:32]
        bits <= 4'h0; // @[\\src\\main\\scala\\Functions.scala 162:70]
      end
    end else if (state) begin // @[\\src\\main\\scala\\Functions.scala 161:17]
      if (cnt == _GEN_18) begin // @[\\src\\main\\scala\\Functions.scala 163:45]
        bits <= _GEN_5;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 158:22]
      state <= 1'h0; // @[\\src\\main\\scala\\Functions.scala 158:22]
    end else if (~state) begin // @[\\src\\main\\scala\\Functions.scala 161:17]
      state <= _GEN_3;
    end else if (state) begin // @[\\src\\main\\scala\\Functions.scala 161:17]
      if (cnt == _GEN_18) begin // @[\\src\\main\\scala\\Functions.scala 163:45]
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
  input  [9:0] io_duty_cycle, // @[\\src\\main\\scala\\Functions.scala 32:14]
  input        io_brake, // @[\\src\\main\\scala\\Functions.scala 32:14]
  output       io_T1, // @[\\src\\main\\scala\\Functions.scala 32:14]
  output       io_T2, // @[\\src\\main\\scala\\Functions.scala 32:14]
  output       io_T3, // @[\\src\\main\\scala\\Functions.scala 32:14]
  output       io_T4 // @[\\src\\main\\scala\\Functions.scala 32:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] pwmCounter; // @[\\src\\main\\scala\\Functions.scala 43:29]
  wire [12:0] _T_1 = 13'h11c1 - 13'h1; // @[\\src\\main\\scala\\Functions.scala 45:35]
  wire [31:0] _GEN_5 = {{19'd0}, _T_1}; // @[\\src\\main\\scala\\Functions.scala 45:19]
  wire [31:0] _pwmCounter_T_1 = pwmCounter + 32'h1; // @[\\src\\main\\scala\\Functions.scala 48:30]
  wire [22:0] _threshold_T = io_duty_cycle * 13'h11c1; // @[\\src\\main\\scala\\Functions.scala 51:34]
  wire [12:0] threshold = _threshold_T[22:10]; // @[\\src\\main\\scala\\Functions.scala 51:50]
  wire [31:0] _GEN_6 = {{19'd0}, threshold}; // @[\\src\\main\\scala\\Functions.scala 52:30]
  wire  pwmSignal = pwmCounter < _GEN_6; // @[\\src\\main\\scala\\Functions.scala 52:30]
  wire  _conduct_T4_T = ~pwmSignal; // @[\\src\\main\\scala\\Functions.scala 67:19]
  wire  conduct_T2 = io_brake ? 1'h0 : pwmSignal; // @[\\src\\main\\scala\\Functions.scala 59:18 61:16 65:16]
  wire  conduct_T4 = io_brake ? 1'h0 : ~pwmSignal; // @[\\src\\main\\scala\\Functions.scala 59:18 63:16 67:16]
  assign io_T1 = io_brake | _conduct_T4_T; // @[\\src\\main\\scala\\Functions.scala 59:18 60:16 68:16]
  assign io_T2 = ~conduct_T2; // @[\\src\\main\\scala\\Functions.scala 73:12]
  assign io_T3 = io_brake | pwmSignal; // @[\\src\\main\\scala\\Functions.scala 59:18 62:16 66:16]
  assign io_T4 = ~conduct_T4; // @[\\src\\main\\scala\\Functions.scala 74:12]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 43:29]
      pwmCounter <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 43:29]
    end else if (pwmCounter >= _GEN_5) begin // @[\\src\\main\\scala\\Functions.scala 45:42]
      pwmCounter <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 46:16]
    end else begin
      pwmCounter <= _pwmCounter_T_1; // @[\\src\\main\\scala\\Functions.scala 48:16]
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
  input  [31:0] io_setPoint, // @[\\src\\main\\scala\\Functions.scala 78:14]
  input  [31:0] io_measuredVal, // @[\\src\\main\\scala\\Functions.scala 78:14]
  input         io_resetBuffer, // @[\\src\\main\\scala\\Functions.scala 78:14]
  output [31:0] io_controlOut // @[\\src\\main\\scala\\Functions.scala 78:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [63:0] _RAND_6;
  reg [63:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] integralReg; // @[\\src\\main\\scala\\Functions.scala 89:29]
  reg [31:0] prevErrorReg; // @[\\src\\main\\scala\\Functions.scala 90:29]
  reg [31:0] outputReg; // @[\\src\\main\\scala\\Functions.scala 91:29]
  wire [31:0] error = $signed(io_setPoint) - $signed(io_measuredVal); // @[\\src\\main\\scala\\Functions.scala 96:27]
  reg [63:0] pTerm; // @[\\src\\main\\scala\\Functions.scala 104:24]
  reg [63:0] iTermNext; // @[\\src\\main\\scala\\Functions.scala 105:28]
  wire [43:0] _GEN_6 = {$signed(integralReg), 12'h0}; // @[\\src\\main\\scala\\Functions.scala 106:41]
  wire [63:0] _GEN_7 = {{20{_GEN_6[43]}},_GEN_6}; // @[\\src\\main\\scala\\Functions.scala 106:41]
  reg [63:0] nextSum; // @[\\src\\main\\scala\\Functions.scala 106:28]
  wire [63:0] _integralReg_T_2 = $signed(nextSum) < -64'sh800000 ? $signed(-64'sh800000) : $signed(nextSum); // @[\\src\\main\\scala\\Functions.scala 108:23]
  wire [63:0] _integralReg_T_3 = $signed(nextSum) > 64'sh800000 ? $signed(64'sh800000) : $signed(_integralReg_T_2); // @[\\src\\main\\scala\\Functions.scala 107:23]
  wire [31:0] _dTerm_T_2 = $signed(error) - $signed(prevErrorReg); // @[\\src\\main\\scala\\Functions.scala 111:40]
  reg [63:0] dTerm; // @[\\src\\main\\scala\\Functions.scala 111:24]
  wire [63:0] _rawOutput_T_2 = $signed(pTerm) + $signed(_GEN_7); // @[\\src\\main\\scala\\Functions.scala 115:35]
  reg [63:0] rawOutput; // @[\\src\\main\\scala\\Functions.scala 115:28]
  wire [63:0] _outputReg_T_2 = $signed(rawOutput) < -64'sh800000 ? $signed(-64'sh800000) : $signed(rawOutput); // @[\\src\\main\\scala\\Functions.scala 117:21]
  wire [63:0] _outputReg_T_3 = $signed(rawOutput) > 64'sh800000 ? $signed(64'sh800000) : $signed(_outputReg_T_2); // @[\\src\\main\\scala\\Functions.scala 116:21]
  wire [63:0] _GEN_3 = io_resetBuffer ? $signed(64'sh0) : $signed(_integralReg_T_3); // @[\\src\\main\\scala\\Functions.scala 98:24 99:18]
  wire [63:0] _GEN_5 = io_resetBuffer ? $signed(64'sh0) : $signed(_outputReg_T_3); // @[\\src\\main\\scala\\Functions.scala 101:18 98:24]
  wire [51:0] _GEN_10 = reset ? $signed(52'sh0) : $signed(_GEN_3[63:12]); // @[\\src\\main\\scala\\Functions.scala 89:{29,29}]
  wire [51:0] _GEN_12 = reset ? $signed(52'sh0) : $signed(_GEN_5[63:12]); // @[\\src\\main\\scala\\Functions.scala 91:{29,29}]
  assign io_controlOut = outputReg; // @[\\src\\main\\scala\\Functions.scala 119:17]
  always @(posedge clock) begin
    integralReg <= _GEN_10[31:0]; // @[\\src\\main\\scala\\Functions.scala 89:{29,29}]
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 90:29]
      prevErrorReg <= 32'sh0; // @[\\src\\main\\scala\\Functions.scala 90:29]
    end else if (io_resetBuffer) begin // @[\\src\\main\\scala\\Functions.scala 98:24]
      prevErrorReg <= 32'sh0; // @[\\src\\main\\scala\\Functions.scala 100:18]
    end else begin
      prevErrorReg <= error;
    end
    outputReg <= _GEN_12[31:0]; // @[\\src\\main\\scala\\Functions.scala 91:{29,29}]
    pTerm <= 32'sh1000 * $signed(error); // @[\\src\\main\\scala\\Functions.scala 104:31]
    iTermNext <= 32'sh800 * $signed(error); // @[\\src\\main\\scala\\Functions.scala 105:35]
    nextSum <= $signed(_GEN_7) + $signed(iTermNext); // @[\\src\\main\\scala\\Functions.scala 106:41]
    dTerm <= 32'sh19a * $signed(_dTerm_T_2); // @[\\src\\main\\scala\\Functions.scala 111:31]
    rawOutput <= $signed(_rawOutput_T_2) + $signed(dTerm); // @[\\src\\main\\scala\\Functions.scala 115:49]
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
  _RAND_3 = {2{`RANDOM}};
  pTerm = _RAND_3[63:0];
  _RAND_4 = {2{`RANDOM}};
  iTermNext = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  nextSum = _RAND_5[63:0];
  _RAND_6 = {2{`RANDOM}};
  dTerm = _RAND_6[63:0];
  _RAND_7 = {2{`RANDOM}};
  rawOutput = _RAND_7[63:0];
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
  input   io_external_overcurrent_input, // @[\\src\\main\\scala\\Functions.scala 168:14]
  input   io_clear_shutdown, // @[\\src\\main\\scala\\Functions.scala 168:14]
  output  io_motor_disable // @[\\src\\main\\scala\\Functions.scala 168:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [24:0] maxCycles = 17'h186a0 * 8'h96; // @[\\src\\main\\scala\\Functions.scala 174:44]
  reg [31:0] durationReg; // @[\\src\\main\\scala\\Functions.scala 175:28]
  reg  isStuckReg; // @[\\src\\main\\scala\\Functions.scala 176:28]
  wire [31:0] _GEN_8 = {{7'd0}, maxCycles}; // @[\\src\\main\\scala\\Functions.scala 180:26]
  wire [31:0] _durationReg_T_1 = durationReg + 32'h1; // @[\\src\\main\\scala\\Functions.scala 180:104]
  wire  _GEN_0 = durationReg >= _GEN_8 | isStuckReg; // @[\\src\\main\\scala\\Functions.scala 176:28 180:{40,53}]
  wire [31:0] _GEN_1 = durationReg >= _GEN_8 ? durationReg : _durationReg_T_1; // @[\\src\\main\\scala\\Functions.scala 175:28 180:{40,89}]
  assign io_motor_disable = isStuckReg; // @[\\src\\main\\scala\\Functions.scala 184:20]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 175:28]
      durationReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 175:28]
    end else if (io_clear_shutdown) begin // @[\\src\\main\\scala\\Functions.scala 177:27]
      durationReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 177:64]
    end else if (~isStuckReg) begin // @[\\src\\main\\scala\\Functions.scala 178:23]
      if (io_external_overcurrent_input) begin // @[\\src\\main\\scala\\Functions.scala 179:43]
        durationReg <= _GEN_1;
      end else begin
        durationReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 181:33]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 176:28]
      isStuckReg <= 1'h0; // @[\\src\\main\\scala\\Functions.scala 176:28]
    end else if (io_clear_shutdown) begin // @[\\src\\main\\scala\\Functions.scala 177:27]
      isStuckReg <= 1'h0; // @[\\src\\main\\scala\\Functions.scala 177:40]
    end else if (~isStuckReg) begin // @[\\src\\main\\scala\\Functions.scala 178:23]
      if (io_external_overcurrent_input) begin // @[\\src\\main\\scala\\Functions.scala 179:43]
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
  input  [4:0] io_in, // @[\\src\\main\\scala\\Functions.scala 236:14]
  output [6:0] io_out // @[\\src\\main\\scala\\Functions.scala 236:14]
);
  wire [6:0] _io_out_T_33 = 5'h0 == io_in ? 7'h3f : 7'h0; // @[\\src\\main\\scala\\Functions.scala 241:46]
  wire [6:0] _io_out_T_35 = 5'h1 == io_in ? 7'h6 : _io_out_T_33; // @[\\src\\main\\scala\\Functions.scala 241:46]
  wire [6:0] _io_out_T_37 = 5'h2 == io_in ? 7'h5b : _io_out_T_35; // @[\\src\\main\\scala\\Functions.scala 241:46]
  wire [6:0] _io_out_T_39 = 5'h3 == io_in ? 7'h4f : _io_out_T_37; // @[\\src\\main\\scala\\Functions.scala 241:46]
  wire [6:0] _io_out_T_41 = 5'h4 == io_in ? 7'h66 : _io_out_T_39; // @[\\src\\main\\scala\\Functions.scala 241:46]
  wire [6:0] _io_out_T_43 = 5'h5 == io_in ? 7'h6d : _io_out_T_41; // @[\\src\\main\\scala\\Functions.scala 241:46]
  wire [6:0] _io_out_T_45 = 5'h6 == io_in ? 7'h7d : _io_out_T_43; // @[\\src\\main\\scala\\Functions.scala 241:46]
  wire [6:0] _io_out_T_47 = 5'h7 == io_in ? 7'h7 : _io_out_T_45; // @[\\src\\main\\scala\\Functions.scala 241:46]
  wire [6:0] _io_out_T_49 = 5'h8 == io_in ? 7'h7f : _io_out_T_47; // @[\\src\\main\\scala\\Functions.scala 241:46]
  wire [6:0] _io_out_T_51 = 5'h9 == io_in ? 7'h6f : _io_out_T_49; // @[\\src\\main\\scala\\Functions.scala 241:46]
  wire [6:0] _io_out_T_53 = 5'ha == io_in ? 7'h77 : _io_out_T_51; // @[\\src\\main\\scala\\Functions.scala 241:46]
  wire [6:0] _io_out_T_55 = 5'hb == io_in ? 7'h7c : _io_out_T_53; // @[\\src\\main\\scala\\Functions.scala 241:46]
  wire [6:0] _io_out_T_57 = 5'hc == io_in ? 7'h39 : _io_out_T_55; // @[\\src\\main\\scala\\Functions.scala 241:46]
  wire [6:0] _io_out_T_59 = 5'hd == io_in ? 7'h5e : _io_out_T_57; // @[\\src\\main\\scala\\Functions.scala 241:46]
  wire [6:0] _io_out_T_61 = 5'he == io_in ? 7'h79 : _io_out_T_59; // @[\\src\\main\\scala\\Functions.scala 241:46]
  wire [6:0] _io_out_T_63 = 5'hf == io_in ? 7'h71 : _io_out_T_61; // @[\\src\\main\\scala\\Functions.scala 241:46]
  wire [6:0] _io_out_T_65 = 5'h10 == io_in ? 7'h3c : _io_out_T_63; // @[\\src\\main\\scala\\Functions.scala 241:46]
  wire [6:0] _io_out_T_67 = 5'h11 == io_in ? 7'h76 : _io_out_T_65; // @[\\src\\main\\scala\\Functions.scala 241:46]
  wire [6:0] _io_out_T_69 = 5'h12 == io_in ? 7'h6 : _io_out_T_67; // @[\\src\\main\\scala\\Functions.scala 241:46]
  wire [6:0] _io_out_T_71 = 5'h13 == io_in ? 7'hf : _io_out_T_69; // @[\\src\\main\\scala\\Functions.scala 241:46]
  wire [6:0] _io_out_T_73 = 5'h14 == io_in ? 7'h38 : _io_out_T_71; // @[\\src\\main\\scala\\Functions.scala 241:46]
  wire [6:0] _io_out_T_75 = 5'h15 == io_in ? 7'h38 : _io_out_T_73; // @[\\src\\main\\scala\\Functions.scala 241:46]
  wire [6:0] _io_out_T_77 = 5'h16 == io_in ? 7'h70 : _io_out_T_75; // @[\\src\\main\\scala\\Functions.scala 241:46]
  wire [6:0] _io_out_T_79 = 5'h17 == io_in ? 7'h3f : _io_out_T_77; // @[\\src\\main\\scala\\Functions.scala 241:46]
  wire [6:0] _io_out_T_81 = 5'h18 == io_in ? 7'h73 : _io_out_T_79; // @[\\src\\main\\scala\\Functions.scala 241:46]
  wire [6:0] _io_out_T_83 = 5'h19 == io_in ? 7'h67 : _io_out_T_81; // @[\\src\\main\\scala\\Functions.scala 241:46]
  wire [6:0] _io_out_T_85 = 5'h1a == io_in ? 7'h31 : _io_out_T_83; // @[\\src\\main\\scala\\Functions.scala 241:46]
  wire [6:0] _io_out_T_87 = 5'h1b == io_in ? 7'h6d : _io_out_T_85; // @[\\src\\main\\scala\\Functions.scala 241:46]
  wire [6:0] _io_out_T_89 = 5'h1c == io_in ? 7'h78 : _io_out_T_87; // @[\\src\\main\\scala\\Functions.scala 241:46]
  wire [6:0] _io_out_T_91 = 5'h1d == io_in ? 7'h3e : _io_out_T_89; // @[\\src\\main\\scala\\Functions.scala 241:46]
  assign io_out = 5'h1e == io_in ? 7'h0 : _io_out_T_91; // @[\\src\\main\\scala\\Functions.scala 241:46]
endmodule
module DisplayMultiplexer(
  input         clock,
  input         reset,
  input  [19:0] io_disp_content, // @[\\src\\main\\scala\\Functions.scala 188:14]
  output [7:0]  io_seg, // @[\\src\\main\\scala\\Functions.scala 188:14]
  output [3:0]  io_an // @[\\src\\main\\scala\\Functions.scala 188:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [4:0] decoder_io_in; // @[\\src\\main\\scala\\Functions.scala 211:23]
  wire [6:0] decoder_io_out; // @[\\src\\main\\scala\\Functions.scala 211:23]
  reg [16:0] cnt; // @[\\src\\main\\scala\\Functions.scala 195:20]
  wire  _cnt_T = cnt == 17'h1869f; // @[\\src\\main\\scala\\Functions.scala 196:18]
  wire [16:0] _cnt_T_2 = cnt + 17'h1; // @[\\src\\main\\scala\\Functions.scala 196:54]
  reg [1:0] digit; // @[\\src\\main\\scala\\Functions.scala 199:22]
  wire [1:0] _digit_T_1 = digit + 2'h1; // @[\\src\\main\\scala\\Functions.scala 200:31]
  wire  _T = 2'h0 == digit; // @[\\src\\main\\scala\\Functions.scala 204:17]
  wire  _T_1 = 2'h1 == digit; // @[\\src\\main\\scala\\Functions.scala 204:17]
  wire  _T_2 = 2'h2 == digit; // @[\\src\\main\\scala\\Functions.scala 204:17]
  wire  _T_3 = 2'h3 == digit; // @[\\src\\main\\scala\\Functions.scala 204:17]
  wire [4:0] _GEN_1 = 2'h3 == digit ? io_disp_content[19:15] : 5'h0; // @[\\src\\main\\scala\\Functions.scala 203:14 204:17 208:26]
  wire [4:0] _GEN_2 = 2'h2 == digit ? io_disp_content[14:10] : _GEN_1; // @[\\src\\main\\scala\\Functions.scala 204:17 207:26]
  wire [4:0] _GEN_3 = 2'h1 == digit ? io_disp_content[9:5] : _GEN_2; // @[\\src\\main\\scala\\Functions.scala 204:17 206:26]
  wire [3:0] _currentDot_T = 4'h0 >> digit; // @[\\src\\main\\scala\\Functions.scala 215:27]
  wire  currentDot = _currentDot_T[0]; // @[\\src\\main\\scala\\Functions.scala 215:27]
  wire [7:0] fullSeg = {currentDot,decoder_io_out}; // @[\\src\\main\\scala\\Functions.scala 216:28]
  wire [3:0] _GEN_5 = _T_3 ? 4'h8 : 4'h1; // @[\\src\\main\\scala\\Functions.scala 219:17 223:22 218:27]
  wire [3:0] _GEN_6 = _T_2 ? 4'h4 : _GEN_5; // @[\\src\\main\\scala\\Functions.scala 219:17 222:22]
  wire [3:0] _GEN_7 = _T_1 ? 4'h2 : _GEN_6; // @[\\src\\main\\scala\\Functions.scala 219:17 221:22]
  wire [3:0] select = _T ? 4'h1 : _GEN_7; // @[\\src\\main\\scala\\Functions.scala 219:17 220:22]
  SevenSegDec decoder ( // @[\\src\\main\\scala\\Functions.scala 211:23]
    .io_in(decoder_io_in),
    .io_out(decoder_io_out)
  );
  assign io_seg = ~fullSeg; // @[\\src\\main\\scala\\Functions.scala 226:13]
  assign io_an = ~select; // @[\\src\\main\\scala\\Functions.scala 227:13]
  assign decoder_io_in = 2'h0 == digit ? io_disp_content[4:0] : _GEN_3; // @[\\src\\main\\scala\\Functions.scala 204:17 205:26]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 195:20]
      cnt <= 17'h0; // @[\\src\\main\\scala\\Functions.scala 195:20]
    end else if (cnt == 17'h1869f) begin // @[\\src\\main\\scala\\Functions.scala 196:13]
      cnt <= 17'h0;
    end else begin
      cnt <= _cnt_T_2;
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 199:22]
      digit <= 2'h0; // @[\\src\\main\\scala\\Functions.scala 199:22]
    end else if (_cnt_T) begin // @[\\src\\main\\scala\\Functions.scala 200:14]
      digit <= _digit_T_1; // @[\\src\\main\\scala\\Functions.scala 200:22]
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
  reg  aSync_REG; // @[\\src\\main\\scala\\Functions.scala 12:31]
  reg  aSync; // @[\\src\\main\\scala\\Functions.scala 12:23]
  reg  bSync_REG; // @[\\src\\main\\scala\\Functions.scala 13:31]
  reg  bSync; // @[\\src\\main\\scala\\Functions.scala 13:23]
  reg  aReg; // @[\\src\\main\\scala\\Functions.scala 14:23]
  reg [31:0] turns; // @[\\src\\main\\scala\\Functions.scala 15:23]
  wire  edge_A = aSync & ~aReg; // @[\\src\\main\\scala\\Functions.scala 17:22]
  wire [31:0] _turns_T_1 = turns + 32'h1; // @[\\src\\main\\scala\\Functions.scala 21:22]
  wire [31:0] _turns_T_3 = turns - 32'h1; // @[\\src\\main\\scala\\Functions.scala 24:24]
  assign io_turns = turns; // @[\\src\\main\\scala\\Functions.scala 28:12]
  always @(posedge clock) begin
    aSync_REG <= io_signal_A; // @[\\src\\main\\scala\\Functions.scala 12:31]
    aSync <= aSync_REG; // @[\\src\\main\\scala\\Functions.scala 12:23]
    bSync_REG <= io_signal_B; // @[\\src\\main\\scala\\Functions.scala 13:31]
    bSync <= bSync_REG; // @[\\src\\main\\scala\\Functions.scala 13:23]
    aReg <= aSync; // @[\\src\\main\\scala\\Functions.scala 14:23]
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 15:23]
      turns <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 15:23]
    end else if (edge_A) begin // @[\\src\\main\\scala\\Functions.scala 19:16]
      if (~bSync) begin // @[\\src\\main\\scala\\Functions.scala 20:18]
        turns <= _turns_T_1; // @[\\src\\main\\scala\\Functions.scala 21:13]
      end else if (turns > 32'h0) begin // @[\\src\\main\\scala\\Functions.scala 23:25]
        turns <= _turns_T_3; // @[\\src\\main\\scala\\Functions.scala 24:15]
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
  input   io_btn_in, // @[\\src\\main\\scala\\Functions.scala 277:14]
  output  io_out // @[\\src\\main\\scala\\Functions.scala 277:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg  btn_sync_REG; // @[\\src\\main\\scala\\Functions.scala 282:33]
  reg  btn_sync; // @[\\src\\main\\scala\\Functions.scala 282:25]
  reg  btnDebReg; // @[\\src\\main\\scala\\Functions.scala 283:26]
  reg [31:0] cntReg; // @[\\src\\main\\scala\\Functions.scala 284:23]
  wire  tick = cntReg == 32'h1869f; // @[\\src\\main\\scala\\Functions.scala 285:21]
  wire [31:0] _cntReg_T_1 = cntReg + 32'h1; // @[\\src\\main\\scala\\Functions.scala 287:20]
  reg  btnCleanPrev; // @[\\src\\main\\scala\\Functions.scala 293:29]
  assign io_out = btnDebReg & ~btnCleanPrev; // @[\\src\\main\\scala\\Functions.scala 294:23]
  always @(posedge clock) begin
    btn_sync_REG <= io_btn_in; // @[\\src\\main\\scala\\Functions.scala 282:33]
    btn_sync <= btn_sync_REG; // @[\\src\\main\\scala\\Functions.scala 282:25]
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 283:26]
      btnDebReg <= 1'h0; // @[\\src\\main\\scala\\Functions.scala 283:26]
    end else if (tick) begin // @[\\src\\main\\scala\\Functions.scala 288:15]
      btnDebReg <= btn_sync; // @[\\src\\main\\scala\\Functions.scala 290:15]
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 284:23]
      cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 284:23]
    end else if (tick) begin // @[\\src\\main\\scala\\Functions.scala 288:15]
      cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 289:12]
    end else begin
      cntReg <= _cntReg_T_1; // @[\\src\\main\\scala\\Functions.scala 287:10]
    end
    btnCleanPrev <= btnDebReg; // @[\\src\\main\\scala\\Functions.scala 293:29]
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
  input        io_uart_rx, // @[\\src\\main\\scala\\SecondDriver.scala 6:14]
  input        io_photo_sensor_A, // @[\\src\\main\\scala\\SecondDriver.scala 6:14]
  input        io_photo_sensor_B, // @[\\src\\main\\scala\\SecondDriver.scala 6:14]
  input        io_over_current_positive, // @[\\src\\main\\scala\\SecondDriver.scala 6:14]
  input        io_over_current_negative, // @[\\src\\main\\scala\\SecondDriver.scala 6:14]
  input        io_error_cleared, // @[\\src\\main\\scala\\SecondDriver.scala 6:14]
  output       io_uart_tx, // @[\\src\\main\\scala\\SecondDriver.scala 6:14]
  output       io_T1, // @[\\src\\main\\scala\\SecondDriver.scala 6:14]
  output       io_T2, // @[\\src\\main\\scala\\SecondDriver.scala 6:14]
  output       io_T3, // @[\\src\\main\\scala\\SecondDriver.scala 6:14]
  output       io_T4, // @[\\src\\main\\scala\\SecondDriver.scala 6:14]
  output [7:0] io_seg, // @[\\src\\main\\scala\\SecondDriver.scala 6:14]
  output [3:0] io_an // @[\\src\\main\\scala\\SecondDriver.scala 6:14]
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
`endif // RANDOMIZE_REG_INIT
  wire  rx_clock; // @[\\src\\main\\scala\\SecondDriver.scala 29:18]
  wire  rx_reset; // @[\\src\\main\\scala\\SecondDriver.scala 29:18]
  wire  rx_io_rx; // @[\\src\\main\\scala\\SecondDriver.scala 29:18]
  wire  rx_io_done; // @[\\src\\main\\scala\\SecondDriver.scala 29:18]
  wire [7:0] rx_io_data; // @[\\src\\main\\scala\\SecondDriver.scala 29:18]
  wire  tx_clock; // @[\\src\\main\\scala\\SecondDriver.scala 30:18]
  wire  tx_reset; // @[\\src\\main\\scala\\SecondDriver.scala 30:18]
  wire [7:0] tx_io_data; // @[\\src\\main\\scala\\SecondDriver.scala 30:18]
  wire  tx_io_start; // @[\\src\\main\\scala\\SecondDriver.scala 30:18]
  wire  tx_io_tx; // @[\\src\\main\\scala\\SecondDriver.scala 30:18]
  wire  tx_io_busy; // @[\\src\\main\\scala\\SecondDriver.scala 30:18]
  wire  pwm_signal_clock; // @[\\src\\main\\scala\\SecondDriver.scala 31:26]
  wire  pwm_signal_reset; // @[\\src\\main\\scala\\SecondDriver.scala 31:26]
  wire [9:0] pwm_signal_io_duty_cycle; // @[\\src\\main\\scala\\SecondDriver.scala 31:26]
  wire  pwm_signal_io_brake; // @[\\src\\main\\scala\\SecondDriver.scala 31:26]
  wire  pwm_signal_io_T1; // @[\\src\\main\\scala\\SecondDriver.scala 31:26]
  wire  pwm_signal_io_T2; // @[\\src\\main\\scala\\SecondDriver.scala 31:26]
  wire  pwm_signal_io_T3; // @[\\src\\main\\scala\\SecondDriver.scala 31:26]
  wire  pwm_signal_io_T4; // @[\\src\\main\\scala\\SecondDriver.scala 31:26]
  wire  pid_clock; // @[\\src\\main\\scala\\SecondDriver.scala 32:19]
  wire  pid_reset; // @[\\src\\main\\scala\\SecondDriver.scala 32:19]
  wire [31:0] pid_io_setPoint; // @[\\src\\main\\scala\\SecondDriver.scala 32:19]
  wire [31:0] pid_io_measuredVal; // @[\\src\\main\\scala\\SecondDriver.scala 32:19]
  wire  pid_io_resetBuffer; // @[\\src\\main\\scala\\SecondDriver.scala 32:19]
  wire [31:0] pid_io_controlOut; // @[\\src\\main\\scala\\SecondDriver.scala 32:19]
  wire  stuck_detector_clock; // @[\\src\\main\\scala\\SecondDriver.scala 33:30]
  wire  stuck_detector_reset; // @[\\src\\main\\scala\\SecondDriver.scala 33:30]
  wire  stuck_detector_io_external_overcurrent_input; // @[\\src\\main\\scala\\SecondDriver.scala 33:30]
  wire  stuck_detector_io_clear_shutdown; // @[\\src\\main\\scala\\SecondDriver.scala 33:30]
  wire  stuck_detector_io_motor_disable; // @[\\src\\main\\scala\\SecondDriver.scala 33:30]
  wire  display_clock; // @[\\src\\main\\scala\\SecondDriver.scala 34:23]
  wire  display_reset; // @[\\src\\main\\scala\\SecondDriver.scala 34:23]
  wire [19:0] display_io_disp_content; // @[\\src\\main\\scala\\SecondDriver.scala 34:23]
  wire [7:0] display_io_seg; // @[\\src\\main\\scala\\SecondDriver.scala 34:23]
  wire [3:0] display_io_an; // @[\\src\\main\\scala\\SecondDriver.scala 34:23]
  wire  rotations_clock; // @[\\src\\main\\scala\\SecondDriver.scala 35:25]
  wire  rotations_reset; // @[\\src\\main\\scala\\SecondDriver.scala 35:25]
  wire  rotations_io_signal_A; // @[\\src\\main\\scala\\SecondDriver.scala 35:25]
  wire  rotations_io_signal_B; // @[\\src\\main\\scala\\SecondDriver.scala 35:25]
  wire [31:0] rotations_io_turns; // @[\\src\\main\\scala\\SecondDriver.scala 35:25]
  wire  error_clear_debounce_clock; // @[\\src\\main\\scala\\SecondDriver.scala 36:36]
  wire  error_clear_debounce_reset; // @[\\src\\main\\scala\\SecondDriver.scala 36:36]
  wire  error_clear_debounce_io_btn_in; // @[\\src\\main\\scala\\SecondDriver.scala 36:36]
  wire  error_clear_debounce_io_out; // @[\\src\\main\\scala\\SecondDriver.scala 36:36]
  wire [63:0] current_position_fixed_point = $signed(rotations_io_turns) * 32'sh222; // @[\\src\\main\\scala\\SecondDriver.scala 67:76]
  wire [51:0] current_position_cm = current_position_fixed_point[63:12]; // @[\\src\\main\\scala\\SecondDriver.scala 68:59]
  reg [31:0] target_position_cm; // @[\\src\\main\\scala\\SecondDriver.scala 71:35]
  reg [9:0] manual_speed; // @[\\src\\main\\scala\\SecondDriver.scala 72:29]
  reg  control_mode; // @[\\src\\main\\scala\\SecondDriver.scala 73:29]
  reg  manual_brake; // @[\\src\\main\\scala\\SecondDriver.scala 74:29]
  reg  system_active; // @[\\src\\main\\scala\\SecondDriver.scala 75:30]
  reg [1:0] uartState; // @[\\src\\main\\scala\\SecondDriver.scala 79:26]
  reg [7:0] CMDByte; // @[\\src\\main\\scala\\SecondDriver.scala 80:24]
  wire [14:0] _target_position_cm_T_1 = rx_io_data * 7'h64; // @[\\src\\main\\scala\\SecondDriver.scala 89:67]
  wire [9:0] _GEN_3 = 8'h4 == rx_io_data ? 10'h10e : manual_speed; // @[\\src\\main\\scala\\SecondDriver.scala 72:29 93:32 99:38]
  wire  _GEN_4 = 8'h4 == rx_io_data ? 1'h0 : 8'h5 == rx_io_data; // @[\\src\\main\\scala\\SecondDriver.scala 93:32 99:61]
  wire [9:0] _GEN_5 = 8'h3 == rx_io_data ? 10'h17c : _GEN_3; // @[\\src\\main\\scala\\SecondDriver.scala 93:32 98:38]
  wire  _GEN_6 = 8'h3 == rx_io_data ? 1'h0 : _GEN_4; // @[\\src\\main\\scala\\SecondDriver.scala 93:32 98:61]
  wire [9:0] _GEN_7 = 8'h2 == rx_io_data ? 10'h2ee : _GEN_5; // @[\\src\\main\\scala\\SecondDriver.scala 93:32 97:38]
  wire  _GEN_8 = 8'h2 == rx_io_data ? 1'h0 : _GEN_6; // @[\\src\\main\\scala\\SecondDriver.scala 93:32 97:61]
  wire [9:0] _GEN_9 = 8'h1 == rx_io_data ? 10'h2a8 : _GEN_7; // @[\\src\\main\\scala\\SecondDriver.scala 93:32 96:38]
  wire  _GEN_10 = 8'h1 == rx_io_data ? 1'h0 : _GEN_8; // @[\\src\\main\\scala\\SecondDriver.scala 93:32 96:61]
  wire [9:0] _GEN_11 = 8'h0 == rx_io_data ? 10'h200 : _GEN_9; // @[\\src\\main\\scala\\SecondDriver.scala 93:32 95:38]
  wire  _GEN_12 = 8'h0 == rx_io_data | _GEN_10; // @[\\src\\main\\scala\\SecondDriver.scala 93:32 95:61]
  wire  _GEN_14 = 8'h2 == CMDByte ? 1'h0 : control_mode; // @[\\src\\main\\scala\\SecondDriver.scala 88:25 91:26 73:29]
  wire  _GEN_15 = 8'h2 == CMDByte ? _GEN_12 : manual_brake; // @[\\src\\main\\scala\\SecondDriver.scala 88:25 74:29]
  wire [9:0] _GEN_16 = 8'h2 == CMDByte ? _GEN_11 : manual_speed; // @[\\src\\main\\scala\\SecondDriver.scala 88:25 72:29]
  wire  _GEN_17 = 8'h2 == CMDByte ? 1'h0 : 8'hff == CMDByte; // @[\\src\\main\\scala\\SecondDriver.scala 88:25 81:36]
  wire [31:0] _GEN_18 = 8'h1 == CMDByte ? $signed({{17{_target_position_cm_T_1[14]}},_target_position_cm_T_1}) :
    $signed(target_position_cm); // @[\\src\\main\\scala\\SecondDriver.scala 88:25 71:35 89:43]
  wire  _GEN_19 = 8'h1 == CMDByte | system_active; // @[\\src\\main\\scala\\SecondDriver.scala 88:25 75:30 89:89]
  wire  _GEN_20 = 8'h1 == CMDByte ? 1'h0 : _GEN_15; // @[\\src\\main\\scala\\SecondDriver.scala 88:25 89:113]
  wire  _GEN_21 = 8'h1 == CMDByte ? control_mode : _GEN_14; // @[\\src\\main\\scala\\SecondDriver.scala 88:25 73:29]
  wire [9:0] _GEN_22 = 8'h1 == CMDByte ? manual_speed : _GEN_16; // @[\\src\\main\\scala\\SecondDriver.scala 88:25 72:29]
  wire  _GEN_23 = 8'h1 == CMDByte ? 1'h0 : _GEN_17; // @[\\src\\main\\scala\\SecondDriver.scala 88:25 81:36]
  wire [31:0] _GEN_24 = 2'h2 == uartState ? $signed(_GEN_18) : $signed(target_position_cm); // @[\\src\\main\\scala\\SecondDriver.scala 84:23 71:35]
  wire  _GEN_25 = 2'h2 == uartState ? _GEN_19 : system_active; // @[\\src\\main\\scala\\SecondDriver.scala 84:23 75:30]
  wire  _GEN_26 = 2'h2 == uartState ? _GEN_20 : manual_brake; // @[\\src\\main\\scala\\SecondDriver.scala 84:23 74:29]
  wire  _GEN_27 = 2'h2 == uartState ? _GEN_21 : control_mode; // @[\\src\\main\\scala\\SecondDriver.scala 84:23 73:29]
  wire [9:0] _GEN_28 = 2'h2 == uartState ? _GEN_22 : manual_speed; // @[\\src\\main\\scala\\SecondDriver.scala 84:23 72:29]
  wire [1:0] _GEN_30 = 2'h2 == uartState ? 2'h0 : uartState; // @[\\src\\main\\scala\\SecondDriver.scala 105:19 84:23 79:26]
  wire  _GEN_36 = 2'h1 == uartState ? control_mode : _GEN_27; // @[\\src\\main\\scala\\SecondDriver.scala 84:23 73:29]
  wire  _GEN_38 = 2'h1 == uartState ? 1'h0 : 2'h2 == uartState & _GEN_23; // @[\\src\\main\\scala\\SecondDriver.scala 84:23 81:36]
  wire  _GEN_44 = 2'h0 == uartState ? control_mode : _GEN_36; // @[\\src\\main\\scala\\SecondDriver.scala 84:23 73:29]
  wire  _GEN_46 = 2'h0 == uartState ? 1'h0 : _GEN_38; // @[\\src\\main\\scala\\SecondDriver.scala 84:23 81:36]
  wire  _GEN_52 = rx_io_done ? _GEN_44 : control_mode; // @[\\src\\main\\scala\\SecondDriver.scala 83:21 73:29]
  wire  reset_triggered = rx_io_done & _GEN_46; // @[\\src\\main\\scala\\SecondDriver.scala 83:21 81:36]
  wire [51:0] _GEN_86 = {{20{target_position_cm[31]}},target_position_cm}; // @[\\src\\main\\scala\\SecondDriver.scala 112:58]
  wire  at_position = control_mode & $signed(_GEN_86) == $signed(current_position_cm); // @[\\src\\main\\scala\\SecondDriver.scala 112:35]
  wire  _pid_io_resetBuffer_T_2 = ~system_active; // @[\\src\\main\\scala\\SecondDriver.scala 116:58]
  wire [31:0] _pid_duty_raw_T_3 = $signed(pid_io_controlOut) + 32'sh800; // @[\\src\\main\\scala\\SecondDriver.scala 121:61]
  wire [31:0] pid_duty_raw = {{2'd0}, _pid_duty_raw_T_3[31:2]}; // @[\\src\\main\\scala\\SecondDriver.scala 121:68]
  wire [9:0] _pid_duty_T_2 = pid_duty_raw > 32'h3ff ? 10'h3ff : pid_duty_raw[9:0]; // @[\\src\\main\\scala\\SecondDriver.scala 122:45]
  wire [9:0] pid_duty = at_position ? 10'h200 : _pid_duty_T_2; // @[\\src\\main\\scala\\SecondDriver.scala 122:21]
  wire  motor_stopped = manual_brake | stuck_detector_io_motor_disable | _pid_io_resetBuffer_T_2 | at_position; // @[\\src\\main\\scala\\SecondDriver.scala 124:89]
  reg [23:0] txTimer; // @[\\src\\main\\scala\\SecondDriver.scala 141:24]
  reg [1:0] txState; // @[\\src\\main\\scala\\SecondDriver.scala 143:24]
  wire  _T_16 = ~tx_io_busy; // @[\\src\\main\\scala\\SecondDriver.scala 149:14]
  wire [7:0] _GEN_59 = ~tx_io_busy ? 8'hff : 8'h0; // @[\\src\\main\\scala\\SecondDriver.scala 144:14 149:27 150:22]
  wire [7:0] _GEN_62 = _T_16 ? current_position_cm[15:8] : 8'h0; // @[\\src\\main\\scala\\SecondDriver.scala 144:14 155:27 156:22]
  wire [1:0] _GEN_64 = _T_16 ? 2'h2 : txState; // @[\\src\\main\\scala\\SecondDriver.scala 155:27 158:19 143:24]
  wire [23:0] _GEN_65 = _T_16 ? 24'h0 : txTimer; // @[\\src\\main\\scala\\SecondDriver.scala 155:27 159:19 141:24]
  wire [7:0] _GEN_66 = _T_16 ? current_position_cm[7:0] : 8'h0; // @[\\src\\main\\scala\\SecondDriver.scala 144:14 162:27 163:22]
  wire [1:0] _GEN_68 = _T_16 ? 2'h0 : txState; // @[\\src\\main\\scala\\SecondDriver.scala 162:27 165:19 143:24]
  wire [7:0] _GEN_70 = 2'h2 == txState ? _GEN_66 : 8'h0; // @[\\src\\main\\scala\\SecondDriver.scala 144:14 147:21]
  wire  _GEN_71 = 2'h2 == txState & _T_16; // @[\\src\\main\\scala\\SecondDriver.scala 145:15 147:21]
  wire [1:0] _GEN_72 = 2'h2 == txState ? _GEN_68 : txState; // @[\\src\\main\\scala\\SecondDriver.scala 147:21 143:24]
  wire [23:0] _GEN_73 = 2'h2 == txState ? _GEN_65 : txTimer; // @[\\src\\main\\scala\\SecondDriver.scala 147:21 141:24]
  wire [7:0] _GEN_74 = 2'h1 == txState ? _GEN_62 : _GEN_70; // @[\\src\\main\\scala\\SecondDriver.scala 147:21]
  wire  _GEN_75 = 2'h1 == txState ? _T_16 : _GEN_71; // @[\\src\\main\\scala\\SecondDriver.scala 147:21]
  wire [7:0] _GEN_78 = 2'h0 == txState ? _GEN_59 : _GEN_74; // @[\\src\\main\\scala\\SecondDriver.scala 147:21]
  wire  _GEN_79 = 2'h0 == txState ? _T_16 : _GEN_75; // @[\\src\\main\\scala\\SecondDriver.scala 147:21]
  wire [23:0] _txTimer_T_1 = txTimer + 24'h1; // @[\\src\\main\\scala\\SecondDriver.scala 170:36]
  UartRx rx ( // @[\\src\\main\\scala\\SecondDriver.scala 29:18]
    .clock(rx_clock),
    .reset(rx_reset),
    .io_rx(rx_io_rx),
    .io_done(rx_io_done),
    .io_data(rx_io_data)
  );
  UartTx tx ( // @[\\src\\main\\scala\\SecondDriver.scala 30:18]
    .clock(tx_clock),
    .reset(tx_reset),
    .io_data(tx_io_data),
    .io_start(tx_io_start),
    .io_tx(tx_io_tx),
    .io_busy(tx_io_busy)
  );
  DCMotorPwm pwm_signal ( // @[\\src\\main\\scala\\SecondDriver.scala 31:26]
    .clock(pwm_signal_clock),
    .reset(pwm_signal_reset),
    .io_duty_cycle(pwm_signal_io_duty_cycle),
    .io_brake(pwm_signal_io_brake),
    .io_T1(pwm_signal_io_T1),
    .io_T2(pwm_signal_io_T2),
    .io_T3(pwm_signal_io_T3),
    .io_T4(pwm_signal_io_T4)
  );
  PIDController pid ( // @[\\src\\main\\scala\\SecondDriver.scala 32:19]
    .clock(pid_clock),
    .reset(pid_reset),
    .io_setPoint(pid_io_setPoint),
    .io_measuredVal(pid_io_measuredVal),
    .io_resetBuffer(pid_io_resetBuffer),
    .io_controlOut(pid_io_controlOut)
  );
  StuckDetector stuck_detector ( // @[\\src\\main\\scala\\SecondDriver.scala 33:30]
    .clock(stuck_detector_clock),
    .reset(stuck_detector_reset),
    .io_external_overcurrent_input(stuck_detector_io_external_overcurrent_input),
    .io_clear_shutdown(stuck_detector_io_clear_shutdown),
    .io_motor_disable(stuck_detector_io_motor_disable)
  );
  DisplayMultiplexer display ( // @[\\src\\main\\scala\\SecondDriver.scala 34:23]
    .clock(display_clock),
    .reset(display_reset),
    .io_disp_content(display_io_disp_content),
    .io_seg(display_io_seg),
    .io_an(display_io_an)
  );
  RotationCounter rotations ( // @[\\src\\main\\scala\\SecondDriver.scala 35:25]
    .clock(rotations_clock),
    .reset(rotations_reset),
    .io_signal_A(rotations_io_signal_A),
    .io_signal_B(rotations_io_signal_B),
    .io_turns(rotations_io_turns)
  );
  Debouncer error_clear_debounce ( // @[\\src\\main\\scala\\SecondDriver.scala 36:36]
    .clock(error_clear_debounce_clock),
    .reset(error_clear_debounce_reset),
    .io_btn_in(error_clear_debounce_io_btn_in),
    .io_out(error_clear_debounce_io_out)
  );
  assign io_uart_tx = tx_io_tx; // @[\\src\\main\\scala\\SecondDriver.scala 171:14]
  assign io_T1 = _pid_io_resetBuffer_T_2 ? 1'h0 : pwm_signal_io_T1; // @[\\src\\main\\scala\\SecondDriver.scala 128:25 129:11 134:11]
  assign io_T2 = _pid_io_resetBuffer_T_2 | pwm_signal_io_T2; // @[\\src\\main\\scala\\SecondDriver.scala 128:25 130:11 135:11]
  assign io_T3 = _pid_io_resetBuffer_T_2 ? 1'h0 : pwm_signal_io_T3; // @[\\src\\main\\scala\\SecondDriver.scala 128:25 131:11 136:11]
  assign io_T4 = _pid_io_resetBuffer_T_2 | pwm_signal_io_T4; // @[\\src\\main\\scala\\SecondDriver.scala 128:25 132:11 137:11]
  assign io_seg = display_io_seg; // @[\\src\\main\\scala\\SecondDriver.scala 175:10]
  assign io_an = display_io_an; // @[\\src\\main\\scala\\SecondDriver.scala 174:9]
  assign rx_clock = clock;
  assign rx_reset = reset;
  assign rx_io_rx = io_uart_rx; // @[\\src\\main\\scala\\SecondDriver.scala 49:12]
  assign tx_clock = clock;
  assign tx_reset = reset;
  assign tx_io_data = txTimer >= 24'h2625a0 ? _GEN_78 : 8'h0; // @[\\src\\main\\scala\\SecondDriver.scala 144:14 146:30]
  assign tx_io_start = txTimer >= 24'h2625a0 & _GEN_79; // @[\\src\\main\\scala\\SecondDriver.scala 145:15 146:30]
  assign pwm_signal_clock = clock;
  assign pwm_signal_reset = reset;
  assign pwm_signal_io_duty_cycle = control_mode ? pid_duty : manual_speed; // @[\\src\\main\\scala\\SecondDriver.scala 123:34]
  assign pwm_signal_io_brake = manual_brake | stuck_detector_io_motor_disable | _pid_io_resetBuffer_T_2 | at_position; // @[\\src\\main\\scala\\SecondDriver.scala 124:89]
  assign pid_clock = clock;
  assign pid_reset = reset;
  assign pid_io_setPoint = target_position_cm; // @[\\src\\main\\scala\\SecondDriver.scala 114:53]
  assign pid_io_measuredVal = current_position_fixed_point[31:0]; // @[\\src\\main\\scala\\SecondDriver.scala 113:22]
  assign pid_io_resetBuffer = ~control_mode | manual_brake | ~system_active; // @[\\src\\main\\scala\\SecondDriver.scala 116:55]
  assign stuck_detector_clock = clock;
  assign stuck_detector_reset = reset;
  assign stuck_detector_io_external_overcurrent_input = io_over_current_positive | io_over_current_negative; // @[\\src\\main\\scala\\SecondDriver.scala 53:76]
  assign stuck_detector_io_clear_shutdown = error_clear_debounce_io_out | reset_triggered; // @[\\src\\main\\scala\\SecondDriver.scala 109:68]
  assign display_clock = clock;
  assign display_reset = reset;
  assign display_io_disp_content = motor_stopped ? 20'hdf2f8 : 20'h57797; // @[\\src\\main\\scala\\SecondDriver.scala 178:33]
  assign rotations_clock = clock;
  assign rotations_reset = reset;
  assign rotations_io_signal_A = io_photo_sensor_A; // @[\\src\\main\\scala\\SecondDriver.scala 50:25]
  assign rotations_io_signal_B = io_photo_sensor_B; // @[\\src\\main\\scala\\SecondDriver.scala 51:25]
  assign error_clear_debounce_clock = clock;
  assign error_clear_debounce_reset = reset;
  assign error_clear_debounce_io_btn_in = io_error_cleared; // @[\\src\\main\\scala\\SecondDriver.scala 54:34]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\SecondDriver.scala 71:35]
      target_position_cm <= 32'sh0; // @[\\src\\main\\scala\\SecondDriver.scala 71:35]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\SecondDriver.scala 83:21]
      if (!(2'h0 == uartState)) begin // @[\\src\\main\\scala\\SecondDriver.scala 84:23]
        if (!(2'h1 == uartState)) begin // @[\\src\\main\\scala\\SecondDriver.scala 84:23]
          target_position_cm <= _GEN_24;
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\SecondDriver.scala 72:29]
      manual_speed <= 10'h200; // @[\\src\\main\\scala\\SecondDriver.scala 72:29]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\SecondDriver.scala 83:21]
      if (!(2'h0 == uartState)) begin // @[\\src\\main\\scala\\SecondDriver.scala 84:23]
        if (!(2'h1 == uartState)) begin // @[\\src\\main\\scala\\SecondDriver.scala 84:23]
          manual_speed <= _GEN_28;
        end
      end
    end
    control_mode <= reset | _GEN_52; // @[\\src\\main\\scala\\SecondDriver.scala 73:{29,29}]
    if (reset) begin // @[\\src\\main\\scala\\SecondDriver.scala 74:29]
      manual_brake <= 1'h0; // @[\\src\\main\\scala\\SecondDriver.scala 74:29]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\SecondDriver.scala 83:21]
      if (!(2'h0 == uartState)) begin // @[\\src\\main\\scala\\SecondDriver.scala 84:23]
        if (!(2'h1 == uartState)) begin // @[\\src\\main\\scala\\SecondDriver.scala 84:23]
          manual_brake <= _GEN_26;
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\SecondDriver.scala 75:30]
      system_active <= 1'h0; // @[\\src\\main\\scala\\SecondDriver.scala 75:30]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\SecondDriver.scala 83:21]
      if (!(2'h0 == uartState)) begin // @[\\src\\main\\scala\\SecondDriver.scala 84:23]
        if (!(2'h1 == uartState)) begin // @[\\src\\main\\scala\\SecondDriver.scala 84:23]
          system_active <= _GEN_25;
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\SecondDriver.scala 79:26]
      uartState <= 2'h0; // @[\\src\\main\\scala\\SecondDriver.scala 79:26]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\SecondDriver.scala 83:21]
      if (2'h0 == uartState) begin // @[\\src\\main\\scala\\SecondDriver.scala 84:23]
        if (rx_io_data == 8'haa) begin // @[\\src\\main\\scala\\SecondDriver.scala 85:49]
          uartState <= 2'h1; // @[\\src\\main\\scala\\SecondDriver.scala 85:61]
        end
      end else if (2'h1 == uartState) begin // @[\\src\\main\\scala\\SecondDriver.scala 84:23]
        uartState <= 2'h2; // @[\\src\\main\\scala\\SecondDriver.scala 86:51]
      end else begin
        uartState <= _GEN_30;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\SecondDriver.scala 80:24]
      CMDByte <= 8'h0; // @[\\src\\main\\scala\\SecondDriver.scala 80:24]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\SecondDriver.scala 83:21]
      if (!(2'h0 == uartState)) begin // @[\\src\\main\\scala\\SecondDriver.scala 84:23]
        if (2'h1 == uartState) begin // @[\\src\\main\\scala\\SecondDriver.scala 84:23]
          CMDByte <= rx_io_data; // @[\\src\\main\\scala\\SecondDriver.scala 86:26]
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\SecondDriver.scala 141:24]
      txTimer <= 24'h0; // @[\\src\\main\\scala\\SecondDriver.scala 141:24]
    end else if (txTimer >= 24'h2625a0) begin // @[\\src\\main\\scala\\SecondDriver.scala 146:30]
      if (!(2'h0 == txState)) begin // @[\\src\\main\\scala\\SecondDriver.scala 147:21]
        if (2'h1 == txState) begin // @[\\src\\main\\scala\\SecondDriver.scala 147:21]
          txTimer <= _GEN_65;
        end else begin
          txTimer <= _GEN_73;
        end
      end
    end else begin
      txTimer <= _txTimer_T_1; // @[\\src\\main\\scala\\SecondDriver.scala 170:25]
    end
    if (reset) begin // @[\\src\\main\\scala\\SecondDriver.scala 143:24]
      txState <= 2'h0; // @[\\src\\main\\scala\\SecondDriver.scala 143:24]
    end else if (txTimer >= 24'h2625a0) begin // @[\\src\\main\\scala\\SecondDriver.scala 146:30]
      if (2'h0 == txState) begin // @[\\src\\main\\scala\\SecondDriver.scala 147:21]
        if (~tx_io_busy) begin // @[\\src\\main\\scala\\SecondDriver.scala 149:27]
          txState <= 2'h1; // @[\\src\\main\\scala\\SecondDriver.scala 152:19]
        end
      end else if (2'h1 == txState) begin // @[\\src\\main\\scala\\SecondDriver.scala 147:21]
        txState <= _GEN_64;
      end else begin
        txState <= _GEN_72;
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
  target_position_cm = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  manual_speed = _RAND_1[9:0];
  _RAND_2 = {1{`RANDOM}};
  control_mode = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  manual_brake = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  system_active = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  uartState = _RAND_5[1:0];
  _RAND_6 = {1{`RANDOM}};
  CMDByte = _RAND_6[7:0];
  _RAND_7 = {1{`RANDOM}};
  txTimer = _RAND_7[23:0];
  _RAND_8 = {1{`RANDOM}};
  txState = _RAND_8[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
