module UartRx(
  input        clock,
  input        reset,
  input        io_rx, // @[\\src\\main\\scala\\Functions.scala 110:14]
  output       io_done, // @[\\src\\main\\scala\\Functions.scala 110:14]
  output [7:0] io_data // @[\\src\\main\\scala\\Functions.scala 110:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg  rxReg_REG; // @[\\src\\main\\scala\\Functions.scala 117:33]
  reg  rxReg; // @[\\src\\main\\scala\\Functions.scala 117:25]
  reg [7:0] shiftReg; // @[\\src\\main\\scala\\Functions.scala 118:25]
  reg [31:0] cntReg; // @[\\src\\main\\scala\\Functions.scala 119:25]
  reg [3:0] bitsReg; // @[\\src\\main\\scala\\Functions.scala 120:25]
  reg [1:0] stateReg; // @[\\src\\main\\scala\\Functions.scala 122:25]
  wire [31:0] _cntReg_T_1 = cntReg + 32'h1; // @[\\src\\main\\scala\\Functions.scala 127:127]
  wire [9:0] _T_6 = 10'h364 - 10'h1; // @[\\src\\main\\scala\\Functions.scala 128:41]
  wire [31:0] _GEN_32 = {{22'd0}, _T_6}; // @[\\src\\main\\scala\\Functions.scala 128:29]
  wire  _T_7 = cntReg == _GEN_32; // @[\\src\\main\\scala\\Functions.scala 128:29]
  wire [7:0] _shiftReg_T_1 = {rxReg,shiftReg[7:1]}; // @[\\src\\main\\scala\\Functions.scala 128:80]
  wire [3:0] _bitsReg_T_1 = bitsReg + 4'h1; // @[\\src\\main\\scala\\Functions.scala 128:180]
  wire [1:0] _GEN_5 = bitsReg == 4'h7 ? 2'h3 : stateReg; // @[\\src\\main\\scala\\Functions.scala 128:{127,138} 122:25]
  wire [3:0] _GEN_6 = bitsReg == 4'h7 ? bitsReg : _bitsReg_T_1; // @[\\src\\main\\scala\\Functions.scala 128:127 120:25 128:169]
  wire [31:0] _GEN_7 = cntReg == _GEN_32 ? 32'h0 : _cntReg_T_1; // @[\\src\\main\\scala\\Functions.scala 128:{209,48,57}]
  wire [7:0] _GEN_8 = cntReg == _GEN_32 ? _shiftReg_T_1 : shiftReg; // @[\\src\\main\\scala\\Functions.scala 118:25 128:{48,74}]
  wire [1:0] _GEN_9 = cntReg == _GEN_32 ? _GEN_5 : stateReg; // @[\\src\\main\\scala\\Functions.scala 122:25 128:48]
  wire [3:0] _GEN_10 = cntReg == _GEN_32 ? _GEN_6 : bitsReg; // @[\\src\\main\\scala\\Functions.scala 120:25 128:48]
  wire [1:0] _GEN_11 = _T_7 ? 2'h0 : stateReg; // @[\\src\\main\\scala\\Functions.scala 122:25 129:{48,59}]
  wire [31:0] _GEN_13 = _T_7 ? cntReg : _cntReg_T_1; // @[\\src\\main\\scala\\Functions.scala 119:25 129:{108,48}]
  wire [1:0] _GEN_14 = 2'h3 == stateReg ? _GEN_11 : stateReg; // @[\\src\\main\\scala\\Functions.scala 125:20 122:25]
  wire [31:0] _GEN_16 = 2'h3 == stateReg ? _GEN_13 : cntReg; // @[\\src\\main\\scala\\Functions.scala 125:20 119:25]
  wire  _GEN_21 = 2'h2 == stateReg ? 1'h0 : 2'h3 == stateReg & _T_7; // @[\\src\\main\\scala\\Functions.scala 123:11 125:20]
  wire  _GEN_26 = 2'h1 == stateReg ? 1'h0 : _GEN_21; // @[\\src\\main\\scala\\Functions.scala 123:11 125:20]
  assign io_done = 2'h0 == stateReg ? 1'h0 : _GEN_26; // @[\\src\\main\\scala\\Functions.scala 123:11 125:20]
  assign io_data = shiftReg; // @[\\src\\main\\scala\\Functions.scala 124:11]
  always @(posedge clock) begin
    rxReg_REG <= io_rx; // @[\\src\\main\\scala\\Functions.scala 117:33]
    rxReg <= rxReg_REG; // @[\\src\\main\\scala\\Functions.scala 117:25]
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 118:25]
      shiftReg <= 8'h0; // @[\\src\\main\\scala\\Functions.scala 118:25]
    end else if (!(2'h0 == stateReg)) begin // @[\\src\\main\\scala\\Functions.scala 125:20]
      if (!(2'h1 == stateReg)) begin // @[\\src\\main\\scala\\Functions.scala 125:20]
        if (2'h2 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 125:20]
          shiftReg <= _GEN_8;
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 119:25]
      cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 119:25]
    end else if (2'h0 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 125:20]
      if (~rxReg) begin // @[\\src\\main\\scala\\Functions.scala 126:30]
        cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 126:59]
      end
    end else if (2'h1 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 125:20]
      if (cntReg == 32'h1b2) begin // @[\\src\\main\\scala\\Functions.scala 127:45]
        cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 127:73]
      end else begin
        cntReg <= _cntReg_T_1; // @[\\src\\main\\scala\\Functions.scala 127:117]
      end
    end else if (2'h2 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 125:20]
      cntReg <= _GEN_7;
    end else begin
      cntReg <= _GEN_16;
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 120:25]
      bitsReg <= 4'h0; // @[\\src\\main\\scala\\Functions.scala 120:25]
    end else if (!(2'h0 == stateReg)) begin // @[\\src\\main\\scala\\Functions.scala 125:20]
      if (2'h1 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 125:20]
        if (cntReg == 32'h1b2) begin // @[\\src\\main\\scala\\Functions.scala 127:45]
          bitsReg <= 4'h0; // @[\\src\\main\\scala\\Functions.scala 127:89]
        end
      end else if (2'h2 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 125:20]
        bitsReg <= _GEN_10;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 122:25]
      stateReg <= 2'h0; // @[\\src\\main\\scala\\Functions.scala 122:25]
    end else if (2'h0 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 125:20]
      if (~rxReg) begin // @[\\src\\main\\scala\\Functions.scala 126:30]
        stateReg <= 2'h1; // @[\\src\\main\\scala\\Functions.scala 126:41]
      end
    end else if (2'h1 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 125:20]
      if (cntReg == 32'h1b2) begin // @[\\src\\main\\scala\\Functions.scala 127:45]
        stateReg <= 2'h2; // @[\\src\\main\\scala\\Functions.scala 127:56]
      end
    end else if (2'h2 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 125:20]
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
  input  [7:0] io_data, // @[\\src\\main\\scala\\Functions.scala 134:14]
  input        io_start, // @[\\src\\main\\scala\\Functions.scala 134:14]
  output       io_tx, // @[\\src\\main\\scala\\Functions.scala 134:14]
  output       io_busy // @[\\src\\main\\scala\\Functions.scala 134:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [9:0] reg_; // @[\\src\\main\\scala\\Functions.scala 141:20]
  reg [31:0] cnt; // @[\\src\\main\\scala\\Functions.scala 142:20]
  reg [3:0] bits; // @[\\src\\main\\scala\\Functions.scala 143:21]
  reg  state; // @[\\src\\main\\scala\\Functions.scala 145:22]
  wire [9:0] _reg_T = {1'h1,io_data,1'h0}; // @[\\src\\main\\scala\\Functions.scala 149:44]
  wire  _GEN_3 = io_start | state; // @[\\src\\main\\scala\\Functions.scala 145:22 149:{32,96}]
  wire [9:0] _T_3 = 10'h364 - 10'h1; // @[\\src\\main\\scala\\Functions.scala 150:38]
  wire [31:0] _GEN_18 = {{22'd0}, _T_3}; // @[\\src\\main\\scala\\Functions.scala 150:26]
  wire [9:0] _reg_T_2 = {1'h1,reg_[9:1]}; // @[\\src\\main\\scala\\Functions.scala 150:69]
  wire [3:0] _bits_T_1 = bits + 4'h1; // @[\\src\\main\\scala\\Functions.scala 150:150]
  wire  _GEN_4 = bits == 4'h9 ? 1'h0 : state; // @[\\src\\main\\scala\\Functions.scala 150:{106,114} 145:22]
  wire [3:0] _GEN_5 = bits == 4'h9 ? bits : _bits_T_1; // @[\\src\\main\\scala\\Functions.scala 150:106 143:21 150:142]
  wire [31:0] _cnt_T_1 = cnt + 32'h1; // @[\\src\\main\\scala\\Functions.scala 150:183]
  assign io_tx = reg_[0]; // @[\\src\\main\\scala\\Functions.scala 146:15]
  assign io_busy = state; // @[\\src\\main\\scala\\Functions.scala 147:20]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 141:20]
      reg_ <= 10'h1; // @[\\src\\main\\scala\\Functions.scala 141:20]
    end else if (~state) begin // @[\\src\\main\\scala\\Functions.scala 148:17]
      if (io_start) begin // @[\\src\\main\\scala\\Functions.scala 149:32]
        reg_ <= _reg_T; // @[\\src\\main\\scala\\Functions.scala 149:38]
      end
    end else if (state) begin // @[\\src\\main\\scala\\Functions.scala 148:17]
      if (cnt == _GEN_18) begin // @[\\src\\main\\scala\\Functions.scala 150:45]
        reg_ <= _reg_T_2; // @[\\src\\main\\scala\\Functions.scala 150:63]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 142:20]
      cnt <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 142:20]
    end else if (~state) begin // @[\\src\\main\\scala\\Functions.scala 148:17]
      if (io_start) begin // @[\\src\\main\\scala\\Functions.scala 149:32]
        cnt <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 149:82]
      end
    end else if (state) begin // @[\\src\\main\\scala\\Functions.scala 148:17]
      if (cnt == _GEN_18) begin // @[\\src\\main\\scala\\Functions.scala 150:45]
        cnt <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 150:51]
      end else begin
        cnt <= _cnt_T_1; // @[\\src\\main\\scala\\Functions.scala 150:176]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 143:21]
      bits <= 4'h0; // @[\\src\\main\\scala\\Functions.scala 143:21]
    end else if (~state) begin // @[\\src\\main\\scala\\Functions.scala 148:17]
      if (io_start) begin // @[\\src\\main\\scala\\Functions.scala 149:32]
        bits <= 4'h0; // @[\\src\\main\\scala\\Functions.scala 149:70]
      end
    end else if (state) begin // @[\\src\\main\\scala\\Functions.scala 148:17]
      if (cnt == _GEN_18) begin // @[\\src\\main\\scala\\Functions.scala 150:45]
        bits <= _GEN_5;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 145:22]
      state <= 1'h0; // @[\\src\\main\\scala\\Functions.scala 145:22]
    end else if (~state) begin // @[\\src\\main\\scala\\Functions.scala 148:17]
      state <= _GEN_3;
    end else if (state) begin // @[\\src\\main\\scala\\Functions.scala 148:17]
      if (cnt == _GEN_18) begin // @[\\src\\main\\scala\\Functions.scala 150:45]
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
  reg  aSync_REG; // @[\\src\\main\\scala\\Functions.scala 15:30]
  reg  aSync; // @[\\src\\main\\scala\\Functions.scala 15:22]
  reg  bSync_REG; // @[\\src\\main\\scala\\Functions.scala 16:30]
  reg  bSync; // @[\\src\\main\\scala\\Functions.scala 16:22]
  reg  aReg; // @[\\src\\main\\scala\\Functions.scala 17:22]
  wire  rise_A = aSync & ~aReg; // @[\\src\\main\\scala\\Functions.scala 18:22]
  reg [31:0] turns; // @[\\src\\main\\scala\\Functions.scala 19:22]
  wire [31:0] _turns_T_2 = $signed(turns) + 32'sh1; // @[\\src\\main\\scala\\Functions.scala 21:35]
  wire [31:0] _turns_T_5 = $signed(turns) - 32'sh1; // @[\\src\\main\\scala\\Functions.scala 22:35]
  assign io_turns = turns; // @[\\src\\main\\scala\\Functions.scala 24:12]
  always @(posedge clock) begin
    aSync_REG <= io_signal_A; // @[\\src\\main\\scala\\Functions.scala 15:30]
    aSync <= aSync_REG; // @[\\src\\main\\scala\\Functions.scala 15:22]
    bSync_REG <= io_signal_B; // @[\\src\\main\\scala\\Functions.scala 16:30]
    bSync <= bSync_REG; // @[\\src\\main\\scala\\Functions.scala 16:22]
    aReg <= aSync; // @[\\src\\main\\scala\\Functions.scala 17:22]
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 19:22]
      turns <= 32'sh0; // @[\\src\\main\\scala\\Functions.scala 19:22]
    end else if (rise_A) begin // @[\\src\\main\\scala\\Functions.scala 20:16]
      if (~bSync) begin // @[\\src\\main\\scala\\Functions.scala 21:18]
        turns <= _turns_T_2; // @[\\src\\main\\scala\\Functions.scala 21:26]
      end else begin
        turns <= _turns_T_5; // @[\\src\\main\\scala\\Functions.scala 22:26]
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
  input  [9:0] io_duty_cycle, // @[\\src\\main\\scala\\Functions.scala 28:14]
  input        io_brake, // @[\\src\\main\\scala\\Functions.scala 28:14]
  output       io_T1, // @[\\src\\main\\scala\\Functions.scala 28:14]
  output       io_T2, // @[\\src\\main\\scala\\Functions.scala 28:14]
  output       io_T3, // @[\\src\\main\\scala\\Functions.scala 28:14]
  output       io_T4 // @[\\src\\main\\scala\\Functions.scala 28:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] pwmCounter; // @[\\src\\main\\scala\\Functions.scala 39:29]
  wire [12:0] _T_1 = 13'h1388 - 13'h1; // @[\\src\\main\\scala\\Functions.scala 41:35]
  wire [31:0] _GEN_5 = {{19'd0}, _T_1}; // @[\\src\\main\\scala\\Functions.scala 41:19]
  wire [31:0] _pwmCounter_T_1 = pwmCounter + 32'h1; // @[\\src\\main\\scala\\Functions.scala 44:30]
  wire [22:0] _threshold_T = io_duty_cycle * 13'h1388; // @[\\src\\main\\scala\\Functions.scala 47:34]
  wire [12:0] threshold = _threshold_T[22:10]; // @[\\src\\main\\scala\\Functions.scala 47:50]
  wire [31:0] _GEN_6 = {{19'd0}, threshold}; // @[\\src\\main\\scala\\Functions.scala 48:30]
  wire  pwmSignal = pwmCounter < _GEN_6; // @[\\src\\main\\scala\\Functions.scala 48:30]
  wire  _conduct_T4_T = ~pwmSignal; // @[\\src\\main\\scala\\Functions.scala 63:19]
  wire  conduct_T2 = io_brake ? 1'h0 : pwmSignal; // @[\\src\\main\\scala\\Functions.scala 55:18 57:16 61:16]
  wire  conduct_T4 = io_brake ? 1'h0 : ~pwmSignal; // @[\\src\\main\\scala\\Functions.scala 55:18 59:16 63:16]
  assign io_T1 = io_brake | _conduct_T4_T; // @[\\src\\main\\scala\\Functions.scala 55:18 56:16 64:16]
  assign io_T2 = ~conduct_T2; // @[\\src\\main\\scala\\Functions.scala 69:12]
  assign io_T3 = io_brake | pwmSignal; // @[\\src\\main\\scala\\Functions.scala 55:18 58:16 62:16]
  assign io_T4 = ~conduct_T4; // @[\\src\\main\\scala\\Functions.scala 70:12]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 39:29]
      pwmCounter <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 39:29]
    end else if (pwmCounter >= _GEN_5) begin // @[\\src\\main\\scala\\Functions.scala 41:42]
      pwmCounter <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 42:16]
    end else begin
      pwmCounter <= _pwmCounter_T_1; // @[\\src\\main\\scala\\Functions.scala 44:16]
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
  input  [31:0] io_setPoint, // @[\\src\\main\\scala\\Functions.scala 74:14]
  input  [31:0] io_measuredVal, // @[\\src\\main\\scala\\Functions.scala 74:14]
  input         io_resetBuffer, // @[\\src\\main\\scala\\Functions.scala 74:14]
  output [31:0] io_controlOut // @[\\src\\main\\scala\\Functions.scala 74:14]
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
  reg [31:0] errorReg; // @[\\src\\main\\scala\\Functions.scala 84:25]
  reg [63:0] pTerm; // @[\\src\\main\\scala\\Functions.scala 85:22]
  reg [31:0] integralReg; // @[\\src\\main\\scala\\Functions.scala 86:28]
  reg [63:0] iTermNext; // @[\\src\\main\\scala\\Functions.scala 87:26]
  wire [43:0] _GEN_1 = {$signed(integralReg), 12'h0}; // @[\\src\\main\\scala\\Functions.scala 95:39]
  wire [63:0] _GEN_2 = {{20{_GEN_1[43]}},_GEN_1}; // @[\\src\\main\\scala\\Functions.scala 95:39]
  reg [63:0] nextSum; // @[\\src\\main\\scala\\Functions.scala 95:26]
  wire [63:0] _integralReg_T_2 = $signed(nextSum) < -64'sh800000 ? $signed(-64'sh800000) : $signed(nextSum); // @[\\src\\main\\scala\\Functions.scala 97:23]
  wire [63:0] _integralReg_T_3 = $signed(nextSum) > 64'sh800000 ? $signed(64'sh800000) : $signed(_integralReg_T_2); // @[\\src\\main\\scala\\Functions.scala 96:23]
  wire [63:0] _GEN_0 = io_resetBuffer ? $signed(64'sh0) : $signed(_integralReg_T_3); // @[\\src\\main\\scala\\Functions.scala 92:24 93:17 96:17]
  reg [31:0] prevErrorReg; // @[\\src\\main\\scala\\Functions.scala 100:29]
  wire [31:0] _dTerm_T_2 = $signed(errorReg) - $signed(prevErrorReg); // @[\\src\\main\\scala\\Functions.scala 101:41]
  reg [63:0] dTerm; // @[\\src\\main\\scala\\Functions.scala 101:22]
  wire [63:0] _rawOutput_T_2 = $signed(pTerm) + $signed(_GEN_2); // @[\\src\\main\\scala\\Functions.scala 104:33]
  reg [63:0] rawOutput; // @[\\src\\main\\scala\\Functions.scala 104:26]
  wire [63:0] _io_controlOut_T_2 = $signed(rawOutput) < -64'sh800000 ? $signed(-64'sh800000) : $signed(rawOutput); // @[\\src\\main\\scala\\Functions.scala 106:23]
  wire [63:0] _io_controlOut_T_3 = $signed(rawOutput) > 64'sh800000 ? $signed(64'sh800000) : $signed(_io_controlOut_T_2)
    ; // @[\\src\\main\\scala\\Functions.scala 105:23]
  wire [51:0] _GEN_5 = _io_controlOut_T_3[63:12]; // @[\\src\\main\\scala\\Functions.scala 105:17]
  wire [51:0] _GEN_7 = reset ? $signed(52'sh0) : $signed(_GEN_0[63:12]); // @[\\src\\main\\scala\\Functions.scala 86:{28,28}]
  assign io_controlOut = _GEN_5[31:0]; // @[\\src\\main\\scala\\Functions.scala 105:17]
  always @(posedge clock) begin
    errorReg <= $signed(io_setPoint) - $signed(io_measuredVal); // @[\\src\\main\\scala\\Functions.scala 84:38]
    pTerm <= 32'sh1000 * $signed(errorReg); // @[\\src\\main\\scala\\Functions.scala 85:29]
    integralReg <= _GEN_7[31:0]; // @[\\src\\main\\scala\\Functions.scala 86:{28,28}]
    iTermNext <= 32'sh800 * $signed(errorReg); // @[\\src\\main\\scala\\Functions.scala 87:33]
    nextSum <= $signed(_GEN_2) + $signed(iTermNext); // @[\\src\\main\\scala\\Functions.scala 95:39]
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 100:29]
      prevErrorReg <= 32'sh0; // @[\\src\\main\\scala\\Functions.scala 100:29]
    end else begin
      prevErrorReg <= errorReg; // @[\\src\\main\\scala\\Functions.scala 102:16]
    end
    dTerm <= 32'sh19a * $signed(_dTerm_T_2); // @[\\src\\main\\scala\\Functions.scala 101:29]
    rawOutput <= $signed(_rawOutput_T_2) + $signed(dTerm); // @[\\src\\main\\scala\\Functions.scala 104:47]
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
  input   io_externalOvercurrentInput, // @[\\src\\main\\scala\\Functions.scala 155:14]
  input   io_clearShutdown, // @[\\src\\main\\scala\\Functions.scala 155:14]
  output  io_motorDisable // @[\\src\\main\\scala\\Functions.scala 155:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [24:0] maxCycles = 17'h186a0 * 8'h96; // @[\\src\\main\\scala\\Functions.scala 162:44]
  reg [31:0] durationReg; // @[\\src\\main\\scala\\Functions.scala 163:28]
  reg  isStuckReg; // @[\\src\\main\\scala\\Functions.scala 164:28]
  wire [31:0] _GEN_8 = {{7'd0}, maxCycles}; // @[\\src\\main\\scala\\Functions.scala 168:26]
  wire [31:0] _durationReg_T_1 = durationReg + 32'h1; // @[\\src\\main\\scala\\Functions.scala 168:104]
  wire  _GEN_0 = durationReg >= _GEN_8 | isStuckReg; // @[\\src\\main\\scala\\Functions.scala 164:28 168:{40,53}]
  wire [31:0] _GEN_1 = durationReg >= _GEN_8 ? durationReg : _durationReg_T_1; // @[\\src\\main\\scala\\Functions.scala 163:28 168:{40,89}]
  assign io_motorDisable = isStuckReg; // @[\\src\\main\\scala\\Functions.scala 173:19]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 163:28]
      durationReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 163:28]
    end else if (io_clearShutdown) begin // @[\\src\\main\\scala\\Functions.scala 165:26]
      durationReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 165:63]
    end else if (~isStuckReg) begin // @[\\src\\main\\scala\\Functions.scala 166:23]
      if (io_externalOvercurrentInput) begin // @[\\src\\main\\scala\\Functions.scala 167:41]
        durationReg <= _GEN_1;
      end else begin
        durationReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 169:33]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 164:28]
      isStuckReg <= 1'h0; // @[\\src\\main\\scala\\Functions.scala 164:28]
    end else if (io_clearShutdown) begin // @[\\src\\main\\scala\\Functions.scala 165:26]
      isStuckReg <= 1'h0; // @[\\src\\main\\scala\\Functions.scala 165:39]
    end else if (~isStuckReg) begin // @[\\src\\main\\scala\\Functions.scala 166:23]
      if (io_externalOvercurrentInput) begin // @[\\src\\main\\scala\\Functions.scala 167:41]
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
  input  [4:0] io_in, // @[\\src\\main\\scala\\Functions.scala 225:14]
  output [6:0] io_out // @[\\src\\main\\scala\\Functions.scala 225:14]
);
  wire [6:0] _io_out_T_33 = 5'h0 == io_in ? 7'h3f : 7'h0; // @[\\src\\main\\scala\\Functions.scala 230:46]
  wire [6:0] _io_out_T_35 = 5'h1 == io_in ? 7'h6 : _io_out_T_33; // @[\\src\\main\\scala\\Functions.scala 230:46]
  wire [6:0] _io_out_T_37 = 5'h2 == io_in ? 7'h5b : _io_out_T_35; // @[\\src\\main\\scala\\Functions.scala 230:46]
  wire [6:0] _io_out_T_39 = 5'h3 == io_in ? 7'h4f : _io_out_T_37; // @[\\src\\main\\scala\\Functions.scala 230:46]
  wire [6:0] _io_out_T_41 = 5'h4 == io_in ? 7'h66 : _io_out_T_39; // @[\\src\\main\\scala\\Functions.scala 230:46]
  wire [6:0] _io_out_T_43 = 5'h5 == io_in ? 7'h6d : _io_out_T_41; // @[\\src\\main\\scala\\Functions.scala 230:46]
  wire [6:0] _io_out_T_45 = 5'h6 == io_in ? 7'h7d : _io_out_T_43; // @[\\src\\main\\scala\\Functions.scala 230:46]
  wire [6:0] _io_out_T_47 = 5'h7 == io_in ? 7'h7 : _io_out_T_45; // @[\\src\\main\\scala\\Functions.scala 230:46]
  wire [6:0] _io_out_T_49 = 5'h8 == io_in ? 7'h7f : _io_out_T_47; // @[\\src\\main\\scala\\Functions.scala 230:46]
  wire [6:0] _io_out_T_51 = 5'h9 == io_in ? 7'h6f : _io_out_T_49; // @[\\src\\main\\scala\\Functions.scala 230:46]
  wire [6:0] _io_out_T_53 = 5'ha == io_in ? 7'h77 : _io_out_T_51; // @[\\src\\main\\scala\\Functions.scala 230:46]
  wire [6:0] _io_out_T_55 = 5'hb == io_in ? 7'h7c : _io_out_T_53; // @[\\src\\main\\scala\\Functions.scala 230:46]
  wire [6:0] _io_out_T_57 = 5'hc == io_in ? 7'h39 : _io_out_T_55; // @[\\src\\main\\scala\\Functions.scala 230:46]
  wire [6:0] _io_out_T_59 = 5'hd == io_in ? 7'h5e : _io_out_T_57; // @[\\src\\main\\scala\\Functions.scala 230:46]
  wire [6:0] _io_out_T_61 = 5'he == io_in ? 7'h79 : _io_out_T_59; // @[\\src\\main\\scala\\Functions.scala 230:46]
  wire [6:0] _io_out_T_63 = 5'hf == io_in ? 7'h71 : _io_out_T_61; // @[\\src\\main\\scala\\Functions.scala 230:46]
  wire [6:0] _io_out_T_65 = 5'h10 == io_in ? 7'h3c : _io_out_T_63; // @[\\src\\main\\scala\\Functions.scala 230:46]
  wire [6:0] _io_out_T_67 = 5'h11 == io_in ? 7'h76 : _io_out_T_65; // @[\\src\\main\\scala\\Functions.scala 230:46]
  wire [6:0] _io_out_T_69 = 5'h12 == io_in ? 7'h6 : _io_out_T_67; // @[\\src\\main\\scala\\Functions.scala 230:46]
  wire [6:0] _io_out_T_71 = 5'h13 == io_in ? 7'hf : _io_out_T_69; // @[\\src\\main\\scala\\Functions.scala 230:46]
  wire [6:0] _io_out_T_73 = 5'h14 == io_in ? 7'h38 : _io_out_T_71; // @[\\src\\main\\scala\\Functions.scala 230:46]
  wire [6:0] _io_out_T_75 = 5'h15 == io_in ? 7'h38 : _io_out_T_73; // @[\\src\\main\\scala\\Functions.scala 230:46]
  wire [6:0] _io_out_T_77 = 5'h16 == io_in ? 7'h70 : _io_out_T_75; // @[\\src\\main\\scala\\Functions.scala 230:46]
  wire [6:0] _io_out_T_79 = 5'h17 == io_in ? 7'h3f : _io_out_T_77; // @[\\src\\main\\scala\\Functions.scala 230:46]
  wire [6:0] _io_out_T_81 = 5'h18 == io_in ? 7'h73 : _io_out_T_79; // @[\\src\\main\\scala\\Functions.scala 230:46]
  wire [6:0] _io_out_T_83 = 5'h19 == io_in ? 7'h67 : _io_out_T_81; // @[\\src\\main\\scala\\Functions.scala 230:46]
  wire [6:0] _io_out_T_85 = 5'h1a == io_in ? 7'h31 : _io_out_T_83; // @[\\src\\main\\scala\\Functions.scala 230:46]
  wire [6:0] _io_out_T_87 = 5'h1b == io_in ? 7'h6d : _io_out_T_85; // @[\\src\\main\\scala\\Functions.scala 230:46]
  wire [6:0] _io_out_T_89 = 5'h1c == io_in ? 7'h78 : _io_out_T_87; // @[\\src\\main\\scala\\Functions.scala 230:46]
  wire [6:0] _io_out_T_91 = 5'h1d == io_in ? 7'h3e : _io_out_T_89; // @[\\src\\main\\scala\\Functions.scala 230:46]
  assign io_out = 5'h1e == io_in ? 7'h0 : _io_out_T_91; // @[\\src\\main\\scala\\Functions.scala 230:46]
endmodule
module DisplayMultiplexer(
  input         clock,
  input         reset,
  input  [19:0] io_disp_content, // @[\\src\\main\\scala\\Functions.scala 177:14]
  output [7:0]  io_seg, // @[\\src\\main\\scala\\Functions.scala 177:14]
  output [3:0]  io_an // @[\\src\\main\\scala\\Functions.scala 177:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [4:0] decoder_io_in; // @[\\src\\main\\scala\\Functions.scala 200:23]
  wire [6:0] decoder_io_out; // @[\\src\\main\\scala\\Functions.scala 200:23]
  reg [16:0] cnt; // @[\\src\\main\\scala\\Functions.scala 184:20]
  wire  _cnt_T = cnt == 17'h1869f; // @[\\src\\main\\scala\\Functions.scala 185:18]
  wire [16:0] _cnt_T_2 = cnt + 17'h1; // @[\\src\\main\\scala\\Functions.scala 185:54]
  reg [1:0] digit; // @[\\src\\main\\scala\\Functions.scala 188:22]
  wire [1:0] _digit_T_1 = digit + 2'h1; // @[\\src\\main\\scala\\Functions.scala 189:31]
  wire  _T = 2'h0 == digit; // @[\\src\\main\\scala\\Functions.scala 193:17]
  wire  _T_1 = 2'h1 == digit; // @[\\src\\main\\scala\\Functions.scala 193:17]
  wire  _T_2 = 2'h2 == digit; // @[\\src\\main\\scala\\Functions.scala 193:17]
  wire  _T_3 = 2'h3 == digit; // @[\\src\\main\\scala\\Functions.scala 193:17]
  wire [4:0] _GEN_1 = 2'h3 == digit ? io_disp_content[19:15] : 5'h0; // @[\\src\\main\\scala\\Functions.scala 192:14 193:17 197:26]
  wire [4:0] _GEN_2 = 2'h2 == digit ? io_disp_content[14:10] : _GEN_1; // @[\\src\\main\\scala\\Functions.scala 193:17 196:26]
  wire [4:0] _GEN_3 = 2'h1 == digit ? io_disp_content[9:5] : _GEN_2; // @[\\src\\main\\scala\\Functions.scala 193:17 195:26]
  wire [3:0] _currentDot_T = 4'h0 >> digit; // @[\\src\\main\\scala\\Functions.scala 204:27]
  wire  currentDot = _currentDot_T[0]; // @[\\src\\main\\scala\\Functions.scala 204:27]
  wire [7:0] fullSeg = {currentDot,decoder_io_out}; // @[\\src\\main\\scala\\Functions.scala 205:28]
  wire [3:0] _GEN_5 = _T_3 ? 4'h8 : 4'h1; // @[\\src\\main\\scala\\Functions.scala 208:17 212:22 207:27]
  wire [3:0] _GEN_6 = _T_2 ? 4'h4 : _GEN_5; // @[\\src\\main\\scala\\Functions.scala 208:17 211:22]
  wire [3:0] _GEN_7 = _T_1 ? 4'h2 : _GEN_6; // @[\\src\\main\\scala\\Functions.scala 208:17 210:22]
  wire [3:0] select = _T ? 4'h1 : _GEN_7; // @[\\src\\main\\scala\\Functions.scala 208:17 209:22]
  SevenSegDec decoder ( // @[\\src\\main\\scala\\Functions.scala 200:23]
    .io_in(decoder_io_in),
    .io_out(decoder_io_out)
  );
  assign io_seg = ~fullSeg; // @[\\src\\main\\scala\\Functions.scala 215:13]
  assign io_an = ~select; // @[\\src\\main\\scala\\Functions.scala 216:13]
  assign decoder_io_in = 2'h0 == digit ? io_disp_content[4:0] : _GEN_3; // @[\\src\\main\\scala\\Functions.scala 193:17 194:26]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 184:20]
      cnt <= 17'h0; // @[\\src\\main\\scala\\Functions.scala 184:20]
    end else if (cnt == 17'h1869f) begin // @[\\src\\main\\scala\\Functions.scala 185:13]
      cnt <= 17'h0;
    end else begin
      cnt <= _cnt_T_2;
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 188:22]
      digit <= 2'h0; // @[\\src\\main\\scala\\Functions.scala 188:22]
    end else if (_cnt_T) begin // @[\\src\\main\\scala\\Functions.scala 189:14]
      digit <= _digit_T_1; // @[\\src\\main\\scala\\Functions.scala 189:22]
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
module MotorDriver(
  input        clock,
  input        reset,
  input        io_uart_rx, // @[\\src\\main\\scala\\MotorDriver.scala 6:14]
  input        io_photo_diode_A, // @[\\src\\main\\scala\\MotorDriver.scala 6:14]
  input        io_photo_diode_B, // @[\\src\\main\\scala\\MotorDriver.scala 6:14]
  input        io_over_current_pos, // @[\\src\\main\\scala\\MotorDriver.scala 6:14]
  input        io_over_current_neg, // @[\\src\\main\\scala\\MotorDriver.scala 6:14]
  input        io_error_cleared, // @[\\src\\main\\scala\\MotorDriver.scala 6:14]
  output       io_uart_tx, // @[\\src\\main\\scala\\MotorDriver.scala 6:14]
  output       io_T1, // @[\\src\\main\\scala\\MotorDriver.scala 6:14]
  output       io_T2, // @[\\src\\main\\scala\\MotorDriver.scala 6:14]
  output       io_T3, // @[\\src\\main\\scala\\MotorDriver.scala 6:14]
  output       io_T4, // @[\\src\\main\\scala\\MotorDriver.scala 6:14]
  output [7:0] io_seg, // @[\\src\\main\\scala\\MotorDriver.scala 6:14]
  output [3:0] io_an // @[\\src\\main\\scala\\MotorDriver.scala 6:14]
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
`endif // RANDOMIZE_REG_INIT
  wire  rx_clock; // @[\\src\\main\\scala\\MotorDriver.scala 22:32]
  wire  rx_reset; // @[\\src\\main\\scala\\MotorDriver.scala 22:32]
  wire  rx_io_rx; // @[\\src\\main\\scala\\MotorDriver.scala 22:32]
  wire  rx_io_done; // @[\\src\\main\\scala\\MotorDriver.scala 22:32]
  wire [7:0] rx_io_data; // @[\\src\\main\\scala\\MotorDriver.scala 22:32]
  wire  tx_clock; // @[\\src\\main\\scala\\MotorDriver.scala 23:32]
  wire  tx_reset; // @[\\src\\main\\scala\\MotorDriver.scala 23:32]
  wire [7:0] tx_io_data; // @[\\src\\main\\scala\\MotorDriver.scala 23:32]
  wire  tx_io_start; // @[\\src\\main\\scala\\MotorDriver.scala 23:32]
  wire  tx_io_tx; // @[\\src\\main\\scala\\MotorDriver.scala 23:32]
  wire  tx_io_busy; // @[\\src\\main\\scala\\MotorDriver.scala 23:32]
  wire  rotation_counter_clock; // @[\\src\\main\\scala\\MotorDriver.scala 24:32]
  wire  rotation_counter_reset; // @[\\src\\main\\scala\\MotorDriver.scala 24:32]
  wire  rotation_counter_io_signal_A; // @[\\src\\main\\scala\\MotorDriver.scala 24:32]
  wire  rotation_counter_io_signal_B; // @[\\src\\main\\scala\\MotorDriver.scala 24:32]
  wire [31:0] rotation_counter_io_turns; // @[\\src\\main\\scala\\MotorDriver.scala 24:32]
  wire  pwm_gen_clock; // @[\\src\\main\\scala\\MotorDriver.scala 25:32]
  wire  pwm_gen_reset; // @[\\src\\main\\scala\\MotorDriver.scala 25:32]
  wire [9:0] pwm_gen_io_duty_cycle; // @[\\src\\main\\scala\\MotorDriver.scala 25:32]
  wire  pwm_gen_io_brake; // @[\\src\\main\\scala\\MotorDriver.scala 25:32]
  wire  pwm_gen_io_T1; // @[\\src\\main\\scala\\MotorDriver.scala 25:32]
  wire  pwm_gen_io_T2; // @[\\src\\main\\scala\\MotorDriver.scala 25:32]
  wire  pwm_gen_io_T3; // @[\\src\\main\\scala\\MotorDriver.scala 25:32]
  wire  pwm_gen_io_T4; // @[\\src\\main\\scala\\MotorDriver.scala 25:32]
  wire  pid_clock; // @[\\src\\main\\scala\\MotorDriver.scala 26:32]
  wire  pid_reset; // @[\\src\\main\\scala\\MotorDriver.scala 26:32]
  wire [31:0] pid_io_setPoint; // @[\\src\\main\\scala\\MotorDriver.scala 26:32]
  wire [31:0] pid_io_measuredVal; // @[\\src\\main\\scala\\MotorDriver.scala 26:32]
  wire  pid_io_resetBuffer; // @[\\src\\main\\scala\\MotorDriver.scala 26:32]
  wire [31:0] pid_io_controlOut; // @[\\src\\main\\scala\\MotorDriver.scala 26:32]
  wire  stuck_detector_clock; // @[\\src\\main\\scala\\MotorDriver.scala 27:32]
  wire  stuck_detector_reset; // @[\\src\\main\\scala\\MotorDriver.scala 27:32]
  wire  stuck_detector_io_externalOvercurrentInput; // @[\\src\\main\\scala\\MotorDriver.scala 27:32]
  wire  stuck_detector_io_clearShutdown; // @[\\src\\main\\scala\\MotorDriver.scala 27:32]
  wire  stuck_detector_io_motorDisable; // @[\\src\\main\\scala\\MotorDriver.scala 27:32]
  wire  disp_mux_clock; // @[\\src\\main\\scala\\MotorDriver.scala 28:32]
  wire  disp_mux_reset; // @[\\src\\main\\scala\\MotorDriver.scala 28:32]
  wire [19:0] disp_mux_io_disp_content; // @[\\src\\main\\scala\\MotorDriver.scala 28:32]
  wire [7:0] disp_mux_io_seg; // @[\\src\\main\\scala\\MotorDriver.scala 28:32]
  wire [3:0] disp_mux_io_an; // @[\\src\\main\\scala\\MotorDriver.scala 28:32]
  reg [31:0] target_pos_cm; // @[\\src\\main\\scala\\MotorDriver.scala 31:30]
  reg [9:0] manual_speed; // @[\\src\\main\\scala\\MotorDriver.scala 32:30]
  reg  control_mode; // @[\\src\\main\\scala\\MotorDriver.scala 33:30]
  reg  manual_brake; // @[\\src\\main\\scala\\MotorDriver.scala 34:30]
  reg [1:0] uartState; // @[\\src\\main\\scala\\MotorDriver.scala 39:26]
  reg [7:0] cmdByte; // @[\\src\\main\\scala\\MotorDriver.scala 40:26]
  wire [14:0] _target_pos_cm_T_1 = rx_io_data * 7'h64; // @[\\src\\main\\scala\\MotorDriver.scala 49:51]
  wire [9:0] _GEN_2 = 8'h4 == rx_io_data ? 10'h46 : manual_speed; // @[\\src\\main\\scala\\MotorDriver.scala 32:30 56:32 61:38]
  wire  _GEN_3 = 8'h4 == rx_io_data ? 1'h0 : 8'h5 == rx_io_data; // @[\\src\\main\\scala\\MotorDriver.scala 55:26 56:32]
  wire [9:0] _GEN_4 = 8'h3 == rx_io_data ? 10'h17c : _GEN_2; // @[\\src\\main\\scala\\MotorDriver.scala 56:32 60:38]
  wire  _GEN_5 = 8'h3 == rx_io_data ? 1'h0 : _GEN_3; // @[\\src\\main\\scala\\MotorDriver.scala 55:26 56:32]
  wire [9:0] _GEN_6 = 8'h2 == rx_io_data ? 10'h3b6 : _GEN_4; // @[\\src\\main\\scala\\MotorDriver.scala 56:32 59:38]
  wire  _GEN_7 = 8'h2 == rx_io_data ? 1'h0 : _GEN_5; // @[\\src\\main\\scala\\MotorDriver.scala 55:26 56:32]
  wire [9:0] _GEN_8 = 8'h1 == rx_io_data ? 10'h280 : _GEN_6; // @[\\src\\main\\scala\\MotorDriver.scala 56:32 58:38]
  wire  _GEN_9 = 8'h1 == rx_io_data ? 1'h0 : _GEN_7; // @[\\src\\main\\scala\\MotorDriver.scala 55:26 56:32]
  wire [9:0] _GEN_10 = 8'h0 == rx_io_data ? 10'h200 : _GEN_8; // @[\\src\\main\\scala\\MotorDriver.scala 56:32 57:38]
  wire  _GEN_11 = 8'h0 == rx_io_data | _GEN_9; // @[\\src\\main\\scala\\MotorDriver.scala 56:32 57:61]
  wire  _GEN_12 = 8'h2 == cmdByte ? 1'h0 : control_mode; // @[\\src\\main\\scala\\MotorDriver.scala 47:25 54:26 33:30]
  wire  _GEN_13 = 8'h2 == cmdByte ? _GEN_11 : manual_brake; // @[\\src\\main\\scala\\MotorDriver.scala 47:25 34:30]
  wire [9:0] _GEN_14 = 8'h2 == cmdByte ? _GEN_10 : manual_speed; // @[\\src\\main\\scala\\MotorDriver.scala 47:25 32:30]
  wire [31:0] _GEN_15 = 8'h1 == cmdByte ? $signed({{17{_target_pos_cm_T_1[14]}},_target_pos_cm_T_1}) : $signed(
    target_pos_cm); // @[\\src\\main\\scala\\MotorDriver.scala 47:25 49:27 31:30]
  wire  _GEN_16 = 8'h1 == cmdByte | _GEN_12; // @[\\src\\main\\scala\\MotorDriver.scala 47:25 50:27]
  wire  _GEN_17 = 8'h1 == cmdByte ? 1'h0 : _GEN_13; // @[\\src\\main\\scala\\MotorDriver.scala 47:25 51:27]
  wire [9:0] _GEN_18 = 8'h1 == cmdByte ? manual_speed : _GEN_14; // @[\\src\\main\\scala\\MotorDriver.scala 47:25 32:30]
  wire [31:0] _GEN_19 = 2'h2 == uartState ? $signed(_GEN_15) : $signed(target_pos_cm); // @[\\src\\main\\scala\\MotorDriver.scala 43:23 31:30]
  wire  _GEN_20 = 2'h2 == uartState ? _GEN_16 : control_mode; // @[\\src\\main\\scala\\MotorDriver.scala 43:23 33:30]
  wire  _GEN_21 = 2'h2 == uartState ? _GEN_17 : manual_brake; // @[\\src\\main\\scala\\MotorDriver.scala 43:23 34:30]
  wire [9:0] _GEN_22 = 2'h2 == uartState ? _GEN_18 : manual_speed; // @[\\src\\main\\scala\\MotorDriver.scala 43:23 32:30]
  wire [1:0] _GEN_23 = 2'h2 == uartState ? 2'h0 : uartState; // @[\\src\\main\\scala\\MotorDriver.scala 43:23 66:19 39:26]
  wire  _GEN_27 = 2'h1 == uartState ? control_mode : _GEN_20; // @[\\src\\main\\scala\\MotorDriver.scala 43:23 33:30]
  wire  _GEN_28 = 2'h1 == uartState ? manual_brake : _GEN_21; // @[\\src\\main\\scala\\MotorDriver.scala 43:23 34:30]
  wire  _GEN_33 = 2'h0 == uartState ? control_mode : _GEN_27; // @[\\src\\main\\scala\\MotorDriver.scala 43:23 33:30]
  wire  _GEN_34 = 2'h0 == uartState ? manual_brake : _GEN_28; // @[\\src\\main\\scala\\MotorDriver.scala 43:23 34:30]
  wire  _GEN_39 = rx_io_done ? _GEN_33 : control_mode; // @[\\src\\main\\scala\\MotorDriver.scala 42:20 33:30]
  wire  _GEN_40 = rx_io_done ? _GEN_34 : manual_brake; // @[\\src\\main\\scala\\MotorDriver.scala 42:20 34:30]
  wire [40:0] _current_pos_cm_T = $signed(rotation_counter_io_turns) * 9'sh88; // @[\\src\\main\\scala\\MotorDriver.scala 75:51]
  wire [30:0] current_pos_cm = _current_pos_cm_T[40:10]; // @[\\src\\main\\scala\\MotorDriver.scala 75:60]
  wire [31:0] _raw_duty_T = $signed(pid_io_controlOut) + 32'sh800; // @[\\src\\main\\scala\\MotorDriver.scala 89:36]
  wire [31:0] raw_duty = {{2'd0}, _raw_duty_T[31:2]}; // @[\\src\\main\\scala\\MotorDriver.scala 89:43]
  wire [9:0] pid_duty = raw_duty > 32'h3ff ? 10'h3ff : raw_duty[9:0]; // @[\\src\\main\\scala\\MotorDriver.scala 90:21]
  wire  brake_active = stuck_detector_io_motorDisable | manual_brake; // @[\\src\\main\\scala\\MotorDriver.scala 96:54]
  reg [23:0] txTimer; // @[\\src\\main\\scala\\MotorDriver.scala 104:24]
  reg  txState; // @[\\src\\main\\scala\\MotorDriver.scala 106:24]
  wire  _T_14 = ~tx_io_busy; // @[\\src\\main\\scala\\MotorDriver.scala 111:14]
  wire [7:0] _GEN_42 = ~tx_io_busy ? current_pos_cm[15:8] : 8'h0; // @[\\src\\main\\scala\\MotorDriver.scala 107:14 111:27 112:22]
  wire  _GEN_44 = ~tx_io_busy | txState; // @[\\src\\main\\scala\\MotorDriver.scala 111:27 114:19 106:24]
  wire [7:0] _GEN_45 = _T_14 ? current_pos_cm[7:0] : 8'h0; // @[\\src\\main\\scala\\MotorDriver.scala 107:14 118:27 119:22]
  wire  _GEN_47 = _T_14 ? 1'h0 : txState; // @[\\src\\main\\scala\\MotorDriver.scala 118:27 121:19 106:24]
  wire [23:0] _GEN_48 = _T_14 ? 24'h0 : txTimer; // @[\\src\\main\\scala\\MotorDriver.scala 118:27 122:19 104:24]
  wire [7:0] _GEN_49 = txState ? _GEN_45 : 8'h0; // @[\\src\\main\\scala\\MotorDriver.scala 107:14 109:21]
  wire  _GEN_50 = txState & _T_14; // @[\\src\\main\\scala\\MotorDriver.scala 109:21 107:34]
  wire [7:0] _GEN_53 = ~txState ? _GEN_42 : _GEN_49; // @[\\src\\main\\scala\\MotorDriver.scala 109:21]
  wire  _GEN_54 = ~txState ? _T_14 : _GEN_50; // @[\\src\\main\\scala\\MotorDriver.scala 109:21]
  wire [23:0] _txTimer_T_1 = txTimer + 24'h1; // @[\\src\\main\\scala\\MotorDriver.scala 126:36]
  wire [19:0] _disp_mux_io_disp_content_T_15 = control_mode ? 20'h57797 : 20'hf7bde; // @[\\src\\main\\scala\\MotorDriver.scala 134:8]
  UartRx rx ( // @[\\src\\main\\scala\\MotorDriver.scala 22:32]
    .clock(rx_clock),
    .reset(rx_reset),
    .io_rx(rx_io_rx),
    .io_done(rx_io_done),
    .io_data(rx_io_data)
  );
  UartTx tx ( // @[\\src\\main\\scala\\MotorDriver.scala 23:32]
    .clock(tx_clock),
    .reset(tx_reset),
    .io_data(tx_io_data),
    .io_start(tx_io_start),
    .io_tx(tx_io_tx),
    .io_busy(tx_io_busy)
  );
  RotationCounter rotation_counter ( // @[\\src\\main\\scala\\MotorDriver.scala 24:32]
    .clock(rotation_counter_clock),
    .reset(rotation_counter_reset),
    .io_signal_A(rotation_counter_io_signal_A),
    .io_signal_B(rotation_counter_io_signal_B),
    .io_turns(rotation_counter_io_turns)
  );
  DCMotorPwm pwm_gen ( // @[\\src\\main\\scala\\MotorDriver.scala 25:32]
    .clock(pwm_gen_clock),
    .reset(pwm_gen_reset),
    .io_duty_cycle(pwm_gen_io_duty_cycle),
    .io_brake(pwm_gen_io_brake),
    .io_T1(pwm_gen_io_T1),
    .io_T2(pwm_gen_io_T2),
    .io_T3(pwm_gen_io_T3),
    .io_T4(pwm_gen_io_T4)
  );
  PIDController pid ( // @[\\src\\main\\scala\\MotorDriver.scala 26:32]
    .clock(pid_clock),
    .reset(pid_reset),
    .io_setPoint(pid_io_setPoint),
    .io_measuredVal(pid_io_measuredVal),
    .io_resetBuffer(pid_io_resetBuffer),
    .io_controlOut(pid_io_controlOut)
  );
  StuckDetector stuck_detector ( // @[\\src\\main\\scala\\MotorDriver.scala 27:32]
    .clock(stuck_detector_clock),
    .reset(stuck_detector_reset),
    .io_externalOvercurrentInput(stuck_detector_io_externalOvercurrentInput),
    .io_clearShutdown(stuck_detector_io_clearShutdown),
    .io_motorDisable(stuck_detector_io_motorDisable)
  );
  DisplayMultiplexer disp_mux ( // @[\\src\\main\\scala\\MotorDriver.scala 28:32]
    .clock(disp_mux_clock),
    .reset(disp_mux_reset),
    .io_disp_content(disp_mux_io_disp_content),
    .io_seg(disp_mux_io_seg),
    .io_an(disp_mux_io_an)
  );
  assign io_uart_tx = tx_io_tx; // @[\\src\\main\\scala\\MotorDriver.scala 127:14]
  assign io_T1 = pwm_gen_io_T1; // @[\\src\\main\\scala\\MotorDriver.scala 100:9]
  assign io_T2 = pwm_gen_io_T2; // @[\\src\\main\\scala\\MotorDriver.scala 100:33]
  assign io_T3 = pwm_gen_io_T3; // @[\\src\\main\\scala\\MotorDriver.scala 101:9]
  assign io_T4 = pwm_gen_io_T4; // @[\\src\\main\\scala\\MotorDriver.scala 101:33]
  assign io_seg = disp_mux_io_seg; // @[\\src\\main\\scala\\MotorDriver.scala 130:35]
  assign io_an = disp_mux_io_an; // @[\\src\\main\\scala\\MotorDriver.scala 130:9]
  assign rx_clock = clock;
  assign rx_reset = reset;
  assign rx_io_rx = io_uart_rx; // @[\\src\\main\\scala\\MotorDriver.scala 37:12]
  assign tx_clock = clock;
  assign tx_reset = reset;
  assign tx_io_data = txTimer >= 24'h4c4b40 ? _GEN_53 : 8'h0; // @[\\src\\main\\scala\\MotorDriver.scala 107:14 108:30]
  assign tx_io_start = txTimer >= 24'h4c4b40 & _GEN_54; // @[\\src\\main\\scala\\MotorDriver.scala 108:30 107:34]
  assign rotation_counter_clock = clock;
  assign rotation_counter_reset = reset;
  assign rotation_counter_io_signal_A = io_photo_diode_A; // @[\\src\\main\\scala\\MotorDriver.scala 72:32]
  assign rotation_counter_io_signal_B = io_photo_diode_B; // @[\\src\\main\\scala\\MotorDriver.scala 73:32]
  assign pwm_gen_clock = clock;
  assign pwm_gen_reset = reset;
  assign pwm_gen_io_duty_cycle = control_mode ? pid_duty : manual_speed; // @[\\src\\main\\scala\\MotorDriver.scala 97:31]
  assign pwm_gen_io_brake = stuck_detector_io_motorDisable | manual_brake; // @[\\src\\main\\scala\\MotorDriver.scala 96:54]
  assign pid_clock = clock;
  assign pid_reset = reset;
  assign pid_io_setPoint = target_pos_cm; // @[\\src\\main\\scala\\MotorDriver.scala 78:51]
  assign pid_io_measuredVal = {{1{current_pos_cm[30]}},current_pos_cm}; // @[\\src\\main\\scala\\MotorDriver.scala 79:22]
  assign pid_io_resetBuffer = ~control_mode | manual_brake; // @[\\src\\main\\scala\\MotorDriver.scala 80:39]
  assign stuck_detector_clock = clock;
  assign stuck_detector_reset = reset;
  assign stuck_detector_io_externalOvercurrentInput = io_over_current_pos | io_over_current_neg; // @[\\src\\main\\scala\\MotorDriver.scala 93:70]
  assign stuck_detector_io_clearShutdown = rx_io_done & cmdByte == 8'hff | io_error_cleared; // @[\\src\\main\\scala\\MotorDriver.scala 94:74]
  assign disp_mux_clock = clock;
  assign disp_mux_reset = reset;
  assign disp_mux_io_disp_content = brake_active ? 20'hdf2f8 : _disp_mux_io_disp_content_T_15; // @[\\src\\main\\scala\\MotorDriver.scala 132:34]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 31:30]
      target_pos_cm <= 32'sh0; // @[\\src\\main\\scala\\MotorDriver.scala 31:30]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\MotorDriver.scala 42:20]
      if (!(2'h0 == uartState)) begin // @[\\src\\main\\scala\\MotorDriver.scala 43:23]
        if (!(2'h1 == uartState)) begin // @[\\src\\main\\scala\\MotorDriver.scala 43:23]
          target_pos_cm <= _GEN_19;
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 32:30]
      manual_speed <= 10'h200; // @[\\src\\main\\scala\\MotorDriver.scala 32:30]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\MotorDriver.scala 42:20]
      if (!(2'h0 == uartState)) begin // @[\\src\\main\\scala\\MotorDriver.scala 43:23]
        if (!(2'h1 == uartState)) begin // @[\\src\\main\\scala\\MotorDriver.scala 43:23]
          manual_speed <= _GEN_22;
        end
      end
    end
    control_mode <= reset | _GEN_39; // @[\\src\\main\\scala\\MotorDriver.scala 33:{30,30}]
    manual_brake <= reset | _GEN_40; // @[\\src\\main\\scala\\MotorDriver.scala 34:{30,30}]
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 39:26]
      uartState <= 2'h0; // @[\\src\\main\\scala\\MotorDriver.scala 39:26]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\MotorDriver.scala 42:20]
      if (2'h0 == uartState) begin // @[\\src\\main\\scala\\MotorDriver.scala 43:23]
        if (rx_io_data == 8'haa) begin // @[\\src\\main\\scala\\MotorDriver.scala 44:49]
          uartState <= 2'h1; // @[\\src\\main\\scala\\MotorDriver.scala 44:61]
        end
      end else if (2'h1 == uartState) begin // @[\\src\\main\\scala\\MotorDriver.scala 43:23]
        uartState <= 2'h2; // @[\\src\\main\\scala\\MotorDriver.scala 45:54]
      end else begin
        uartState <= _GEN_23;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 40:26]
      cmdByte <= 8'h0; // @[\\src\\main\\scala\\MotorDriver.scala 40:26]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\MotorDriver.scala 42:20]
      if (!(2'h0 == uartState)) begin // @[\\src\\main\\scala\\MotorDriver.scala 43:23]
        if (2'h1 == uartState) begin // @[\\src\\main\\scala\\MotorDriver.scala 43:23]
          cmdByte <= rx_io_data; // @[\\src\\main\\scala\\MotorDriver.scala 45:29]
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 104:24]
      txTimer <= 24'h0; // @[\\src\\main\\scala\\MotorDriver.scala 104:24]
    end else if (txTimer >= 24'h4c4b40) begin // @[\\src\\main\\scala\\MotorDriver.scala 108:30]
      if (!(~txState)) begin // @[\\src\\main\\scala\\MotorDriver.scala 109:21]
        if (txState) begin // @[\\src\\main\\scala\\MotorDriver.scala 109:21]
          txTimer <= _GEN_48;
        end
      end
    end else begin
      txTimer <= _txTimer_T_1; // @[\\src\\main\\scala\\MotorDriver.scala 126:25]
    end
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 106:24]
      txState <= 1'h0; // @[\\src\\main\\scala\\MotorDriver.scala 106:24]
    end else if (txTimer >= 24'h4c4b40) begin // @[\\src\\main\\scala\\MotorDriver.scala 108:30]
      if (~txState) begin // @[\\src\\main\\scala\\MotorDriver.scala 109:21]
        txState <= _GEN_44;
      end else if (txState) begin // @[\\src\\main\\scala\\MotorDriver.scala 109:21]
        txState <= _GEN_47;
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
  target_pos_cm = _RAND_0[31:0];
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
  _RAND_7 = {1{`RANDOM}};
  txState = _RAND_7[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
