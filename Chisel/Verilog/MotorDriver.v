module UartRx(
  input        clock,
  input        reset,
  input        io_rx, // @[\\src\\main\\scala\\Functions.scala 118:14]
  output       io_done, // @[\\src\\main\\scala\\Functions.scala 118:14]
  output [7:0] io_data // @[\\src\\main\\scala\\Functions.scala 118:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg  rxReg_REG; // @[\\src\\main\\scala\\Functions.scala 125:33]
  reg  rxReg; // @[\\src\\main\\scala\\Functions.scala 125:25]
  reg [7:0] shiftReg; // @[\\src\\main\\scala\\Functions.scala 126:25]
  reg [31:0] cntReg; // @[\\src\\main\\scala\\Functions.scala 127:25]
  reg [3:0] bitsReg; // @[\\src\\main\\scala\\Functions.scala 128:25]
  reg [1:0] stateReg; // @[\\src\\main\\scala\\Functions.scala 130:25]
  wire [31:0] _cntReg_T_1 = cntReg + 32'h1; // @[\\src\\main\\scala\\Functions.scala 135:127]
  wire [9:0] _T_6 = 10'h364 - 10'h1; // @[\\src\\main\\scala\\Functions.scala 136:41]
  wire [31:0] _GEN_32 = {{22'd0}, _T_6}; // @[\\src\\main\\scala\\Functions.scala 136:29]
  wire  _T_7 = cntReg == _GEN_32; // @[\\src\\main\\scala\\Functions.scala 136:29]
  wire [7:0] _shiftReg_T_1 = {rxReg,shiftReg[7:1]}; // @[\\src\\main\\scala\\Functions.scala 136:80]
  wire [3:0] _bitsReg_T_1 = bitsReg + 4'h1; // @[\\src\\main\\scala\\Functions.scala 136:180]
  wire [1:0] _GEN_5 = bitsReg == 4'h7 ? 2'h3 : stateReg; // @[\\src\\main\\scala\\Functions.scala 136:{127,138} 130:25]
  wire [3:0] _GEN_6 = bitsReg == 4'h7 ? bitsReg : _bitsReg_T_1; // @[\\src\\main\\scala\\Functions.scala 136:127 128:25 136:169]
  wire [31:0] _GEN_7 = cntReg == _GEN_32 ? 32'h0 : _cntReg_T_1; // @[\\src\\main\\scala\\Functions.scala 136:{209,48,57}]
  wire [7:0] _GEN_8 = cntReg == _GEN_32 ? _shiftReg_T_1 : shiftReg; // @[\\src\\main\\scala\\Functions.scala 126:25 136:{48,74}]
  wire [1:0] _GEN_9 = cntReg == _GEN_32 ? _GEN_5 : stateReg; // @[\\src\\main\\scala\\Functions.scala 130:25 136:48]
  wire [3:0] _GEN_10 = cntReg == _GEN_32 ? _GEN_6 : bitsReg; // @[\\src\\main\\scala\\Functions.scala 128:25 136:48]
  wire [1:0] _GEN_11 = _T_7 ? 2'h0 : stateReg; // @[\\src\\main\\scala\\Functions.scala 130:25 137:{48,59}]
  wire [31:0] _GEN_13 = _T_7 ? cntReg : _cntReg_T_1; // @[\\src\\main\\scala\\Functions.scala 127:25 137:{108,48}]
  wire [1:0] _GEN_14 = 2'h3 == stateReg ? _GEN_11 : stateReg; // @[\\src\\main\\scala\\Functions.scala 133:20 130:25]
  wire [31:0] _GEN_16 = 2'h3 == stateReg ? _GEN_13 : cntReg; // @[\\src\\main\\scala\\Functions.scala 133:20 127:25]
  wire  _GEN_21 = 2'h2 == stateReg ? 1'h0 : 2'h3 == stateReg & _T_7; // @[\\src\\main\\scala\\Functions.scala 131:11 133:20]
  wire  _GEN_26 = 2'h1 == stateReg ? 1'h0 : _GEN_21; // @[\\src\\main\\scala\\Functions.scala 131:11 133:20]
  assign io_done = 2'h0 == stateReg ? 1'h0 : _GEN_26; // @[\\src\\main\\scala\\Functions.scala 131:11 133:20]
  assign io_data = shiftReg; // @[\\src\\main\\scala\\Functions.scala 132:11]
  always @(posedge clock) begin
    rxReg_REG <= io_rx; // @[\\src\\main\\scala\\Functions.scala 125:33]
    rxReg <= rxReg_REG; // @[\\src\\main\\scala\\Functions.scala 125:25]
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 126:25]
      shiftReg <= 8'h0; // @[\\src\\main\\scala\\Functions.scala 126:25]
    end else if (!(2'h0 == stateReg)) begin // @[\\src\\main\\scala\\Functions.scala 133:20]
      if (!(2'h1 == stateReg)) begin // @[\\src\\main\\scala\\Functions.scala 133:20]
        if (2'h2 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 133:20]
          shiftReg <= _GEN_8;
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 127:25]
      cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 127:25]
    end else if (2'h0 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 133:20]
      if (~rxReg) begin // @[\\src\\main\\scala\\Functions.scala 134:30]
        cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 134:59]
      end
    end else if (2'h1 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 133:20]
      if (cntReg == 32'h1b2) begin // @[\\src\\main\\scala\\Functions.scala 135:45]
        cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 135:73]
      end else begin
        cntReg <= _cntReg_T_1; // @[\\src\\main\\scala\\Functions.scala 135:117]
      end
    end else if (2'h2 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 133:20]
      cntReg <= _GEN_7;
    end else begin
      cntReg <= _GEN_16;
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 128:25]
      bitsReg <= 4'h0; // @[\\src\\main\\scala\\Functions.scala 128:25]
    end else if (!(2'h0 == stateReg)) begin // @[\\src\\main\\scala\\Functions.scala 133:20]
      if (2'h1 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 133:20]
        if (cntReg == 32'h1b2) begin // @[\\src\\main\\scala\\Functions.scala 135:45]
          bitsReg <= 4'h0; // @[\\src\\main\\scala\\Functions.scala 135:89]
        end
      end else if (2'h2 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 133:20]
        bitsReg <= _GEN_10;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 130:25]
      stateReg <= 2'h0; // @[\\src\\main\\scala\\Functions.scala 130:25]
    end else if (2'h0 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 133:20]
      if (~rxReg) begin // @[\\src\\main\\scala\\Functions.scala 134:30]
        stateReg <= 2'h1; // @[\\src\\main\\scala\\Functions.scala 134:41]
      end
    end else if (2'h1 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 133:20]
      if (cntReg == 32'h1b2) begin // @[\\src\\main\\scala\\Functions.scala 135:45]
        stateReg <= 2'h2; // @[\\src\\main\\scala\\Functions.scala 135:56]
      end
    end else if (2'h2 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 133:20]
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
  input  [7:0] io_data, // @[\\src\\main\\scala\\Functions.scala 142:14]
  input        io_start, // @[\\src\\main\\scala\\Functions.scala 142:14]
  output       io_tx, // @[\\src\\main\\scala\\Functions.scala 142:14]
  output       io_busy // @[\\src\\main\\scala\\Functions.scala 142:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [9:0] reg_; // @[\\src\\main\\scala\\Functions.scala 149:20]
  reg [31:0] cnt; // @[\\src\\main\\scala\\Functions.scala 150:20]
  reg [3:0] bits; // @[\\src\\main\\scala\\Functions.scala 151:21]
  reg  state; // @[\\src\\main\\scala\\Functions.scala 153:22]
  wire [9:0] _reg_T = {1'h1,io_data,1'h0}; // @[\\src\\main\\scala\\Functions.scala 157:44]
  wire  _GEN_3 = io_start | state; // @[\\src\\main\\scala\\Functions.scala 153:22 157:{32,96}]
  wire [9:0] _T_3 = 10'h364 - 10'h1; // @[\\src\\main\\scala\\Functions.scala 158:38]
  wire [31:0] _GEN_18 = {{22'd0}, _T_3}; // @[\\src\\main\\scala\\Functions.scala 158:26]
  wire [9:0] _reg_T_2 = {1'h1,reg_[9:1]}; // @[\\src\\main\\scala\\Functions.scala 158:69]
  wire [3:0] _bits_T_1 = bits + 4'h1; // @[\\src\\main\\scala\\Functions.scala 158:150]
  wire  _GEN_4 = bits == 4'h9 ? 1'h0 : state; // @[\\src\\main\\scala\\Functions.scala 158:{106,114} 153:22]
  wire [3:0] _GEN_5 = bits == 4'h9 ? bits : _bits_T_1; // @[\\src\\main\\scala\\Functions.scala 158:106 151:21 158:142]
  wire [31:0] _cnt_T_1 = cnt + 32'h1; // @[\\src\\main\\scala\\Functions.scala 158:183]
  assign io_tx = reg_[0]; // @[\\src\\main\\scala\\Functions.scala 154:15]
  assign io_busy = state; // @[\\src\\main\\scala\\Functions.scala 155:20]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 149:20]
      reg_ <= 10'h1; // @[\\src\\main\\scala\\Functions.scala 149:20]
    end else if (~state) begin // @[\\src\\main\\scala\\Functions.scala 156:17]
      if (io_start) begin // @[\\src\\main\\scala\\Functions.scala 157:32]
        reg_ <= _reg_T; // @[\\src\\main\\scala\\Functions.scala 157:38]
      end
    end else if (state) begin // @[\\src\\main\\scala\\Functions.scala 156:17]
      if (cnt == _GEN_18) begin // @[\\src\\main\\scala\\Functions.scala 158:45]
        reg_ <= _reg_T_2; // @[\\src\\main\\scala\\Functions.scala 158:63]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 150:20]
      cnt <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 150:20]
    end else if (~state) begin // @[\\src\\main\\scala\\Functions.scala 156:17]
      if (io_start) begin // @[\\src\\main\\scala\\Functions.scala 157:32]
        cnt <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 157:82]
      end
    end else if (state) begin // @[\\src\\main\\scala\\Functions.scala 156:17]
      if (cnt == _GEN_18) begin // @[\\src\\main\\scala\\Functions.scala 158:45]
        cnt <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 158:51]
      end else begin
        cnt <= _cnt_T_1; // @[\\src\\main\\scala\\Functions.scala 158:176]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 151:21]
      bits <= 4'h0; // @[\\src\\main\\scala\\Functions.scala 151:21]
    end else if (~state) begin // @[\\src\\main\\scala\\Functions.scala 156:17]
      if (io_start) begin // @[\\src\\main\\scala\\Functions.scala 157:32]
        bits <= 4'h0; // @[\\src\\main\\scala\\Functions.scala 157:70]
      end
    end else if (state) begin // @[\\src\\main\\scala\\Functions.scala 156:17]
      if (cnt == _GEN_18) begin // @[\\src\\main\\scala\\Functions.scala 158:45]
        bits <= _GEN_5;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 153:22]
      state <= 1'h0; // @[\\src\\main\\scala\\Functions.scala 153:22]
    end else if (~state) begin // @[\\src\\main\\scala\\Functions.scala 156:17]
      state <= _GEN_3;
    end else if (state) begin // @[\\src\\main\\scala\\Functions.scala 156:17]
      if (cnt == _GEN_18) begin // @[\\src\\main\\scala\\Functions.scala 158:45]
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
  input         io_signal_A, // @[\\src\\main\\scala\\Functions.scala 10:14]
  input         io_signal_B, // @[\\src\\main\\scala\\Functions.scala 10:14]
  output [31:0] io_turns // @[\\src\\main\\scala\\Functions.scala 10:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg  aSync_REG; // @[\\src\\main\\scala\\Functions.scala 16:31]
  reg  aSync; // @[\\src\\main\\scala\\Functions.scala 16:23]
  reg  bSync_REG; // @[\\src\\main\\scala\\Functions.scala 17:31]
  reg  bSync; // @[\\src\\main\\scala\\Functions.scala 17:23]
  reg  aReg; // @[\\src\\main\\scala\\Functions.scala 19:23]
  reg [31:0] turns; // @[\\src\\main\\scala\\Functions.scala 22:23]
  wire [31:0] _turns_T_1 = turns + 32'h1; // @[\\src\\main\\scala\\Functions.scala 26:22]
  wire [31:0] _turns_T_3 = turns - 32'h1; // @[\\src\\main\\scala\\Functions.scala 28:42]
  assign io_turns = turns; // @[\\src\\main\\scala\\Functions.scala 32:12]
  always @(posedge clock) begin
    aSync_REG <= io_signal_A; // @[\\src\\main\\scala\\Functions.scala 16:31]
    aSync <= aSync_REG; // @[\\src\\main\\scala\\Functions.scala 16:23]
    bSync_REG <= io_signal_B; // @[\\src\\main\\scala\\Functions.scala 17:31]
    bSync <= bSync_REG; // @[\\src\\main\\scala\\Functions.scala 17:23]
    aReg <= aSync; // @[\\src\\main\\scala\\Functions.scala 19:23]
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 22:23]
      turns <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 22:23]
    end else if (aSync & ~aReg) begin // @[\\src\\main\\scala\\Functions.scala 24:24]
      if (~bSync) begin // @[\\src\\main\\scala\\Functions.scala 25:18]
        turns <= _turns_T_1; // @[\\src\\main\\scala\\Functions.scala 26:13]
      end else if (turns > 32'h0) begin // @[\\src\\main\\scala\\Functions.scala 28:25]
        turns <= _turns_T_3; // @[\\src\\main\\scala\\Functions.scala 28:33]
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
module DCMotorPwm(
  input        clock,
  input        reset,
  input  [9:0] io_duty_cycle, // @[\\src\\main\\scala\\Functions.scala 36:14]
  input        io_brake, // @[\\src\\main\\scala\\Functions.scala 36:14]
  output       io_T1, // @[\\src\\main\\scala\\Functions.scala 36:14]
  output       io_T2, // @[\\src\\main\\scala\\Functions.scala 36:14]
  output       io_T3, // @[\\src\\main\\scala\\Functions.scala 36:14]
  output       io_T4 // @[\\src\\main\\scala\\Functions.scala 36:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] pwmCounter; // @[\\src\\main\\scala\\Functions.scala 47:29]
  wire [12:0] _T_1 = 13'h1388 - 13'h1; // @[\\src\\main\\scala\\Functions.scala 49:35]
  wire [31:0] _GEN_5 = {{19'd0}, _T_1}; // @[\\src\\main\\scala\\Functions.scala 49:19]
  wire [31:0] _pwmCounter_T_1 = pwmCounter + 32'h1; // @[\\src\\main\\scala\\Functions.scala 52:30]
  wire [22:0] _threshold_T = io_duty_cycle * 13'h1388; // @[\\src\\main\\scala\\Functions.scala 55:34]
  wire [12:0] threshold = _threshold_T[22:10]; // @[\\src\\main\\scala\\Functions.scala 55:50]
  wire [31:0] _GEN_6 = {{19'd0}, threshold}; // @[\\src\\main\\scala\\Functions.scala 56:30]
  wire  pwmSignal = pwmCounter < _GEN_6; // @[\\src\\main\\scala\\Functions.scala 56:30]
  wire  _conduct_T4_T = ~pwmSignal; // @[\\src\\main\\scala\\Functions.scala 71:19]
  wire  conduct_T2 = io_brake ? 1'h0 : pwmSignal; // @[\\src\\main\\scala\\Functions.scala 63:18 65:16 69:16]
  wire  conduct_T4 = io_brake ? 1'h0 : ~pwmSignal; // @[\\src\\main\\scala\\Functions.scala 63:18 67:16 71:16]
  assign io_T1 = io_brake | _conduct_T4_T; // @[\\src\\main\\scala\\Functions.scala 63:18 64:16 72:16]
  assign io_T2 = ~conduct_T2; // @[\\src\\main\\scala\\Functions.scala 77:12]
  assign io_T3 = io_brake | pwmSignal; // @[\\src\\main\\scala\\Functions.scala 63:18 66:16 70:16]
  assign io_T4 = ~conduct_T4; // @[\\src\\main\\scala\\Functions.scala 78:12]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 47:29]
      pwmCounter <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 47:29]
    end else if (pwmCounter >= _GEN_5) begin // @[\\src\\main\\scala\\Functions.scala 49:42]
      pwmCounter <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 50:16]
    end else begin
      pwmCounter <= _pwmCounter_T_1; // @[\\src\\main\\scala\\Functions.scala 52:16]
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
  input  [31:0] io_setPoint, // @[\\src\\main\\scala\\Functions.scala 82:14]
  input  [31:0] io_measuredVal, // @[\\src\\main\\scala\\Functions.scala 82:14]
  input         io_resetBuffer, // @[\\src\\main\\scala\\Functions.scala 82:14]
  output [31:0] io_controlOut // @[\\src\\main\\scala\\Functions.scala 82:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [63:0] _RAND_6;
  reg [63:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] errorReg; // @[\\src\\main\\scala\\Functions.scala 92:25]
  reg [63:0] pTerm; // @[\\src\\main\\scala\\Functions.scala 93:22]
  reg [31:0] integralReg; // @[\\src\\main\\scala\\Functions.scala 94:28]
  reg [63:0] iTermNext; // @[\\src\\main\\scala\\Functions.scala 95:26]
  wire [43:0] _GEN_1 = {$signed(integralReg), 12'h0}; // @[\\src\\main\\scala\\Functions.scala 103:39]
  wire [63:0] _GEN_2 = {{20{_GEN_1[43]}},_GEN_1}; // @[\\src\\main\\scala\\Functions.scala 103:39]
  reg [63:0] nextSum; // @[\\src\\main\\scala\\Functions.scala 103:26]
  wire [63:0] _integralReg_T_2 = $signed(nextSum) < -64'sh800000 ? $signed(-64'sh800000) : $signed(nextSum); // @[\\src\\main\\scala\\Functions.scala 105:23]
  wire [63:0] _integralReg_T_3 = $signed(nextSum) > 64'sh800000 ? $signed(64'sh800000) : $signed(_integralReg_T_2); // @[\\src\\main\\scala\\Functions.scala 104:23]
  wire [63:0] _GEN_0 = io_resetBuffer ? $signed(64'sh0) : $signed(_integralReg_T_3); // @[\\src\\main\\scala\\Functions.scala 100:24 101:17 104:17]
  reg [31:0] prevErrorReg; // @[\\src\\main\\scala\\Functions.scala 108:29]
  wire [31:0] _dTerm_T_2 = $signed(errorReg) - $signed(prevErrorReg); // @[\\src\\main\\scala\\Functions.scala 109:41]
  reg [63:0] dTerm; // @[\\src\\main\\scala\\Functions.scala 109:22]
  wire [63:0] _rawOutput_T_2 = $signed(pTerm) + $signed(_GEN_2); // @[\\src\\main\\scala\\Functions.scala 112:33]
  reg [63:0] rawOutput; // @[\\src\\main\\scala\\Functions.scala 112:26]
  wire [63:0] _io_controlOut_T_2 = $signed(rawOutput) < -64'sh800000 ? $signed(-64'sh800000) : $signed(rawOutput); // @[\\src\\main\\scala\\Functions.scala 114:23]
  wire [63:0] _io_controlOut_T_3 = $signed(rawOutput) > 64'sh800000 ? $signed(64'sh800000) : $signed(_io_controlOut_T_2)
    ; // @[\\src\\main\\scala\\Functions.scala 113:23]
  wire [51:0] _GEN_5 = _io_controlOut_T_3[63:12]; // @[\\src\\main\\scala\\Functions.scala 113:17]
  wire [51:0] _GEN_7 = reset ? $signed(52'sh0) : $signed(_GEN_0[63:12]); // @[\\src\\main\\scala\\Functions.scala 94:{28,28}]
  assign io_controlOut = _GEN_5[31:0]; // @[\\src\\main\\scala\\Functions.scala 113:17]
  always @(posedge clock) begin
    errorReg <= $signed(io_setPoint) - $signed(io_measuredVal); // @[\\src\\main\\scala\\Functions.scala 92:38]
    pTerm <= 32'sh1000 * $signed(errorReg); // @[\\src\\main\\scala\\Functions.scala 93:29]
    integralReg <= _GEN_7[31:0]; // @[\\src\\main\\scala\\Functions.scala 94:{28,28}]
    iTermNext <= 32'sh1000 * $signed(errorReg); // @[\\src\\main\\scala\\Functions.scala 95:33]
    nextSum <= $signed(_GEN_2) + $signed(iTermNext); // @[\\src\\main\\scala\\Functions.scala 103:39]
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 108:29]
      prevErrorReg <= 32'sh0; // @[\\src\\main\\scala\\Functions.scala 108:29]
    end else begin
      prevErrorReg <= errorReg; // @[\\src\\main\\scala\\Functions.scala 110:16]
    end
    dTerm <= 32'sh1000 * $signed(_dTerm_T_2); // @[\\src\\main\\scala\\Functions.scala 109:29]
    rawOutput <= $signed(_rawOutput_T_2) + $signed(dTerm); // @[\\src\\main\\scala\\Functions.scala 112:47]
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
  errorReg = _RAND_0[31:0];
  _RAND_1 = {2{`RANDOM}};
  pTerm = _RAND_1[63:0];
  _RAND_2 = {1{`RANDOM}};
  integralReg = _RAND_2[31:0];
  _RAND_3 = {2{`RANDOM}};
  iTermNext = _RAND_3[63:0];
  _RAND_4 = {2{`RANDOM}};
  nextSum = _RAND_4[63:0];
  _RAND_5 = {1{`RANDOM}};
  prevErrorReg = _RAND_5[31:0];
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
  input   io_externalOvercurrentInput, // @[\\src\\main\\scala\\Functions.scala 163:14]
  input   io_clearShutdown, // @[\\src\\main\\scala\\Functions.scala 163:14]
  output  io_motorDisable // @[\\src\\main\\scala\\Functions.scala 163:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [24:0] maxCycles = 17'h186a0 * 8'h96; // @[\\src\\main\\scala\\Functions.scala 170:44]
  reg [31:0] durationReg; // @[\\src\\main\\scala\\Functions.scala 171:28]
  reg  isStuckReg; // @[\\src\\main\\scala\\Functions.scala 172:28]
  wire [31:0] _GEN_8 = {{7'd0}, maxCycles}; // @[\\src\\main\\scala\\Functions.scala 176:26]
  wire [31:0] _durationReg_T_1 = durationReg + 32'h1; // @[\\src\\main\\scala\\Functions.scala 176:104]
  wire  _GEN_0 = durationReg >= _GEN_8 | isStuckReg; // @[\\src\\main\\scala\\Functions.scala 172:28 176:{40,53}]
  wire [31:0] _GEN_1 = durationReg >= _GEN_8 ? durationReg : _durationReg_T_1; // @[\\src\\main\\scala\\Functions.scala 171:28 176:{40,89}]
  assign io_motorDisable = isStuckReg; // @[\\src\\main\\scala\\Functions.scala 181:19]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 171:28]
      durationReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 171:28]
    end else if (io_clearShutdown) begin // @[\\src\\main\\scala\\Functions.scala 173:26]
      durationReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 173:63]
    end else if (~isStuckReg) begin // @[\\src\\main\\scala\\Functions.scala 174:23]
      if (io_externalOvercurrentInput) begin // @[\\src\\main\\scala\\Functions.scala 175:41]
        durationReg <= _GEN_1;
      end else begin
        durationReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 177:33]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 172:28]
      isStuckReg <= 1'h0; // @[\\src\\main\\scala\\Functions.scala 172:28]
    end else if (io_clearShutdown) begin // @[\\src\\main\\scala\\Functions.scala 173:26]
      isStuckReg <= 1'h0; // @[\\src\\main\\scala\\Functions.scala 173:39]
    end else if (~isStuckReg) begin // @[\\src\\main\\scala\\Functions.scala 174:23]
      if (io_externalOvercurrentInput) begin // @[\\src\\main\\scala\\Functions.scala 175:41]
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
  input  [4:0] io_in, // @[\\src\\main\\scala\\Functions.scala 233:14]
  output [6:0] io_out // @[\\src\\main\\scala\\Functions.scala 233:14]
);
  wire [6:0] _io_out_T_33 = 5'h0 == io_in ? 7'h3f : 7'h0; // @[\\src\\main\\scala\\Functions.scala 238:46]
  wire [6:0] _io_out_T_35 = 5'h1 == io_in ? 7'h6 : _io_out_T_33; // @[\\src\\main\\scala\\Functions.scala 238:46]
  wire [6:0] _io_out_T_37 = 5'h2 == io_in ? 7'h5b : _io_out_T_35; // @[\\src\\main\\scala\\Functions.scala 238:46]
  wire [6:0] _io_out_T_39 = 5'h3 == io_in ? 7'h4f : _io_out_T_37; // @[\\src\\main\\scala\\Functions.scala 238:46]
  wire [6:0] _io_out_T_41 = 5'h4 == io_in ? 7'h66 : _io_out_T_39; // @[\\src\\main\\scala\\Functions.scala 238:46]
  wire [6:0] _io_out_T_43 = 5'h5 == io_in ? 7'h6d : _io_out_T_41; // @[\\src\\main\\scala\\Functions.scala 238:46]
  wire [6:0] _io_out_T_45 = 5'h6 == io_in ? 7'h7d : _io_out_T_43; // @[\\src\\main\\scala\\Functions.scala 238:46]
  wire [6:0] _io_out_T_47 = 5'h7 == io_in ? 7'h7 : _io_out_T_45; // @[\\src\\main\\scala\\Functions.scala 238:46]
  wire [6:0] _io_out_T_49 = 5'h8 == io_in ? 7'h7f : _io_out_T_47; // @[\\src\\main\\scala\\Functions.scala 238:46]
  wire [6:0] _io_out_T_51 = 5'h9 == io_in ? 7'h6f : _io_out_T_49; // @[\\src\\main\\scala\\Functions.scala 238:46]
  wire [6:0] _io_out_T_53 = 5'ha == io_in ? 7'h77 : _io_out_T_51; // @[\\src\\main\\scala\\Functions.scala 238:46]
  wire [6:0] _io_out_T_55 = 5'hb == io_in ? 7'h7c : _io_out_T_53; // @[\\src\\main\\scala\\Functions.scala 238:46]
  wire [6:0] _io_out_T_57 = 5'hc == io_in ? 7'h39 : _io_out_T_55; // @[\\src\\main\\scala\\Functions.scala 238:46]
  wire [6:0] _io_out_T_59 = 5'hd == io_in ? 7'h5e : _io_out_T_57; // @[\\src\\main\\scala\\Functions.scala 238:46]
  wire [6:0] _io_out_T_61 = 5'he == io_in ? 7'h79 : _io_out_T_59; // @[\\src\\main\\scala\\Functions.scala 238:46]
  wire [6:0] _io_out_T_63 = 5'hf == io_in ? 7'h71 : _io_out_T_61; // @[\\src\\main\\scala\\Functions.scala 238:46]
  wire [6:0] _io_out_T_65 = 5'h10 == io_in ? 7'h3c : _io_out_T_63; // @[\\src\\main\\scala\\Functions.scala 238:46]
  wire [6:0] _io_out_T_67 = 5'h11 == io_in ? 7'h76 : _io_out_T_65; // @[\\src\\main\\scala\\Functions.scala 238:46]
  wire [6:0] _io_out_T_69 = 5'h12 == io_in ? 7'h6 : _io_out_T_67; // @[\\src\\main\\scala\\Functions.scala 238:46]
  wire [6:0] _io_out_T_71 = 5'h13 == io_in ? 7'hf : _io_out_T_69; // @[\\src\\main\\scala\\Functions.scala 238:46]
  wire [6:0] _io_out_T_73 = 5'h14 == io_in ? 7'h38 : _io_out_T_71; // @[\\src\\main\\scala\\Functions.scala 238:46]
  wire [6:0] _io_out_T_75 = 5'h15 == io_in ? 7'h38 : _io_out_T_73; // @[\\src\\main\\scala\\Functions.scala 238:46]
  wire [6:0] _io_out_T_77 = 5'h16 == io_in ? 7'h70 : _io_out_T_75; // @[\\src\\main\\scala\\Functions.scala 238:46]
  wire [6:0] _io_out_T_79 = 5'h17 == io_in ? 7'h3f : _io_out_T_77; // @[\\src\\main\\scala\\Functions.scala 238:46]
  wire [6:0] _io_out_T_81 = 5'h18 == io_in ? 7'h73 : _io_out_T_79; // @[\\src\\main\\scala\\Functions.scala 238:46]
  wire [6:0] _io_out_T_83 = 5'h19 == io_in ? 7'h67 : _io_out_T_81; // @[\\src\\main\\scala\\Functions.scala 238:46]
  wire [6:0] _io_out_T_85 = 5'h1a == io_in ? 7'h31 : _io_out_T_83; // @[\\src\\main\\scala\\Functions.scala 238:46]
  wire [6:0] _io_out_T_87 = 5'h1b == io_in ? 7'h6d : _io_out_T_85; // @[\\src\\main\\scala\\Functions.scala 238:46]
  wire [6:0] _io_out_T_89 = 5'h1c == io_in ? 7'h78 : _io_out_T_87; // @[\\src\\main\\scala\\Functions.scala 238:46]
  wire [6:0] _io_out_T_91 = 5'h1d == io_in ? 7'h3f : _io_out_T_89; // @[\\src\\main\\scala\\Functions.scala 238:46]
  assign io_out = 5'h1e == io_in ? 7'h0 : _io_out_T_91; // @[\\src\\main\\scala\\Functions.scala 238:46]
endmodule
module DisplayMultiplexer(
  input         clock,
  input         reset,
  input  [19:0] io_disp_content, // @[\\src\\main\\scala\\Functions.scala 185:14]
  output [7:0]  io_seg, // @[\\src\\main\\scala\\Functions.scala 185:14]
  output [3:0]  io_an // @[\\src\\main\\scala\\Functions.scala 185:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [4:0] decoder_io_in; // @[\\src\\main\\scala\\Functions.scala 208:23]
  wire [6:0] decoder_io_out; // @[\\src\\main\\scala\\Functions.scala 208:23]
  reg [16:0] cnt; // @[\\src\\main\\scala\\Functions.scala 192:20]
  wire  _cnt_T = cnt == 17'h1869f; // @[\\src\\main\\scala\\Functions.scala 193:18]
  wire [16:0] _cnt_T_2 = cnt + 17'h1; // @[\\src\\main\\scala\\Functions.scala 193:54]
  reg [1:0] digit; // @[\\src\\main\\scala\\Functions.scala 196:22]
  wire [1:0] _digit_T_1 = digit + 2'h1; // @[\\src\\main\\scala\\Functions.scala 197:31]
  wire  _T = 2'h0 == digit; // @[\\src\\main\\scala\\Functions.scala 201:17]
  wire  _T_1 = 2'h1 == digit; // @[\\src\\main\\scala\\Functions.scala 201:17]
  wire  _T_2 = 2'h2 == digit; // @[\\src\\main\\scala\\Functions.scala 201:17]
  wire  _T_3 = 2'h3 == digit; // @[\\src\\main\\scala\\Functions.scala 201:17]
  wire [4:0] _GEN_1 = 2'h3 == digit ? io_disp_content[19:15] : 5'h0; // @[\\src\\main\\scala\\Functions.scala 200:14 201:17 205:26]
  wire [4:0] _GEN_2 = 2'h2 == digit ? io_disp_content[14:10] : _GEN_1; // @[\\src\\main\\scala\\Functions.scala 201:17 204:26]
  wire [4:0] _GEN_3 = 2'h1 == digit ? io_disp_content[9:5] : _GEN_2; // @[\\src\\main\\scala\\Functions.scala 201:17 203:26]
  wire [3:0] _currentDot_T = 4'h0 >> digit; // @[\\src\\main\\scala\\Functions.scala 212:27]
  wire  currentDot = _currentDot_T[0]; // @[\\src\\main\\scala\\Functions.scala 212:27]
  wire [7:0] fullSeg = {currentDot,decoder_io_out}; // @[\\src\\main\\scala\\Functions.scala 213:28]
  wire [3:0] _GEN_5 = _T_3 ? 4'h8 : 4'h1; // @[\\src\\main\\scala\\Functions.scala 216:17 220:22 215:27]
  wire [3:0] _GEN_6 = _T_2 ? 4'h4 : _GEN_5; // @[\\src\\main\\scala\\Functions.scala 216:17 219:22]
  wire [3:0] _GEN_7 = _T_1 ? 4'h2 : _GEN_6; // @[\\src\\main\\scala\\Functions.scala 216:17 218:22]
  wire [3:0] select = _T ? 4'h1 : _GEN_7; // @[\\src\\main\\scala\\Functions.scala 216:17 217:22]
  SevenSegDec decoder ( // @[\\src\\main\\scala\\Functions.scala 208:23]
    .io_in(decoder_io_in),
    .io_out(decoder_io_out)
  );
  assign io_seg = ~fullSeg; // @[\\src\\main\\scala\\Functions.scala 223:13]
  assign io_an = ~select; // @[\\src\\main\\scala\\Functions.scala 224:13]
  assign decoder_io_in = 2'h0 == digit ? io_disp_content[4:0] : _GEN_3; // @[\\src\\main\\scala\\Functions.scala 201:17 202:26]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 192:20]
      cnt <= 17'h0; // @[\\src\\main\\scala\\Functions.scala 192:20]
    end else if (cnt == 17'h1869f) begin // @[\\src\\main\\scala\\Functions.scala 193:13]
      cnt <= 17'h0;
    end else begin
      cnt <= _cnt_T_2;
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 196:22]
      digit <= 2'h0; // @[\\src\\main\\scala\\Functions.scala 196:22]
    end else if (_cnt_T) begin // @[\\src\\main\\scala\\Functions.scala 197:14]
      digit <= _digit_T_1; // @[\\src\\main\\scala\\Functions.scala 197:22]
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
module Debouncer(
  input   clock,
  input   reset,
  input   io_btn_in, // @[\\src\\main\\scala\\Functions.scala 274:14]
  output  io_state // @[\\src\\main\\scala\\Functions.scala 274:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg  btn_sync_REG; // @[\\src\\main\\scala\\Functions.scala 279:33]
  reg  btn_sync; // @[\\src\\main\\scala\\Functions.scala 279:25]
  reg  btnDebReg; // @[\\src\\main\\scala\\Functions.scala 280:26]
  reg [31:0] cntReg; // @[\\src\\main\\scala\\Functions.scala 281:23]
  wire  tick = cntReg == 32'h31; // @[\\src\\main\\scala\\Functions.scala 282:21]
  wire [31:0] _cntReg_T_1 = cntReg + 32'h1; // @[\\src\\main\\scala\\Functions.scala 284:20]
  assign io_state = btnDebReg; // @[\\src\\main\\scala\\Functions.scala 292:12]
  always @(posedge clock) begin
    btn_sync_REG <= io_btn_in; // @[\\src\\main\\scala\\Functions.scala 279:33]
    btn_sync <= btn_sync_REG; // @[\\src\\main\\scala\\Functions.scala 279:25]
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 280:26]
      btnDebReg <= 1'h0; // @[\\src\\main\\scala\\Functions.scala 280:26]
    end else if (tick) begin // @[\\src\\main\\scala\\Functions.scala 285:15]
      btnDebReg <= btn_sync; // @[\\src\\main\\scala\\Functions.scala 287:15]
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 281:23]
      cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 281:23]
    end else if (tick) begin // @[\\src\\main\\scala\\Functions.scala 285:15]
      cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 286:12]
    end else begin
      cntReg <= _cntReg_T_1; // @[\\src\\main\\scala\\Functions.scala 284:10]
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
  btn_sync_REG = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  btn_sync = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  btnDebReg = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  cntReg = _RAND_3[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Debouncer_2(
  input   clock,
  input   reset,
  input   io_btn_in, // @[\\src\\main\\scala\\Functions.scala 274:14]
  output  io_out // @[\\src\\main\\scala\\Functions.scala 274:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg  btn_sync_REG; // @[\\src\\main\\scala\\Functions.scala 279:33]
  reg  btn_sync; // @[\\src\\main\\scala\\Functions.scala 279:25]
  reg  btnDebReg; // @[\\src\\main\\scala\\Functions.scala 280:26]
  reg [31:0] cntReg; // @[\\src\\main\\scala\\Functions.scala 281:23]
  wire  tick = cntReg == 32'h1869f; // @[\\src\\main\\scala\\Functions.scala 282:21]
  wire [31:0] _cntReg_T_1 = cntReg + 32'h1; // @[\\src\\main\\scala\\Functions.scala 284:20]
  reg  btnCleanPrev; // @[\\src\\main\\scala\\Functions.scala 290:29]
  assign io_out = btnDebReg & ~btnCleanPrev; // @[\\src\\main\\scala\\Functions.scala 291:23]
  always @(posedge clock) begin
    btn_sync_REG <= io_btn_in; // @[\\src\\main\\scala\\Functions.scala 279:33]
    btn_sync <= btn_sync_REG; // @[\\src\\main\\scala\\Functions.scala 279:25]
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 280:26]
      btnDebReg <= 1'h0; // @[\\src\\main\\scala\\Functions.scala 280:26]
    end else if (tick) begin // @[\\src\\main\\scala\\Functions.scala 285:15]
      btnDebReg <= btn_sync; // @[\\src\\main\\scala\\Functions.scala 287:15]
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 281:23]
      cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 281:23]
    end else if (tick) begin // @[\\src\\main\\scala\\Functions.scala 285:15]
      cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 286:12]
    end else begin
      cntReg <= _cntReg_T_1; // @[\\src\\main\\scala\\Functions.scala 284:10]
    end
    btnCleanPrev <= btnDebReg; // @[\\src\\main\\scala\\Functions.scala 290:29]
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
module MotorDriver(
  input        clock,
  input        reset,
  input        io_uart_rx, // @[\\src\\main\\scala\\MotorDriver.scala 6:16]
  input        io_photo_diode_A, // @[\\src\\main\\scala\\MotorDriver.scala 6:16]
  input        io_photo_diode_B, // @[\\src\\main\\scala\\MotorDriver.scala 6:16]
  input        io_over_current_pos, // @[\\src\\main\\scala\\MotorDriver.scala 6:16]
  input        io_over_current_neg, // @[\\src\\main\\scala\\MotorDriver.scala 6:16]
  input        io_error_cleared, // @[\\src\\main\\scala\\MotorDriver.scala 6:16]
  output       io_uart_tx, // @[\\src\\main\\scala\\MotorDriver.scala 6:16]
  output       io_T1, // @[\\src\\main\\scala\\MotorDriver.scala 6:16]
  output       io_T2, // @[\\src\\main\\scala\\MotorDriver.scala 6:16]
  output       io_T3, // @[\\src\\main\\scala\\MotorDriver.scala 6:16]
  output       io_T4, // @[\\src\\main\\scala\\MotorDriver.scala 6:16]
  output [7:0] io_seg, // @[\\src\\main\\scala\\MotorDriver.scala 6:16]
  output [3:0] io_an // @[\\src\\main\\scala\\MotorDriver.scala 6:16]
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
  wire  rx_clock; // @[\\src\\main\\scala\\MotorDriver.scala 26:38]
  wire  rx_reset; // @[\\src\\main\\scala\\MotorDriver.scala 26:38]
  wire  rx_io_rx; // @[\\src\\main\\scala\\MotorDriver.scala 26:38]
  wire  rx_io_done; // @[\\src\\main\\scala\\MotorDriver.scala 26:38]
  wire [7:0] rx_io_data; // @[\\src\\main\\scala\\MotorDriver.scala 26:38]
  wire  tx_clock; // @[\\src\\main\\scala\\MotorDriver.scala 27:38]
  wire  tx_reset; // @[\\src\\main\\scala\\MotorDriver.scala 27:38]
  wire [7:0] tx_io_data; // @[\\src\\main\\scala\\MotorDriver.scala 27:38]
  wire  tx_io_start; // @[\\src\\main\\scala\\MotorDriver.scala 27:38]
  wire  tx_io_tx; // @[\\src\\main\\scala\\MotorDriver.scala 27:38]
  wire  tx_io_busy; // @[\\src\\main\\scala\\MotorDriver.scala 27:38]
  wire  rotation_counter_clock; // @[\\src\\main\\scala\\MotorDriver.scala 28:38]
  wire  rotation_counter_reset; // @[\\src\\main\\scala\\MotorDriver.scala 28:38]
  wire  rotation_counter_io_signal_A; // @[\\src\\main\\scala\\MotorDriver.scala 28:38]
  wire  rotation_counter_io_signal_B; // @[\\src\\main\\scala\\MotorDriver.scala 28:38]
  wire [31:0] rotation_counter_io_turns; // @[\\src\\main\\scala\\MotorDriver.scala 28:38]
  wire  pwm_gen_clock; // @[\\src\\main\\scala\\MotorDriver.scala 29:38]
  wire  pwm_gen_reset; // @[\\src\\main\\scala\\MotorDriver.scala 29:38]
  wire [9:0] pwm_gen_io_duty_cycle; // @[\\src\\main\\scala\\MotorDriver.scala 29:38]
  wire  pwm_gen_io_brake; // @[\\src\\main\\scala\\MotorDriver.scala 29:38]
  wire  pwm_gen_io_T1; // @[\\src\\main\\scala\\MotorDriver.scala 29:38]
  wire  pwm_gen_io_T2; // @[\\src\\main\\scala\\MotorDriver.scala 29:38]
  wire  pwm_gen_io_T3; // @[\\src\\main\\scala\\MotorDriver.scala 29:38]
  wire  pwm_gen_io_T4; // @[\\src\\main\\scala\\MotorDriver.scala 29:38]
  wire  pid_clock; // @[\\src\\main\\scala\\MotorDriver.scala 30:38]
  wire  pid_reset; // @[\\src\\main\\scala\\MotorDriver.scala 30:38]
  wire [31:0] pid_io_setPoint; // @[\\src\\main\\scala\\MotorDriver.scala 30:38]
  wire [31:0] pid_io_measuredVal; // @[\\src\\main\\scala\\MotorDriver.scala 30:38]
  wire  pid_io_resetBuffer; // @[\\src\\main\\scala\\MotorDriver.scala 30:38]
  wire [31:0] pid_io_controlOut; // @[\\src\\main\\scala\\MotorDriver.scala 30:38]
  wire  stuck_detector_clock; // @[\\src\\main\\scala\\MotorDriver.scala 31:38]
  wire  stuck_detector_reset; // @[\\src\\main\\scala\\MotorDriver.scala 31:38]
  wire  stuck_detector_io_externalOvercurrentInput; // @[\\src\\main\\scala\\MotorDriver.scala 31:38]
  wire  stuck_detector_io_clearShutdown; // @[\\src\\main\\scala\\MotorDriver.scala 31:38]
  wire  stuck_detector_io_motorDisable; // @[\\src\\main\\scala\\MotorDriver.scala 31:38]
  wire  disp_mux_clock; // @[\\src\\main\\scala\\MotorDriver.scala 32:38]
  wire  disp_mux_reset; // @[\\src\\main\\scala\\MotorDriver.scala 32:38]
  wire [19:0] disp_mux_io_disp_content; // @[\\src\\main\\scala\\MotorDriver.scala 32:38]
  wire [7:0] disp_mux_io_seg; // @[\\src\\main\\scala\\MotorDriver.scala 32:38]
  wire [3:0] disp_mux_io_an; // @[\\src\\main\\scala\\MotorDriver.scala 32:38]
  wire  filter_A_clock; // @[\\src\\main\\scala\\MotorDriver.scala 33:38]
  wire  filter_A_reset; // @[\\src\\main\\scala\\MotorDriver.scala 33:38]
  wire  filter_A_io_btn_in; // @[\\src\\main\\scala\\MotorDriver.scala 33:38]
  wire  filter_A_io_state; // @[\\src\\main\\scala\\MotorDriver.scala 33:38]
  wire  filter_B_clock; // @[\\src\\main\\scala\\MotorDriver.scala 34:38]
  wire  filter_B_reset; // @[\\src\\main\\scala\\MotorDriver.scala 34:38]
  wire  filter_B_io_btn_in; // @[\\src\\main\\scala\\MotorDriver.scala 34:38]
  wire  filter_B_io_state; // @[\\src\\main\\scala\\MotorDriver.scala 34:38]
  wire  error_clear_debounce_clock; // @[\\src\\main\\scala\\MotorDriver.scala 35:38]
  wire  error_clear_debounce_reset; // @[\\src\\main\\scala\\MotorDriver.scala 35:38]
  wire  error_clear_debounce_io_btn_in; // @[\\src\\main\\scala\\MotorDriver.scala 35:38]
  wire  error_clear_debounce_io_out; // @[\\src\\main\\scala\\MotorDriver.scala 35:38]
  reg [7:0] target_position; // @[\\src\\main\\scala\\MotorDriver.scala 38:34]
  reg [9:0] manual_speed; // @[\\src\\main\\scala\\MotorDriver.scala 39:34]
  reg  control_mode; // @[\\src\\main\\scala\\MotorDriver.scala 40:34]
  reg  manual_brake; // @[\\src\\main\\scala\\MotorDriver.scala 41:34]
  reg [1:0] uartState; // @[\\src\\main\\scala\\MotorDriver.scala 46:28]
  reg [7:0] cmdByte; // @[\\src\\main\\scala\\MotorDriver.scala 47:28]
  wire [9:0] _GEN_2 = 8'h4 == rx_io_data ? 10'h46 : manual_speed; // @[\\src\\main\\scala\\MotorDriver.scala 39:34 69:44 74:52]
  wire  _GEN_3 = 8'h4 == rx_io_data ? 1'h0 : 8'h5 == rx_io_data; // @[\\src\\main\\scala\\MotorDriver.scala 68:38 69:44]
  wire [9:0] _GEN_4 = 8'h3 == rx_io_data ? 10'h17c : _GEN_2; // @[\\src\\main\\scala\\MotorDriver.scala 69:44 73:52]
  wire  _GEN_5 = 8'h3 == rx_io_data ? 1'h0 : _GEN_3; // @[\\src\\main\\scala\\MotorDriver.scala 68:38 69:44]
  wire [9:0] _GEN_6 = 8'h2 == rx_io_data ? 10'h3b6 : _GEN_4; // @[\\src\\main\\scala\\MotorDriver.scala 69:44 72:52]
  wire  _GEN_7 = 8'h2 == rx_io_data ? 1'h0 : _GEN_5; // @[\\src\\main\\scala\\MotorDriver.scala 68:38 69:44]
  wire [9:0] _GEN_8 = 8'h1 == rx_io_data ? 10'h280 : _GEN_6; // @[\\src\\main\\scala\\MotorDriver.scala 69:44 71:52]
  wire  _GEN_9 = 8'h1 == rx_io_data ? 1'h0 : _GEN_7; // @[\\src\\main\\scala\\MotorDriver.scala 68:38 69:44]
  wire [9:0] _GEN_10 = 8'h0 == rx_io_data ? 10'h200 : _GEN_8; // @[\\src\\main\\scala\\MotorDriver.scala 69:44 70:52]
  wire  _GEN_11 = 8'h0 == rx_io_data | _GEN_9; // @[\\src\\main\\scala\\MotorDriver.scala 69:44 70:75]
  wire  _GEN_12 = 8'h2 == cmdByte ? 1'h0 : control_mode; // @[\\src\\main\\scala\\MotorDriver.scala 60:33 40:34 67:38]
  wire  _GEN_13 = 8'h2 == cmdByte ? _GEN_11 : manual_brake; // @[\\src\\main\\scala\\MotorDriver.scala 60:33 41:34]
  wire [9:0] _GEN_14 = 8'h2 == cmdByte ? _GEN_10 : manual_speed; // @[\\src\\main\\scala\\MotorDriver.scala 60:33 39:34]
  wire [7:0] _GEN_15 = 8'h1 == cmdByte ? rx_io_data : target_position; // @[\\src\\main\\scala\\MotorDriver.scala 60:33 38:34 62:41]
  wire  _GEN_16 = 8'h1 == cmdByte | _GEN_12; // @[\\src\\main\\scala\\MotorDriver.scala 60:33 63:41]
  wire  _GEN_17 = 8'h1 == cmdByte ? 1'h0 : _GEN_13; // @[\\src\\main\\scala\\MotorDriver.scala 60:33 64:41]
  wire [9:0] _GEN_18 = 8'h1 == cmdByte ? manual_speed : _GEN_14; // @[\\src\\main\\scala\\MotorDriver.scala 60:33 39:34]
  wire [7:0] _GEN_19 = 2'h2 == uartState ? _GEN_15 : target_position; // @[\\src\\main\\scala\\MotorDriver.scala 50:27 38:34]
  wire  _GEN_20 = 2'h2 == uartState ? _GEN_16 : control_mode; // @[\\src\\main\\scala\\MotorDriver.scala 50:27 40:34]
  wire  _GEN_21 = 2'h2 == uartState ? _GEN_17 : manual_brake; // @[\\src\\main\\scala\\MotorDriver.scala 50:27 41:34]
  wire [9:0] _GEN_22 = 2'h2 == uartState ? _GEN_18 : manual_speed; // @[\\src\\main\\scala\\MotorDriver.scala 50:27 39:34]
  wire [1:0] _GEN_23 = 2'h2 == uartState ? 2'h0 : uartState; // @[\\src\\main\\scala\\MotorDriver.scala 50:27 79:27 46:28]
  wire  _GEN_27 = 2'h1 == uartState ? control_mode : _GEN_20; // @[\\src\\main\\scala\\MotorDriver.scala 50:27 40:34]
  wire  _GEN_28 = 2'h1 == uartState ? manual_brake : _GEN_21; // @[\\src\\main\\scala\\MotorDriver.scala 50:27 41:34]
  wire  _GEN_33 = 2'h0 == uartState ? control_mode : _GEN_27; // @[\\src\\main\\scala\\MotorDriver.scala 50:27 40:34]
  wire  _GEN_34 = 2'h0 == uartState ? manual_brake : _GEN_28; // @[\\src\\main\\scala\\MotorDriver.scala 50:27 41:34]
  wire  _GEN_39 = rx_io_done ? _GEN_33 : control_mode; // @[\\src\\main\\scala\\MotorDriver.scala 49:22 40:34]
  wire  _GEN_40 = rx_io_done ? _GEN_34 : manual_brake; // @[\\src\\main\\scala\\MotorDriver.scala 49:22 41:34]
  wire [42:0] _current_pos_m_T = rotation_counter_io_turns * 11'h576; // @[\\src\\main\\scala\\MotorDriver.scala 89:52]
  wire [39:0] _current_pos_cm_T = rotation_counter_io_turns * 8'h88; // @[\\src\\main\\scala\\MotorDriver.scala 90:53]
  wire [29:0] current_pos_cm = _current_pos_cm_T[39:10]; // @[\\src\\main\\scala\\MotorDriver.scala 90:62]
  wire [7:0] _pid_io_setPoint_T = target_position; // @[\\src\\main\\scala\\MotorDriver.scala 93:55]
  wire [22:0] _pid_io_measuredVal_T = _current_pos_m_T[42:20]; // @[\\src\\main\\scala\\MotorDriver.scala 94:53]
  wire [31:0] _pid_duty_T = $signed(pid_io_controlOut) + 32'sh800; // @[\\src\\main\\scala\\MotorDriver.scala 103:38]
  wire [31:0] _pid_duty_T_1 = {{2'd0}, _pid_duty_T[31:2]}; // @[\\src\\main\\scala\\MotorDriver.scala 103:45]
  wire [9:0] pid_duty = _pid_duty_T_1[9:0]; // @[\\src\\main\\scala\\MotorDriver.scala 103:63]
  wire  brake_active = stuck_detector_io_motorDisable | manual_brake; // @[\\src\\main\\scala\\MotorDriver.scala 110:56]
  wire [18:0] modeLabel = control_mode ? 19'h57797 : 19'h7ab56; // @[\\src\\main\\scala\\MotorDriver.scala 128:28]
  reg [23:0] txTimer; // @[\\src\\main\\scala\\MotorDriver.scala 135:26]
  wire  _T_13 = ~tx_io_busy; // @[\\src\\main\\scala\\MotorDriver.scala 139:14]
  wire [23:0] _txTimer_T_1 = txTimer + 24'h1; // @[\\src\\main\\scala\\MotorDriver.scala 140:38]
  UartRx rx ( // @[\\src\\main\\scala\\MotorDriver.scala 26:38]
    .clock(rx_clock),
    .reset(rx_reset),
    .io_rx(rx_io_rx),
    .io_done(rx_io_done),
    .io_data(rx_io_data)
  );
  UartTx tx ( // @[\\src\\main\\scala\\MotorDriver.scala 27:38]
    .clock(tx_clock),
    .reset(tx_reset),
    .io_data(tx_io_data),
    .io_start(tx_io_start),
    .io_tx(tx_io_tx),
    .io_busy(tx_io_busy)
  );
  RotationCounter rotation_counter ( // @[\\src\\main\\scala\\MotorDriver.scala 28:38]
    .clock(rotation_counter_clock),
    .reset(rotation_counter_reset),
    .io_signal_A(rotation_counter_io_signal_A),
    .io_signal_B(rotation_counter_io_signal_B),
    .io_turns(rotation_counter_io_turns)
  );
  DCMotorPwm pwm_gen ( // @[\\src\\main\\scala\\MotorDriver.scala 29:38]
    .clock(pwm_gen_clock),
    .reset(pwm_gen_reset),
    .io_duty_cycle(pwm_gen_io_duty_cycle),
    .io_brake(pwm_gen_io_brake),
    .io_T1(pwm_gen_io_T1),
    .io_T2(pwm_gen_io_T2),
    .io_T3(pwm_gen_io_T3),
    .io_T4(pwm_gen_io_T4)
  );
  PIDController pid ( // @[\\src\\main\\scala\\MotorDriver.scala 30:38]
    .clock(pid_clock),
    .reset(pid_reset),
    .io_setPoint(pid_io_setPoint),
    .io_measuredVal(pid_io_measuredVal),
    .io_resetBuffer(pid_io_resetBuffer),
    .io_controlOut(pid_io_controlOut)
  );
  StuckDetector stuck_detector ( // @[\\src\\main\\scala\\MotorDriver.scala 31:38]
    .clock(stuck_detector_clock),
    .reset(stuck_detector_reset),
    .io_externalOvercurrentInput(stuck_detector_io_externalOvercurrentInput),
    .io_clearShutdown(stuck_detector_io_clearShutdown),
    .io_motorDisable(stuck_detector_io_motorDisable)
  );
  DisplayMultiplexer disp_mux ( // @[\\src\\main\\scala\\MotorDriver.scala 32:38]
    .clock(disp_mux_clock),
    .reset(disp_mux_reset),
    .io_disp_content(disp_mux_io_disp_content),
    .io_seg(disp_mux_io_seg),
    .io_an(disp_mux_io_an)
  );
  Debouncer filter_A ( // @[\\src\\main\\scala\\MotorDriver.scala 33:38]
    .clock(filter_A_clock),
    .reset(filter_A_reset),
    .io_btn_in(filter_A_io_btn_in),
    .io_state(filter_A_io_state)
  );
  Debouncer filter_B ( // @[\\src\\main\\scala\\MotorDriver.scala 34:38]
    .clock(filter_B_clock),
    .reset(filter_B_reset),
    .io_btn_in(filter_B_io_btn_in),
    .io_state(filter_B_io_state)
  );
  Debouncer_2 error_clear_debounce ( // @[\\src\\main\\scala\\MotorDriver.scala 35:38]
    .clock(error_clear_debounce_clock),
    .reset(error_clear_debounce_reset),
    .io_btn_in(error_clear_debounce_io_btn_in),
    .io_out(error_clear_debounce_io_out)
  );
  assign io_uart_tx = tx_io_tx; // @[\\src\\main\\scala\\MotorDriver.scala 141:16]
  assign io_T1 = pwm_gen_io_T1; // @[\\src\\main\\scala\\MotorDriver.scala 116:11]
  assign io_T2 = pwm_gen_io_T2; // @[\\src\\main\\scala\\MotorDriver.scala 117:11]
  assign io_T3 = pwm_gen_io_T3; // @[\\src\\main\\scala\\MotorDriver.scala 118:11]
  assign io_T4 = pwm_gen_io_T4; // @[\\src\\main\\scala\\MotorDriver.scala 119:11]
  assign io_seg = disp_mux_io_seg; // @[\\src\\main\\scala\\MotorDriver.scala 123:12]
  assign io_an = disp_mux_io_an; // @[\\src\\main\\scala\\MotorDriver.scala 122:11]
  assign rx_clock = clock;
  assign rx_reset = reset;
  assign rx_io_rx = io_uart_rx; // @[\\src\\main\\scala\\MotorDriver.scala 44:14]
  assign tx_clock = clock;
  assign tx_reset = reset;
  assign tx_io_data = current_pos_cm[7:0]; // @[\\src\\main\\scala\\MotorDriver.scala 136:34]
  assign tx_io_start = txTimer >= 24'h4c4b40 & _T_13; // @[\\src\\main\\scala\\MotorDriver.scala 137:17 138:32]
  assign rotation_counter_clock = clock;
  assign rotation_counter_reset = reset;
  assign rotation_counter_io_signal_A = filter_A_io_state; // @[\\src\\main\\scala\\MotorDriver.scala 87:34]
  assign rotation_counter_io_signal_B = filter_B_io_state; // @[\\src\\main\\scala\\MotorDriver.scala 88:34]
  assign pwm_gen_clock = clock;
  assign pwm_gen_reset = reset;
  assign pwm_gen_io_duty_cycle = control_mode ? pid_duty : manual_speed; // @[\\src\\main\\scala\\MotorDriver.scala 112:33]
  assign pwm_gen_io_brake = stuck_detector_io_motorDisable | manual_brake; // @[\\src\\main\\scala\\MotorDriver.scala 110:56]
  assign pid_clock = clock;
  assign pid_reset = reset;
  assign pid_io_setPoint = {{24{_pid_io_setPoint_T[7]}},_pid_io_setPoint_T}; // @[\\src\\main\\scala\\MotorDriver.scala 93:24]
  assign pid_io_measuredVal = {{9{_pid_io_measuredVal_T[22]}},_pid_io_measuredVal_T}; // @[\\src\\main\\scala\\MotorDriver.scala 94:24]
  assign pid_io_resetBuffer = ~control_mode | manual_brake; // @[\\src\\main\\scala\\MotorDriver.scala 95:41]
  assign stuck_detector_clock = clock;
  assign stuck_detector_reset = reset;
  assign stuck_detector_io_externalOvercurrentInput = io_over_current_pos | io_over_current_neg; // @[\\src\\main\\scala\\MotorDriver.scala 107:72]
  assign stuck_detector_io_clearShutdown = rx_io_done & cmdByte == 8'hff | error_clear_debounce_io_out; // @[\\src\\main\\scala\\MotorDriver.scala 108:76]
  assign disp_mux_clock = clock;
  assign disp_mux_reset = reset;
  assign disp_mux_io_disp_content = brake_active ? 20'hdf2f8 : {{1'd0}, modeLabel}; // @[\\src\\main\\scala\\MotorDriver.scala 125:25 126:34 131:34]
  assign filter_A_clock = clock;
  assign filter_A_reset = reset;
  assign filter_A_io_btn_in = io_photo_diode_A; // @[\\src\\main\\scala\\MotorDriver.scala 85:24]
  assign filter_B_clock = clock;
  assign filter_B_reset = reset;
  assign filter_B_io_btn_in = io_photo_diode_B; // @[\\src\\main\\scala\\MotorDriver.scala 86:24]
  assign error_clear_debounce_clock = clock;
  assign error_clear_debounce_reset = reset;
  assign error_clear_debounce_io_btn_in = io_error_cleared; // @[\\src\\main\\scala\\MotorDriver.scala 106:36]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 38:34]
      target_position <= 8'h0; // @[\\src\\main\\scala\\MotorDriver.scala 38:34]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\MotorDriver.scala 49:22]
      if (!(2'h0 == uartState)) begin // @[\\src\\main\\scala\\MotorDriver.scala 50:27]
        if (!(2'h1 == uartState)) begin // @[\\src\\main\\scala\\MotorDriver.scala 50:27]
          target_position <= _GEN_19;
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 39:34]
      manual_speed <= 10'h200; // @[\\src\\main\\scala\\MotorDriver.scala 39:34]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\MotorDriver.scala 49:22]
      if (!(2'h0 == uartState)) begin // @[\\src\\main\\scala\\MotorDriver.scala 50:27]
        if (!(2'h1 == uartState)) begin // @[\\src\\main\\scala\\MotorDriver.scala 50:27]
          manual_speed <= _GEN_22;
        end
      end
    end
    control_mode <= reset | _GEN_39; // @[\\src\\main\\scala\\MotorDriver.scala 40:{34,34}]
    manual_brake <= reset | _GEN_40; // @[\\src\\main\\scala\\MotorDriver.scala 41:{34,34}]
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 46:28]
      uartState <= 2'h0; // @[\\src\\main\\scala\\MotorDriver.scala 46:28]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\MotorDriver.scala 49:22]
      if (2'h0 == uartState) begin // @[\\src\\main\\scala\\MotorDriver.scala 50:27]
        if (rx_io_data == 8'haa) begin // @[\\src\\main\\scala\\MotorDriver.scala 53:45]
          uartState <= 2'h1; // @[\\src\\main\\scala\\MotorDriver.scala 53:57]
        end
      end else if (2'h1 == uartState) begin // @[\\src\\main\\scala\\MotorDriver.scala 50:27]
        uartState <= 2'h2; // @[\\src\\main\\scala\\MotorDriver.scala 57:27]
      end else begin
        uartState <= _GEN_23;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 47:28]
      cmdByte <= 8'h0; // @[\\src\\main\\scala\\MotorDriver.scala 47:28]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\MotorDriver.scala 49:22]
      if (!(2'h0 == uartState)) begin // @[\\src\\main\\scala\\MotorDriver.scala 50:27]
        if (2'h1 == uartState) begin // @[\\src\\main\\scala\\MotorDriver.scala 50:27]
          cmdByte <= rx_io_data; // @[\\src\\main\\scala\\MotorDriver.scala 56:27]
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 135:26]
      txTimer <= 24'h0; // @[\\src\\main\\scala\\MotorDriver.scala 135:26]
    end else if (txTimer >= 24'h4c4b40) begin // @[\\src\\main\\scala\\MotorDriver.scala 138:32]
      if (~tx_io_busy) begin // @[\\src\\main\\scala\\MotorDriver.scala 139:27]
        txTimer <= 24'h0; // @[\\src\\main\\scala\\MotorDriver.scala 139:60]
      end
    end else begin
      txTimer <= _txTimer_T_1; // @[\\src\\main\\scala\\MotorDriver.scala 140:27]
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
  uartState = _RAND_4[1:0];
  _RAND_5 = {1{`RANDOM}};
  cmdByte = _RAND_5[7:0];
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
