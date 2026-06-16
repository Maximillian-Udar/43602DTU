module UartRx(
  input        clock,
  input        reset,
  input        io_rx, // @[\\src\\main\\scala\\Functions.scala 115:14]
  output       io_done, // @[\\src\\main\\scala\\Functions.scala 115:14]
  output [7:0] io_data // @[\\src\\main\\scala\\Functions.scala 115:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg  rxReg_REG; // @[\\src\\main\\scala\\Functions.scala 122:33]
  reg  rxReg; // @[\\src\\main\\scala\\Functions.scala 122:25]
  reg [7:0] shiftReg; // @[\\src\\main\\scala\\Functions.scala 123:25]
  reg [31:0] cntReg; // @[\\src\\main\\scala\\Functions.scala 124:25]
  reg [3:0] bitsReg; // @[\\src\\main\\scala\\Functions.scala 125:25]
  reg [1:0] stateReg; // @[\\src\\main\\scala\\Functions.scala 127:25]
  wire [31:0] _cntReg_T_1 = cntReg + 32'h1; // @[\\src\\main\\scala\\Functions.scala 132:127]
  wire [9:0] _T_6 = 10'h364 - 10'h1; // @[\\src\\main\\scala\\Functions.scala 133:41]
  wire [31:0] _GEN_32 = {{22'd0}, _T_6}; // @[\\src\\main\\scala\\Functions.scala 133:29]
  wire  _T_7 = cntReg == _GEN_32; // @[\\src\\main\\scala\\Functions.scala 133:29]
  wire [7:0] _shiftReg_T_1 = {rxReg,shiftReg[7:1]}; // @[\\src\\main\\scala\\Functions.scala 133:80]
  wire [3:0] _bitsReg_T_1 = bitsReg + 4'h1; // @[\\src\\main\\scala\\Functions.scala 133:180]
  wire [1:0] _GEN_5 = bitsReg == 4'h7 ? 2'h3 : stateReg; // @[\\src\\main\\scala\\Functions.scala 133:{127,138} 127:25]
  wire [3:0] _GEN_6 = bitsReg == 4'h7 ? bitsReg : _bitsReg_T_1; // @[\\src\\main\\scala\\Functions.scala 133:127 125:25 133:169]
  wire [31:0] _GEN_7 = cntReg == _GEN_32 ? 32'h0 : _cntReg_T_1; // @[\\src\\main\\scala\\Functions.scala 133:{209,48,57}]
  wire [7:0] _GEN_8 = cntReg == _GEN_32 ? _shiftReg_T_1 : shiftReg; // @[\\src\\main\\scala\\Functions.scala 123:25 133:{48,74}]
  wire [1:0] _GEN_9 = cntReg == _GEN_32 ? _GEN_5 : stateReg; // @[\\src\\main\\scala\\Functions.scala 127:25 133:48]
  wire [3:0] _GEN_10 = cntReg == _GEN_32 ? _GEN_6 : bitsReg; // @[\\src\\main\\scala\\Functions.scala 125:25 133:48]
  wire [1:0] _GEN_11 = _T_7 ? 2'h0 : stateReg; // @[\\src\\main\\scala\\Functions.scala 127:25 134:{48,59}]
  wire [31:0] _GEN_13 = _T_7 ? cntReg : _cntReg_T_1; // @[\\src\\main\\scala\\Functions.scala 124:25 134:{108,48}]
  wire [1:0] _GEN_14 = 2'h3 == stateReg ? _GEN_11 : stateReg; // @[\\src\\main\\scala\\Functions.scala 130:20 127:25]
  wire [31:0] _GEN_16 = 2'h3 == stateReg ? _GEN_13 : cntReg; // @[\\src\\main\\scala\\Functions.scala 130:20 124:25]
  wire  _GEN_21 = 2'h2 == stateReg ? 1'h0 : 2'h3 == stateReg & _T_7; // @[\\src\\main\\scala\\Functions.scala 128:11 130:20]
  wire  _GEN_26 = 2'h1 == stateReg ? 1'h0 : _GEN_21; // @[\\src\\main\\scala\\Functions.scala 128:11 130:20]
  assign io_done = 2'h0 == stateReg ? 1'h0 : _GEN_26; // @[\\src\\main\\scala\\Functions.scala 128:11 130:20]
  assign io_data = shiftReg; // @[\\src\\main\\scala\\Functions.scala 129:11]
  always @(posedge clock) begin
    rxReg_REG <= io_rx; // @[\\src\\main\\scala\\Functions.scala 122:33]
    rxReg <= rxReg_REG; // @[\\src\\main\\scala\\Functions.scala 122:25]
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 123:25]
      shiftReg <= 8'h0; // @[\\src\\main\\scala\\Functions.scala 123:25]
    end else if (!(2'h0 == stateReg)) begin // @[\\src\\main\\scala\\Functions.scala 130:20]
      if (!(2'h1 == stateReg)) begin // @[\\src\\main\\scala\\Functions.scala 130:20]
        if (2'h2 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 130:20]
          shiftReg <= _GEN_8;
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 124:25]
      cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 124:25]
    end else if (2'h0 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 130:20]
      if (~rxReg) begin // @[\\src\\main\\scala\\Functions.scala 131:30]
        cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 131:59]
      end
    end else if (2'h1 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 130:20]
      if (cntReg == 32'h1b2) begin // @[\\src\\main\\scala\\Functions.scala 132:45]
        cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 132:73]
      end else begin
        cntReg <= _cntReg_T_1; // @[\\src\\main\\scala\\Functions.scala 132:117]
      end
    end else if (2'h2 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 130:20]
      cntReg <= _GEN_7;
    end else begin
      cntReg <= _GEN_16;
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 125:25]
      bitsReg <= 4'h0; // @[\\src\\main\\scala\\Functions.scala 125:25]
    end else if (!(2'h0 == stateReg)) begin // @[\\src\\main\\scala\\Functions.scala 130:20]
      if (2'h1 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 130:20]
        if (cntReg == 32'h1b2) begin // @[\\src\\main\\scala\\Functions.scala 132:45]
          bitsReg <= 4'h0; // @[\\src\\main\\scala\\Functions.scala 132:89]
        end
      end else if (2'h2 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 130:20]
        bitsReg <= _GEN_10;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 127:25]
      stateReg <= 2'h0; // @[\\src\\main\\scala\\Functions.scala 127:25]
    end else if (2'h0 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 130:20]
      if (~rxReg) begin // @[\\src\\main\\scala\\Functions.scala 131:30]
        stateReg <= 2'h1; // @[\\src\\main\\scala\\Functions.scala 131:41]
      end
    end else if (2'h1 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 130:20]
      if (cntReg == 32'h1b2) begin // @[\\src\\main\\scala\\Functions.scala 132:45]
        stateReg <= 2'h2; // @[\\src\\main\\scala\\Functions.scala 132:56]
      end
    end else if (2'h2 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 130:20]
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
  input  [7:0] io_data, // @[\\src\\main\\scala\\Functions.scala 139:14]
  input        io_start, // @[\\src\\main\\scala\\Functions.scala 139:14]
  output       io_tx, // @[\\src\\main\\scala\\Functions.scala 139:14]
  output       io_busy // @[\\src\\main\\scala\\Functions.scala 139:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [9:0] reg_; // @[\\src\\main\\scala\\Functions.scala 146:20]
  reg [31:0] cnt; // @[\\src\\main\\scala\\Functions.scala 147:20]
  reg [3:0] bits; // @[\\src\\main\\scala\\Functions.scala 148:21]
  reg  state; // @[\\src\\main\\scala\\Functions.scala 150:22]
  wire [9:0] _reg_T = {1'h1,io_data,1'h0}; // @[\\src\\main\\scala\\Functions.scala 154:44]
  wire  _GEN_3 = io_start | state; // @[\\src\\main\\scala\\Functions.scala 150:22 154:{32,96}]
  wire [9:0] _T_3 = 10'h364 - 10'h1; // @[\\src\\main\\scala\\Functions.scala 155:38]
  wire [31:0] _GEN_18 = {{22'd0}, _T_3}; // @[\\src\\main\\scala\\Functions.scala 155:26]
  wire [9:0] _reg_T_2 = {1'h1,reg_[9:1]}; // @[\\src\\main\\scala\\Functions.scala 155:69]
  wire [3:0] _bits_T_1 = bits + 4'h1; // @[\\src\\main\\scala\\Functions.scala 155:150]
  wire  _GEN_4 = bits == 4'h9 ? 1'h0 : state; // @[\\src\\main\\scala\\Functions.scala 155:{106,114} 150:22]
  wire [3:0] _GEN_5 = bits == 4'h9 ? bits : _bits_T_1; // @[\\src\\main\\scala\\Functions.scala 155:106 148:21 155:142]
  wire [31:0] _cnt_T_1 = cnt + 32'h1; // @[\\src\\main\\scala\\Functions.scala 155:183]
  assign io_tx = reg_[0]; // @[\\src\\main\\scala\\Functions.scala 151:15]
  assign io_busy = state; // @[\\src\\main\\scala\\Functions.scala 152:20]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 146:20]
      reg_ <= 10'h1; // @[\\src\\main\\scala\\Functions.scala 146:20]
    end else if (~state) begin // @[\\src\\main\\scala\\Functions.scala 153:17]
      if (io_start) begin // @[\\src\\main\\scala\\Functions.scala 154:32]
        reg_ <= _reg_T; // @[\\src\\main\\scala\\Functions.scala 154:38]
      end
    end else if (state) begin // @[\\src\\main\\scala\\Functions.scala 153:17]
      if (cnt == _GEN_18) begin // @[\\src\\main\\scala\\Functions.scala 155:45]
        reg_ <= _reg_T_2; // @[\\src\\main\\scala\\Functions.scala 155:63]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 147:20]
      cnt <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 147:20]
    end else if (~state) begin // @[\\src\\main\\scala\\Functions.scala 153:17]
      if (io_start) begin // @[\\src\\main\\scala\\Functions.scala 154:32]
        cnt <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 154:82]
      end
    end else if (state) begin // @[\\src\\main\\scala\\Functions.scala 153:17]
      if (cnt == _GEN_18) begin // @[\\src\\main\\scala\\Functions.scala 155:45]
        cnt <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 155:51]
      end else begin
        cnt <= _cnt_T_1; // @[\\src\\main\\scala\\Functions.scala 155:176]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 148:21]
      bits <= 4'h0; // @[\\src\\main\\scala\\Functions.scala 148:21]
    end else if (~state) begin // @[\\src\\main\\scala\\Functions.scala 153:17]
      if (io_start) begin // @[\\src\\main\\scala\\Functions.scala 154:32]
        bits <= 4'h0; // @[\\src\\main\\scala\\Functions.scala 154:70]
      end
    end else if (state) begin // @[\\src\\main\\scala\\Functions.scala 153:17]
      if (cnt == _GEN_18) begin // @[\\src\\main\\scala\\Functions.scala 155:45]
        bits <= _GEN_5;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 150:22]
      state <= 1'h0; // @[\\src\\main\\scala\\Functions.scala 150:22]
    end else if (~state) begin // @[\\src\\main\\scala\\Functions.scala 153:17]
      state <= _GEN_3;
    end else if (state) begin // @[\\src\\main\\scala\\Functions.scala 153:17]
      if (cnt == _GEN_18) begin // @[\\src\\main\\scala\\Functions.scala 155:45]
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
  reg  aReg; // @[\\src\\main\\scala\\Functions.scala 18:23]
  wire  rise_A = aSync & ~aReg; // @[\\src\\main\\scala\\Functions.scala 19:22]
  reg [31:0] turns; // @[\\src\\main\\scala\\Functions.scala 20:23]
  wire [31:0] _turns_T_1 = turns + 32'h1; // @[\\src\\main\\scala\\Functions.scala 24:22]
  wire [31:0] _turns_T_4 = turns - 32'h1; // @[\\src\\main\\scala\\Functions.scala 26:46]
  assign io_turns = turns; // @[\\src\\main\\scala\\Functions.scala 29:12]
  always @(posedge clock) begin
    aSync_REG <= io_signal_A; // @[\\src\\main\\scala\\Functions.scala 16:31]
    aSync <= aSync_REG; // @[\\src\\main\\scala\\Functions.scala 16:23]
    bSync_REG <= io_signal_B; // @[\\src\\main\\scala\\Functions.scala 17:31]
    bSync <= bSync_REG; // @[\\src\\main\\scala\\Functions.scala 17:23]
    aReg <= aSync; // @[\\src\\main\\scala\\Functions.scala 18:23]
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 20:23]
      turns <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 20:23]
    end else if (rise_A) begin // @[\\src\\main\\scala\\Functions.scala 22:16]
      if (~bSync) begin // @[\\src\\main\\scala\\Functions.scala 23:18]
        turns <= _turns_T_1; // @[\\src\\main\\scala\\Functions.scala 24:13]
      end else if (turns == 32'h0) begin // @[\\src\\main\\scala\\Functions.scala 26:19]
        turns <= 32'h0;
      end else begin
        turns <= _turns_T_4;
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
  input  [9:0] io_duty_cycle, // @[\\src\\main\\scala\\Functions.scala 33:14]
  input        io_brake, // @[\\src\\main\\scala\\Functions.scala 33:14]
  output       io_T1, // @[\\src\\main\\scala\\Functions.scala 33:14]
  output       io_T2, // @[\\src\\main\\scala\\Functions.scala 33:14]
  output       io_T3, // @[\\src\\main\\scala\\Functions.scala 33:14]
  output       io_T4 // @[\\src\\main\\scala\\Functions.scala 33:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] pwmCounter; // @[\\src\\main\\scala\\Functions.scala 44:29]
  wire [11:0] _T_1 = 12'hd05 - 12'h1; // @[\\src\\main\\scala\\Functions.scala 46:35]
  wire [31:0] _GEN_5 = {{20'd0}, _T_1}; // @[\\src\\main\\scala\\Functions.scala 46:19]
  wire [31:0] _pwmCounter_T_1 = pwmCounter + 32'h1; // @[\\src\\main\\scala\\Functions.scala 49:30]
  wire [21:0] _threshold_T = io_duty_cycle * 12'hd05; // @[\\src\\main\\scala\\Functions.scala 52:34]
  wire [11:0] threshold = _threshold_T[21:10]; // @[\\src\\main\\scala\\Functions.scala 52:50]
  wire [31:0] _GEN_6 = {{20'd0}, threshold}; // @[\\src\\main\\scala\\Functions.scala 53:30]
  wire  pwmSignal = pwmCounter < _GEN_6; // @[\\src\\main\\scala\\Functions.scala 53:30]
  wire  _conduct_T4_T = ~pwmSignal; // @[\\src\\main\\scala\\Functions.scala 68:19]
  wire  conduct_T2 = io_brake ? 1'h0 : pwmSignal; // @[\\src\\main\\scala\\Functions.scala 60:18 62:16 66:16]
  wire  conduct_T4 = io_brake ? 1'h0 : ~pwmSignal; // @[\\src\\main\\scala\\Functions.scala 60:18 64:16 68:16]
  assign io_T1 = io_brake | _conduct_T4_T; // @[\\src\\main\\scala\\Functions.scala 60:18 61:16 69:16]
  assign io_T2 = ~conduct_T2; // @[\\src\\main\\scala\\Functions.scala 74:12]
  assign io_T3 = io_brake | pwmSignal; // @[\\src\\main\\scala\\Functions.scala 60:18 63:16 67:16]
  assign io_T4 = ~conduct_T4; // @[\\src\\main\\scala\\Functions.scala 75:12]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 44:29]
      pwmCounter <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 44:29]
    end else if (pwmCounter >= _GEN_5) begin // @[\\src\\main\\scala\\Functions.scala 46:42]
      pwmCounter <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 47:16]
    end else begin
      pwmCounter <= _pwmCounter_T_1; // @[\\src\\main\\scala\\Functions.scala 49:16]
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
  input  [31:0] io_setPoint, // @[\\src\\main\\scala\\Functions.scala 79:14]
  input  [31:0] io_measuredVal, // @[\\src\\main\\scala\\Functions.scala 79:14]
  input         io_resetBuffer, // @[\\src\\main\\scala\\Functions.scala 79:14]
  output [31:0] io_controlOut // @[\\src\\main\\scala\\Functions.scala 79:14]
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
  reg [31:0] errorReg; // @[\\src\\main\\scala\\Functions.scala 89:25]
  reg [63:0] pTerm; // @[\\src\\main\\scala\\Functions.scala 90:22]
  reg [31:0] integralReg; // @[\\src\\main\\scala\\Functions.scala 91:28]
  reg [63:0] iTermNext; // @[\\src\\main\\scala\\Functions.scala 92:26]
  wire [43:0] _GEN_1 = {$signed(integralReg), 12'h0}; // @[\\src\\main\\scala\\Functions.scala 100:39]
  wire [63:0] _GEN_2 = {{20{_GEN_1[43]}},_GEN_1}; // @[\\src\\main\\scala\\Functions.scala 100:39]
  reg [63:0] nextSum; // @[\\src\\main\\scala\\Functions.scala 100:26]
  wire [63:0] _integralReg_T_2 = $signed(nextSum) < -64'sh800000 ? $signed(-64'sh800000) : $signed(nextSum); // @[\\src\\main\\scala\\Functions.scala 102:23]
  wire [63:0] _integralReg_T_3 = $signed(nextSum) > 64'sh800000 ? $signed(64'sh800000) : $signed(_integralReg_T_2); // @[\\src\\main\\scala\\Functions.scala 101:23]
  wire [63:0] _GEN_0 = io_resetBuffer ? $signed(64'sh0) : $signed(_integralReg_T_3); // @[\\src\\main\\scala\\Functions.scala 101:17 97:24 98:17]
  reg [31:0] prevErrorReg; // @[\\src\\main\\scala\\Functions.scala 105:29]
  wire [31:0] _dTerm_T_2 = $signed(errorReg) - $signed(prevErrorReg); // @[\\src\\main\\scala\\Functions.scala 106:41]
  reg [63:0] dTerm; // @[\\src\\main\\scala\\Functions.scala 106:22]
  wire [63:0] _rawOutput_T_2 = $signed(pTerm) + $signed(_GEN_2); // @[\\src\\main\\scala\\Functions.scala 109:33]
  reg [63:0] rawOutput; // @[\\src\\main\\scala\\Functions.scala 109:26]
  wire [63:0] _io_controlOut_T_2 = $signed(rawOutput) < -64'sh800000 ? $signed(-64'sh800000) : $signed(rawOutput); // @[\\src\\main\\scala\\Functions.scala 111:23]
  wire [63:0] _io_controlOut_T_3 = $signed(rawOutput) > 64'sh800000 ? $signed(64'sh800000) : $signed(_io_controlOut_T_2)
    ; // @[\\src\\main\\scala\\Functions.scala 110:23]
  wire [51:0] _GEN_5 = _io_controlOut_T_3[63:12]; // @[\\src\\main\\scala\\Functions.scala 110:17]
  wire [51:0] _GEN_7 = reset ? $signed(52'sh0) : $signed(_GEN_0[63:12]); // @[\\src\\main\\scala\\Functions.scala 91:{28,28}]
  assign io_controlOut = _GEN_5[31:0]; // @[\\src\\main\\scala\\Functions.scala 110:17]
  always @(posedge clock) begin
    errorReg <= $signed(io_setPoint) - $signed(io_measuredVal); // @[\\src\\main\\scala\\Functions.scala 89:38]
    pTerm <= 32'sh50000 * $signed(errorReg); // @[\\src\\main\\scala\\Functions.scala 90:29]
    integralReg <= _GEN_7[31:0]; // @[\\src\\main\\scala\\Functions.scala 91:{28,28}]
    iTermNext <= 32'sh0 * $signed(errorReg); // @[\\src\\main\\scala\\Functions.scala 92:33]
    nextSum <= $signed(_GEN_2) + $signed(iTermNext); // @[\\src\\main\\scala\\Functions.scala 100:39]
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 105:29]
      prevErrorReg <= 32'sh0; // @[\\src\\main\\scala\\Functions.scala 105:29]
    end else begin
      prevErrorReg <= errorReg; // @[\\src\\main\\scala\\Functions.scala 107:16]
    end
    dTerm <= 32'sh1000 * $signed(_dTerm_T_2); // @[\\src\\main\\scala\\Functions.scala 106:29]
    rawOutput <= $signed(_rawOutput_T_2) + $signed(dTerm); // @[\\src\\main\\scala\\Functions.scala 109:47]
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
  input   io_externalOvercurrentInput, // @[\\src\\main\\scala\\Functions.scala 160:14]
  input   io_clearShutdown, // @[\\src\\main\\scala\\Functions.scala 160:14]
  output  io_motorDisable // @[\\src\\main\\scala\\Functions.scala 160:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [24:0] maxCycles = 17'h186a0 * 8'h96; // @[\\src\\main\\scala\\Functions.scala 167:44]
  reg [31:0] durationReg; // @[\\src\\main\\scala\\Functions.scala 168:28]
  reg  isStuckReg; // @[\\src\\main\\scala\\Functions.scala 169:28]
  wire [31:0] _GEN_8 = {{7'd0}, maxCycles}; // @[\\src\\main\\scala\\Functions.scala 173:26]
  wire [31:0] _durationReg_T_1 = durationReg + 32'h1; // @[\\src\\main\\scala\\Functions.scala 173:104]
  wire  _GEN_0 = durationReg >= _GEN_8 | isStuckReg; // @[\\src\\main\\scala\\Functions.scala 169:28 173:{40,53}]
  wire [31:0] _GEN_1 = durationReg >= _GEN_8 ? durationReg : _durationReg_T_1; // @[\\src\\main\\scala\\Functions.scala 168:28 173:{40,89}]
  assign io_motorDisable = isStuckReg; // @[\\src\\main\\scala\\Functions.scala 178:19]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 168:28]
      durationReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 168:28]
    end else if (io_clearShutdown) begin // @[\\src\\main\\scala\\Functions.scala 170:26]
      durationReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 170:63]
    end else if (~isStuckReg) begin // @[\\src\\main\\scala\\Functions.scala 171:23]
      if (io_externalOvercurrentInput) begin // @[\\src\\main\\scala\\Functions.scala 172:41]
        durationReg <= _GEN_1;
      end else begin
        durationReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 174:33]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 169:28]
      isStuckReg <= 1'h0; // @[\\src\\main\\scala\\Functions.scala 169:28]
    end else if (io_clearShutdown) begin // @[\\src\\main\\scala\\Functions.scala 170:26]
      isStuckReg <= 1'h0; // @[\\src\\main\\scala\\Functions.scala 170:39]
    end else if (~isStuckReg) begin // @[\\src\\main\\scala\\Functions.scala 171:23]
      if (io_externalOvercurrentInput) begin // @[\\src\\main\\scala\\Functions.scala 172:41]
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
  input  [4:0] io_in, // @[\\src\\main\\scala\\Functions.scala 230:14]
  output [6:0] io_out // @[\\src\\main\\scala\\Functions.scala 230:14]
);
  wire [6:0] _io_out_T_32 = 5'h0 == io_in ? 7'h3f : 7'h0; // @[\\src\\main\\scala\\Functions.scala 235:46]
  wire [6:0] _io_out_T_34 = 5'h1 == io_in ? 7'h6 : _io_out_T_32; // @[\\src\\main\\scala\\Functions.scala 235:46]
  wire [6:0] _io_out_T_36 = 5'h2 == io_in ? 7'h5b : _io_out_T_34; // @[\\src\\main\\scala\\Functions.scala 235:46]
  wire [6:0] _io_out_T_38 = 5'h3 == io_in ? 7'h4f : _io_out_T_36; // @[\\src\\main\\scala\\Functions.scala 235:46]
  wire [6:0] _io_out_T_40 = 5'h4 == io_in ? 7'h66 : _io_out_T_38; // @[\\src\\main\\scala\\Functions.scala 235:46]
  wire [6:0] _io_out_T_42 = 5'h5 == io_in ? 7'h6d : _io_out_T_40; // @[\\src\\main\\scala\\Functions.scala 235:46]
  wire [6:0] _io_out_T_44 = 5'h6 == io_in ? 7'h7d : _io_out_T_42; // @[\\src\\main\\scala\\Functions.scala 235:46]
  wire [6:0] _io_out_T_46 = 5'h7 == io_in ? 7'h7 : _io_out_T_44; // @[\\src\\main\\scala\\Functions.scala 235:46]
  wire [6:0] _io_out_T_48 = 5'h8 == io_in ? 7'h7f : _io_out_T_46; // @[\\src\\main\\scala\\Functions.scala 235:46]
  wire [6:0] _io_out_T_50 = 5'h9 == io_in ? 7'h6f : _io_out_T_48; // @[\\src\\main\\scala\\Functions.scala 235:46]
  wire [6:0] _io_out_T_52 = 5'ha == io_in ? 7'h77 : _io_out_T_50; // @[\\src\\main\\scala\\Functions.scala 235:46]
  wire [6:0] _io_out_T_54 = 5'hb == io_in ? 7'h7c : _io_out_T_52; // @[\\src\\main\\scala\\Functions.scala 235:46]
  wire [6:0] _io_out_T_56 = 5'hc == io_in ? 7'h39 : _io_out_T_54; // @[\\src\\main\\scala\\Functions.scala 235:46]
  wire [6:0] _io_out_T_58 = 5'hd == io_in ? 7'h5e : _io_out_T_56; // @[\\src\\main\\scala\\Functions.scala 235:46]
  wire [6:0] _io_out_T_60 = 5'he == io_in ? 7'h79 : _io_out_T_58; // @[\\src\\main\\scala\\Functions.scala 235:46]
  wire [6:0] _io_out_T_62 = 5'hf == io_in ? 7'h71 : _io_out_T_60; // @[\\src\\main\\scala\\Functions.scala 235:46]
  wire [6:0] _io_out_T_64 = 5'h10 == io_in ? 7'h3c : _io_out_T_62; // @[\\src\\main\\scala\\Functions.scala 235:46]
  wire [6:0] _io_out_T_66 = 5'h11 == io_in ? 7'h76 : _io_out_T_64; // @[\\src\\main\\scala\\Functions.scala 235:46]
  wire [6:0] _io_out_T_68 = 5'h12 == io_in ? 7'h6 : _io_out_T_66; // @[\\src\\main\\scala\\Functions.scala 235:46]
  wire [6:0] _io_out_T_70 = 5'h13 == io_in ? 7'hf : _io_out_T_68; // @[\\src\\main\\scala\\Functions.scala 235:46]
  wire [6:0] _io_out_T_72 = 5'h14 == io_in ? 7'h38 : _io_out_T_70; // @[\\src\\main\\scala\\Functions.scala 235:46]
  wire [6:0] _io_out_T_74 = 5'h15 == io_in ? 7'h70 : _io_out_T_72; // @[\\src\\main\\scala\\Functions.scala 235:46]
  wire [6:0] _io_out_T_76 = 5'h16 == io_in ? 7'h3f : _io_out_T_74; // @[\\src\\main\\scala\\Functions.scala 235:46]
  wire [6:0] _io_out_T_78 = 5'h17 == io_in ? 7'h73 : _io_out_T_76; // @[\\src\\main\\scala\\Functions.scala 235:46]
  wire [6:0] _io_out_T_80 = 5'h18 == io_in ? 7'h67 : _io_out_T_78; // @[\\src\\main\\scala\\Functions.scala 235:46]
  wire [6:0] _io_out_T_82 = 5'h19 == io_in ? 7'h31 : _io_out_T_80; // @[\\src\\main\\scala\\Functions.scala 235:46]
  wire [6:0] _io_out_T_84 = 5'h1a == io_in ? 7'h6d : _io_out_T_82; // @[\\src\\main\\scala\\Functions.scala 235:46]
  wire [6:0] _io_out_T_86 = 5'h1b == io_in ? 7'h78 : _io_out_T_84; // @[\\src\\main\\scala\\Functions.scala 235:46]
  wire [6:0] _io_out_T_88 = 5'h1c == io_in ? 7'h3f : _io_out_T_86; // @[\\src\\main\\scala\\Functions.scala 235:46]
  assign io_out = 5'h1d == io_in ? 7'h0 : _io_out_T_88; // @[\\src\\main\\scala\\Functions.scala 235:46]
endmodule
module DisplayMultiplexer(
  input         clock,
  input         reset,
  input  [19:0] io_disp_content, // @[\\src\\main\\scala\\Functions.scala 182:14]
  output [7:0]  io_seg, // @[\\src\\main\\scala\\Functions.scala 182:14]
  output [3:0]  io_an // @[\\src\\main\\scala\\Functions.scala 182:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [4:0] decoder_io_in; // @[\\src\\main\\scala\\Functions.scala 205:23]
  wire [6:0] decoder_io_out; // @[\\src\\main\\scala\\Functions.scala 205:23]
  reg [16:0] cnt; // @[\\src\\main\\scala\\Functions.scala 189:20]
  wire  _cnt_T = cnt == 17'h1869f; // @[\\src\\main\\scala\\Functions.scala 190:18]
  wire [16:0] _cnt_T_2 = cnt + 17'h1; // @[\\src\\main\\scala\\Functions.scala 190:54]
  reg [1:0] digit; // @[\\src\\main\\scala\\Functions.scala 193:22]
  wire [1:0] _digit_T_1 = digit + 2'h1; // @[\\src\\main\\scala\\Functions.scala 194:31]
  wire  _T = 2'h0 == digit; // @[\\src\\main\\scala\\Functions.scala 198:17]
  wire  _T_1 = 2'h1 == digit; // @[\\src\\main\\scala\\Functions.scala 198:17]
  wire  _T_2 = 2'h2 == digit; // @[\\src\\main\\scala\\Functions.scala 198:17]
  wire  _T_3 = 2'h3 == digit; // @[\\src\\main\\scala\\Functions.scala 198:17]
  wire [4:0] _GEN_1 = 2'h3 == digit ? io_disp_content[19:15] : 5'h0; // @[\\src\\main\\scala\\Functions.scala 197:14 198:17 202:26]
  wire [4:0] _GEN_2 = 2'h2 == digit ? io_disp_content[14:10] : _GEN_1; // @[\\src\\main\\scala\\Functions.scala 198:17 201:26]
  wire [4:0] _GEN_3 = 2'h1 == digit ? io_disp_content[9:5] : _GEN_2; // @[\\src\\main\\scala\\Functions.scala 198:17 200:26]
  wire [3:0] _currentDot_T = 4'h0 >> digit; // @[\\src\\main\\scala\\Functions.scala 209:27]
  wire  currentDot = _currentDot_T[0]; // @[\\src\\main\\scala\\Functions.scala 209:27]
  wire [7:0] fullSeg = {currentDot,decoder_io_out}; // @[\\src\\main\\scala\\Functions.scala 210:28]
  wire [3:0] _GEN_5 = _T_3 ? 4'h8 : 4'h1; // @[\\src\\main\\scala\\Functions.scala 213:17 217:22 212:27]
  wire [3:0] _GEN_6 = _T_2 ? 4'h4 : _GEN_5; // @[\\src\\main\\scala\\Functions.scala 213:17 216:22]
  wire [3:0] _GEN_7 = _T_1 ? 4'h2 : _GEN_6; // @[\\src\\main\\scala\\Functions.scala 213:17 215:22]
  wire [3:0] select = _T ? 4'h1 : _GEN_7; // @[\\src\\main\\scala\\Functions.scala 213:17 214:22]
  SevenSegDec decoder ( // @[\\src\\main\\scala\\Functions.scala 205:23]
    .io_in(decoder_io_in),
    .io_out(decoder_io_out)
  );
  assign io_seg = ~fullSeg; // @[\\src\\main\\scala\\Functions.scala 220:13]
  assign io_an = ~select; // @[\\src\\main\\scala\\Functions.scala 221:13]
  assign decoder_io_in = 2'h0 == digit ? io_disp_content[4:0] : _GEN_3; // @[\\src\\main\\scala\\Functions.scala 198:17 199:26]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 189:20]
      cnt <= 17'h0; // @[\\src\\main\\scala\\Functions.scala 189:20]
    end else if (cnt == 17'h1869f) begin // @[\\src\\main\\scala\\Functions.scala 190:13]
      cnt <= 17'h0;
    end else begin
      cnt <= _cnt_T_2;
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 193:22]
      digit <= 2'h0; // @[\\src\\main\\scala\\Functions.scala 193:22]
    end else if (_cnt_T) begin // @[\\src\\main\\scala\\Functions.scala 194:14]
      digit <= _digit_T_1; // @[\\src\\main\\scala\\Functions.scala 194:22]
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
  input   io_btn_in, // @[\\src\\main\\scala\\Functions.scala 270:14]
  output  io_out // @[\\src\\main\\scala\\Functions.scala 270:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg  btn_sync_REG; // @[\\src\\main\\scala\\Functions.scala 275:33]
  reg  btn_sync; // @[\\src\\main\\scala\\Functions.scala 275:25]
  reg  btnDebReg; // @[\\src\\main\\scala\\Functions.scala 276:26]
  reg [31:0] cntReg; // @[\\src\\main\\scala\\Functions.scala 277:23]
  wire  tick = cntReg == 32'h1869f; // @[\\src\\main\\scala\\Functions.scala 278:21]
  wire [31:0] _cntReg_T_1 = cntReg + 32'h1; // @[\\src\\main\\scala\\Functions.scala 280:20]
  reg  btnCleanPrev; // @[\\src\\main\\scala\\Functions.scala 286:29]
  assign io_out = btnDebReg & ~btnCleanPrev; // @[\\src\\main\\scala\\Functions.scala 287:23]
  always @(posedge clock) begin
    btn_sync_REG <= io_btn_in; // @[\\src\\main\\scala\\Functions.scala 275:33]
    btn_sync <= btn_sync_REG; // @[\\src\\main\\scala\\Functions.scala 275:25]
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 276:26]
      btnDebReg <= 1'h0; // @[\\src\\main\\scala\\Functions.scala 276:26]
    end else if (tick) begin // @[\\src\\main\\scala\\Functions.scala 281:15]
      btnDebReg <= btn_sync; // @[\\src\\main\\scala\\Functions.scala 283:15]
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 277:23]
      cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 277:23]
    end else if (tick) begin // @[\\src\\main\\scala\\Functions.scala 281:15]
      cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 282:12]
    end else begin
      cntReg <= _cntReg_T_1; // @[\\src\\main\\scala\\Functions.scala 280:10]
    end
    btnCleanPrev <= btnDebReg; // @[\\src\\main\\scala\\Functions.scala 286:29]
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
  wire  rx_clock; // @[\\src\\main\\scala\\MotorDriver.scala 27:38]
  wire  rx_reset; // @[\\src\\main\\scala\\MotorDriver.scala 27:38]
  wire  rx_io_rx; // @[\\src\\main\\scala\\MotorDriver.scala 27:38]
  wire  rx_io_done; // @[\\src\\main\\scala\\MotorDriver.scala 27:38]
  wire [7:0] rx_io_data; // @[\\src\\main\\scala\\MotorDriver.scala 27:38]
  wire  tx_clock; // @[\\src\\main\\scala\\MotorDriver.scala 28:38]
  wire  tx_reset; // @[\\src\\main\\scala\\MotorDriver.scala 28:38]
  wire [7:0] tx_io_data; // @[\\src\\main\\scala\\MotorDriver.scala 28:38]
  wire  tx_io_start; // @[\\src\\main\\scala\\MotorDriver.scala 28:38]
  wire  tx_io_tx; // @[\\src\\main\\scala\\MotorDriver.scala 28:38]
  wire  tx_io_busy; // @[\\src\\main\\scala\\MotorDriver.scala 28:38]
  wire  rotation_counter_clock; // @[\\src\\main\\scala\\MotorDriver.scala 29:38]
  wire  rotation_counter_reset; // @[\\src\\main\\scala\\MotorDriver.scala 29:38]
  wire  rotation_counter_io_signal_A; // @[\\src\\main\\scala\\MotorDriver.scala 29:38]
  wire  rotation_counter_io_signal_B; // @[\\src\\main\\scala\\MotorDriver.scala 29:38]
  wire [31:0] rotation_counter_io_turns; // @[\\src\\main\\scala\\MotorDriver.scala 29:38]
  wire  pwm_gen_clock; // @[\\src\\main\\scala\\MotorDriver.scala 30:38]
  wire  pwm_gen_reset; // @[\\src\\main\\scala\\MotorDriver.scala 30:38]
  wire [9:0] pwm_gen_io_duty_cycle; // @[\\src\\main\\scala\\MotorDriver.scala 30:38]
  wire  pwm_gen_io_brake; // @[\\src\\main\\scala\\MotorDriver.scala 30:38]
  wire  pwm_gen_io_T1; // @[\\src\\main\\scala\\MotorDriver.scala 30:38]
  wire  pwm_gen_io_T2; // @[\\src\\main\\scala\\MotorDriver.scala 30:38]
  wire  pwm_gen_io_T3; // @[\\src\\main\\scala\\MotorDriver.scala 30:38]
  wire  pwm_gen_io_T4; // @[\\src\\main\\scala\\MotorDriver.scala 30:38]
  wire  pid_clock; // @[\\src\\main\\scala\\MotorDriver.scala 31:38]
  wire  pid_reset; // @[\\src\\main\\scala\\MotorDriver.scala 31:38]
  wire [31:0] pid_io_setPoint; // @[\\src\\main\\scala\\MotorDriver.scala 31:38]
  wire [31:0] pid_io_measuredVal; // @[\\src\\main\\scala\\MotorDriver.scala 31:38]
  wire  pid_io_resetBuffer; // @[\\src\\main\\scala\\MotorDriver.scala 31:38]
  wire [31:0] pid_io_controlOut; // @[\\src\\main\\scala\\MotorDriver.scala 31:38]
  wire  stuck_detector_clock; // @[\\src\\main\\scala\\MotorDriver.scala 32:38]
  wire  stuck_detector_reset; // @[\\src\\main\\scala\\MotorDriver.scala 32:38]
  wire  stuck_detector_io_externalOvercurrentInput; // @[\\src\\main\\scala\\MotorDriver.scala 32:38]
  wire  stuck_detector_io_clearShutdown; // @[\\src\\main\\scala\\MotorDriver.scala 32:38]
  wire  stuck_detector_io_motorDisable; // @[\\src\\main\\scala\\MotorDriver.scala 32:38]
  wire  disp_mux_clock; // @[\\src\\main\\scala\\MotorDriver.scala 33:38]
  wire  disp_mux_reset; // @[\\src\\main\\scala\\MotorDriver.scala 33:38]
  wire [19:0] disp_mux_io_disp_content; // @[\\src\\main\\scala\\MotorDriver.scala 33:38]
  wire [7:0] disp_mux_io_seg; // @[\\src\\main\\scala\\MotorDriver.scala 33:38]
  wire [3:0] disp_mux_io_an; // @[\\src\\main\\scala\\MotorDriver.scala 33:38]
  wire  error_clear_debounce_clock; // @[\\src\\main\\scala\\MotorDriver.scala 34:38]
  wire  error_clear_debounce_reset; // @[\\src\\main\\scala\\MotorDriver.scala 34:38]
  wire  error_clear_debounce_io_btn_in; // @[\\src\\main\\scala\\MotorDriver.scala 34:38]
  wire  error_clear_debounce_io_out; // @[\\src\\main\\scala\\MotorDriver.scala 34:38]
  reg [7:0] target_position; // @[\\src\\main\\scala\\MotorDriver.scala 45:34]
  reg [9:0] manual_speed; // @[\\src\\main\\scala\\MotorDriver.scala 46:34]
  reg  control_mode; // @[\\src\\main\\scala\\MotorDriver.scala 47:34]
  reg  manual_brake; // @[\\src\\main\\scala\\MotorDriver.scala 48:34]
  reg [7:0] cmdByte; // @[\\src\\main\\scala\\MotorDriver.scala 51:26]
  reg  isValueByte; // @[\\src\\main\\scala\\MotorDriver.scala 52:30]
  wire  _T = ~isValueByte; // @[\\src\\main\\scala\\MotorDriver.scala 55:14]
  wire  _GEN_0 = 8'h5 == rx_io_data | manual_brake; // @[\\src\\main\\scala\\MotorDriver.scala 48:34 67:40 73:48]
  wire [9:0] _GEN_1 = 8'h4 == rx_io_data ? 10'h7c : manual_speed; // @[\\src\\main\\scala\\MotorDriver.scala 46:34 67:40 72:48]
  wire  _GEN_2 = 8'h4 == rx_io_data ? 1'h0 : _GEN_0; // @[\\src\\main\\scala\\MotorDriver.scala 67:40 72:71]
  wire [9:0] _GEN_3 = 8'h3 == rx_io_data ? 10'h176 : _GEN_1; // @[\\src\\main\\scala\\MotorDriver.scala 67:40 71:48]
  wire  _GEN_4 = 8'h3 == rx_io_data ? 1'h0 : _GEN_2; // @[\\src\\main\\scala\\MotorDriver.scala 67:40 71:71]
  wire [9:0] _GEN_5 = 8'h2 == rx_io_data ? 10'h384 : _GEN_3; // @[\\src\\main\\scala\\MotorDriver.scala 67:40 70:48]
  wire  _GEN_6 = 8'h2 == rx_io_data ? 1'h0 : _GEN_4; // @[\\src\\main\\scala\\MotorDriver.scala 67:40 70:71]
  wire [9:0] _GEN_7 = 8'h1 == rx_io_data ? 10'h28a : _GEN_5; // @[\\src\\main\\scala\\MotorDriver.scala 67:40 69:48]
  wire  _GEN_8 = 8'h1 == rx_io_data ? 1'h0 : _GEN_6; // @[\\src\\main\\scala\\MotorDriver.scala 67:40 69:71]
  wire [9:0] _GEN_9 = 8'h0 == rx_io_data ? 10'h200 : _GEN_7; // @[\\src\\main\\scala\\MotorDriver.scala 67:40 68:48]
  wire  _GEN_10 = 8'h0 == rx_io_data ? 1'h0 : _GEN_8; // @[\\src\\main\\scala\\MotorDriver.scala 67:40 68:71]
  wire  _GEN_11 = 8'h2 == cmdByte ? 1'h0 : control_mode; // @[\\src\\main\\scala\\MotorDriver.scala 59:29 47:34 66:34]
  wire [9:0] _GEN_12 = 8'h2 == cmdByte ? _GEN_9 : manual_speed; // @[\\src\\main\\scala\\MotorDriver.scala 59:29 46:34]
  wire  _GEN_13 = 8'h2 == cmdByte ? _GEN_10 : manual_brake; // @[\\src\\main\\scala\\MotorDriver.scala 59:29 48:34]
  wire  _GEN_15 = 8'h1 == cmdByte | _GEN_11; // @[\\src\\main\\scala\\MotorDriver.scala 59:29 62:34]
  wire [42:0] _current_pos_m_T = rotation_counter_io_turns * 11'h576; // @[\\src\\main\\scala\\MotorDriver.scala 84:52]
  wire [22:0] current_pos_m = _current_pos_m_T[42:20]; // @[\\src\\main\\scala\\MotorDriver.scala 84:62]
  wire [7:0] _pid_io_setPoint_T = target_position; // @[\\src\\main\\scala\\MotorDriver.scala 86:55]
  wire [22:0] _pid_io_measuredVal_T = _current_pos_m_T[42:20]; // @[\\src\\main\\scala\\MotorDriver.scala 87:53]
  wire [31:0] _pid_duty_T = $signed(pid_io_controlOut) + 32'sh800; // @[\\src\\main\\scala\\MotorDriver.scala 96:38]
  wire [9:0] pid_duty = _pid_duty_T[11:2]; // @[\\src\\main\\scala\\MotorDriver.scala 96:50]
  wire  brake_active = stuck_detector_io_motorDisable | manual_brake; // @[\\src\\main\\scala\\MotorDriver.scala 102:56]
  reg [23:0] txTimer; // @[\\src\\main\\scala\\MotorDriver.scala 115:26]
  wire  _T_10 = ~tx_io_busy; // @[\\src\\main\\scala\\MotorDriver.scala 119:14]
  wire [23:0] _txTimer_T_1 = txTimer + 24'h1; // @[\\src\\main\\scala\\MotorDriver.scala 123:38]
  UartRx rx ( // @[\\src\\main\\scala\\MotorDriver.scala 27:38]
    .clock(rx_clock),
    .reset(rx_reset),
    .io_rx(rx_io_rx),
    .io_done(rx_io_done),
    .io_data(rx_io_data)
  );
  UartTx tx ( // @[\\src\\main\\scala\\MotorDriver.scala 28:38]
    .clock(tx_clock),
    .reset(tx_reset),
    .io_data(tx_io_data),
    .io_start(tx_io_start),
    .io_tx(tx_io_tx),
    .io_busy(tx_io_busy)
  );
  RotationCounter rotation_counter ( // @[\\src\\main\\scala\\MotorDriver.scala 29:38]
    .clock(rotation_counter_clock),
    .reset(rotation_counter_reset),
    .io_signal_A(rotation_counter_io_signal_A),
    .io_signal_B(rotation_counter_io_signal_B),
    .io_turns(rotation_counter_io_turns)
  );
  DCMotorPwm pwm_gen ( // @[\\src\\main\\scala\\MotorDriver.scala 30:38]
    .clock(pwm_gen_clock),
    .reset(pwm_gen_reset),
    .io_duty_cycle(pwm_gen_io_duty_cycle),
    .io_brake(pwm_gen_io_brake),
    .io_T1(pwm_gen_io_T1),
    .io_T2(pwm_gen_io_T2),
    .io_T3(pwm_gen_io_T3),
    .io_T4(pwm_gen_io_T4)
  );
  PIDController pid ( // @[\\src\\main\\scala\\MotorDriver.scala 31:38]
    .clock(pid_clock),
    .reset(pid_reset),
    .io_setPoint(pid_io_setPoint),
    .io_measuredVal(pid_io_measuredVal),
    .io_resetBuffer(pid_io_resetBuffer),
    .io_controlOut(pid_io_controlOut)
  );
  StuckDetector stuck_detector ( // @[\\src\\main\\scala\\MotorDriver.scala 32:38]
    .clock(stuck_detector_clock),
    .reset(stuck_detector_reset),
    .io_externalOvercurrentInput(stuck_detector_io_externalOvercurrentInput),
    .io_clearShutdown(stuck_detector_io_clearShutdown),
    .io_motorDisable(stuck_detector_io_motorDisable)
  );
  DisplayMultiplexer disp_mux ( // @[\\src\\main\\scala\\MotorDriver.scala 33:38]
    .clock(disp_mux_clock),
    .reset(disp_mux_reset),
    .io_disp_content(disp_mux_io_disp_content),
    .io_seg(disp_mux_io_seg),
    .io_an(disp_mux_io_an)
  );
  Debouncer error_clear_debounce ( // @[\\src\\main\\scala\\MotorDriver.scala 34:38]
    .clock(error_clear_debounce_clock),
    .reset(error_clear_debounce_reset),
    .io_btn_in(error_clear_debounce_io_btn_in),
    .io_out(error_clear_debounce_io_out)
  );
  assign io_uart_tx = tx_io_tx; // @[\\src\\main\\scala\\MotorDriver.scala 124:16]
  assign io_T1 = pwm_gen_io_T1; // @[\\src\\main\\scala\\MotorDriver.scala 110:11]
  assign io_T2 = pwm_gen_io_T2; // @[\\src\\main\\scala\\MotorDriver.scala 111:11]
  assign io_T3 = pwm_gen_io_T3; // @[\\src\\main\\scala\\MotorDriver.scala 112:11]
  assign io_T4 = pwm_gen_io_T4; // @[\\src\\main\\scala\\MotorDriver.scala 113:11]
  assign io_seg = disp_mux_io_seg; // @[\\src\\main\\scala\\MotorDriver.scala 43:12]
  assign io_an = disp_mux_io_an; // @[\\src\\main\\scala\\MotorDriver.scala 42:11]
  assign rx_clock = clock;
  assign rx_reset = reset;
  assign rx_io_rx = io_uart_rx; // @[\\src\\main\\scala\\MotorDriver.scala 50:14]
  assign tx_clock = clock;
  assign tx_reset = reset;
  assign tx_io_data = current_pos_m[7:0]; // @[\\src\\main\\scala\\MotorDriver.scala 116:33]
  assign tx_io_start = txTimer >= 24'h989680 & _T_10; // @[\\src\\main\\scala\\MotorDriver.scala 117:17 118:33]
  assign rotation_counter_clock = clock;
  assign rotation_counter_reset = reset;
  assign rotation_counter_io_signal_A = io_photo_diode_A; // @[\\src\\main\\scala\\MotorDriver.scala 81:34]
  assign rotation_counter_io_signal_B = io_photo_diode_B; // @[\\src\\main\\scala\\MotorDriver.scala 82:34]
  assign pwm_gen_clock = clock;
  assign pwm_gen_reset = reset;
  assign pwm_gen_io_duty_cycle = control_mode ? pid_duty : manual_speed; // @[\\src\\main\\scala\\MotorDriver.scala 101:33]
  assign pwm_gen_io_brake = stuck_detector_io_motorDisable | manual_brake; // @[\\src\\main\\scala\\MotorDriver.scala 102:56]
  assign pid_clock = clock;
  assign pid_reset = reset;
  assign pid_io_setPoint = {{24{_pid_io_setPoint_T[7]}},_pid_io_setPoint_T}; // @[\\src\\main\\scala\\MotorDriver.scala 86:24]
  assign pid_io_measuredVal = {{9{_pid_io_measuredVal_T[22]}},_pid_io_measuredVal_T}; // @[\\src\\main\\scala\\MotorDriver.scala 87:24]
  assign pid_io_resetBuffer = ~control_mode | manual_brake; // @[\\src\\main\\scala\\MotorDriver.scala 88:41]
  assign stuck_detector_clock = clock;
  assign stuck_detector_reset = reset;
  assign stuck_detector_io_externalOvercurrentInput = io_over_current_pos | io_over_current_neg; // @[\\src\\main\\scala\\MotorDriver.scala 98:72]
  assign stuck_detector_io_clearShutdown = rx_io_done & cmdByte == 8'hff | error_clear_debounce_io_out; // @[\\src\\main\\scala\\MotorDriver.scala 99:87]
  assign disp_mux_clock = clock;
  assign disp_mux_reset = reset;
  assign disp_mux_io_disp_content = brake_active ? 20'hd6ed7 : 20'hef7bd; // @[\\src\\main\\scala\\MotorDriver.scala 106:25 107:34 39:30]
  assign error_clear_debounce_clock = clock;
  assign error_clear_debounce_reset = reset;
  assign error_clear_debounce_io_btn_in = io_error_cleared; // @[\\src\\main\\scala\\MotorDriver.scala 36:36]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 45:34]
      target_position <= 8'h0; // @[\\src\\main\\scala\\MotorDriver.scala 45:34]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\MotorDriver.scala 54:22]
      if (!(~isValueByte)) begin // @[\\src\\main\\scala\\MotorDriver.scala 55:28]
        if (8'h1 == cmdByte) begin // @[\\src\\main\\scala\\MotorDriver.scala 59:29]
          target_position <= rx_io_data; // @[\\src\\main\\scala\\MotorDriver.scala 61:37]
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 46:34]
      manual_speed <= 10'h200; // @[\\src\\main\\scala\\MotorDriver.scala 46:34]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\MotorDriver.scala 54:22]
      if (!(~isValueByte)) begin // @[\\src\\main\\scala\\MotorDriver.scala 55:28]
        if (!(8'h1 == cmdByte)) begin // @[\\src\\main\\scala\\MotorDriver.scala 59:29]
          manual_speed <= _GEN_12;
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 47:34]
      control_mode <= 1'h0; // @[\\src\\main\\scala\\MotorDriver.scala 47:34]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\MotorDriver.scala 54:22]
      if (!(~isValueByte)) begin // @[\\src\\main\\scala\\MotorDriver.scala 55:28]
        control_mode <= _GEN_15;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 48:34]
      manual_brake <= 1'h0; // @[\\src\\main\\scala\\MotorDriver.scala 48:34]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\MotorDriver.scala 54:22]
      if (!(~isValueByte)) begin // @[\\src\\main\\scala\\MotorDriver.scala 55:28]
        if (8'h1 == cmdByte) begin // @[\\src\\main\\scala\\MotorDriver.scala 59:29]
          manual_brake <= 1'h0; // @[\\src\\main\\scala\\MotorDriver.scala 63:34]
        end else begin
          manual_brake <= _GEN_13;
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 51:26]
      cmdByte <= 8'h0; // @[\\src\\main\\scala\\MotorDriver.scala 51:26]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\MotorDriver.scala 54:22]
      if (~isValueByte) begin // @[\\src\\main\\scala\\MotorDriver.scala 55:28]
        cmdByte <= rx_io_data; // @[\\src\\main\\scala\\MotorDriver.scala 56:21]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 52:30]
      isValueByte <= 1'h0; // @[\\src\\main\\scala\\MotorDriver.scala 52:30]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\MotorDriver.scala 54:22]
      isValueByte <= _T;
    end
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 115:26]
      txTimer <= 24'h0; // @[\\src\\main\\scala\\MotorDriver.scala 115:26]
    end else if (txTimer >= 24'h989680) begin // @[\\src\\main\\scala\\MotorDriver.scala 118:33]
      if (~tx_io_busy) begin // @[\\src\\main\\scala\\MotorDriver.scala 119:27]
        txTimer <= 24'h0; // @[\\src\\main\\scala\\MotorDriver.scala 121:21]
      end
    end else begin
      txTimer <= _txTimer_T_1; // @[\\src\\main\\scala\\MotorDriver.scala 123:27]
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
