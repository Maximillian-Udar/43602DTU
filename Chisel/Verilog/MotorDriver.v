module UartRx(
  input        clock,
  input        reset,
  input        io_rx, // @[\\src\\main\\scala\\Functions.scala 77:14]
  output       io_done, // @[\\src\\main\\scala\\Functions.scala 77:14]
  output [7:0] io_data // @[\\src\\main\\scala\\Functions.scala 77:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg  rxReg_REG; // @[\\src\\main\\scala\\Functions.scala 84:33]
  reg  rxReg; // @[\\src\\main\\scala\\Functions.scala 84:25]
  reg [7:0] shiftReg; // @[\\src\\main\\scala\\Functions.scala 85:25]
  reg [31:0] cntReg; // @[\\src\\main\\scala\\Functions.scala 86:25]
  reg [3:0] bitsReg; // @[\\src\\main\\scala\\Functions.scala 87:25]
  reg [1:0] stateReg; // @[\\src\\main\\scala\\Functions.scala 89:25]
  wire [31:0] _cntReg_T_1 = cntReg + 32'h1; // @[\\src\\main\\scala\\Functions.scala 94:127]
  wire [9:0] _T_6 = 10'h364 - 10'h1; // @[\\src\\main\\scala\\Functions.scala 95:41]
  wire [31:0] _GEN_32 = {{22'd0}, _T_6}; // @[\\src\\main\\scala\\Functions.scala 95:29]
  wire  _T_7 = cntReg == _GEN_32; // @[\\src\\main\\scala\\Functions.scala 95:29]
  wire [7:0] _shiftReg_T_1 = {rxReg,shiftReg[7:1]}; // @[\\src\\main\\scala\\Functions.scala 95:80]
  wire [3:0] _bitsReg_T_1 = bitsReg + 4'h1; // @[\\src\\main\\scala\\Functions.scala 95:180]
  wire [1:0] _GEN_5 = bitsReg == 4'h7 ? 2'h3 : stateReg; // @[\\src\\main\\scala\\Functions.scala 95:{127,138} 89:25]
  wire [3:0] _GEN_6 = bitsReg == 4'h7 ? bitsReg : _bitsReg_T_1; // @[\\src\\main\\scala\\Functions.scala 95:127 87:25 95:169]
  wire [31:0] _GEN_7 = cntReg == _GEN_32 ? 32'h0 : _cntReg_T_1; // @[\\src\\main\\scala\\Functions.scala 95:{209,48,57}]
  wire [7:0] _GEN_8 = cntReg == _GEN_32 ? _shiftReg_T_1 : shiftReg; // @[\\src\\main\\scala\\Functions.scala 85:25 95:{48,74}]
  wire [1:0] _GEN_9 = cntReg == _GEN_32 ? _GEN_5 : stateReg; // @[\\src\\main\\scala\\Functions.scala 89:25 95:48]
  wire [3:0] _GEN_10 = cntReg == _GEN_32 ? _GEN_6 : bitsReg; // @[\\src\\main\\scala\\Functions.scala 87:25 95:48]
  wire [1:0] _GEN_11 = _T_7 ? 2'h0 : stateReg; // @[\\src\\main\\scala\\Functions.scala 89:25 96:{48,59}]
  wire [31:0] _GEN_13 = _T_7 ? cntReg : _cntReg_T_1; // @[\\src\\main\\scala\\Functions.scala 86:25 96:{108,48}]
  wire [1:0] _GEN_14 = 2'h3 == stateReg ? _GEN_11 : stateReg; // @[\\src\\main\\scala\\Functions.scala 92:20 89:25]
  wire [31:0] _GEN_16 = 2'h3 == stateReg ? _GEN_13 : cntReg; // @[\\src\\main\\scala\\Functions.scala 92:20 86:25]
  wire  _GEN_21 = 2'h2 == stateReg ? 1'h0 : 2'h3 == stateReg & _T_7; // @[\\src\\main\\scala\\Functions.scala 90:11 92:20]
  wire  _GEN_26 = 2'h1 == stateReg ? 1'h0 : _GEN_21; // @[\\src\\main\\scala\\Functions.scala 90:11 92:20]
  assign io_done = 2'h0 == stateReg ? 1'h0 : _GEN_26; // @[\\src\\main\\scala\\Functions.scala 90:11 92:20]
  assign io_data = shiftReg; // @[\\src\\main\\scala\\Functions.scala 91:11]
  always @(posedge clock) begin
    rxReg_REG <= io_rx; // @[\\src\\main\\scala\\Functions.scala 84:33]
    rxReg <= rxReg_REG; // @[\\src\\main\\scala\\Functions.scala 84:25]
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 85:25]
      shiftReg <= 8'h0; // @[\\src\\main\\scala\\Functions.scala 85:25]
    end else if (!(2'h0 == stateReg)) begin // @[\\src\\main\\scala\\Functions.scala 92:20]
      if (!(2'h1 == stateReg)) begin // @[\\src\\main\\scala\\Functions.scala 92:20]
        if (2'h2 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 92:20]
          shiftReg <= _GEN_8;
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 86:25]
      cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 86:25]
    end else if (2'h0 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 92:20]
      if (~rxReg) begin // @[\\src\\main\\scala\\Functions.scala 93:30]
        cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 93:59]
      end
    end else if (2'h1 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 92:20]
      if (cntReg == 32'h1b2) begin // @[\\src\\main\\scala\\Functions.scala 94:45]
        cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 94:73]
      end else begin
        cntReg <= _cntReg_T_1; // @[\\src\\main\\scala\\Functions.scala 94:117]
      end
    end else if (2'h2 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 92:20]
      cntReg <= _GEN_7;
    end else begin
      cntReg <= _GEN_16;
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 87:25]
      bitsReg <= 4'h0; // @[\\src\\main\\scala\\Functions.scala 87:25]
    end else if (!(2'h0 == stateReg)) begin // @[\\src\\main\\scala\\Functions.scala 92:20]
      if (2'h1 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 92:20]
        if (cntReg == 32'h1b2) begin // @[\\src\\main\\scala\\Functions.scala 94:45]
          bitsReg <= 4'h0; // @[\\src\\main\\scala\\Functions.scala 94:89]
        end
      end else if (2'h2 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 92:20]
        bitsReg <= _GEN_10;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 89:25]
      stateReg <= 2'h0; // @[\\src\\main\\scala\\Functions.scala 89:25]
    end else if (2'h0 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 92:20]
      if (~rxReg) begin // @[\\src\\main\\scala\\Functions.scala 93:30]
        stateReg <= 2'h1; // @[\\src\\main\\scala\\Functions.scala 93:41]
      end
    end else if (2'h1 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 92:20]
      if (cntReg == 32'h1b2) begin // @[\\src\\main\\scala\\Functions.scala 94:45]
        stateReg <= 2'h2; // @[\\src\\main\\scala\\Functions.scala 94:56]
      end
    end else if (2'h2 == stateReg) begin // @[\\src\\main\\scala\\Functions.scala 92:20]
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
  input  [7:0] io_data, // @[\\src\\main\\scala\\Functions.scala 101:14]
  input        io_start, // @[\\src\\main\\scala\\Functions.scala 101:14]
  output       io_tx, // @[\\src\\main\\scala\\Functions.scala 101:14]
  output       io_busy // @[\\src\\main\\scala\\Functions.scala 101:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [9:0] reg_; // @[\\src\\main\\scala\\Functions.scala 108:20]
  reg [31:0] cnt; // @[\\src\\main\\scala\\Functions.scala 109:20]
  reg [3:0] bits; // @[\\src\\main\\scala\\Functions.scala 110:21]
  reg  state; // @[\\src\\main\\scala\\Functions.scala 112:22]
  wire [9:0] _reg_T = {1'h1,io_data,1'h0}; // @[\\src\\main\\scala\\Functions.scala 116:44]
  wire  _GEN_3 = io_start | state; // @[\\src\\main\\scala\\Functions.scala 112:22 116:{32,96}]
  wire [9:0] _T_3 = 10'h364 - 10'h1; // @[\\src\\main\\scala\\Functions.scala 117:38]
  wire [31:0] _GEN_18 = {{22'd0}, _T_3}; // @[\\src\\main\\scala\\Functions.scala 117:26]
  wire [9:0] _reg_T_2 = {1'h1,reg_[9:1]}; // @[\\src\\main\\scala\\Functions.scala 117:69]
  wire [3:0] _bits_T_1 = bits + 4'h1; // @[\\src\\main\\scala\\Functions.scala 117:150]
  wire  _GEN_4 = bits == 4'h9 ? 1'h0 : state; // @[\\src\\main\\scala\\Functions.scala 117:{106,114} 112:22]
  wire [3:0] _GEN_5 = bits == 4'h9 ? bits : _bits_T_1; // @[\\src\\main\\scala\\Functions.scala 117:106 110:21 117:142]
  wire [31:0] _cnt_T_1 = cnt + 32'h1; // @[\\src\\main\\scala\\Functions.scala 117:183]
  assign io_tx = reg_[0]; // @[\\src\\main\\scala\\Functions.scala 113:15]
  assign io_busy = state; // @[\\src\\main\\scala\\Functions.scala 114:20]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 108:20]
      reg_ <= 10'h1; // @[\\src\\main\\scala\\Functions.scala 108:20]
    end else if (~state) begin // @[\\src\\main\\scala\\Functions.scala 115:17]
      if (io_start) begin // @[\\src\\main\\scala\\Functions.scala 116:32]
        reg_ <= _reg_T; // @[\\src\\main\\scala\\Functions.scala 116:38]
      end
    end else if (state) begin // @[\\src\\main\\scala\\Functions.scala 115:17]
      if (cnt == _GEN_18) begin // @[\\src\\main\\scala\\Functions.scala 117:45]
        reg_ <= _reg_T_2; // @[\\src\\main\\scala\\Functions.scala 117:63]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 109:20]
      cnt <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 109:20]
    end else if (~state) begin // @[\\src\\main\\scala\\Functions.scala 115:17]
      if (io_start) begin // @[\\src\\main\\scala\\Functions.scala 116:32]
        cnt <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 116:82]
      end
    end else if (state) begin // @[\\src\\main\\scala\\Functions.scala 115:17]
      if (cnt == _GEN_18) begin // @[\\src\\main\\scala\\Functions.scala 117:45]
        cnt <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 117:51]
      end else begin
        cnt <= _cnt_T_1; // @[\\src\\main\\scala\\Functions.scala 117:176]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 110:21]
      bits <= 4'h0; // @[\\src\\main\\scala\\Functions.scala 110:21]
    end else if (~state) begin // @[\\src\\main\\scala\\Functions.scala 115:17]
      if (io_start) begin // @[\\src\\main\\scala\\Functions.scala 116:32]
        bits <= 4'h0; // @[\\src\\main\\scala\\Functions.scala 116:70]
      end
    end else if (state) begin // @[\\src\\main\\scala\\Functions.scala 115:17]
      if (cnt == _GEN_18) begin // @[\\src\\main\\scala\\Functions.scala 117:45]
        bits <= _GEN_5;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 112:22]
      state <= 1'h0; // @[\\src\\main\\scala\\Functions.scala 112:22]
    end else if (~state) begin // @[\\src\\main\\scala\\Functions.scala 115:17]
      state <= _GEN_3;
    end else if (state) begin // @[\\src\\main\\scala\\Functions.scala 115:17]
      if (cnt == _GEN_18) begin // @[\\src\\main\\scala\\Functions.scala 117:45]
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
  reg [31:0] pwmCounter; // @[\\src\\main\\scala\\Functions.scala 34:27]
  wire [12:0] _pwmCounter_T_1 = 13'h1388 - 13'h1; // @[\\src\\main\\scala\\Functions.scala 35:48]
  wire [31:0] _GEN_4 = {{19'd0}, _pwmCounter_T_1}; // @[\\src\\main\\scala\\Functions.scala 35:32]
  wire [31:0] _pwmCounter_T_4 = pwmCounter + 32'h1; // @[\\src\\main\\scala\\Functions.scala 35:71]
  wire [22:0] _pwmSignal_T = io_duty_cycle * 13'h1388; // @[\\src\\main\\scala\\Functions.scala 36:48]
  wire [31:0] _GEN_5 = {{19'd0}, _pwmSignal_T[22:10]}; // @[\\src\\main\\scala\\Functions.scala 36:30]
  wire  pwmSignal = pwmCounter < _GEN_5; // @[\\src\\main\\scala\\Functions.scala 36:30]
  wire  _conduct_T1_T = ~pwmSignal; // @[\\src\\main\\scala\\Functions.scala 46:19]
  wire  conduct_T2 = io_brake ? 1'h0 : pwmSignal; // @[\\src\\main\\scala\\Functions.scala 42:18 44:16 46:42]
  wire  conduct_T4 = io_brake ? 1'h0 : _conduct_T1_T; // @[\\src\\main\\scala\\Functions.scala 42:18 44:39 47:42]
  assign io_T1 = io_brake | ~pwmSignal; // @[\\src\\main\\scala\\Functions.scala 42:18 43:16 46:16]
  assign io_T2 = ~conduct_T2; // @[\\src\\main\\scala\\Functions.scala 50:12]
  assign io_T3 = io_brake | pwmSignal; // @[\\src\\main\\scala\\Functions.scala 42:18 43:38 47:16]
  assign io_T4 = ~conduct_T4; // @[\\src\\main\\scala\\Functions.scala 50:34]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 34:27]
      pwmCounter <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 34:27]
    end else if (pwmCounter >= _GEN_4) begin // @[\\src\\main\\scala\\Functions.scala 35:20]
      pwmCounter <= 32'h0;
    end else begin
      pwmCounter <= _pwmCounter_T_4;
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
  input  [31:0] io_setPoint, // @[\\src\\main\\scala\\Functions.scala 56:14]
  input  [31:0] io_measuredVal, // @[\\src\\main\\scala\\Functions.scala 56:14]
  input         io_resetBuffer, // @[\\src\\main\\scala\\Functions.scala 56:14]
  output [31:0] io_controlOut // @[\\src\\main\\scala\\Functions.scala 56:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire [31:0] error = $signed(io_setPoint) - $signed(io_measuredVal); // @[\\src\\main\\scala\\Functions.scala 60:27]
  reg [31:0] integralReg; // @[\\src\\main\\scala\\Functions.scala 61:28]
  reg [31:0] prevErrorReg; // @[\\src\\main\\scala\\Functions.scala 61:72]
  reg [31:0] outReg; // @[\\src\\main\\scala\\Functions.scala 62:23]
  wire [63:0] _nextI_T = $signed(error) * 32'shcd; // @[\\src\\main\\scala\\Functions.scala 65:38]
  wire [43:0] _GEN_6 = {$signed(integralReg), 12'h0}; // @[\\src\\main\\scala\\Functions.scala 65:29]
  wire [63:0] _GEN_7 = {{20{_GEN_6[43]}},_GEN_6}; // @[\\src\\main\\scala\\Functions.scala 65:29]
  wire [63:0] nextI = $signed(_GEN_7) + $signed(_nextI_T); // @[\\src\\main\\scala\\Functions.scala 65:29]
  wire [31:0] _integralReg_T_3 = 32'sh0 - 32'sh800; // @[\\src\\main\\scala\\Functions.scala 66:58]
  wire [43:0] _GEN_8 = {$signed(_integralReg_T_3), 12'h0}; // @[\\src\\main\\scala\\Functions.scala 66:56]
  wire [63:0] _GEN_9 = {{20{_GEN_8[43]}},_GEN_8}; // @[\\src\\main\\scala\\Functions.scala 66:56]
  wire [63:0] _integralReg_T_8 = $signed(nextI) < $signed(_GEN_9) ? $signed({{20{_GEN_8[43]}},_GEN_8}) : $signed(nextI); // @[\\src\\main\\scala\\Functions.scala 66:49]
  wire [63:0] _integralReg_T_9 = $signed(nextI) > 64'sh800000 ? $signed(64'sh800000) : $signed(_integralReg_T_8); // @[\\src\\main\\scala\\Functions.scala 66:23]
  wire [31:0] _deriv_T_2 = $signed(error) - $signed(prevErrorReg); // @[\\src\\main\\scala\\Functions.scala 67:24]
  wire [63:0] deriv = $signed(_deriv_T_2) * 32'sh666; // @[\\src\\main\\scala\\Functions.scala 67:40]
  wire [63:0] _raw_T = $signed(error) * 32'sh2000; // @[\\src\\main\\scala\\Functions.scala 68:22]
  wire [63:0] _raw_T_3 = $signed(_raw_T) + $signed(_GEN_7); // @[\\src\\main\\scala\\Functions.scala 68:31]
  wire [63:0] raw = $signed(_raw_T_3) + $signed(deriv); // @[\\src\\main\\scala\\Functions.scala 68:45]
  wire [63:0] _outReg_T_8 = $signed(raw) < $signed(_GEN_9) ? $signed({{20{_GEN_8[43]}},_GEN_8}) : $signed(raw); // @[\\src\\main\\scala\\Functions.scala 69:42]
  wire [63:0] _outReg_T_9 = $signed(raw) > 64'sh800000 ? $signed(64'sh800000) : $signed(_outReg_T_8); // @[\\src\\main\\scala\\Functions.scala 69:18]
  wire [63:0] _GEN_3 = io_resetBuffer ? $signed(64'sh0) : $signed(_integralReg_T_9); // @[\\src\\main\\scala\\Functions.scala 63:{24,38}]
  wire [63:0] _GEN_4 = io_resetBuffer ? $signed(64'sh0) : $signed(_outReg_T_9); // @[\\src\\main\\scala\\Functions.scala 63:{24,64}]
  wire [51:0] _GEN_16 = reset ? $signed(52'sh0) : $signed(_GEN_3[63:12]); // @[\\src\\main\\scala\\Functions.scala 61:{28,28}]
  wire [51:0] _GEN_18 = reset ? $signed(52'sh0) : $signed(_GEN_4[63:12]); // @[\\src\\main\\scala\\Functions.scala 62:{23,23}]
  assign io_controlOut = outReg; // @[\\src\\main\\scala\\Functions.scala 71:17]
  always @(posedge clock) begin
    integralReg <= _GEN_16[31:0]; // @[\\src\\main\\scala\\Functions.scala 61:{28,28}]
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 61:72]
      prevErrorReg <= 32'sh0; // @[\\src\\main\\scala\\Functions.scala 61:72]
    end else if (!(io_resetBuffer)) begin // @[\\src\\main\\scala\\Functions.scala 63:24]
      prevErrorReg <= error;
    end
    outReg <= _GEN_18[31:0]; // @[\\src\\main\\scala\\Functions.scala 62:{23,23}]
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
  outReg = _RAND_2[31:0];
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
  input   io_externalOvercurrentInput, // @[\\src\\main\\scala\\Functions.scala 122:14]
  input   io_clearShutdown, // @[\\src\\main\\scala\\Functions.scala 122:14]
  output  io_motorDisable // @[\\src\\main\\scala\\Functions.scala 122:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [24:0] maxCycles = 17'h186a0 * 8'h96; // @[\\src\\main\\scala\\Functions.scala 129:44]
  reg [31:0] durationReg; // @[\\src\\main\\scala\\Functions.scala 130:28]
  reg  isStuckReg; // @[\\src\\main\\scala\\Functions.scala 131:28]
  wire [31:0] _GEN_8 = {{7'd0}, maxCycles}; // @[\\src\\main\\scala\\Functions.scala 135:26]
  wire [31:0] _durationReg_T_1 = durationReg + 32'h1; // @[\\src\\main\\scala\\Functions.scala 135:104]
  wire  _GEN_0 = durationReg >= _GEN_8 | isStuckReg; // @[\\src\\main\\scala\\Functions.scala 131:28 135:{40,53}]
  wire [31:0] _GEN_1 = durationReg >= _GEN_8 ? durationReg : _durationReg_T_1; // @[\\src\\main\\scala\\Functions.scala 130:28 135:{40,89}]
  assign io_motorDisable = isStuckReg; // @[\\src\\main\\scala\\Functions.scala 140:19]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 130:28]
      durationReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 130:28]
    end else if (io_clearShutdown) begin // @[\\src\\main\\scala\\Functions.scala 132:26]
      durationReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 132:63]
    end else if (~isStuckReg) begin // @[\\src\\main\\scala\\Functions.scala 133:23]
      if (io_externalOvercurrentInput) begin // @[\\src\\main\\scala\\Functions.scala 134:41]
        durationReg <= _GEN_1;
      end else begin
        durationReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 136:33]
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 131:28]
      isStuckReg <= 1'h0; // @[\\src\\main\\scala\\Functions.scala 131:28]
    end else if (io_clearShutdown) begin // @[\\src\\main\\scala\\Functions.scala 132:26]
      isStuckReg <= 1'h0; // @[\\src\\main\\scala\\Functions.scala 132:39]
    end else if (~isStuckReg) begin // @[\\src\\main\\scala\\Functions.scala 133:23]
      if (io_externalOvercurrentInput) begin // @[\\src\\main\\scala\\Functions.scala 134:41]
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
  input  [4:0] io_in, // @[\\src\\main\\scala\\Functions.scala 192:14]
  output [6:0] io_out // @[\\src\\main\\scala\\Functions.scala 192:14]
);
  wire [6:0] _io_out_T_33 = 5'h0 == io_in ? 7'h3f : 7'h0; // @[\\src\\main\\scala\\Functions.scala 197:46]
  wire [6:0] _io_out_T_35 = 5'h1 == io_in ? 7'h6 : _io_out_T_33; // @[\\src\\main\\scala\\Functions.scala 197:46]
  wire [6:0] _io_out_T_37 = 5'h2 == io_in ? 7'h5b : _io_out_T_35; // @[\\src\\main\\scala\\Functions.scala 197:46]
  wire [6:0] _io_out_T_39 = 5'h3 == io_in ? 7'h4f : _io_out_T_37; // @[\\src\\main\\scala\\Functions.scala 197:46]
  wire [6:0] _io_out_T_41 = 5'h4 == io_in ? 7'h66 : _io_out_T_39; // @[\\src\\main\\scala\\Functions.scala 197:46]
  wire [6:0] _io_out_T_43 = 5'h5 == io_in ? 7'h6d : _io_out_T_41; // @[\\src\\main\\scala\\Functions.scala 197:46]
  wire [6:0] _io_out_T_45 = 5'h6 == io_in ? 7'h7d : _io_out_T_43; // @[\\src\\main\\scala\\Functions.scala 197:46]
  wire [6:0] _io_out_T_47 = 5'h7 == io_in ? 7'h7 : _io_out_T_45; // @[\\src\\main\\scala\\Functions.scala 197:46]
  wire [6:0] _io_out_T_49 = 5'h8 == io_in ? 7'h7f : _io_out_T_47; // @[\\src\\main\\scala\\Functions.scala 197:46]
  wire [6:0] _io_out_T_51 = 5'h9 == io_in ? 7'h6f : _io_out_T_49; // @[\\src\\main\\scala\\Functions.scala 197:46]
  wire [6:0] _io_out_T_53 = 5'ha == io_in ? 7'h77 : _io_out_T_51; // @[\\src\\main\\scala\\Functions.scala 197:46]
  wire [6:0] _io_out_T_55 = 5'hb == io_in ? 7'h7c : _io_out_T_53; // @[\\src\\main\\scala\\Functions.scala 197:46]
  wire [6:0] _io_out_T_57 = 5'hc == io_in ? 7'h39 : _io_out_T_55; // @[\\src\\main\\scala\\Functions.scala 197:46]
  wire [6:0] _io_out_T_59 = 5'hd == io_in ? 7'h5e : _io_out_T_57; // @[\\src\\main\\scala\\Functions.scala 197:46]
  wire [6:0] _io_out_T_61 = 5'he == io_in ? 7'h79 : _io_out_T_59; // @[\\src\\main\\scala\\Functions.scala 197:46]
  wire [6:0] _io_out_T_63 = 5'hf == io_in ? 7'h71 : _io_out_T_61; // @[\\src\\main\\scala\\Functions.scala 197:46]
  wire [6:0] _io_out_T_65 = 5'h10 == io_in ? 7'h3c : _io_out_T_63; // @[\\src\\main\\scala\\Functions.scala 197:46]
  wire [6:0] _io_out_T_67 = 5'h11 == io_in ? 7'h76 : _io_out_T_65; // @[\\src\\main\\scala\\Functions.scala 197:46]
  wire [6:0] _io_out_T_69 = 5'h12 == io_in ? 7'h6 : _io_out_T_67; // @[\\src\\main\\scala\\Functions.scala 197:46]
  wire [6:0] _io_out_T_71 = 5'h13 == io_in ? 7'hf : _io_out_T_69; // @[\\src\\main\\scala\\Functions.scala 197:46]
  wire [6:0] _io_out_T_73 = 5'h14 == io_in ? 7'h38 : _io_out_T_71; // @[\\src\\main\\scala\\Functions.scala 197:46]
  wire [6:0] _io_out_T_75 = 5'h15 == io_in ? 7'h38 : _io_out_T_73; // @[\\src\\main\\scala\\Functions.scala 197:46]
  wire [6:0] _io_out_T_77 = 5'h16 == io_in ? 7'h70 : _io_out_T_75; // @[\\src\\main\\scala\\Functions.scala 197:46]
  wire [6:0] _io_out_T_79 = 5'h17 == io_in ? 7'h3f : _io_out_T_77; // @[\\src\\main\\scala\\Functions.scala 197:46]
  wire [6:0] _io_out_T_81 = 5'h18 == io_in ? 7'h73 : _io_out_T_79; // @[\\src\\main\\scala\\Functions.scala 197:46]
  wire [6:0] _io_out_T_83 = 5'h19 == io_in ? 7'h67 : _io_out_T_81; // @[\\src\\main\\scala\\Functions.scala 197:46]
  wire [6:0] _io_out_T_85 = 5'h1a == io_in ? 7'h31 : _io_out_T_83; // @[\\src\\main\\scala\\Functions.scala 197:46]
  wire [6:0] _io_out_T_87 = 5'h1b == io_in ? 7'h6d : _io_out_T_85; // @[\\src\\main\\scala\\Functions.scala 197:46]
  wire [6:0] _io_out_T_89 = 5'h1c == io_in ? 7'h78 : _io_out_T_87; // @[\\src\\main\\scala\\Functions.scala 197:46]
  wire [6:0] _io_out_T_91 = 5'h1d == io_in ? 7'h3e : _io_out_T_89; // @[\\src\\main\\scala\\Functions.scala 197:46]
  assign io_out = 5'h1e == io_in ? 7'h0 : _io_out_T_91; // @[\\src\\main\\scala\\Functions.scala 197:46]
endmodule
module DisplayMultiplexer(
  input         clock,
  input         reset,
  input  [19:0] io_disp_content, // @[\\src\\main\\scala\\Functions.scala 144:14]
  output [7:0]  io_seg, // @[\\src\\main\\scala\\Functions.scala 144:14]
  output [3:0]  io_an // @[\\src\\main\\scala\\Functions.scala 144:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [4:0] decoder_io_in; // @[\\src\\main\\scala\\Functions.scala 167:23]
  wire [6:0] decoder_io_out; // @[\\src\\main\\scala\\Functions.scala 167:23]
  reg [16:0] cnt; // @[\\src\\main\\scala\\Functions.scala 151:20]
  wire  _cnt_T = cnt == 17'h1869f; // @[\\src\\main\\scala\\Functions.scala 152:18]
  wire [16:0] _cnt_T_2 = cnt + 17'h1; // @[\\src\\main\\scala\\Functions.scala 152:54]
  reg [1:0] digit; // @[\\src\\main\\scala\\Functions.scala 155:22]
  wire [1:0] _digit_T_1 = digit + 2'h1; // @[\\src\\main\\scala\\Functions.scala 156:31]
  wire  _T = 2'h0 == digit; // @[\\src\\main\\scala\\Functions.scala 160:17]
  wire  _T_1 = 2'h1 == digit; // @[\\src\\main\\scala\\Functions.scala 160:17]
  wire  _T_2 = 2'h2 == digit; // @[\\src\\main\\scala\\Functions.scala 160:17]
  wire  _T_3 = 2'h3 == digit; // @[\\src\\main\\scala\\Functions.scala 160:17]
  wire [4:0] _GEN_1 = 2'h3 == digit ? io_disp_content[19:15] : 5'h0; // @[\\src\\main\\scala\\Functions.scala 159:14 160:17 164:26]
  wire [4:0] _GEN_2 = 2'h2 == digit ? io_disp_content[14:10] : _GEN_1; // @[\\src\\main\\scala\\Functions.scala 160:17 163:26]
  wire [4:0] _GEN_3 = 2'h1 == digit ? io_disp_content[9:5] : _GEN_2; // @[\\src\\main\\scala\\Functions.scala 160:17 162:26]
  wire [3:0] _currentDot_T = 4'h0 >> digit; // @[\\src\\main\\scala\\Functions.scala 171:27]
  wire  currentDot = _currentDot_T[0]; // @[\\src\\main\\scala\\Functions.scala 171:27]
  wire [7:0] fullSeg = {currentDot,decoder_io_out}; // @[\\src\\main\\scala\\Functions.scala 172:28]
  wire [3:0] _GEN_5 = _T_3 ? 4'h8 : 4'h1; // @[\\src\\main\\scala\\Functions.scala 175:17 179:22 174:27]
  wire [3:0] _GEN_6 = _T_2 ? 4'h4 : _GEN_5; // @[\\src\\main\\scala\\Functions.scala 175:17 178:22]
  wire [3:0] _GEN_7 = _T_1 ? 4'h2 : _GEN_6; // @[\\src\\main\\scala\\Functions.scala 175:17 177:22]
  wire [3:0] select = _T ? 4'h1 : _GEN_7; // @[\\src\\main\\scala\\Functions.scala 175:17 176:22]
  SevenSegDec decoder ( // @[\\src\\main\\scala\\Functions.scala 167:23]
    .io_in(decoder_io_in),
    .io_out(decoder_io_out)
  );
  assign io_seg = ~fullSeg; // @[\\src\\main\\scala\\Functions.scala 182:13]
  assign io_an = ~select; // @[\\src\\main\\scala\\Functions.scala 183:13]
  assign decoder_io_in = 2'h0 == digit ? io_disp_content[4:0] : _GEN_3; // @[\\src\\main\\scala\\Functions.scala 160:17 161:26]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 151:20]
      cnt <= 17'h0; // @[\\src\\main\\scala\\Functions.scala 151:20]
    end else if (cnt == 17'h1869f) begin // @[\\src\\main\\scala\\Functions.scala 152:13]
      cnt <= 17'h0;
    end else begin
      cnt <= _cnt_T_2;
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 155:22]
      digit <= 2'h0; // @[\\src\\main\\scala\\Functions.scala 155:22]
    end else if (_cnt_T) begin // @[\\src\\main\\scala\\Functions.scala 156:14]
      digit <= _digit_T_1; // @[\\src\\main\\scala\\Functions.scala 156:22]
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
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
`endif // RANDOMIZE_REG_INIT
  wire  rx_clock; // @[\\src\\main\\scala\\MotorDriver.scala 23:18]
  wire  rx_reset; // @[\\src\\main\\scala\\MotorDriver.scala 23:18]
  wire  rx_io_rx; // @[\\src\\main\\scala\\MotorDriver.scala 23:18]
  wire  rx_io_done; // @[\\src\\main\\scala\\MotorDriver.scala 23:18]
  wire [7:0] rx_io_data; // @[\\src\\main\\scala\\MotorDriver.scala 23:18]
  wire  tx_clock; // @[\\src\\main\\scala\\MotorDriver.scala 23:47]
  wire  tx_reset; // @[\\src\\main\\scala\\MotorDriver.scala 23:47]
  wire [7:0] tx_io_data; // @[\\src\\main\\scala\\MotorDriver.scala 23:47]
  wire  tx_io_start; // @[\\src\\main\\scala\\MotorDriver.scala 23:47]
  wire  tx_io_tx; // @[\\src\\main\\scala\\MotorDriver.scala 23:47]
  wire  tx_io_busy; // @[\\src\\main\\scala\\MotorDriver.scala 23:47]
  wire  pwm_gen_clock; // @[\\src\\main\\scala\\MotorDriver.scala 24:23]
  wire  pwm_gen_reset; // @[\\src\\main\\scala\\MotorDriver.scala 24:23]
  wire [9:0] pwm_gen_io_duty_cycle; // @[\\src\\main\\scala\\MotorDriver.scala 24:23]
  wire  pwm_gen_io_brake; // @[\\src\\main\\scala\\MotorDriver.scala 24:23]
  wire  pwm_gen_io_T1; // @[\\src\\main\\scala\\MotorDriver.scala 24:23]
  wire  pwm_gen_io_T2; // @[\\src\\main\\scala\\MotorDriver.scala 24:23]
  wire  pwm_gen_io_T3; // @[\\src\\main\\scala\\MotorDriver.scala 24:23]
  wire  pwm_gen_io_T4; // @[\\src\\main\\scala\\MotorDriver.scala 24:23]
  wire  pid_clock; // @[\\src\\main\\scala\\MotorDriver.scala 25:19]
  wire  pid_reset; // @[\\src\\main\\scala\\MotorDriver.scala 25:19]
  wire [31:0] pid_io_setPoint; // @[\\src\\main\\scala\\MotorDriver.scala 25:19]
  wire [31:0] pid_io_measuredVal; // @[\\src\\main\\scala\\MotorDriver.scala 25:19]
  wire  pid_io_resetBuffer; // @[\\src\\main\\scala\\MotorDriver.scala 25:19]
  wire [31:0] pid_io_controlOut; // @[\\src\\main\\scala\\MotorDriver.scala 25:19]
  wire  stuck_detector_clock; // @[\\src\\main\\scala\\MotorDriver.scala 26:30]
  wire  stuck_detector_reset; // @[\\src\\main\\scala\\MotorDriver.scala 26:30]
  wire  stuck_detector_io_externalOvercurrentInput; // @[\\src\\main\\scala\\MotorDriver.scala 26:30]
  wire  stuck_detector_io_clearShutdown; // @[\\src\\main\\scala\\MotorDriver.scala 26:30]
  wire  stuck_detector_io_motorDisable; // @[\\src\\main\\scala\\MotorDriver.scala 26:30]
  wire  disp_mux_clock; // @[\\src\\main\\scala\\MotorDriver.scala 27:24]
  wire  disp_mux_reset; // @[\\src\\main\\scala\\MotorDriver.scala 27:24]
  wire [19:0] disp_mux_io_disp_content; // @[\\src\\main\\scala\\MotorDriver.scala 27:24]
  wire [7:0] disp_mux_io_seg; // @[\\src\\main\\scala\\MotorDriver.scala 27:24]
  wire [3:0] disp_mux_io_an; // @[\\src\\main\\scala\\MotorDriver.scala 27:24]
  reg  pulse_A_sync_REG; // @[\\src\\main\\scala\\MotorDriver.scala 31:31]
  reg  pulse_A_sync; // @[\\src\\main\\scala\\MotorDriver.scala 31:23]
  reg [13:0] pulse_A_cnt; // @[\\src\\main\\scala\\MotorDriver.scala 32:23]
  reg  pulse_A; // @[\\src\\main\\scala\\MotorDriver.scala 33:23]
  wire [13:0] _pulse_A_cnt_T_1 = pulse_A_cnt + 14'h1; // @[\\src\\main\\scala\\MotorDriver.scala 35:29]
  reg  pulse_edge_REG; // @[\\src\\main\\scala\\MotorDriver.scala 39:39]
  wire  pulse_edge = pulse_A & ~pulse_edge_REG; // @[\\src\\main\\scala\\MotorDriver.scala 39:28]
  reg [31:0] turns; // @[\\src\\main\\scala\\MotorDriver.scala 42:22]
  wire  is_driving_fwd = pwm_gen_io_duty_cycle > 10'h21c; // @[\\src\\main\\scala\\MotorDriver.scala 44:47]
  wire  is_driving_back = pwm_gen_io_duty_cycle < 10'h1e4; // @[\\src\\main\\scala\\MotorDriver.scala 45:47]
  wire [31:0] _turns_T_2 = $signed(turns) + 32'sh1; // @[\\src\\main\\scala\\MotorDriver.scala 48:43]
  wire [31:0] _turns_T_5 = $signed(turns) - 32'sh1; // @[\\src\\main\\scala\\MotorDriver.scala 49:49]
  wire [31:0] _GEN_3 = is_driving_back ? $signed(_turns_T_5) : $signed(turns); // @[\\src\\main\\scala\\MotorDriver.scala 42:22 49:{32,40}]
  wire [63:0] current_pos_fp = $signed(turns) * 32'sh222; // @[\\src\\main\\scala\\MotorDriver.scala 56:49]
  wire [51:0] current_pos_cm = current_pos_fp[63:12]; // @[\\src\\main\\scala\\MotorDriver.scala 57:40]
  reg [31:0] target_pos_cm; // @[\\src\\main\\scala\\MotorDriver.scala 60:30]
  reg [9:0] manual_speed; // @[\\src\\main\\scala\\MotorDriver.scala 61:30]
  reg  control_mode; // @[\\src\\main\\scala\\MotorDriver.scala 62:30]
  reg  manual_brake; // @[\\src\\main\\scala\\MotorDriver.scala 63:30]
  reg  system_active; // @[\\src\\main\\scala\\MotorDriver.scala 64:30]
  reg [1:0] uartState; // @[\\src\\main\\scala\\MotorDriver.scala 72:26]
  reg [7:0] cmdByte; // @[\\src\\main\\scala\\MotorDriver.scala 72:58]
  wire [14:0] _target_pos_cm_T_1 = rx_io_data * 7'h64; // @[\\src\\main\\scala\\MotorDriver.scala 81:62]
  wire [9:0] _GEN_9 = 8'h4 == rx_io_data ? 10'h46 : manual_speed; // @[\\src\\main\\scala\\MotorDriver.scala 61:30 84:32 87:73]
  wire  _GEN_10 = 8'h4 == rx_io_data ? 1'h0 : 8'h5 == rx_io_data; // @[\\src\\main\\scala\\MotorDriver.scala 84:32 83:51]
  wire [9:0] _GEN_11 = 8'h3 == rx_io_data ? 10'h17c : _GEN_9; // @[\\src\\main\\scala\\MotorDriver.scala 84:32 87:38]
  wire  _GEN_12 = 8'h3 == rx_io_data ? 1'h0 : _GEN_10; // @[\\src\\main\\scala\\MotorDriver.scala 84:32 83:51]
  wire [9:0] _GEN_13 = 8'h2 == rx_io_data ? 10'h3b6 : _GEN_11; // @[\\src\\main\\scala\\MotorDriver.scala 84:32 86:73]
  wire  _GEN_14 = 8'h2 == rx_io_data ? 1'h0 : _GEN_12; // @[\\src\\main\\scala\\MotorDriver.scala 84:32 83:51]
  wire [9:0] _GEN_15 = 8'h1 == rx_io_data ? 10'h280 : _GEN_13; // @[\\src\\main\\scala\\MotorDriver.scala 84:32 86:38]
  wire  _GEN_16 = 8'h1 == rx_io_data ? 1'h0 : _GEN_14; // @[\\src\\main\\scala\\MotorDriver.scala 84:32 83:51]
  wire  _GEN_17 = 8'h0 == rx_io_data | _GEN_16; // @[\\src\\main\\scala\\MotorDriver.scala 84:32 85:38]
  wire [9:0] _GEN_18 = 8'h0 == rx_io_data ? 10'h200 : _GEN_15; // @[\\src\\main\\scala\\MotorDriver.scala 84:32 85:62]
  wire  _GEN_20 = 8'h2 == cmdByte ? 1'h0 : control_mode; // @[\\src\\main\\scala\\MotorDriver.scala 80:25 83:26 62:30]
  wire  _GEN_21 = 8'h2 == cmdByte ? _GEN_17 : manual_brake; // @[\\src\\main\\scala\\MotorDriver.scala 80:25 63:30]
  wire [9:0] _GEN_22 = 8'h2 == cmdByte ? _GEN_18 : manual_speed; // @[\\src\\main\\scala\\MotorDriver.scala 80:25 61:30]
  wire  _GEN_23 = 8'h2 == cmdByte ? 1'h0 : 8'hff == cmdByte; // @[\\src\\main\\scala\\MotorDriver.scala 80:25 73:31]
  wire [31:0] _GEN_24 = 8'h1 == cmdByte ? $signed({{17{_target_pos_cm_T_1[14]}},_target_pos_cm_T_1}) : $signed(
    target_pos_cm); // @[\\src\\main\\scala\\MotorDriver.scala 80:25 60:30 81:38]
  wire  _GEN_25 = 8'h1 == cmdByte | _GEN_20; // @[\\src\\main\\scala\\MotorDriver.scala 80:25 81:83]
  wire  _GEN_26 = 8'h1 == cmdByte ? 1'h0 : _GEN_21; // @[\\src\\main\\scala\\MotorDriver.scala 80:25 81:107]
  wire [9:0] _GEN_27 = 8'h1 == cmdByte ? manual_speed : _GEN_22; // @[\\src\\main\\scala\\MotorDriver.scala 80:25 61:30]
  wire  _GEN_28 = 8'h1 == cmdByte ? 1'h0 : _GEN_23; // @[\\src\\main\\scala\\MotorDriver.scala 80:25 73:31]
  wire  _GEN_29 = 2'h2 == uartState | system_active; // @[\\src\\main\\scala\\MotorDriver.scala 75:23 79:23 64:30]
  wire [31:0] _GEN_30 = 2'h2 == uartState ? $signed(_GEN_24) : $signed(target_pos_cm); // @[\\src\\main\\scala\\MotorDriver.scala 75:23 60:30]
  wire  _GEN_31 = 2'h2 == uartState ? _GEN_25 : control_mode; // @[\\src\\main\\scala\\MotorDriver.scala 75:23 62:30]
  wire  _GEN_32 = 2'h2 == uartState ? _GEN_26 : manual_brake; // @[\\src\\main\\scala\\MotorDriver.scala 75:23 63:30]
  wire [9:0] _GEN_33 = 2'h2 == uartState ? _GEN_27 : manual_speed; // @[\\src\\main\\scala\\MotorDriver.scala 75:23 61:30]
  wire [1:0] _GEN_35 = 2'h2 == uartState ? 2'h0 : uartState; // @[\\src\\main\\scala\\MotorDriver.scala 75:23 93:19 72:26]
  wire  _GEN_41 = 2'h1 == uartState ? manual_brake : _GEN_32; // @[\\src\\main\\scala\\MotorDriver.scala 75:23 63:30]
  wire  _GEN_43 = 2'h1 == uartState ? 1'h0 : 2'h2 == uartState & _GEN_28; // @[\\src\\main\\scala\\MotorDriver.scala 75:23 73:31]
  wire  _GEN_49 = 2'h0 == uartState ? manual_brake : _GEN_41; // @[\\src\\main\\scala\\MotorDriver.scala 75:23 63:30]
  wire  _GEN_51 = 2'h0 == uartState ? 1'h0 : _GEN_43; // @[\\src\\main\\scala\\MotorDriver.scala 75:23 73:31]
  wire  _GEN_57 = rx_io_done ? _GEN_49 : manual_brake; // @[\\src\\main\\scala\\MotorDriver.scala 74:20 63:30]
  wire  uart_reset = rx_io_done & _GEN_51; // @[\\src\\main\\scala\\MotorDriver.scala 74:20 73:31]
  wire [51:0] _GEN_90 = {{20{target_pos_cm[31]}},target_pos_cm}; // @[\\src\\main\\scala\\MotorDriver.scala 100:37]
  wire [51:0] _error_abs_T_3 = $signed(_GEN_90) - $signed(current_pos_cm); // @[\\src\\main\\scala\\MotorDriver.scala 100:69]
  wire [51:0] _error_abs_T_6 = $signed(current_pos_cm) - $signed(_GEN_90); // @[\\src\\main\\scala\\MotorDriver.scala 100:102]
  wire [51:0] error_abs = $signed(_GEN_90) > $signed(current_pos_cm) ? $signed(_error_abs_T_3) : $signed(_error_abs_T_6)
    ; // @[\\src\\main\\scala\\MotorDriver.scala 100:22]
  wire  near_target = control_mode & $signed(error_abs) == 52'sh0; // @[\\src\\main\\scala\\MotorDriver.scala 102:35]
  wire  _pid_io_resetBuffer_T_2 = ~system_active; // @[\\src\\main\\scala\\MotorDriver.scala 107:58]
  wire [31:0] _pid_duty_raw_T_3 = $signed(pid_io_controlOut) + 32'sh800; // @[\\src\\main\\scala\\MotorDriver.scala 110:61]
  wire [31:0] pid_duty_raw = {{2'd0}, _pid_duty_raw_T_3[31:2]}; // @[\\src\\main\\scala\\MotorDriver.scala 110:68]
  wire [9:0] _pid_duty_T_2 = pid_duty_raw > 32'h3ff ? 10'h3ff : pid_duty_raw[9:0]; // @[\\src\\main\\scala\\MotorDriver.scala 111:45]
  wire [9:0] pid_duty = near_target ? 10'h200 : _pid_duty_T_2; // @[\\src\\main\\scala\\MotorDriver.scala 111:21]
  wire  is_stopped = manual_brake | stuck_detector_io_motorDisable | _pid_io_resetBuffer_T_2 | near_target; // @[\\src\\main\\scala\\MotorDriver.scala 114:85]
  reg [23:0] txTimer; // @[\\src\\main\\scala\\MotorDriver.scala 126:24]
  reg [1:0] txState; // @[\\src\\main\\scala\\MotorDriver.scala 128:24]
  wire  _T_17 = ~tx_io_busy; // @[\\src\\main\\scala\\MotorDriver.scala 132:24]
  wire [7:0] _GEN_64 = ~tx_io_busy ? 8'hff : 8'h0; // @[\\src\\main\\scala\\MotorDriver.scala 129:14 132:{37,50}]
  wire [7:0] _GEN_67 = _T_17 ? current_pos_cm[15:8] : 8'h0; // @[\\src\\main\\scala\\MotorDriver.scala 129:14 133:{37,50}]
  wire [1:0] _GEN_69 = _T_17 ? 2'h2 : txState; // @[\\src\\main\\scala\\MotorDriver.scala 133:114 128:24 133:37]
  wire [7:0] _GEN_70 = _T_17 ? current_pos_cm[7:0] : 8'h0; // @[\\src\\main\\scala\\MotorDriver.scala 129:14 134:{37,50}]
  wire [1:0] _GEN_72 = _T_17 ? 2'h0 : txState; // @[\\src\\main\\scala\\MotorDriver.scala 134:113 128:24 134:37]
  wire [23:0] _GEN_73 = _T_17 ? 24'h0 : txTimer; // @[\\src\\main\\scala\\MotorDriver.scala 134:131 126:24 134:37]
  wire [7:0] _GEN_74 = 2'h2 == txState ? _GEN_70 : 8'h0; // @[\\src\\main\\scala\\MotorDriver.scala 129:14 131:21]
  wire  _GEN_75 = 2'h2 == txState & _T_17; // @[\\src\\main\\scala\\MotorDriver.scala 131:21 129:34]
  wire [1:0] _GEN_76 = 2'h2 == txState ? _GEN_72 : txState; // @[\\src\\main\\scala\\MotorDriver.scala 131:21 128:24]
  wire [23:0] _GEN_77 = 2'h2 == txState ? _GEN_73 : txTimer; // @[\\src\\main\\scala\\MotorDriver.scala 131:21 126:24]
  wire [7:0] _GEN_78 = 2'h1 == txState ? _GEN_67 : _GEN_74; // @[\\src\\main\\scala\\MotorDriver.scala 131:21]
  wire  _GEN_79 = 2'h1 == txState ? _T_17 : _GEN_75; // @[\\src\\main\\scala\\MotorDriver.scala 131:21]
  wire [7:0] _GEN_82 = 2'h0 == txState ? _GEN_64 : _GEN_78; // @[\\src\\main\\scala\\MotorDriver.scala 131:21]
  wire  _GEN_83 = 2'h0 == txState ? _T_17 : _GEN_79; // @[\\src\\main\\scala\\MotorDriver.scala 131:21]
  wire [23:0] _txTimer_T_1 = txTimer + 24'h1; // @[\\src\\main\\scala\\MotorDriver.scala 136:36]
  UartRx rx ( // @[\\src\\main\\scala\\MotorDriver.scala 23:18]
    .clock(rx_clock),
    .reset(rx_reset),
    .io_rx(rx_io_rx),
    .io_done(rx_io_done),
    .io_data(rx_io_data)
  );
  UartTx tx ( // @[\\src\\main\\scala\\MotorDriver.scala 23:47]
    .clock(tx_clock),
    .reset(tx_reset),
    .io_data(tx_io_data),
    .io_start(tx_io_start),
    .io_tx(tx_io_tx),
    .io_busy(tx_io_busy)
  );
  DCMotorPwm pwm_gen ( // @[\\src\\main\\scala\\MotorDriver.scala 24:23]
    .clock(pwm_gen_clock),
    .reset(pwm_gen_reset),
    .io_duty_cycle(pwm_gen_io_duty_cycle),
    .io_brake(pwm_gen_io_brake),
    .io_T1(pwm_gen_io_T1),
    .io_T2(pwm_gen_io_T2),
    .io_T3(pwm_gen_io_T3),
    .io_T4(pwm_gen_io_T4)
  );
  PIDController pid ( // @[\\src\\main\\scala\\MotorDriver.scala 25:19]
    .clock(pid_clock),
    .reset(pid_reset),
    .io_setPoint(pid_io_setPoint),
    .io_measuredVal(pid_io_measuredVal),
    .io_resetBuffer(pid_io_resetBuffer),
    .io_controlOut(pid_io_controlOut)
  );
  StuckDetector stuck_detector ( // @[\\src\\main\\scala\\MotorDriver.scala 26:30]
    .clock(stuck_detector_clock),
    .reset(stuck_detector_reset),
    .io_externalOvercurrentInput(stuck_detector_io_externalOvercurrentInput),
    .io_clearShutdown(stuck_detector_io_clearShutdown),
    .io_motorDisable(stuck_detector_io_motorDisable)
  );
  DisplayMultiplexer disp_mux ( // @[\\src\\main\\scala\\MotorDriver.scala 27:24]
    .clock(disp_mux_clock),
    .reset(disp_mux_reset),
    .io_disp_content(disp_mux_io_disp_content),
    .io_seg(disp_mux_io_seg),
    .io_an(disp_mux_io_an)
  );
  assign io_uart_tx = tx_io_tx; // @[\\src\\main\\scala\\MotorDriver.scala 137:14]
  assign io_T1 = _pid_io_resetBuffer_T_2 ? 1'h0 : pwm_gen_io_T1; // @[\\src\\main\\scala\\MotorDriver.scala 118:24 119:11 121:11]
  assign io_T2 = _pid_io_resetBuffer_T_2 | pwm_gen_io_T2; // @[\\src\\main\\scala\\MotorDriver.scala 118:24 119:47 121:35]
  assign io_T3 = _pid_io_resetBuffer_T_2 ? 1'h0 : pwm_gen_io_T3; // @[\\src\\main\\scala\\MotorDriver.scala 118:24 119:29 122:11]
  assign io_T4 = _pid_io_resetBuffer_T_2 | pwm_gen_io_T4; // @[\\src\\main\\scala\\MotorDriver.scala 118:24 119:64 122:35]
  assign io_seg = disp_mux_io_seg; // @[\\src\\main\\scala\\MotorDriver.scala 140:35]
  assign io_an = disp_mux_io_an; // @[\\src\\main\\scala\\MotorDriver.scala 140:9]
  assign rx_clock = clock;
  assign rx_reset = reset;
  assign rx_io_rx = io_uart_rx; // @[\\src\\main\\scala\\MotorDriver.scala 66:12]
  assign tx_clock = clock;
  assign tx_reset = reset;
  assign tx_io_data = txTimer >= 24'h2625a0 ? _GEN_82 : 8'h0; // @[\\src\\main\\scala\\MotorDriver.scala 129:14 130:30]
  assign tx_io_start = txTimer >= 24'h2625a0 & _GEN_83; // @[\\src\\main\\scala\\MotorDriver.scala 130:30 129:34]
  assign pwm_gen_clock = clock;
  assign pwm_gen_reset = reset;
  assign pwm_gen_io_duty_cycle = control_mode ? pid_duty : manual_speed; // @[\\src\\main\\scala\\MotorDriver.scala 113:31]
  assign pwm_gen_io_brake = manual_brake | stuck_detector_io_motorDisable | _pid_io_resetBuffer_T_2 | near_target; // @[\\src\\main\\scala\\MotorDriver.scala 114:85]
  assign pid_clock = clock;
  assign pid_reset = reset;
  assign pid_io_setPoint = target_pos_cm; // @[\\src\\main\\scala\\MotorDriver.scala 105:51]
  assign pid_io_measuredVal = current_pos_fp[31:0]; // @[\\src\\main\\scala\\MotorDriver.scala 106:22]
  assign pid_io_resetBuffer = ~control_mode | manual_brake | ~system_active | near_target; // @[\\src\\main\\scala\\MotorDriver.scala 107:73]
  assign stuck_detector_clock = clock;
  assign stuck_detector_reset = reset;
  assign stuck_detector_io_externalOvercurrentInput = io_over_current_pos | io_over_current_neg; // @[\\src\\main\\scala\\MotorDriver.scala 68:70]
  assign stuck_detector_io_clearShutdown = io_error_cleared | uart_reset; // @[\\src\\main\\scala\\MotorDriver.scala 97:55]
  assign disp_mux_clock = clock;
  assign disp_mux_reset = reset;
  assign disp_mux_io_disp_content = is_stopped ? 20'hdf2f8 : 20'h57797; // @[\\src\\main\\scala\\MotorDriver.scala 143:34]
  always @(posedge clock) begin
    pulse_A_sync_REG <= io_photo_diode_A; // @[\\src\\main\\scala\\MotorDriver.scala 31:31]
    pulse_A_sync <= pulse_A_sync_REG; // @[\\src\\main\\scala\\MotorDriver.scala 31:23]
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 32:23]
      pulse_A_cnt <= 14'h0; // @[\\src\\main\\scala\\MotorDriver.scala 32:23]
    end else if (pulse_A_sync == pulse_A) begin // @[\\src\\main\\scala\\MotorDriver.scala 34:24]
      pulse_A_cnt <= 14'h0; // @[\\src\\main\\scala\\MotorDriver.scala 34:30]
    end else begin
      pulse_A_cnt <= _pulse_A_cnt_T_1; // @[\\src\\main\\scala\\MotorDriver.scala 35:22]
    end
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 33:23]
      pulse_A <= 1'h0; // @[\\src\\main\\scala\\MotorDriver.scala 33:23]
    end else if (!(pulse_A_sync == pulse_A)) begin // @[\\src\\main\\scala\\MotorDriver.scala 34:24]
      if (pulse_A_cnt == 14'h2710) begin // @[\\src\\main\\scala\\MotorDriver.scala 35:58]
        pulse_A <= pulse_A_sync; // @[\\src\\main\\scala\\MotorDriver.scala 35:64]
      end
    end
    pulse_edge_REG <= pulse_A; // @[\\src\\main\\scala\\MotorDriver.scala 39:39]
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 42:22]
      turns <= 32'sh0; // @[\\src\\main\\scala\\MotorDriver.scala 42:22]
    end else if ($signed(turns) < 32'sh0) begin // @[\\src\\main\\scala\\MotorDriver.scala 52:21]
      turns <= 32'sh0; // @[\\src\\main\\scala\\MotorDriver.scala 52:29]
    end else if (pulse_edge) begin // @[\\src\\main\\scala\\MotorDriver.scala 47:20]
      if (is_driving_fwd) begin // @[\\src\\main\\scala\\MotorDriver.scala 48:26]
        turns <= _turns_T_2; // @[\\src\\main\\scala\\MotorDriver.scala 48:34]
      end else begin
        turns <= _GEN_3;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 60:30]
      target_pos_cm <= 32'sh0; // @[\\src\\main\\scala\\MotorDriver.scala 60:30]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\MotorDriver.scala 74:20]
      if (!(2'h0 == uartState)) begin // @[\\src\\main\\scala\\MotorDriver.scala 75:23]
        if (!(2'h1 == uartState)) begin // @[\\src\\main\\scala\\MotorDriver.scala 75:23]
          target_pos_cm <= _GEN_30;
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 61:30]
      manual_speed <= 10'h200; // @[\\src\\main\\scala\\MotorDriver.scala 61:30]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\MotorDriver.scala 74:20]
      if (!(2'h0 == uartState)) begin // @[\\src\\main\\scala\\MotorDriver.scala 75:23]
        if (!(2'h1 == uartState)) begin // @[\\src\\main\\scala\\MotorDriver.scala 75:23]
          manual_speed <= _GEN_33;
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 62:30]
      control_mode <= 1'h0; // @[\\src\\main\\scala\\MotorDriver.scala 62:30]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\MotorDriver.scala 74:20]
      if (!(2'h0 == uartState)) begin // @[\\src\\main\\scala\\MotorDriver.scala 75:23]
        if (!(2'h1 == uartState)) begin // @[\\src\\main\\scala\\MotorDriver.scala 75:23]
          control_mode <= _GEN_31;
        end
      end
    end
    manual_brake <= reset | _GEN_57; // @[\\src\\main\\scala\\MotorDriver.scala 63:{30,30}]
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 64:30]
      system_active <= 1'h0; // @[\\src\\main\\scala\\MotorDriver.scala 64:30]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\MotorDriver.scala 74:20]
      if (!(2'h0 == uartState)) begin // @[\\src\\main\\scala\\MotorDriver.scala 75:23]
        if (!(2'h1 == uartState)) begin // @[\\src\\main\\scala\\MotorDriver.scala 75:23]
          system_active <= _GEN_29;
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 72:26]
      uartState <= 2'h0; // @[\\src\\main\\scala\\MotorDriver.scala 72:26]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\MotorDriver.scala 74:20]
      if (2'h0 == uartState) begin // @[\\src\\main\\scala\\MotorDriver.scala 75:23]
        if (rx_io_data == 8'haa) begin // @[\\src\\main\\scala\\MotorDriver.scala 76:49]
          uartState <= 2'h1; // @[\\src\\main\\scala\\MotorDriver.scala 76:61]
        end
      end else if (2'h1 == uartState) begin // @[\\src\\main\\scala\\MotorDriver.scala 75:23]
        uartState <= 2'h2; // @[\\src\\main\\scala\\MotorDriver.scala 77:54]
      end else begin
        uartState <= _GEN_35;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 72:58]
      cmdByte <= 8'h0; // @[\\src\\main\\scala\\MotorDriver.scala 72:58]
    end else if (rx_io_done) begin // @[\\src\\main\\scala\\MotorDriver.scala 74:20]
      if (!(2'h0 == uartState)) begin // @[\\src\\main\\scala\\MotorDriver.scala 75:23]
        if (2'h1 == uartState) begin // @[\\src\\main\\scala\\MotorDriver.scala 75:23]
          cmdByte <= rx_io_data; // @[\\src\\main\\scala\\MotorDriver.scala 77:29]
        end
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 126:24]
      txTimer <= 24'h0; // @[\\src\\main\\scala\\MotorDriver.scala 126:24]
    end else if (txTimer >= 24'h2625a0) begin // @[\\src\\main\\scala\\MotorDriver.scala 130:30]
      if (!(2'h0 == txState)) begin // @[\\src\\main\\scala\\MotorDriver.scala 131:21]
        if (!(2'h1 == txState)) begin // @[\\src\\main\\scala\\MotorDriver.scala 131:21]
          txTimer <= _GEN_77;
        end
      end
    end else begin
      txTimer <= _txTimer_T_1; // @[\\src\\main\\scala\\MotorDriver.scala 136:25]
    end
    if (reset) begin // @[\\src\\main\\scala\\MotorDriver.scala 128:24]
      txState <= 2'h0; // @[\\src\\main\\scala\\MotorDriver.scala 128:24]
    end else if (txTimer >= 24'h2625a0) begin // @[\\src\\main\\scala\\MotorDriver.scala 130:30]
      if (2'h0 == txState) begin // @[\\src\\main\\scala\\MotorDriver.scala 131:21]
        if (~tx_io_busy) begin // @[\\src\\main\\scala\\MotorDriver.scala 132:37]
          txState <= 2'h1; // @[\\src\\main\\scala\\MotorDriver.scala 132:92]
        end
      end else if (2'h1 == txState) begin // @[\\src\\main\\scala\\MotorDriver.scala 131:21]
        txState <= _GEN_69;
      end else begin
        txState <= _GEN_76;
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
  pulse_A_sync_REG = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  pulse_A_sync = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  pulse_A_cnt = _RAND_2[13:0];
  _RAND_3 = {1{`RANDOM}};
  pulse_A = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  pulse_edge_REG = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  turns = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  target_pos_cm = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  manual_speed = _RAND_7[9:0];
  _RAND_8 = {1{`RANDOM}};
  control_mode = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  manual_brake = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  system_active = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  uartState = _RAND_11[1:0];
  _RAND_12 = {1{`RANDOM}};
  cmdByte = _RAND_12[7:0];
  _RAND_13 = {1{`RANDOM}};
  txTimer = _RAND_13[23:0];
  _RAND_14 = {1{`RANDOM}};
  txState = _RAND_14[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
