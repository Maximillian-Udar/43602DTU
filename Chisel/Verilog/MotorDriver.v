module UartRx(
  input        clock,
  input        reset,
  input        io_rx, // @[\\src\\main\\scala\\Functions.scala 12:14]
  output       io_done, // @[\\src\\main\\scala\\Functions.scala 12:14]
  output [7:0] io_data // @[\\src\\main\\scala\\Functions.scala 12:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg  rxReg_REG; // @[\\src\\main\\scala\\Functions.scala 21:30]
  reg  rxReg; // @[\\src\\main\\scala\\Functions.scala 21:22]
  reg [7:0] shiftReg; // @[\\src\\main\\scala\\Functions.scala 22:25]
  reg [31:0] cntReg; // @[\\src\\main\\scala\\Functions.scala 23:23]
  reg [3:0] bitsReg; // @[\\src\\main\\scala\\Functions.scala 24:24]
  reg [1:0] stateReg; // @[\\src\\main\\scala\\Functions.scala 27:25]
  wire [31:0] _cntReg_T_1 = cntReg + 32'h1; // @[\\src\\main\\scala\\Functions.scala 44:38]
  wire [9:0] _T_6 = 10'h364 - 10'h1; // @[\\src\\main\\scala\\Functions.scala 47:31]
  wire [31:0] _GEN_32 = {{22'd0}, _T_6}; // @[\\src\\main\\scala\\Functions.scala 47:19]
  wire  _T_7 = cntReg == _GEN_32; // @[\\src\\main\\scala\\Functions.scala 47:19]
  wire [7:0] _shiftReg_T_1 = {rxReg,shiftReg[7:1]}; // @[\\src\\main\\scala\\Functions.scala 49:24]
  wire [3:0] _bitsReg_T_1 = bitsReg + 4'h1; // @[\\src\\main\\scala\\Functions.scala 51:41]
  wire [1:0] _GEN_5 = bitsReg == 4'h7 ? 2'h3 : stateReg; // @[\\src\\main\\scala\\Functions.scala 27:25 50:{31,42}]
  wire [3:0] _GEN_6 = bitsReg == 4'h7 ? bitsReg : _bitsReg_T_1; // @[\\src\\main\\scala\\Functions.scala 24:24 50:31 51:30]
  wire [31:0] _GEN_7 = cntReg == _GEN_32 ? 32'h0 : _cntReg_T_1; // @[\\src\\main\\scala\\Functions.scala 47:38 48:16 52:28]
  wire [7:0] _GEN_8 = cntReg == _GEN_32 ? _shiftReg_T_1 : shiftReg; // @[\\src\\main\\scala\\Functions.scala 47:38 49:18 22:25]
  wire [1:0] _GEN_9 = cntReg == _GEN_32 ? _GEN_5 : stateReg; // @[\\src\\main\\scala\\Functions.scala 27:25 47:38]
  wire [3:0] _GEN_10 = cntReg == _GEN_32 ? _GEN_6 : bitsReg; // @[\\src\\main\\scala\\Functions.scala 24:24 47:38]
  wire [1:0] _GEN_11 = _T_7 ? 2'h0 : stateReg; // @[\\src\\main\\scala\\Functions.scala 55:38 56:18 27:25]
  wire [31:0] _GEN_13 = _T_7 ? cntReg : _cntReg_T_1; // @[\\src\\main\\scala\\Functions.scala 23:23 55:38 58:28]
  wire [1:0] _GEN_14 = 2'h3 == stateReg ? _GEN_11 : stateReg; // @[\\src\\main\\scala\\Functions.scala 32:20 27:25]
  wire [31:0] _GEN_16 = 2'h3 == stateReg ? _GEN_13 : cntReg; // @[\\src\\main\\scala\\Functions.scala 32:20 23:23]
  wire  _GEN_21 = 2'h2 == stateReg ? 1'h0 : 2'h3 == stateReg & _T_7; // @[\\src\\main\\scala\\Functions.scala 29:11 32:20]
  wire  _GEN_26 = 2'h1 == stateReg ? 1'h0 : _GEN_21; // @[\\src\\main\\scala\\Functions.scala 29:11 32:20]
  assign io_done = 2'h0 == stateReg ? 1'h0 : _GEN_26; // @[\\src\\main\\scala\\Functions.scala 29:11 32:20]
  assign io_data = shiftReg; // @[\\src\\main\\scala\\Functions.scala 30:11]
  always @(posedge clock) begin
    rxReg_REG <= io_rx; // @[\\src\\main\\scala\\Functions.scala 21:30]
    rxReg <= rxReg_REG; // @[\\src\\main\\scala\\Functions.scala 21:22]
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 22:25]
      shiftReg <= 8'h0; // @[\\src\\main\\scala\\Functions.scala 22:25]
    end else if (!(2'h0 == stateReg)) begin // @[\\src\\main\\scala\\Functions.scala 32:20]
      if (!(2'h1 == stateReg)) begin // @[\\src\\main\\scala\\Functions.scala 32:20]
        if (2'h2 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 32:20]
          shiftReg <= _GEN_8;
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 23:23]
      cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 23:23]
    end else if (2'h0 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 32:20]
      if (~rxReg) begin // @[\\src\\main\\scala\\Functions.scala 34:20]
        cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 36:16]
      end
    end else if (2'h1 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 32:20]
      if (cntReg == 32'h1b2) begin // @[\\src\\main\\scala\\Functions.scala 40:34]
        cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 42:16]
      end else begin
        cntReg <= _cntReg_T_1; // @[\\src\\main\\scala\\Functions.scala 44:28]
      end
    end else if (2'h2 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 32:20]
      cntReg <= _GEN_7;
    end else begin
      cntReg <= _GEN_16;
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 24:24]
      bitsReg <= 4'h0; // @[\\src\\main\\scala\\Functions.scala 24:24]
    end else if (!(2'h0 == stateReg)) begin // @[\\src\\main\\scala\\Functions.scala 32:20]
      if (2'h1 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 32:20]
        if (cntReg == 32'h1b2) begin // @[\\src\\main\\scala\\Functions.scala 40:34]
          bitsReg <= 4'h0; // @[\\src\\main\\scala\\Functions.scala 43:17]
        end
      end else if (2'h2 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 32:20]
        bitsReg <= _GEN_10;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 27:25]
      stateReg <= 2'h0; // @[\\src\\main\\scala\\Functions.scala 27:25]
    end else if (2'h0 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 32:20]
      if (~rxReg) begin // @[\\src\\main\\scala\\Functions.scala 34:20]
        stateReg <= 2'h1; // @[\\src\\main\\scala\\Functions.scala 35:18]
      end
    end else if (2'h1 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 32:20]
      if (cntReg == 32'h1b2) begin // @[\\src\\main\\scala\\Functions.scala 40:34]
        stateReg <= 2'h2; // @[\\src\\main\\scala\\Functions.scala 41:18]
      end
    end else if (2'h2 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 32:20]
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
  input  [7:0] io_data, // @[\\src\\main\\scala\\Functions.scala 65:14]
  input        io_start, // @[\\src\\main\\scala\\Functions.scala 65:14]
  output       io_tx, // @[\\src\\main\\scala\\Functions.scala 65:14]
  output       io_busy // @[\\src\\main\\scala\\Functions.scala 65:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [9:0] reg_; // @[\\src\\main\\scala\\Functions.scala 73:20]
  reg [31:0] cnt; // @[\\src\\main\\scala\\Functions.scala 74:20]
  reg [3:0] bits; // @[\\src\\main\\scala\\Functions.scala 75:21]
  reg  state; // @[\\src\\main\\scala\\Functions.scala 78:22]
  wire [9:0] _reg_T = {1'h1,io_data,1'h0}; // @[\\src\\main\\scala\\Functions.scala 86:19]
  wire  _GEN_3 = io_start | state; // @[\\src\\main\\scala\\Functions.scala 85:22 89:15 78:22]
  wire [9:0] _T_3 = 10'h364 - 10'h1; // @[\\src\\main\\scala\\Functions.scala 93:28]
  wire [31:0] _GEN_18 = {{22'd0}, _T_3}; // @[\\src\\main\\scala\\Functions.scala 93:16]
  wire [9:0] _reg_T_2 = {1'h1,reg_[9:1]}; // @[\\src\\main\\scala\\Functions.scala 95:19]
  wire [3:0] _bits_T_1 = bits + 4'h1; // @[\\src\\main\\scala\\Functions.scala 97:35]
  wire  _GEN_4 = bits == 4'h9 ? 1'h0 : state; // @[\\src\\main\\scala\\Functions.scala 78:22 96:{28,36}]
  wire [3:0] _GEN_5 = bits == 4'h9 ? bits : _bits_T_1; // @[\\src\\main\\scala\\Functions.scala 75:21 96:28 97:27]
  wire [31:0] _cnt_T_1 = cnt + 32'h1; // @[\\src\\main\\scala\\Functions.scala 98:32]
  assign io_tx = reg_[0]; // @[\\src\\main\\scala\\Functions.scala 80:15]
  assign io_busy = state; // @[\\src\\main\\scala\\Functions.scala 81:20]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 73:20]
      reg_ <= 10'h1; // @[\\src\\main\\scala\\Functions.scala 73:20]
    end else if (~state) begin // @[\\src\\main\\scala\\Functions.scala 83:17]
      if (io_start) begin // @[\\src\\main\\scala\\Functions.scala 85:22]
        reg_ <= _reg_T; // @[\\src\\main\\scala\\Functions.scala 86:13]
      end
    end else if (state) begin // @[\\src\\main\\scala\\Functions.scala 83:17]
      if (cnt == _GEN_18) begin // @[\\src\\main\\scala\\Functions.scala 93:35]
        reg_ <= _reg_T_2; // @[\\src\\main\\scala\\Functions.scala 95:13]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 74:20]
      cnt <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 74:20]
    end else if (~state) begin // @[\\src\\main\\scala\\Functions.scala 83:17]
      if (io_start) begin // @[\\src\\main\\scala\\Functions.scala 85:22]
        cnt <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 88:13]
      end
    end else if (state) begin // @[\\src\\main\\scala\\Functions.scala 83:17]
      if (cnt == _GEN_18) begin // @[\\src\\main\\scala\\Functions.scala 93:35]
        cnt <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 94:13]
      end else begin
        cnt <= _cnt_T_1; // @[\\src\\main\\scala\\Functions.scala 98:25]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 75:21]
      bits <= 4'h0; // @[\\src\\main\\scala\\Functions.scala 75:21]
    end else if (~state) begin // @[\\src\\main\\scala\\Functions.scala 83:17]
      if (io_start) begin // @[\\src\\main\\scala\\Functions.scala 85:22]
        bits <= 4'h0; // @[\\src\\main\\scala\\Functions.scala 87:14]
      end
    end else if (state) begin // @[\\src\\main\\scala\\Functions.scala 83:17]
      if (cnt == _GEN_18) begin // @[\\src\\main\\scala\\Functions.scala 93:35]
        bits <= _GEN_5;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 78:22]
      state <= 1'h0; // @[\\src\\main\\scala\\Functions.scala 78:22]
    end else if (~state) begin // @[\\src\\main\\scala\\Functions.scala 83:17]
      state <= _GEN_3;
    end else if (state) begin // @[\\src\\main\\scala\\Functions.scala 83:17]
      if (cnt == _GEN_18) begin // @[\\src\\main\\scala\\Functions.scala 93:35]
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
module RotationCounter(
  input         clock,
  input         reset,
  input         io_signal_A, // @[\\src\\main\\scala\\Functions.scala 208:14]
  input         io_signal_B, // @[\\src\\main\\scala\\Functions.scala 208:14]
  output [15:0] io_turns // @[\\src\\main\\scala\\Functions.scala 208:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg  aSync_REG; // @[\\src\\main\\scala\\Functions.scala 214:30]
  reg  aSync; // @[\\src\\main\\scala\\Functions.scala 214:22]
  reg  bSync_REG; // @[\\src\\main\\scala\\Functions.scala 215:30]
  reg  bSync; // @[\\src\\main\\scala\\Functions.scala 215:22]
  reg  aReg; // @[\\src\\main\\scala\\Functions.scala 216:22]
  wire  rise_A = aSync & ~aReg; // @[\\src\\main\\scala\\Functions.scala 217:22]
  reg [15:0] turns; // @[\\src\\main\\scala\\Functions.scala 219:22]
  wire [15:0] _turns_T_1 = turns + 16'h1; // @[\\src\\main\\scala\\Functions.scala 223:22]
  wire [15:0] _turns_T_3 = turns - 16'h1; // @[\\src\\main\\scala\\Functions.scala 225:22]
  assign io_turns = turns; // @[\\src\\main\\scala\\Functions.scala 228:12]
  always @(posedge clock) begin
    aSync_REG <= io_signal_A; // @[\\src\\main\\scala\\Functions.scala 214:30]
    aSync <= aSync_REG; // @[\\src\\main\\scala\\Functions.scala 214:22]
    bSync_REG <= io_signal_B; // @[\\src\\main\\scala\\Functions.scala 215:30]
    bSync <= bSync_REG; // @[\\src\\main\\scala\\Functions.scala 215:22]
    aReg <= aSync; // @[\\src\\main\\scala\\Functions.scala 216:22]
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 219:22]
      turns <= 16'h0; // @[\\src\\main\\scala\\Functions.scala 219:22]
    end else if (rise_A) begin // @[\\src\\main\\scala\\Functions.scala 221:16]
      if (~bSync) begin // @[\\src\\main\\scala\\Functions.scala 222:18]
        turns <= _turns_T_1; // @[\\src\\main\\scala\\Functions.scala 223:13]
      end else begin
        turns <= _turns_T_3; // @[\\src\\main\\scala\\Functions.scala 225:13]
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
  turns = _RAND_5[15:0];
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
  input  [9:0] io_duty_cycle, // @[\\src\\main\\scala\\Functions.scala 105:14]
  input        io_brake, // @[\\src\\main\\scala\\Functions.scala 105:14]
  output       io_T1, // @[\\src\\main\\scala\\Functions.scala 105:14]
  output       io_T2, // @[\\src\\main\\scala\\Functions.scala 105:14]
  output       io_T3, // @[\\src\\main\\scala\\Functions.scala 105:14]
  output       io_T4 // @[\\src\\main\\scala\\Functions.scala 105:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] pwmCounter; // @[\\src\\main\\scala\\Functions.scala 116:29]
  wire [11:0] _T_1 = 12'hd05 - 12'h1; // @[\\src\\main\\scala\\Functions.scala 118:35]
  wire [31:0] _GEN_5 = {{20'd0}, _T_1}; // @[\\src\\main\\scala\\Functions.scala 118:19]
  wire [31:0] _pwmCounter_T_1 = pwmCounter + 32'h1; // @[\\src\\main\\scala\\Functions.scala 121:30]
  wire [21:0] _threshold_T = io_duty_cycle * 12'hd05; // @[\\src\\main\\scala\\Functions.scala 124:34]
  wire [11:0] threshold = _threshold_T[21:10]; // @[\\src\\main\\scala\\Functions.scala 124:50]
  wire [31:0] _GEN_6 = {{20'd0}, threshold}; // @[\\src\\main\\scala\\Functions.scala 125:30]
  wire  pwmSignal = pwmCounter < _GEN_6; // @[\\src\\main\\scala\\Functions.scala 125:30]
  wire  _conduct_T1_T = ~pwmSignal; // @[\\src\\main\\scala\\Functions.scala 140:19]
  wire  conduct_T2 = io_brake ? 1'h0 : pwmSignal; // @[\\src\\main\\scala\\Functions.scala 132:18 134:16 138:16]
  wire  conduct_T4 = io_brake ? 1'h0 : _conduct_T1_T; // @[\\src\\main\\scala\\Functions.scala 132:18 136:16 141:16]
  assign io_T1 = io_brake | ~pwmSignal; // @[\\src\\main\\scala\\Functions.scala 132:18 133:16 140:16]
  assign io_T2 = ~conduct_T2; // @[\\src\\main\\scala\\Functions.scala 147:12]
  assign io_T3 = io_brake | pwmSignal; // @[\\src\\main\\scala\\Functions.scala 132:18 135:16 139:16]
  assign io_T4 = ~conduct_T4; // @[\\src\\main\\scala\\Functions.scala 148:12]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 116:29]
      pwmCounter <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 116:29]
    end else if (pwmCounter >= _GEN_5) begin // @[\\src\\main\\scala\\Functions.scala 118:42]
      pwmCounter <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 119:16]
    end else begin
      pwmCounter <= _pwmCounter_T_1; // @[\\src\\main\\scala\\Functions.scala 121:16]
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
  input  [15:0] io_setPoint, // @[\\src\\main\\scala\\Functions.scala 153:14]
  input  [15:0] io_measuredVal, // @[\\src\\main\\scala\\Functions.scala 153:14]
  input         io_resetBuffer, // @[\\src\\main\\scala\\Functions.scala 153:14]
  output [15:0] io_controlOut // @[\\src\\main\\scala\\Functions.scala 153:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [15:0] error = $signed(io_setPoint) - $signed(io_measuredVal); // @[\\src\\main\\scala\\Functions.scala 167:27]
  wire [32:0] pTerm = -17'sh6000 * $signed(error); // @[\\src\\main\\scala\\Functions.scala 168:24]
  reg [15:0] prevErrorReg; // @[\\src\\main\\scala\\Functions.scala 170:29]
  wire [15:0] _dTerm_T_2 = $signed(error) - $signed(prevErrorReg); // @[\\src\\main\\scala\\Functions.scala 171:40]
  wire [31:0] dTerm = 16'sh0 * $signed(_dTerm_T_2); // @[\\src\\main\\scala\\Functions.scala 171:31]
  reg [15:0] integralReg; // @[\\src\\main\\scala\\Functions.scala 177:28]
  wire [31:0] _iTermNext_T = 16'sh1000 * $signed(error); // @[\\src\\main\\scala\\Functions.scala 178:45]
  wire [27:0] _GEN_5 = {$signed(integralReg), 12'h0}; // @[\\src\\main\\scala\\Functions.scala 178:33]
  wire [31:0] _GEN_6 = {{4{_GEN_5[27]}},_GEN_5}; // @[\\src\\main\\scala\\Functions.scala 178:33]
  wire [31:0] iTermNext = $signed(_GEN_6) + $signed(_iTermNext_T); // @[\\src\\main\\scala\\Functions.scala 178:33]
  wire [31:0] _GEN_0 = $signed(iTermNext) < 32'sh0 ? $signed(32'sh0) : $signed(iTermNext); // @[\\src\\main\\scala\\Functions.scala 185:40 186:19 188:19]
  wire [31:0] _GEN_1 = $signed(iTermNext) > 32'sh1000000 ? $signed(32'sh1000000) : $signed(_GEN_0); // @[\\src\\main\\scala\\Functions.scala 183:34 184:19]
  wire [31:0] _GEN_2 = io_resetBuffer ? $signed(32'sh0) : $signed(_GEN_1); // @[\\src\\main\\scala\\Functions.scala 180:24 181:17]
  wire [32:0] _GEN_8 = {{5{_GEN_5[27]}},_GEN_5}; // @[\\src\\main\\scala\\Functions.scala 192:25]
  wire [32:0] _rawOutput_T_2 = $signed(pTerm) + $signed(_GEN_8); // @[\\src\\main\\scala\\Functions.scala 192:25]
  wire [32:0] _GEN_9 = {{1{dTerm[31]}},dTerm}; // @[\\src\\main\\scala\\Functions.scala 192:39]
  wire [32:0] rawOutput = $signed(_rawOutput_T_2) + $signed(_GEN_9); // @[\\src\\main\\scala\\Functions.scala 192:39]
  wire [32:0] _GEN_3 = $signed(rawOutput) < 33'sh0 ? $signed(33'sh0) : $signed(rawOutput); // @[\\src\\main\\scala\\Functions.scala 197:38 198:18 200:18]
  wire [32:0] _GEN_4 = $signed(rawOutput) > 33'sh1000000 ? $signed(33'sh1000000) : $signed(_GEN_3); // @[\\src\\main\\scala\\Functions.scala 195:32 196:18]
  wire [20:0] _GEN_10 = _GEN_4[32:12]; // @[\\src\\main\\scala\\Functions.scala 193:26]
  wire [19:0] _GEN_14 = reset ? $signed(20'sh0) : $signed(_GEN_2[31:12]); // @[\\src\\main\\scala\\Functions.scala 177:{28,28}]
  assign io_controlOut = _GEN_10[15:0]; // @[\\src\\main\\scala\\Functions.scala 193:26]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 170:29]
      prevErrorReg <= 16'sh0; // @[\\src\\main\\scala\\Functions.scala 170:29]
    end else begin
      prevErrorReg <= error; // @[\\src\\main\\scala\\Functions.scala 172:20]
    end
    integralReg <= _GEN_14[15:0]; // @[\\src\\main\\scala\\Functions.scala 177:{28,28}]
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
  prevErrorReg = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  integralReg = _RAND_1[15:0];
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
  input   io_externalOvercurrentInput, // @[\\src\\main\\scala\\Functions.scala 233:14]
  input   io_clearShutdown, // @[\\src\\main\\scala\\Functions.scala 233:14]
  output  io_motorDisable // @[\\src\\main\\scala\\Functions.scala 233:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [24:0] maxCycles = 17'h186a0 * 8'hc8; // @[\\src\\main\\scala\\Functions.scala 241:44]
  reg [31:0] durationReg; // @[\\src\\main\\scala\\Functions.scala 242:28]
  reg  isStuckReg; // @[\\src\\main\\scala\\Functions.scala 243:28]
  wire [31:0] _GEN_8 = {{7'd0}, maxCycles}; // @[\\src\\main\\scala\\Functions.scala 251:26]
  wire [31:0] _durationReg_T_1 = durationReg + 32'h1; // @[\\src\\main\\scala\\Functions.scala 254:38]
  wire  _GEN_0 = durationReg >= _GEN_8 | isStuckReg; // @[\\src\\main\\scala\\Functions.scala 251:40 252:22 243:28]
  wire [31:0] _GEN_1 = durationReg >= _GEN_8 ? durationReg : _durationReg_T_1; // @[\\src\\main\\scala\\Functions.scala 242:28 251:40 254:23]
  assign io_motorDisable = isStuckReg; // @[\\src\\main\\scala\\Functions.scala 263:20]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 242:28]
      durationReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 242:28]
    end else if (io_clearShutdown) begin // @[\\src\\main\\scala\\Functions.scala 245:26]
      durationReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 247:17]
    end else if (~isStuckReg) begin // @[\\src\\main\\scala\\Functions.scala 249:23]
      if (io_externalOvercurrentInput) begin // @[\\src\\main\\scala\\Functions.scala 250:41]
        durationReg <= _GEN_1;
      end else begin
        durationReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 257:21]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 243:28]
      isStuckReg <= 1'h0; // @[\\src\\main\\scala\\Functions.scala 243:28]
    end else if (io_clearShutdown) begin // @[\\src\\main\\scala\\Functions.scala 245:26]
      isStuckReg <= 1'h0; // @[\\src\\main\\scala\\Functions.scala 246:17]
    end else if (~isStuckReg) begin // @[\\src\\main\\scala\\Functions.scala 249:23]
      if (io_externalOvercurrentInput) begin // @[\\src\\main\\scala\\Functions.scala 250:41]
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
module MotorDriver(
  input   clock,
  input   reset,
  input   io_uart_rx, // @[\\src\\main\\scala\\MotorDriver.scala 6:16]
  output  io_uart_tx, // @[\\src\\main\\scala\\MotorDriver.scala 6:16]
  input   io_photo_diode_A, // @[\\src\\main\\scala\\MotorDriver.scala 6:16]
  input   io_photo_diode_B, // @[\\src\\main\\scala\\MotorDriver.scala 6:16]
  input   io_over_current, // @[\\src\\main\\scala\\MotorDriver.scala 6:16]
  output  io_T1, // @[\\src\\main\\scala\\MotorDriver.scala 6:16]
  output  io_T2, // @[\\src\\main\\scala\\MotorDriver.scala 6:16]
  output  io_T3, // @[\\src\\main\\scala\\MotorDriver.scala 6:16]
  output  io_T4 // @[\\src\\main\\scala\\MotorDriver.scala 6:16]
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
  wire  rx_clock; // @[\\src\\main\\scala\\MotorDriver.scala 20:34]
  wire  rx_reset; // @[\\src\\main\\scala\\MotorDriver.scala 20:34]
  wire  rx_io_rx; // @[\\src\\main\\scala\\MotorDriver.scala 20:34]
  wire  rx_io_done; // @[\\src\\main\\scala\\MotorDriver.scala 20:34]
  wire [7:0] rx_io_data; // @[\\src\\main\\scala\\MotorDriver.scala 20:34]
  wire  tx_clock; // @[\\src\\main\\scala\\MotorDriver.scala 21:34]
  wire  tx_reset; // @[\\src\\main\\scala\\MotorDriver.scala 21:34]
  wire [7:0] tx_io_data; // @[\\src\\main\\scala\\MotorDriver.scala 21:34]
  wire  tx_io_start; // @[\\src\\main\\scala\\MotorDriver.scala 21:34]
  wire  tx_io_tx; // @[\\src\\main\\scala\\MotorDriver.scala 21:34]
  wire  tx_io_busy; // @[\\src\\main\\scala\\MotorDriver.scala 21:34]
  wire  rotation_counter_clock; // @[\\src\\main\\scala\\MotorDriver.scala 22:34]
  wire  rotation_counter_reset; // @[\\src\\main\\scala\\MotorDriver.scala 22:34]
  wire  rotation_counter_io_signal_A; // @[\\src\\main\\scala\\MotorDriver.scala 22:34]
  wire  rotation_counter_io_signal_B; // @[\\src\\main\\scala\\MotorDriver.scala 22:34]
  wire [15:0] rotation_counter_io_turns; // @[\\src\\main\\scala\\MotorDriver.scala 22:34]
  wire  pwm_gen_clock; // @[\\src\\main\\scala\\MotorDriver.scala 23:34]
  wire  pwm_gen_reset; // @[\\src\\main\\scala\\MotorDriver.scala 23:34]
  wire [9:0] pwm_gen_io_duty_cycle; // @[\\src\\main\\scala\\MotorDriver.scala 23:34]
  wire  pwm_gen_io_brake; // @[\\src\\main\\scala\\MotorDriver.scala 23:34]
  wire  pwm_gen_io_T1; // @[\\src\\main\\scala\\MotorDriver.scala 23:34]
  wire  pwm_gen_io_T2; // @[\\src\\main\\scala\\MotorDriver.scala 23:34]
  wire  pwm_gen_io_T3; // @[\\src\\main\\scala\\MotorDriver.scala 23:34]
  wire  pwm_gen_io_T4; // @[\\src\\main\\scala\\MotorDriver.scala 23:34]
  wire  pid_clock; // @[\\src\\main\\scala\\MotorDriver.scala 24:34]
  wire  pid_reset; // @[\\src\\main\\scala\\MotorDriver.scala 24:34]
  wire [15:0] pid_io_setPoint; // @[\\src\\main\\scala\\MotorDriver.scala 24:34]
  wire [15:0] pid_io_measuredVal; // @[\\src\\main\\scala\\MotorDriver.scala 24:34]
  wire  pid_io_resetBuffer; // @[\\src\\main\\scala\\MotorDriver.scala 24:34]
  wire [15:0] pid_io_controlOut; // @[\\src\\main\\scala\\MotorDriver.scala 24:34]
  wire  stuck_detector_clock; // @[\\src\\main\\scala\\MotorDriver.scala 25:34]
  wire  stuck_detector_reset; // @[\\src\\main\\scala\\MotorDriver.scala 25:34]
  wire  stuck_detector_io_externalOvercurrentInput; // @[\\src\\main\\scala\\MotorDriver.scala 25:34]
  wire  stuck_detector_io_clearShutdown; // @[\\src\\main\\scala\\MotorDriver.scala 25:34]
  wire  stuck_detector_io_motorDisable; // @[\\src\\main\\scala\\MotorDriver.scala 25:34]
  reg [7:0] target_position; // @[\\src\\main\\scala\\MotorDriver.scala 28:34]
  reg [9:0] manual_speed; // @[\\src\\main\\scala\\MotorDriver.scala 29:34]
  reg  control_mode; // @[\\src\\main\\scala\\MotorDriver.scala 30:34]
  reg  manual_brake; // @[\\src\\main\\scala\\MotorDriver.scala 31:34]
  reg [7:0] cmdByte; // @[\\src\\main\\scala\\MotorDriver.scala 35:26]
  reg  isValueByte; // @[\\src\\main\\scala\\MotorDriver.scala 36:30]
  wire  _T = ~isValueByte; // @[\\src\\main\\scala\\MotorDriver.scala 39:14]
  wire  _GEN_0 = 8'h5 == rx_io_data | manual_brake; // @[\\src\\main\\scala\\MotorDriver.scala 31:34 51:40 57:48]
  wire [9:0] _GEN_1 = 8'h4 == rx_io_data ? 10'h64 : manual_speed; // @[\\src\\main\\scala\\MotorDriver.scala 29:34 51:40 56:48]
  wire  _GEN_2 = 8'h4 == rx_io_data ? 1'h0 : _GEN_0; // @[\\src\\main\\scala\\MotorDriver.scala 51:40 56:71]
  wire [9:0] _GEN_3 = 8'h3 == rx_io_data ? 10'h15e : _GEN_1; // @[\\src\\main\\scala\\MotorDriver.scala 51:40 55:48]
  wire  _GEN_4 = 8'h3 == rx_io_data ? 1'h0 : _GEN_2; // @[\\src\\main\\scala\\MotorDriver.scala 51:40 55:71]
  wire [9:0] _GEN_5 = 8'h2 == rx_io_data ? 10'h384 : _GEN_3; // @[\\src\\main\\scala\\MotorDriver.scala 51:40 54:48]
  wire  _GEN_6 = 8'h2 == rx_io_data ? 1'h0 : _GEN_4; // @[\\src\\main\\scala\\MotorDriver.scala 51:40 54:71]
  wire [9:0] _GEN_7 = 8'h1 == rx_io_data ? 10'h28a : _GEN_5; // @[\\src\\main\\scala\\MotorDriver.scala 51:40 53:48]
  wire  _GEN_8 = 8'h1 == rx_io_data ? 1'h0 : _GEN_6; // @[\\src\\main\\scala\\MotorDriver.scala 51:40 53:71]
  wire [9:0] _GEN_9 = 8'h0 == rx_io_data ? 10'h200 : _GEN_7; // @[\\src\\main\\scala\\MotorDriver.scala 51:40 52:48]
  wire  _GEN_10 = 8'h0 == rx_io_data ? 1'h0 : _GEN_8; // @[\\src\\main\\scala\\MotorDriver.scala 51:40 52:71]
  wire  _GEN_11 = 8'h2 == cmdByte ? 1'h0 : control_mode; // @[\\src\\main\\scala\\MotorDriver.scala 43:29 30:34 50:34]
  wire [9:0] _GEN_12 = 8'h2 == cmdByte ? _GEN_9 : manual_speed; // @[\\src\\main\\scala\\MotorDriver.scala 43:29 29:34]
  wire  _GEN_13 = 8'h2 == cmdByte ? _GEN_10 : manual_brake; // @[\\src\\main\\scala\\MotorDriver.scala 43:29 31:34]
  wire  _GEN_15 = 8'h1 == cmdByte | _GEN_11; // @[\\src\\main\\scala\\MotorDriver.scala 43:29 46:34]
  wire [19:0] _current_pos_m_T = rotation_counter_io_turns * 4'ha; // @[\\src\\main\\scala\\MotorDriver.scala 74:52]
  wire [19:0] current_pos_m = _current_pos_m_T / 13'h1d4c; // @[\\src\\main\\scala\\MotorDriver.scala 74:60]
  wire [7:0] _pid_io_setPoint_T = target_position; // @[\\src\\main\\scala\\MotorDriver.scala 77:55]
  wire [19:0] _pid_io_measuredVal_T = _current_pos_m_T / 13'h1d4c; // @[\\src\\main\\scala\\MotorDriver.scala 78:53]
  wire [15:0] _pid_duty_raw_T = pid_io_controlOut; // @[\\src\\main\\scala\\MotorDriver.scala 88:43]
  wire [13:0] pid_duty_raw = _pid_duty_raw_T[15:2]; // @[\\src\\main\\scala\\MotorDriver.scala 88:50]
  wire [9:0] pid_duty = pid_duty_raw > 14'h3ff ? 10'h3ff : pid_duty_raw[9:0]; // @[\\src\\main\\scala\\MotorDriver.scala 89:27]
  reg [23:0] txTimer; // @[\\src\\main\\scala\\MotorDriver.scala 108:26]
  wire  _T_11 = ~tx_io_busy; // @[\\src\\main\\scala\\MotorDriver.scala 113:14]
  wire [23:0] _txTimer_T_1 = txTimer + 24'h1; // @[\\src\\main\\scala\\MotorDriver.scala 118:28]
  UartRx rx ( // @[\\src\\main\\scala\\MotorDriver.scala 20:34]
    .clock(rx_clock),
    .reset(rx_reset),
    .io_rx(rx_io_rx),
    .io_done(rx_io_done),
    .io_data(rx_io_data)
  );
  UartTx tx ( // @[\\src\\main\\scala\\MotorDriver.scala 21:34]
    .clock(tx_clock),
    .reset(tx_reset),
    .io_data(tx_io_data),
    .io_start(tx_io_start),
    .io_tx(tx_io_tx),
    .io_busy(tx_io_busy)
  );
  RotationCounter rotation_counter ( // @[\\src\\main\\scala\\MotorDriver.scala 22:34]
    .clock(rotation_counter_clock),
    .reset(rotation_counter_reset),
    .io_signal_A(rotation_counter_io_signal_A),
    .io_signal_B(rotation_counter_io_signal_B),
    .io_turns(rotation_counter_io_turns)
  );
  DCMotorPwm pwm_gen ( // @[\\src\\main\\scala\\MotorDriver.scala 23:34]
    .clock(pwm_gen_clock),
    .reset(pwm_gen_reset),
    .io_duty_cycle(pwm_gen_io_duty_cycle),
    .io_brake(pwm_gen_io_brake),
    .io_T1(pwm_gen_io_T1),
    .io_T2(pwm_gen_io_T2),
    .io_T3(pwm_gen_io_T3),
    .io_T4(pwm_gen_io_T4)
  );
  PIDController pid ( // @[\\src\\main\\scala\\MotorDriver.scala 24:34]
    .clock(pid_clock),
    .reset(pid_reset),
    .io_setPoint(pid_io_setPoint),
    .io_measuredVal(pid_io_measuredVal),
    .io_resetBuffer(pid_io_resetBuffer),
    .io_controlOut(pid_io_controlOut)
  );
  StuckDetector stuck_detector ( // @[\\src\\main\\scala\\MotorDriver.scala 25:34]
    .clock(stuck_detector_clock),
    .reset(stuck_detector_reset),
    .io_externalOvercurrentInput(stuck_detector_io_externalOvercurrentInput),
    .io_clearShutdown(stuck_detector_io_clearShutdown),
    .io_motorDisable(stuck_detector_io_motorDisable)
  );
  assign io_uart_tx = tx_io_tx; // @[\\src\\main\\scala\\MotorDriver.scala 120:16]
  assign io_T1 = pwm_gen_io_T1; // @[\\src\\main\\scala\\MotorDriver.scala 102:11]
  assign io_T2 = pwm_gen_io_T2; // @[\\src\\main\\scala\\MotorDriver.scala 103:11]
  assign io_T3 = pwm_gen_io_T3; // @[\\src\\main\\scala\\MotorDriver.scala 104:11]
  assign io_T4 = pwm_gen_io_T4; // @[\\src\\main\\scala\\MotorDriver.scala 105:11]
  assign rx_clock = clock;
  assign rx_reset = reset;
  assign rx_io_rx = io_uart_rx; // @[\\src\\main\\scala\\MotorDriver.scala 34:14]
  assign tx_clock = clock;
  assign tx_reset = reset;
  assign tx_io_data = current_pos_m[7:0]; // @[\\src\\main\\scala\\MotorDriver.scala 109:33]
  assign tx_io_start = txTimer >= 24'h989680 & _T_11; // @[\\src\\main\\scala\\MotorDriver.scala 110:17 112:33]
  assign rotation_counter_clock = clock;
  assign rotation_counter_reset = reset;
  assign rotation_counter_io_signal_A = io_photo_diode_A; // @[\\src\\main\\scala\\MotorDriver.scala 69:34]
  assign rotation_counter_io_signal_B = io_photo_diode_B; // @[\\src\\main\\scala\\MotorDriver.scala 70:34]
  assign pwm_gen_clock = clock;
  assign pwm_gen_reset = reset;
  assign pwm_gen_io_duty_cycle = control_mode ? pid_duty : manual_speed; // @[\\src\\main\\scala\\MotorDriver.scala 96:33]
  assign pwm_gen_io_brake = manual_brake | stuck_detector_io_motorDisable; // @[\\src\\main\\scala\\MotorDriver.scala 99:38]
  assign pid_clock = clock;
  assign pid_reset = reset;
  assign pid_io_setPoint = {{8{_pid_io_setPoint_T[7]}},_pid_io_setPoint_T}; // @[\\src\\main\\scala\\MotorDriver.scala 77:24]
  assign pid_io_measuredVal = _pid_io_measuredVal_T[15:0]; // @[\\src\\main\\scala\\MotorDriver.scala 78:24]
  assign pid_io_resetBuffer = ~control_mode | manual_brake; // @[\\src\\main\\scala\\MotorDriver.scala 79:41]
  assign stuck_detector_clock = clock;
  assign stuck_detector_reset = reset;
  assign stuck_detector_io_externalOvercurrentInput = io_over_current; // @[\\src\\main\\scala\\MotorDriver.scala 92:48]
  assign stuck_detector_io_clearShutdown = rx_io_done & cmdByte == 8'hff; // @[\\src\\main\\scala\\MotorDriver.scala 93:52]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 28:34]
      target_position <= 8'h0; // @[\\src\\main\\scala\\MotorDriver.scala 28:34]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\MotorDriver.scala 38:22]
      if (!(~isValueByte)) begin // @[\\src\\main\\scala\\MotorDriver.scala 39:28]
        if (8'h1 == cmdByte) begin // @[\\src\\main\\scala\\MotorDriver.scala 43:29]
          target_position <= rx_io_data; // @[\\src\\main\\scala\\MotorDriver.scala 45:37]
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 29:34]
      manual_speed <= 10'h200; // @[\\src\\main\\scala\\MotorDriver.scala 29:34]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\MotorDriver.scala 38:22]
      if (!(~isValueByte)) begin // @[\\src\\main\\scala\\MotorDriver.scala 39:28]
        if (!(8'h1 == cmdByte)) begin // @[\\src\\main\\scala\\MotorDriver.scala 43:29]
          manual_speed <= _GEN_12;
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 30:34]
      control_mode <= 1'h0; // @[\\src\\main\\scala\\MotorDriver.scala 30:34]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\MotorDriver.scala 38:22]
      if (!(~isValueByte)) begin // @[\\src\\main\\scala\\MotorDriver.scala 39:28]
        control_mode <= _GEN_15;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 31:34]
      manual_brake <= 1'h0; // @[\\src\\main\\scala\\MotorDriver.scala 31:34]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\MotorDriver.scala 38:22]
      if (!(~isValueByte)) begin // @[\\src\\main\\scala\\MotorDriver.scala 39:28]
        if (8'h1 == cmdByte) begin // @[\\src\\main\\scala\\MotorDriver.scala 43:29]
          manual_brake <= 1'h0; // @[\\src\\main\\scala\\MotorDriver.scala 47:34]
        end else begin
          manual_brake <= _GEN_13;
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 35:26]
      cmdByte <= 8'h0; // @[\\src\\main\\scala\\MotorDriver.scala 35:26]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\MotorDriver.scala 38:22]
      if (~isValueByte) begin // @[\\src\\main\\scala\\MotorDriver.scala 39:28]
        cmdByte <= rx_io_data; // @[\\src\\main\\scala\\MotorDriver.scala 40:21]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 36:30]
      isValueByte <= 1'h0; // @[\\src\\main\\scala\\MotorDriver.scala 36:30]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\MotorDriver.scala 38:22]
      isValueByte <= _T;
    end
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 108:26]
      txTimer <= 24'h0; // @[\\src\\main\\scala\\MotorDriver.scala 108:26]
    end else if (txTimer >= 24'h989680) begin // @[\\src\\main\\scala\\MotorDriver.scala 112:33]
      if (~tx_io_busy) begin // @[\\src\\main\\scala\\MotorDriver.scala 113:27]
        txTimer <= 24'h0; // @[\\src\\main\\scala\\MotorDriver.scala 115:21]
      end
    end else begin
      txTimer <= _txTimer_T_1; // @[\\src\\main\\scala\\MotorDriver.scala 118:17]
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
  target_position = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  manual_speed = _RAND_1[9:0];
  _RAND_2 = {1{`RANDOM}};
  control_mode = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  manual_brake = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  cmdByte = _RAND_4[7:0];
  _RAND_5 = {1{`RANDOM}};
  isValueByte = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  txTimer = _RAND_6[23:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
