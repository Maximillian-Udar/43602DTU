module UartRx(
  input        clock,
  input        reset,
  input        io_rx, // @[\\src\\main\\scala\\Functions.scala 10:14]
  output       io_done, // @[\\src\\main\\scala\\Functions.scala 10:14]
  output [7:0] io_data // @[\\src\\main\\scala\\Functions.scala 10:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg  rxReg_REG; // @[\\src\\main\\scala\\Functions.scala 19:33]
  reg  rxReg; // @[\\src\\main\\scala\\Functions.scala 19:25]
  reg [7:0] shiftReg; // @[\\src\\main\\scala\\Functions.scala 20:25]
  reg [31:0] cntReg; // @[\\src\\main\\scala\\Functions.scala 21:25]
  reg [3:0] bitsReg; // @[\\src\\main\\scala\\Functions.scala 22:25]
  reg [1:0] stateReg; // @[\\src\\main\\scala\\Functions.scala 25:25]
  wire [31:0] _cntReg_T_1 = cntReg + 32'h1; // @[\\src\\main\\scala\\Functions.scala 42:38]
  wire [9:0] _T_6 = 10'h364 - 10'h1; // @[\\src\\main\\scala\\Functions.scala 45:31]
  wire [31:0] _GEN_32 = {{22'd0}, _T_6}; // @[\\src\\main\\scala\\Functions.scala 45:19]
  wire  _T_7 = cntReg == _GEN_32; // @[\\src\\main\\scala\\Functions.scala 45:19]
  wire [7:0] _shiftReg_T_1 = {rxReg,shiftReg[7:1]}; // @[\\src\\main\\scala\\Functions.scala 47:24]
  wire [3:0] _bitsReg_T_1 = bitsReg + 4'h1; // @[\\src\\main\\scala\\Functions.scala 49:41]
  wire [1:0] _GEN_5 = bitsReg == 4'h7 ? 2'h3 : stateReg; // @[\\src\\main\\scala\\Functions.scala 25:25 48:{31,42}]
  wire [3:0] _GEN_6 = bitsReg == 4'h7 ? bitsReg : _bitsReg_T_1; // @[\\src\\main\\scala\\Functions.scala 22:25 48:31 49:30]
  wire [31:0] _GEN_7 = cntReg == _GEN_32 ? 32'h0 : _cntReg_T_1; // @[\\src\\main\\scala\\Functions.scala 45:38 46:16 50:28]
  wire [7:0] _GEN_8 = cntReg == _GEN_32 ? _shiftReg_T_1 : shiftReg; // @[\\src\\main\\scala\\Functions.scala 45:38 47:18 20:25]
  wire [1:0] _GEN_9 = cntReg == _GEN_32 ? _GEN_5 : stateReg; // @[\\src\\main\\scala\\Functions.scala 25:25 45:38]
  wire [3:0] _GEN_10 = cntReg == _GEN_32 ? _GEN_6 : bitsReg; // @[\\src\\main\\scala\\Functions.scala 22:25 45:38]
  wire [1:0] _GEN_11 = _T_7 ? 2'h0 : stateReg; // @[\\src\\main\\scala\\Functions.scala 53:38 54:18 25:25]
  wire [31:0] _GEN_13 = _T_7 ? cntReg : _cntReg_T_1; // @[\\src\\main\\scala\\Functions.scala 21:25 53:38 56:28]
  wire [1:0] _GEN_14 = 2'h3 == stateReg ? _GEN_11 : stateReg; // @[\\src\\main\\scala\\Functions.scala 30:20 25:25]
  wire [31:0] _GEN_16 = 2'h3 == stateReg ? _GEN_13 : cntReg; // @[\\src\\main\\scala\\Functions.scala 30:20 21:25]
  wire  _GEN_21 = 2'h2 == stateReg ? 1'h0 : 2'h3 == stateReg & _T_7; // @[\\src\\main\\scala\\Functions.scala 27:11 30:20]
  wire  _GEN_26 = 2'h1 == stateReg ? 1'h0 : _GEN_21; // @[\\src\\main\\scala\\Functions.scala 27:11 30:20]
  assign io_done = 2'h0 == stateReg ? 1'h0 : _GEN_26; // @[\\src\\main\\scala\\Functions.scala 27:11 30:20]
  assign io_data = shiftReg; // @[\\src\\main\\scala\\Functions.scala 28:11]
  always @(posedge clock) begin
    rxReg_REG <= io_rx; // @[\\src\\main\\scala\\Functions.scala 19:33]
    rxReg <= rxReg_REG; // @[\\src\\main\\scala\\Functions.scala 19:25]
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 20:25]
      shiftReg <= 8'h0; // @[\\src\\main\\scala\\Functions.scala 20:25]
    end else if (!(2'h0 == stateReg)) begin // @[\\src\\main\\scala\\Functions.scala 30:20]
      if (!(2'h1 == stateReg)) begin // @[\\src\\main\\scala\\Functions.scala 30:20]
        if (2'h2 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 30:20]
          shiftReg <= _GEN_8;
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 21:25]
      cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 21:25]
    end else if (2'h0 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 30:20]
      if (~rxReg) begin // @[\\src\\main\\scala\\Functions.scala 32:20]
        cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 34:16]
      end
    end else if (2'h1 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 30:20]
      if (cntReg == 32'h1b2) begin // @[\\src\\main\\scala\\Functions.scala 38:34]
        cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 40:16]
      end else begin
        cntReg <= _cntReg_T_1; // @[\\src\\main\\scala\\Functions.scala 42:28]
      end
    end else if (2'h2 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 30:20]
      cntReg <= _GEN_7;
    end else begin
      cntReg <= _GEN_16;
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 22:25]
      bitsReg <= 4'h0; // @[\\src\\main\\scala\\Functions.scala 22:25]
    end else if (!(2'h0 == stateReg)) begin // @[\\src\\main\\scala\\Functions.scala 30:20]
      if (2'h1 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 30:20]
        if (cntReg == 32'h1b2) begin // @[\\src\\main\\scala\\Functions.scala 38:34]
          bitsReg <= 4'h0; // @[\\src\\main\\scala\\Functions.scala 41:17]
        end
      end else if (2'h2 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 30:20]
        bitsReg <= _GEN_10;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 25:25]
      stateReg <= 2'h0; // @[\\src\\main\\scala\\Functions.scala 25:25]
    end else if (2'h0 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 30:20]
      if (~rxReg) begin // @[\\src\\main\\scala\\Functions.scala 32:20]
        stateReg <= 2'h1; // @[\\src\\main\\scala\\Functions.scala 33:18]
      end
    end else if (2'h1 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 30:20]
      if (cntReg == 32'h1b2) begin // @[\\src\\main\\scala\\Functions.scala 38:34]
        stateReg <= 2'h2; // @[\\src\\main\\scala\\Functions.scala 39:18]
      end
    end else if (2'h2 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 30:20]
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
  input  [7:0] io_data, // @[\\src\\main\\scala\\Functions.scala 62:14]
  input        io_start, // @[\\src\\main\\scala\\Functions.scala 62:14]
  output       io_tx, // @[\\src\\main\\scala\\Functions.scala 62:14]
  output       io_busy // @[\\src\\main\\scala\\Functions.scala 62:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [9:0] reg_; // @[\\src\\main\\scala\\Functions.scala 70:20]
  reg [31:0] cnt; // @[\\src\\main\\scala\\Functions.scala 71:20]
  reg [3:0] bits; // @[\\src\\main\\scala\\Functions.scala 72:21]
  reg  state; // @[\\src\\main\\scala\\Functions.scala 75:22]
  wire [9:0] _reg_T = {1'h1,io_data,1'h0}; // @[\\src\\main\\scala\\Functions.scala 83:19]
  wire  _GEN_3 = io_start | state; // @[\\src\\main\\scala\\Functions.scala 82:22 86:15 75:22]
  wire [9:0] _T_3 = 10'h364 - 10'h1; // @[\\src\\main\\scala\\Functions.scala 90:28]
  wire [31:0] _GEN_18 = {{22'd0}, _T_3}; // @[\\src\\main\\scala\\Functions.scala 90:16]
  wire [9:0] _reg_T_2 = {1'h1,reg_[9:1]}; // @[\\src\\main\\scala\\Functions.scala 92:19]
  wire [3:0] _bits_T_1 = bits + 4'h1; // @[\\src\\main\\scala\\Functions.scala 94:35]
  wire  _GEN_4 = bits == 4'h9 ? 1'h0 : state; // @[\\src\\main\\scala\\Functions.scala 75:22 93:{28,36}]
  wire [3:0] _GEN_5 = bits == 4'h9 ? bits : _bits_T_1; // @[\\src\\main\\scala\\Functions.scala 72:21 93:28 94:27]
  wire [31:0] _cnt_T_1 = cnt + 32'h1; // @[\\src\\main\\scala\\Functions.scala 95:32]
  assign io_tx = reg_[0]; // @[\\src\\main\\scala\\Functions.scala 77:15]
  assign io_busy = state; // @[\\src\\main\\scala\\Functions.scala 78:20]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 70:20]
      reg_ <= 10'h1; // @[\\src\\main\\scala\\Functions.scala 70:20]
    end else if (~state) begin // @[\\src\\main\\scala\\Functions.scala 80:17]
      if (io_start) begin // @[\\src\\main\\scala\\Functions.scala 82:22]
        reg_ <= _reg_T; // @[\\src\\main\\scala\\Functions.scala 83:13]
      end
    end else if (state) begin // @[\\src\\main\\scala\\Functions.scala 80:17]
      if (cnt == _GEN_18) begin // @[\\src\\main\\scala\\Functions.scala 90:35]
        reg_ <= _reg_T_2; // @[\\src\\main\\scala\\Functions.scala 92:13]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 71:20]
      cnt <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 71:20]
    end else if (~state) begin // @[\\src\\main\\scala\\Functions.scala 80:17]
      if (io_start) begin // @[\\src\\main\\scala\\Functions.scala 82:22]
        cnt <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 85:13]
      end
    end else if (state) begin // @[\\src\\main\\scala\\Functions.scala 80:17]
      if (cnt == _GEN_18) begin // @[\\src\\main\\scala\\Functions.scala 90:35]
        cnt <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 91:13]
      end else begin
        cnt <= _cnt_T_1; // @[\\src\\main\\scala\\Functions.scala 95:25]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 72:21]
      bits <= 4'h0; // @[\\src\\main\\scala\\Functions.scala 72:21]
    end else if (~state) begin // @[\\src\\main\\scala\\Functions.scala 80:17]
      if (io_start) begin // @[\\src\\main\\scala\\Functions.scala 82:22]
        bits <= 4'h0; // @[\\src\\main\\scala\\Functions.scala 84:14]
      end
    end else if (state) begin // @[\\src\\main\\scala\\Functions.scala 80:17]
      if (cnt == _GEN_18) begin // @[\\src\\main\\scala\\Functions.scala 90:35]
        bits <= _GEN_5;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 75:22]
      state <= 1'h0; // @[\\src\\main\\scala\\Functions.scala 75:22]
    end else if (~state) begin // @[\\src\\main\\scala\\Functions.scala 80:17]
      state <= _GEN_3;
    end else if (state) begin // @[\\src\\main\\scala\\Functions.scala 80:17]
      if (cnt == _GEN_18) begin // @[\\src\\main\\scala\\Functions.scala 90:35]
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
  input         io_signal_A, // @[\\src\\main\\scala\\Functions.scala 187:14]
  input         io_signal_B, // @[\\src\\main\\scala\\Functions.scala 187:14]
  output [15:0] io_turns // @[\\src\\main\\scala\\Functions.scala 187:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg  aSync_REG; // @[\\src\\main\\scala\\Functions.scala 193:31]
  reg  aSync; // @[\\src\\main\\scala\\Functions.scala 193:23]
  reg  bSync_REG; // @[\\src\\main\\scala\\Functions.scala 194:31]
  reg  bSync; // @[\\src\\main\\scala\\Functions.scala 194:23]
  reg  aReg; // @[\\src\\main\\scala\\Functions.scala 195:23]
  wire  rise_A = aSync & ~aReg; // @[\\src\\main\\scala\\Functions.scala 196:22]
  reg [15:0] turns; // @[\\src\\main\\scala\\Functions.scala 197:22]
  wire [15:0] _turns_T_1 = turns + 16'h1; // @[\\src\\main\\scala\\Functions.scala 201:22]
  wire [15:0] _turns_T_3 = turns - 16'h1; // @[\\src\\main\\scala\\Functions.scala 203:22]
  assign io_turns = turns; // @[\\src\\main\\scala\\Functions.scala 206:12]
  always @(posedge clock) begin
    aSync_REG <= io_signal_A; // @[\\src\\main\\scala\\Functions.scala 193:31]
    aSync <= aSync_REG; // @[\\src\\main\\scala\\Functions.scala 193:23]
    bSync_REG <= io_signal_B; // @[\\src\\main\\scala\\Functions.scala 194:31]
    bSync <= bSync_REG; // @[\\src\\main\\scala\\Functions.scala 194:23]
    aReg <= aSync; // @[\\src\\main\\scala\\Functions.scala 195:23]
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 197:22]
      turns <= 16'h0; // @[\\src\\main\\scala\\Functions.scala 197:22]
    end else if (rise_A) begin // @[\\src\\main\\scala\\Functions.scala 199:16]
      if (~bSync) begin // @[\\src\\main\\scala\\Functions.scala 200:18]
        turns <= _turns_T_1; // @[\\src\\main\\scala\\Functions.scala 201:13]
      end else begin
        turns <= _turns_T_3; // @[\\src\\main\\scala\\Functions.scala 203:13]
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
  input  [9:0] io_duty_cycle, // @[\\src\\main\\scala\\Functions.scala 101:14]
  input        io_brake, // @[\\src\\main\\scala\\Functions.scala 101:14]
  output       io_T1, // @[\\src\\main\\scala\\Functions.scala 101:14]
  output       io_T2, // @[\\src\\main\\scala\\Functions.scala 101:14]
  output       io_T3, // @[\\src\\main\\scala\\Functions.scala 101:14]
  output       io_T4 // @[\\src\\main\\scala\\Functions.scala 101:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] pwmCounter; // @[\\src\\main\\scala\\Functions.scala 112:29]
  wire [11:0] _T_1 = 12'hd05 - 12'h1; // @[\\src\\main\\scala\\Functions.scala 114:35]
  wire [31:0] _GEN_5 = {{20'd0}, _T_1}; // @[\\src\\main\\scala\\Functions.scala 114:19]
  wire [31:0] _pwmCounter_T_1 = pwmCounter + 32'h1; // @[\\src\\main\\scala\\Functions.scala 117:30]
  wire [21:0] _threshold_T = io_duty_cycle * 12'hd05; // @[\\src\\main\\scala\\Functions.scala 120:34]
  wire [11:0] threshold = _threshold_T[21:10]; // @[\\src\\main\\scala\\Functions.scala 120:50]
  wire [31:0] _GEN_6 = {{20'd0}, threshold}; // @[\\src\\main\\scala\\Functions.scala 121:30]
  wire  pwmSignal = pwmCounter < _GEN_6; // @[\\src\\main\\scala\\Functions.scala 121:30]
  wire  _conduct_T1_T = ~pwmSignal; // @[\\src\\main\\scala\\Functions.scala 136:19]
  wire  conduct_T2 = io_brake ? 1'h0 : pwmSignal; // @[\\src\\main\\scala\\Functions.scala 128:18 130:16 134:16]
  wire  conduct_T4 = io_brake ? 1'h0 : _conduct_T1_T; // @[\\src\\main\\scala\\Functions.scala 128:18 132:16 137:16]
  assign io_T1 = io_brake | ~pwmSignal; // @[\\src\\main\\scala\\Functions.scala 128:18 129:16 136:16]
  assign io_T2 = ~conduct_T2; // @[\\src\\main\\scala\\Functions.scala 142:12]
  assign io_T3 = io_brake | pwmSignal; // @[\\src\\main\\scala\\Functions.scala 128:18 131:16 135:16]
  assign io_T4 = ~conduct_T4; // @[\\src\\main\\scala\\Functions.scala 143:12]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 112:29]
      pwmCounter <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 112:29]
    end else if (pwmCounter >= _GEN_5) begin // @[\\src\\main\\scala\\Functions.scala 114:42]
      pwmCounter <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 115:16]
    end else begin
      pwmCounter <= _pwmCounter_T_1; // @[\\src\\main\\scala\\Functions.scala 117:16]
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
  input  [15:0] io_setPoint, // @[\\src\\main\\scala\\Functions.scala 147:14]
  input  [15:0] io_measuredVal, // @[\\src\\main\\scala\\Functions.scala 147:14]
  input         io_resetBuffer, // @[\\src\\main\\scala\\Functions.scala 147:14]
  output [15:0] io_controlOut // @[\\src\\main\\scala\\Functions.scala 147:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [63:0] _RAND_6;
  reg [63:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  reg [15:0] errorReg; // @[\\src\\main\\scala\\Functions.scala 157:25]
  reg [32:0] pTerm; // @[\\src\\main\\scala\\Functions.scala 162:26]
  reg [31:0] iTermNext; // @[\\src\\main\\scala\\Functions.scala 163:26]
  reg [15:0] prevErrorReg; // @[\\src\\main\\scala\\Functions.scala 165:29]
  wire [15:0] _dTerm_T_2 = $signed(errorReg) - $signed(prevErrorReg); // @[\\src\\main\\scala\\Functions.scala 166:48]
  reg [31:0] dTerm; // @[\\src\\main\\scala\\Functions.scala 166:29]
  reg [15:0] integralReg; // @[\\src\\main\\scala\\Functions.scala 171:28]
  wire [27:0] _GEN_1 = {$signed(integralReg), 12'h0}; // @[\\src\\main\\scala\\Functions.scala 176:27]
  wire [31:0] _GEN_2 = {{4{_GEN_1[27]}},_GEN_1}; // @[\\src\\main\\scala\\Functions.scala 176:27]
  wire [31:0] sum = $signed(_GEN_2) + $signed(iTermNext); // @[\\src\\main\\scala\\Functions.scala 176:27]
  wire [31:0] _integralReg_T_2 = $signed(sum) < 32'sh0 ? $signed(32'sh0) : $signed(sum); // @[\\src\\main\\scala\\Functions.scala 177:57]
  wire [31:0] _integralReg_T_3 = $signed(sum) > 32'sh1000000 ? $signed(32'sh1000000) : $signed(_integralReg_T_2); // @[\\src\\main\\scala\\Functions.scala 177:23]
  wire [31:0] _GEN_0 = io_resetBuffer ? $signed(32'sh0) : $signed(_integralReg_T_3); // @[\\src\\main\\scala\\Functions.scala 173:24 174:17 177:17]
  wire [32:0] _GEN_4 = {{5{_GEN_1[27]}},_GEN_1}; // @[\\src\\main\\scala\\Functions.scala 180:36]
  wire [32:0] _rawOutput_T_2 = $signed(pTerm) + $signed(_GEN_4); // @[\\src\\main\\scala\\Functions.scala 180:36]
  wire [32:0] _GEN_5 = {{1{dTerm[31]}},dTerm}; // @[\\src\\main\\scala\\Functions.scala 180:50]
  reg [32:0] rawOutput; // @[\\src\\main\\scala\\Functions.scala 180:29]
  reg [32:0] io_controlOut_REG; // @[\\src\\main\\scala\\Functions.scala 183:27]
  wire [20:0] _GEN_6 = io_controlOut_REG[32:12]; // @[\\src\\main\\scala\\Functions.scala 183:17]
  wire [19:0] _GEN_8 = reset ? $signed(20'sh0) : $signed(_GEN_0[31:12]); // @[\\src\\main\\scala\\Functions.scala 171:{28,28}]
  assign io_controlOut = _GEN_6[15:0]; // @[\\src\\main\\scala\\Functions.scala 183:17]
  always @(posedge clock) begin
    errorReg <= $signed(io_setPoint) - $signed(io_measuredVal); // @[\\src\\main\\scala\\Functions.scala 157:38]
    pTerm <= 17'sha000 * $signed(errorReg); // @[\\src\\main\\scala\\Functions.scala 162:33]
    iTermNext <= 16'sh1000 * $signed(errorReg); // @[\\src\\main\\scala\\Functions.scala 163:33]
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 165:29]
      prevErrorReg <= 16'sh0; // @[\\src\\main\\scala\\Functions.scala 165:29]
    end else begin
      prevErrorReg <= errorReg; // @[\\src\\main\\scala\\Functions.scala 167:20]
    end
    dTerm <= 16'sh1000 * $signed(_dTerm_T_2); // @[\\src\\main\\scala\\Functions.scala 166:36]
    integralReg <= _GEN_8[15:0]; // @[\\src\\main\\scala\\Functions.scala 171:{28,28}]
    rawOutput <= $signed(_rawOutput_T_2) + $signed(_GEN_5); // @[\\src\\main\\scala\\Functions.scala 180:50]
    if ($signed(rawOutput) > 33'sh1000000) begin // @[\\src\\main\\scala\\Functions.scala 181:25]
      io_controlOut_REG <= 33'sh1000000;
    end else if ($signed(rawOutput) < 33'sh0) begin // @[\\src\\main\\scala\\Functions.scala 181:65]
      io_controlOut_REG <= 33'sh0;
    end else begin
      io_controlOut_REG <= rawOutput;
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
  errorReg = _RAND_0[15:0];
  _RAND_1 = {2{`RANDOM}};
  pTerm = _RAND_1[32:0];
  _RAND_2 = {1{`RANDOM}};
  iTermNext = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  prevErrorReg = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  dTerm = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  integralReg = _RAND_5[15:0];
  _RAND_6 = {2{`RANDOM}};
  rawOutput = _RAND_6[32:0];
  _RAND_7 = {2{`RANDOM}};
  io_controlOut_REG = _RAND_7[32:0];
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
  input   io_externalOvercurrentInput, // @[\\src\\main\\scala\\Functions.scala 210:14]
  input   io_clearShutdown, // @[\\src\\main\\scala\\Functions.scala 210:14]
  output  io_motorDisable // @[\\src\\main\\scala\\Functions.scala 210:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [24:0] maxCycles = 17'h186a0 * 8'h96; // @[\\src\\main\\scala\\Functions.scala 218:44]
  reg [31:0] durationReg; // @[\\src\\main\\scala\\Functions.scala 219:28]
  reg  isStuckReg; // @[\\src\\main\\scala\\Functions.scala 220:28]
  wire [31:0] _GEN_8 = {{7'd0}, maxCycles}; // @[\\src\\main\\scala\\Functions.scala 228:26]
  wire [31:0] _durationReg_T_1 = durationReg + 32'h1; // @[\\src\\main\\scala\\Functions.scala 231:38]
  wire  _GEN_0 = durationReg >= _GEN_8 | isStuckReg; // @[\\src\\main\\scala\\Functions.scala 228:40 229:22 220:28]
  wire [31:0] _GEN_1 = durationReg >= _GEN_8 ? durationReg : _durationReg_T_1; // @[\\src\\main\\scala\\Functions.scala 219:28 228:40 231:23]
  assign io_motorDisable = isStuckReg; // @[\\src\\main\\scala\\Functions.scala 240:20]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 219:28]
      durationReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 219:28]
    end else if (io_clearShutdown) begin // @[\\src\\main\\scala\\Functions.scala 222:26]
      durationReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 224:17]
    end else if (~isStuckReg) begin // @[\\src\\main\\scala\\Functions.scala 226:23]
      if (io_externalOvercurrentInput) begin // @[\\src\\main\\scala\\Functions.scala 227:41]
        durationReg <= _GEN_1;
      end else begin
        durationReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 234:21]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 220:28]
      isStuckReg <= 1'h0; // @[\\src\\main\\scala\\Functions.scala 220:28]
    end else if (io_clearShutdown) begin // @[\\src\\main\\scala\\Functions.scala 222:26]
      isStuckReg <= 1'h0; // @[\\src\\main\\scala\\Functions.scala 223:17]
    end else if (~isStuckReg) begin // @[\\src\\main\\scala\\Functions.scala 226:23]
      if (io_externalOvercurrentInput) begin // @[\\src\\main\\scala\\Functions.scala 227:41]
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
  input   io_photo_diode_A, // @[\\src\\main\\scala\\MotorDriver.scala 6:16]
  input   io_photo_diode_B, // @[\\src\\main\\scala\\MotorDriver.scala 6:16]
  input   io_over_current, // @[\\src\\main\\scala\\MotorDriver.scala 6:16]
  output  io_uart_tx, // @[\\src\\main\\scala\\MotorDriver.scala 6:16]
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
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
`endif // RANDOMIZE_REG_INIT
  wire  rx_clock; // @[\\src\\main\\scala\\MotorDriver.scala 19:34]
  wire  rx_reset; // @[\\src\\main\\scala\\MotorDriver.scala 19:34]
  wire  rx_io_rx; // @[\\src\\main\\scala\\MotorDriver.scala 19:34]
  wire  rx_io_done; // @[\\src\\main\\scala\\MotorDriver.scala 19:34]
  wire [7:0] rx_io_data; // @[\\src\\main\\scala\\MotorDriver.scala 19:34]
  wire  tx_clock; // @[\\src\\main\\scala\\MotorDriver.scala 20:34]
  wire  tx_reset; // @[\\src\\main\\scala\\MotorDriver.scala 20:34]
  wire [7:0] tx_io_data; // @[\\src\\main\\scala\\MotorDriver.scala 20:34]
  wire  tx_io_start; // @[\\src\\main\\scala\\MotorDriver.scala 20:34]
  wire  tx_io_tx; // @[\\src\\main\\scala\\MotorDriver.scala 20:34]
  wire  tx_io_busy; // @[\\src\\main\\scala\\MotorDriver.scala 20:34]
  wire  rotation_counter_clock; // @[\\src\\main\\scala\\MotorDriver.scala 21:34]
  wire  rotation_counter_reset; // @[\\src\\main\\scala\\MotorDriver.scala 21:34]
  wire  rotation_counter_io_signal_A; // @[\\src\\main\\scala\\MotorDriver.scala 21:34]
  wire  rotation_counter_io_signal_B; // @[\\src\\main\\scala\\MotorDriver.scala 21:34]
  wire [15:0] rotation_counter_io_turns; // @[\\src\\main\\scala\\MotorDriver.scala 21:34]
  wire  pwm_gen_clock; // @[\\src\\main\\scala\\MotorDriver.scala 22:34]
  wire  pwm_gen_reset; // @[\\src\\main\\scala\\MotorDriver.scala 22:34]
  wire [9:0] pwm_gen_io_duty_cycle; // @[\\src\\main\\scala\\MotorDriver.scala 22:34]
  wire  pwm_gen_io_brake; // @[\\src\\main\\scala\\MotorDriver.scala 22:34]
  wire  pwm_gen_io_T1; // @[\\src\\main\\scala\\MotorDriver.scala 22:34]
  wire  pwm_gen_io_T2; // @[\\src\\main\\scala\\MotorDriver.scala 22:34]
  wire  pwm_gen_io_T3; // @[\\src\\main\\scala\\MotorDriver.scala 22:34]
  wire  pwm_gen_io_T4; // @[\\src\\main\\scala\\MotorDriver.scala 22:34]
  wire  pid_clock; // @[\\src\\main\\scala\\MotorDriver.scala 23:34]
  wire  pid_reset; // @[\\src\\main\\scala\\MotorDriver.scala 23:34]
  wire [15:0] pid_io_setPoint; // @[\\src\\main\\scala\\MotorDriver.scala 23:34]
  wire [15:0] pid_io_measuredVal; // @[\\src\\main\\scala\\MotorDriver.scala 23:34]
  wire  pid_io_resetBuffer; // @[\\src\\main\\scala\\MotorDriver.scala 23:34]
  wire [15:0] pid_io_controlOut; // @[\\src\\main\\scala\\MotorDriver.scala 23:34]
  wire  stuck_detector_clock; // @[\\src\\main\\scala\\MotorDriver.scala 24:34]
  wire  stuck_detector_reset; // @[\\src\\main\\scala\\MotorDriver.scala 24:34]
  wire  stuck_detector_io_externalOvercurrentInput; // @[\\src\\main\\scala\\MotorDriver.scala 24:34]
  wire  stuck_detector_io_clearShutdown; // @[\\src\\main\\scala\\MotorDriver.scala 24:34]
  wire  stuck_detector_io_motorDisable; // @[\\src\\main\\scala\\MotorDriver.scala 24:34]
  reg [7:0] target_position; // @[\\src\\main\\scala\\MotorDriver.scala 26:34]
  reg [9:0] manual_speed; // @[\\src\\main\\scala\\MotorDriver.scala 27:34]
  reg  control_mode; // @[\\src\\main\\scala\\MotorDriver.scala 28:34]
  reg  manual_brake; // @[\\src\\main\\scala\\MotorDriver.scala 29:34]
  reg [7:0] cmdByte; // @[\\src\\main\\scala\\MotorDriver.scala 32:26]
  reg  isValueByte; // @[\\src\\main\\scala\\MotorDriver.scala 33:30]
  wire  _T = ~isValueByte; // @[\\src\\main\\scala\\MotorDriver.scala 36:14]
  wire  _GEN_0 = 8'h5 == rx_io_data | manual_brake; // @[\\src\\main\\scala\\MotorDriver.scala 29:34 48:40 54:48]
  wire [9:0] _GEN_1 = 8'h4 == rx_io_data ? 10'h64 : manual_speed; // @[\\src\\main\\scala\\MotorDriver.scala 27:34 48:40 53:48]
  wire  _GEN_2 = 8'h4 == rx_io_data ? 1'h0 : _GEN_0; // @[\\src\\main\\scala\\MotorDriver.scala 48:40 53:71]
  wire [9:0] _GEN_3 = 8'h3 == rx_io_data ? 10'h15e : _GEN_1; // @[\\src\\main\\scala\\MotorDriver.scala 48:40 52:48]
  wire  _GEN_4 = 8'h3 == rx_io_data ? 1'h0 : _GEN_2; // @[\\src\\main\\scala\\MotorDriver.scala 48:40 52:71]
  wire [9:0] _GEN_5 = 8'h2 == rx_io_data ? 10'h384 : _GEN_3; // @[\\src\\main\\scala\\MotorDriver.scala 48:40 51:48]
  wire  _GEN_6 = 8'h2 == rx_io_data ? 1'h0 : _GEN_4; // @[\\src\\main\\scala\\MotorDriver.scala 48:40 51:71]
  wire [9:0] _GEN_7 = 8'h1 == rx_io_data ? 10'h28a : _GEN_5; // @[\\src\\main\\scala\\MotorDriver.scala 48:40 50:48]
  wire  _GEN_8 = 8'h1 == rx_io_data ? 1'h0 : _GEN_6; // @[\\src\\main\\scala\\MotorDriver.scala 48:40 50:71]
  wire [9:0] _GEN_9 = 8'h0 == rx_io_data ? 10'h200 : _GEN_7; // @[\\src\\main\\scala\\MotorDriver.scala 48:40 49:48]
  wire  _GEN_10 = 8'h0 == rx_io_data ? 1'h0 : _GEN_8; // @[\\src\\main\\scala\\MotorDriver.scala 48:40 49:71]
  wire  _GEN_11 = 8'h2 == cmdByte ? 1'h0 : control_mode; // @[\\src\\main\\scala\\MotorDriver.scala 40:29 28:34 47:34]
  wire [9:0] _GEN_12 = 8'h2 == cmdByte ? _GEN_9 : manual_speed; // @[\\src\\main\\scala\\MotorDriver.scala 40:29 27:34]
  wire  _GEN_13 = 8'h2 == cmdByte ? _GEN_10 : manual_brake; // @[\\src\\main\\scala\\MotorDriver.scala 40:29 29:34]
  wire  _GEN_15 = 8'h1 == cmdByte | _GEN_11; // @[\\src\\main\\scala\\MotorDriver.scala 40:29 43:34]
  reg [26:0] scaled_turns; // @[\\src\\main\\scala\\MotorDriver.scala 69:31]
  reg [6:0] current_pos_m; // @[\\src\\main\\scala\\MotorDriver.scala 70:32]
  wire [7:0] _pid_io_setPoint_T = target_position; // @[\\src\\main\\scala\\MotorDriver.scala 72:55]
  wire [6:0] _pid_io_measuredVal_T = current_pos_m; // @[\\src\\main\\scala\\MotorDriver.scala 73:53]
  wire [15:0] _pid_duty_raw_T = pid_io_controlOut; // @[\\src\\main\\scala\\MotorDriver.scala 80:43]
  wire [13:0] pid_duty_raw = _pid_duty_raw_T[15:2]; // @[\\src\\main\\scala\\MotorDriver.scala 80:50]
  reg [9:0] pwm_gen_io_duty_cycle_REG; // @[\\src\\main\\scala\\MotorDriver.scala 86:37]
  reg [23:0] txTimer; // @[\\src\\main\\scala\\MotorDriver.scala 96:26]
  wire  _T_11 = ~tx_io_busy; // @[\\src\\main\\scala\\MotorDriver.scala 101:14]
  wire [23:0] _txTimer_T_1 = txTimer + 24'h1; // @[\\src\\main\\scala\\MotorDriver.scala 106:28]
  UartRx rx ( // @[\\src\\main\\scala\\MotorDriver.scala 19:34]
    .clock(rx_clock),
    .reset(rx_reset),
    .io_rx(rx_io_rx),
    .io_done(rx_io_done),
    .io_data(rx_io_data)
  );
  UartTx tx ( // @[\\src\\main\\scala\\MotorDriver.scala 20:34]
    .clock(tx_clock),
    .reset(tx_reset),
    .io_data(tx_io_data),
    .io_start(tx_io_start),
    .io_tx(tx_io_tx),
    .io_busy(tx_io_busy)
  );
  RotationCounter rotation_counter ( // @[\\src\\main\\scala\\MotorDriver.scala 21:34]
    .clock(rotation_counter_clock),
    .reset(rotation_counter_reset),
    .io_signal_A(rotation_counter_io_signal_A),
    .io_signal_B(rotation_counter_io_signal_B),
    .io_turns(rotation_counter_io_turns)
  );
  DCMotorPwm pwm_gen ( // @[\\src\\main\\scala\\MotorDriver.scala 22:34]
    .clock(pwm_gen_clock),
    .reset(pwm_gen_reset),
    .io_duty_cycle(pwm_gen_io_duty_cycle),
    .io_brake(pwm_gen_io_brake),
    .io_T1(pwm_gen_io_T1),
    .io_T2(pwm_gen_io_T2),
    .io_T3(pwm_gen_io_T3),
    .io_T4(pwm_gen_io_T4)
  );
  PIDController pid ( // @[\\src\\main\\scala\\MotorDriver.scala 23:34]
    .clock(pid_clock),
    .reset(pid_reset),
    .io_setPoint(pid_io_setPoint),
    .io_measuredVal(pid_io_measuredVal),
    .io_resetBuffer(pid_io_resetBuffer),
    .io_controlOut(pid_io_controlOut)
  );
  StuckDetector stuck_detector ( // @[\\src\\main\\scala\\MotorDriver.scala 24:34]
    .clock(stuck_detector_clock),
    .reset(stuck_detector_reset),
    .io_externalOvercurrentInput(stuck_detector_io_externalOvercurrentInput),
    .io_clearShutdown(stuck_detector_io_clearShutdown),
    .io_motorDisable(stuck_detector_io_motorDisable)
  );
  assign io_uart_tx = tx_io_tx; // @[\\src\\main\\scala\\MotorDriver.scala 108:16]
  assign io_T1 = pwm_gen_io_T1; // @[\\src\\main\\scala\\MotorDriver.scala 90:11]
  assign io_T2 = pwm_gen_io_T2; // @[\\src\\main\\scala\\MotorDriver.scala 91:11]
  assign io_T3 = pwm_gen_io_T3; // @[\\src\\main\\scala\\MotorDriver.scala 92:11]
  assign io_T4 = pwm_gen_io_T4; // @[\\src\\main\\scala\\MotorDriver.scala 93:11]
  assign rx_clock = clock;
  assign rx_reset = reset;
  assign rx_io_rx = io_uart_rx; // @[\\src\\main\\scala\\MotorDriver.scala 31:14]
  assign tx_clock = clock;
  assign tx_reset = reset;
  assign tx_io_data = {{1'd0}, current_pos_m}; // @[\\src\\main\\scala\\MotorDriver.scala 97:17]
  assign tx_io_start = txTimer >= 24'h989680 & _T_11; // @[\\src\\main\\scala\\MotorDriver.scala 100:33 98:17]
  assign rotation_counter_clock = clock;
  assign rotation_counter_reset = reset;
  assign rotation_counter_io_signal_A = io_photo_diode_A; // @[\\src\\main\\scala\\MotorDriver.scala 65:34]
  assign rotation_counter_io_signal_B = io_photo_diode_B; // @[\\src\\main\\scala\\MotorDriver.scala 66:34]
  assign pwm_gen_clock = clock;
  assign pwm_gen_reset = reset;
  assign pwm_gen_io_duty_cycle = pwm_gen_io_duty_cycle_REG; // @[\\src\\main\\scala\\MotorDriver.scala 86:27]
  assign pwm_gen_io_brake = manual_brake | stuck_detector_io_motorDisable; // @[\\src\\main\\scala\\MotorDriver.scala 88:38]
  assign pid_clock = clock;
  assign pid_reset = reset;
  assign pid_io_setPoint = {{8{_pid_io_setPoint_T[7]}},_pid_io_setPoint_T}; // @[\\src\\main\\scala\\MotorDriver.scala 72:24]
  assign pid_io_measuredVal = {{9{_pid_io_measuredVal_T[6]}},_pid_io_measuredVal_T}; // @[\\src\\main\\scala\\MotorDriver.scala 73:24]
  assign pid_io_resetBuffer = ~control_mode | manual_brake; // @[\\src\\main\\scala\\MotorDriver.scala 74:41]
  assign stuck_detector_clock = clock;
  assign stuck_detector_reset = reset;
  assign stuck_detector_io_externalOvercurrentInput = io_over_current; // @[\\src\\main\\scala\\MotorDriver.scala 83:48]
  assign stuck_detector_io_clearShutdown = rx_io_done & cmdByte == 8'hff; // @[\\src\\main\\scala\\MotorDriver.scala 84:52]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 26:34]
      target_position <= 8'h0; // @[\\src\\main\\scala\\MotorDriver.scala 26:34]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\MotorDriver.scala 35:22]
      if (!(~isValueByte)) begin // @[\\src\\main\\scala\\MotorDriver.scala 36:28]
        if (8'h1 == cmdByte) begin // @[\\src\\main\\scala\\MotorDriver.scala 40:29]
          target_position <= rx_io_data; // @[\\src\\main\\scala\\MotorDriver.scala 42:37]
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 27:34]
      manual_speed <= 10'h200; // @[\\src\\main\\scala\\MotorDriver.scala 27:34]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\MotorDriver.scala 35:22]
      if (!(~isValueByte)) begin // @[\\src\\main\\scala\\MotorDriver.scala 36:28]
        if (!(8'h1 == cmdByte)) begin // @[\\src\\main\\scala\\MotorDriver.scala 40:29]
          manual_speed <= _GEN_12;
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 28:34]
      control_mode <= 1'h0; // @[\\src\\main\\scala\\MotorDriver.scala 28:34]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\MotorDriver.scala 35:22]
      if (!(~isValueByte)) begin // @[\\src\\main\\scala\\MotorDriver.scala 36:28]
        control_mode <= _GEN_15;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 29:34]
      manual_brake <= 1'h0; // @[\\src\\main\\scala\\MotorDriver.scala 29:34]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\MotorDriver.scala 35:22]
      if (!(~isValueByte)) begin // @[\\src\\main\\scala\\MotorDriver.scala 36:28]
        if (8'h1 == cmdByte) begin // @[\\src\\main\\scala\\MotorDriver.scala 40:29]
          manual_brake <= 1'h0; // @[\\src\\main\\scala\\MotorDriver.scala 44:34]
        end else begin
          manual_brake <= _GEN_13;
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 32:26]
      cmdByte <= 8'h0; // @[\\src\\main\\scala\\MotorDriver.scala 32:26]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\MotorDriver.scala 35:22]
      if (~isValueByte) begin // @[\\src\\main\\scala\\MotorDriver.scala 36:28]
        cmdByte <= rx_io_data; // @[\\src\\main\\scala\\MotorDriver.scala 37:21]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 33:30]
      isValueByte <= 1'h0; // @[\\src\\main\\scala\\MotorDriver.scala 33:30]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\MotorDriver.scala 35:22]
      isValueByte <= _T;
    end
    scaled_turns <= rotation_counter_io_turns * 11'h576; // @[\\src\\main\\scala\\MotorDriver.scala 69:58]
    current_pos_m <= scaled_turns[26:20]; // @[\\src\\main\\scala\\MotorDriver.scala 70:46]
    if (control_mode) begin // @[\\src\\main\\scala\\MotorDriver.scala 86:41]
      if (pid_duty_raw > 14'h3ff) begin // @[\\src\\main\\scala\\MotorDriver.scala 81:27]
        pwm_gen_io_duty_cycle_REG <= 10'h3ff;
      end else begin
        pwm_gen_io_duty_cycle_REG <= pid_duty_raw[9:0];
      end
    end else begin
      pwm_gen_io_duty_cycle_REG <= manual_speed;
    end
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 96:26]
      txTimer <= 24'h0; // @[\\src\\main\\scala\\MotorDriver.scala 96:26]
    end else if (txTimer >= 24'h989680) begin // @[\\src\\main\\scala\\MotorDriver.scala 100:33]
      if (~tx_io_busy) begin // @[\\src\\main\\scala\\MotorDriver.scala 101:27]
        txTimer <= 24'h0; // @[\\src\\main\\scala\\MotorDriver.scala 103:21]
      end
    end else begin
      txTimer <= _txTimer_T_1; // @[\\src\\main\\scala\\MotorDriver.scala 106:17]
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
  scaled_turns = _RAND_6[26:0];
  _RAND_7 = {1{`RANDOM}};
  current_pos_m = _RAND_7[6:0];
  _RAND_8 = {1{`RANDOM}};
  pwm_gen_io_duty_cycle_REG = _RAND_8[9:0];
  _RAND_9 = {1{`RANDOM}};
  txTimer = _RAND_9[23:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
