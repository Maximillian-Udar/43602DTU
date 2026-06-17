module UartTx(
  input        clock,
  input        reset,
  input  [7:0] io_data, // @[src/main/scala/Functions.scala 147:14]
  input        io_start, // @[src/main/scala/Functions.scala 147:14]
  output       io_tx, // @[src/main/scala/Functions.scala 147:14]
  output       io_busy // @[src/main/scala/Functions.scala 147:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [9:0] reg_; // @[src/main/scala/Functions.scala 154:20]
  reg [31:0] cnt; // @[src/main/scala/Functions.scala 155:20]
  reg [3:0] bits; // @[src/main/scala/Functions.scala 156:21]
  reg  state; // @[src/main/scala/Functions.scala 158:22]
  wire [9:0] _reg_T = {1'h1,io_data,1'h0}; // @[src/main/scala/Functions.scala 162:44]
  wire  _GEN_3 = io_start | state; // @[src/main/scala/Functions.scala 158:22 162:{32,96}]
  wire [9:0] _T_3 = 10'h364 - 10'h1; // @[src/main/scala/Functions.scala 163:38]
  wire [31:0] _GEN_18 = {{22'd0}, _T_3}; // @[src/main/scala/Functions.scala 163:26]
  wire [9:0] _reg_T_2 = {1'h1,reg_[9:1]}; // @[src/main/scala/Functions.scala 163:69]
  wire [3:0] _bits_T_1 = bits + 4'h1; // @[src/main/scala/Functions.scala 163:150]
  wire  _GEN_4 = bits == 4'h9 ? 1'h0 : state; // @[src/main/scala/Functions.scala 163:{106,114} 158:22]
  wire [3:0] _GEN_5 = bits == 4'h9 ? bits : _bits_T_1; // @[src/main/scala/Functions.scala 163:106 156:21 163:142]
  wire [31:0] _cnt_T_1 = cnt + 32'h1; // @[src/main/scala/Functions.scala 163:183]
  assign io_tx = reg_[0]; // @[src/main/scala/Functions.scala 159:15]
  assign io_busy = state; // @[src/main/scala/Functions.scala 160:20]
  always @(posedge clock) begin
    if (reset) begin // @[src/main/scala/Functions.scala 154:20]
      reg_ <= 10'h1; // @[src/main/scala/Functions.scala 154:20]
    end else if (~state) begin // @[src/main/scala/Functions.scala 161:17]
      if (io_start) begin // @[src/main/scala/Functions.scala 162:32]
        reg_ <= _reg_T; // @[src/main/scala/Functions.scala 162:38]
      end
    end else if (state) begin // @[src/main/scala/Functions.scala 161:17]
      if (cnt == _GEN_18) begin // @[src/main/scala/Functions.scala 163:45]
        reg_ <= _reg_T_2; // @[src/main/scala/Functions.scala 163:63]
      end
    end
    if (reset) begin // @[src/main/scala/Functions.scala 155:20]
      cnt <= 32'h0; // @[src/main/scala/Functions.scala 155:20]
    end else if (~state) begin // @[src/main/scala/Functions.scala 161:17]
      if (io_start) begin // @[src/main/scala/Functions.scala 162:32]
        cnt <= 32'h0; // @[src/main/scala/Functions.scala 162:82]
      end
    end else if (state) begin // @[src/main/scala/Functions.scala 161:17]
      if (cnt == _GEN_18) begin // @[src/main/scala/Functions.scala 163:45]
        cnt <= 32'h0; // @[src/main/scala/Functions.scala 163:51]
      end else begin
        cnt <= _cnt_T_1; // @[src/main/scala/Functions.scala 163:176]
      end
    end
    if (reset) begin // @[src/main/scala/Functions.scala 156:21]
      bits <= 4'h0; // @[src/main/scala/Functions.scala 156:21]
    end else if (~state) begin // @[src/main/scala/Functions.scala 161:17]
      if (io_start) begin // @[src/main/scala/Functions.scala 162:32]
        bits <= 4'h0; // @[src/main/scala/Functions.scala 162:70]
      end
    end else if (state) begin // @[src/main/scala/Functions.scala 161:17]
      if (cnt == _GEN_18) begin // @[src/main/scala/Functions.scala 163:45]
        bits <= _GEN_5;
      end
    end
    if (reset) begin // @[src/main/scala/Functions.scala 158:22]
      state <= 1'h0; // @[src/main/scala/Functions.scala 158:22]
    end else if (~state) begin // @[src/main/scala/Functions.scala 161:17]
      state <= _GEN_3;
    end else if (state) begin // @[src/main/scala/Functions.scala 161:17]
      if (cnt == _GEN_18) begin // @[src/main/scala/Functions.scala 163:45]
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
module SevenSegDec(
  input  [4:0] io_in, // @[src/main/scala/Functions.scala 236:14]
  output [6:0] io_out // @[src/main/scala/Functions.scala 236:14]
);
  wire [6:0] _io_out_T_33 = 5'h0 == io_in ? 7'h3f : 7'h0; // @[src/main/scala/Functions.scala 241:46]
  wire [6:0] _io_out_T_35 = 5'h1 == io_in ? 7'h6 : _io_out_T_33; // @[src/main/scala/Functions.scala 241:46]
  wire [6:0] _io_out_T_37 = 5'h2 == io_in ? 7'h5b : _io_out_T_35; // @[src/main/scala/Functions.scala 241:46]
  wire [6:0] _io_out_T_39 = 5'h3 == io_in ? 7'h4f : _io_out_T_37; // @[src/main/scala/Functions.scala 241:46]
  wire [6:0] _io_out_T_41 = 5'h4 == io_in ? 7'h66 : _io_out_T_39; // @[src/main/scala/Functions.scala 241:46]
  wire [6:0] _io_out_T_43 = 5'h5 == io_in ? 7'h6d : _io_out_T_41; // @[src/main/scala/Functions.scala 241:46]
  wire [6:0] _io_out_T_45 = 5'h6 == io_in ? 7'h7d : _io_out_T_43; // @[src/main/scala/Functions.scala 241:46]
  wire [6:0] _io_out_T_47 = 5'h7 == io_in ? 7'h7 : _io_out_T_45; // @[src/main/scala/Functions.scala 241:46]
  wire [6:0] _io_out_T_49 = 5'h8 == io_in ? 7'h7f : _io_out_T_47; // @[src/main/scala/Functions.scala 241:46]
  wire [6:0] _io_out_T_51 = 5'h9 == io_in ? 7'h6f : _io_out_T_49; // @[src/main/scala/Functions.scala 241:46]
  wire [6:0] _io_out_T_53 = 5'ha == io_in ? 7'h77 : _io_out_T_51; // @[src/main/scala/Functions.scala 241:46]
  wire [6:0] _io_out_T_55 = 5'hb == io_in ? 7'h7c : _io_out_T_53; // @[src/main/scala/Functions.scala 241:46]
  wire [6:0] _io_out_T_57 = 5'hc == io_in ? 7'h39 : _io_out_T_55; // @[src/main/scala/Functions.scala 241:46]
  wire [6:0] _io_out_T_59 = 5'hd == io_in ? 7'h5e : _io_out_T_57; // @[src/main/scala/Functions.scala 241:46]
  wire [6:0] _io_out_T_61 = 5'he == io_in ? 7'h79 : _io_out_T_59; // @[src/main/scala/Functions.scala 241:46]
  wire [6:0] _io_out_T_63 = 5'hf == io_in ? 7'h71 : _io_out_T_61; // @[src/main/scala/Functions.scala 241:46]
  wire [6:0] _io_out_T_65 = 5'h10 == io_in ? 7'h3c : _io_out_T_63; // @[src/main/scala/Functions.scala 241:46]
  wire [6:0] _io_out_T_67 = 5'h11 == io_in ? 7'h76 : _io_out_T_65; // @[src/main/scala/Functions.scala 241:46]
  wire [6:0] _io_out_T_69 = 5'h12 == io_in ? 7'h6 : _io_out_T_67; // @[src/main/scala/Functions.scala 241:46]
  wire [6:0] _io_out_T_71 = 5'h13 == io_in ? 7'hf : _io_out_T_69; // @[src/main/scala/Functions.scala 241:46]
  wire [6:0] _io_out_T_73 = 5'h14 == io_in ? 7'h38 : _io_out_T_71; // @[src/main/scala/Functions.scala 241:46]
  wire [6:0] _io_out_T_75 = 5'h15 == io_in ? 7'h38 : _io_out_T_73; // @[src/main/scala/Functions.scala 241:46]
  wire [6:0] _io_out_T_77 = 5'h16 == io_in ? 7'h70 : _io_out_T_75; // @[src/main/scala/Functions.scala 241:46]
  wire [6:0] _io_out_T_79 = 5'h17 == io_in ? 7'h3f : _io_out_T_77; // @[src/main/scala/Functions.scala 241:46]
  wire [6:0] _io_out_T_81 = 5'h18 == io_in ? 7'h73 : _io_out_T_79; // @[src/main/scala/Functions.scala 241:46]
  wire [6:0] _io_out_T_83 = 5'h19 == io_in ? 7'h67 : _io_out_T_81; // @[src/main/scala/Functions.scala 241:46]
  wire [6:0] _io_out_T_85 = 5'h1a == io_in ? 7'h31 : _io_out_T_83; // @[src/main/scala/Functions.scala 241:46]
  wire [6:0] _io_out_T_87 = 5'h1b == io_in ? 7'h6d : _io_out_T_85; // @[src/main/scala/Functions.scala 241:46]
  wire [6:0] _io_out_T_89 = 5'h1c == io_in ? 7'h78 : _io_out_T_87; // @[src/main/scala/Functions.scala 241:46]
  wire [6:0] _io_out_T_91 = 5'h1d == io_in ? 7'h3e : _io_out_T_89; // @[src/main/scala/Functions.scala 241:46]
  assign io_out = 5'h1e == io_in ? 7'h0 : _io_out_T_91; // @[src/main/scala/Functions.scala 241:46]
endmodule
module DisplayMultiplexer(
  input        clock,
  input        reset,
  output [7:0] io_seg, // @[src/main/scala/Functions.scala 188:14]
  output [3:0] io_an // @[src/main/scala/Functions.scala 188:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [4:0] decoder_io_in; // @[src/main/scala/Functions.scala 211:23]
  wire [6:0] decoder_io_out; // @[src/main/scala/Functions.scala 211:23]
  reg [16:0] cnt; // @[src/main/scala/Functions.scala 195:20]
  wire  _cnt_T = cnt == 17'h1869f; // @[src/main/scala/Functions.scala 196:18]
  wire [16:0] _cnt_T_2 = cnt + 17'h1; // @[src/main/scala/Functions.scala 196:54]
  reg [1:0] digit; // @[src/main/scala/Functions.scala 199:22]
  wire [1:0] _digit_T_1 = digit + 2'h1; // @[src/main/scala/Functions.scala 200:31]
  wire  _T = 2'h0 == digit; // @[src/main/scala/Functions.scala 204:17]
  wire  _T_1 = 2'h1 == digit; // @[src/main/scala/Functions.scala 204:17]
  wire  _T_2 = 2'h2 == digit; // @[src/main/scala/Functions.scala 204:17]
  wire  _T_3 = 2'h3 == digit; // @[src/main/scala/Functions.scala 204:17]
  wire [4:0] _GEN_1 = 2'h3 == digit ? 5'h1b : 5'h0; // @[src/main/scala/Functions.scala 203:14 204:17 208:26]
  wire [4:0] _GEN_2 = 2'h2 == digit ? 5'h1c : _GEN_1; // @[src/main/scala/Functions.scala 204:17 207:26]
  wire [4:0] _GEN_3 = 2'h1 == digit ? 5'h17 : _GEN_2; // @[src/main/scala/Functions.scala 204:17 206:26]
  wire [3:0] _currentDot_T = 4'h0 >> digit; // @[src/main/scala/Functions.scala 215:27]
  wire  currentDot = _currentDot_T[0]; // @[src/main/scala/Functions.scala 215:27]
  wire [7:0] fullSeg = {currentDot,decoder_io_out}; // @[src/main/scala/Functions.scala 216:28]
  wire [3:0] _GEN_5 = _T_3 ? 4'h8 : 4'h1; // @[src/main/scala/Functions.scala 219:17 223:22 218:27]
  wire [3:0] _GEN_6 = _T_2 ? 4'h4 : _GEN_5; // @[src/main/scala/Functions.scala 219:17 222:22]
  wire [3:0] _GEN_7 = _T_1 ? 4'h2 : _GEN_6; // @[src/main/scala/Functions.scala 219:17 221:22]
  wire [3:0] select = _T ? 4'h1 : _GEN_7; // @[src/main/scala/Functions.scala 219:17 220:22]
  SevenSegDec decoder ( // @[src/main/scala/Functions.scala 211:23]
    .io_in(decoder_io_in),
    .io_out(decoder_io_out)
  );
  assign io_seg = ~fullSeg; // @[src/main/scala/Functions.scala 226:13]
  assign io_an = ~select; // @[src/main/scala/Functions.scala 227:13]
  assign decoder_io_in = 2'h0 == digit ? 5'h18 : _GEN_3; // @[src/main/scala/Functions.scala 204:17 205:26]
  always @(posedge clock) begin
    if (reset) begin // @[src/main/scala/Functions.scala 195:20]
      cnt <= 17'h0; // @[src/main/scala/Functions.scala 195:20]
    end else if (cnt == 17'h1869f) begin // @[src/main/scala/Functions.scala 196:13]
      cnt <= 17'h0;
    end else begin
      cnt <= _cnt_T_2;
    end
    if (reset) begin // @[src/main/scala/Functions.scala 199:22]
      digit <= 2'h0; // @[src/main/scala/Functions.scala 199:22]
    end else if (_cnt_T) begin // @[src/main/scala/Functions.scala 200:14]
      digit <= _digit_T_1; // @[src/main/scala/Functions.scala 200:22]
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
  reg  aSync_REG; // @[src/main/scala/Functions.scala 12:31]
  reg  aSync; // @[src/main/scala/Functions.scala 12:23]
  reg  bSync_REG; // @[src/main/scala/Functions.scala 13:31]
  reg  bSync; // @[src/main/scala/Functions.scala 13:23]
  reg  aReg; // @[src/main/scala/Functions.scala 14:23]
  reg [31:0] turns; // @[src/main/scala/Functions.scala 15:23]
  wire  edge_A = aSync & ~aReg; // @[src/main/scala/Functions.scala 17:22]
  wire [31:0] _turns_T_1 = turns + 32'h1; // @[src/main/scala/Functions.scala 21:22]
  wire [31:0] _turns_T_3 = turns - 32'h1; // @[src/main/scala/Functions.scala 24:24]
  assign io_turns = turns; // @[src/main/scala/Functions.scala 28:12]
  always @(posedge clock) begin
    aSync_REG <= io_signal_A; // @[src/main/scala/Functions.scala 12:31]
    aSync <= aSync_REG; // @[src/main/scala/Functions.scala 12:23]
    bSync_REG <= io_signal_B; // @[src/main/scala/Functions.scala 13:31]
    bSync <= bSync_REG; // @[src/main/scala/Functions.scala 13:23]
    aReg <= aSync; // @[src/main/scala/Functions.scala 14:23]
    if (reset) begin // @[src/main/scala/Functions.scala 15:23]
      turns <= 32'h0; // @[src/main/scala/Functions.scala 15:23]
    end else if (edge_A) begin // @[src/main/scala/Functions.scala 19:16]
      if (~bSync) begin // @[src/main/scala/Functions.scala 20:18]
        turns <= _turns_T_1; // @[src/main/scala/Functions.scala 21:13]
      end else if (turns > 32'h0) begin // @[src/main/scala/Functions.scala 23:25]
        turns <= _turns_T_3; // @[src/main/scala/Functions.scala 24:15]
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
`endif // RANDOMIZE_REG_INIT
  wire  tx_clock; // @[src/main/scala/SecondDriver.scala 30:18]
  wire  tx_reset; // @[src/main/scala/SecondDriver.scala 30:18]
  wire [7:0] tx_io_data; // @[src/main/scala/SecondDriver.scala 30:18]
  wire  tx_io_start; // @[src/main/scala/SecondDriver.scala 30:18]
  wire  tx_io_tx; // @[src/main/scala/SecondDriver.scala 30:18]
  wire  tx_io_busy; // @[src/main/scala/SecondDriver.scala 30:18]
  wire  display_clock; // @[src/main/scala/SecondDriver.scala 34:23]
  wire  display_reset; // @[src/main/scala/SecondDriver.scala 34:23]
  wire [7:0] display_io_seg; // @[src/main/scala/SecondDriver.scala 34:23]
  wire [3:0] display_io_an; // @[src/main/scala/SecondDriver.scala 34:23]
  wire  rotations_clock; // @[src/main/scala/SecondDriver.scala 35:25]
  wire  rotations_reset; // @[src/main/scala/SecondDriver.scala 35:25]
  wire  rotations_io_signal_A; // @[src/main/scala/SecondDriver.scala 35:25]
  wire  rotations_io_signal_B; // @[src/main/scala/SecondDriver.scala 35:25]
  wire [31:0] rotations_io_turns; // @[src/main/scala/SecondDriver.scala 35:25]
  reg  rotations_io_signal_A_sync_REG; // @[src/main/scala/SecondDriver.scala 40:31]
  reg  rotations_io_signal_A_sync; // @[src/main/scala/SecondDriver.scala 40:23]
  reg [13:0] rotations_io_signal_A_cnt; // @[src/main/scala/SecondDriver.scala 41:23]
  reg  rotations_io_signal_A_out; // @[src/main/scala/SecondDriver.scala 42:23]
  wire [13:0] _rotations_io_signal_A_cnt_T_1 = rotations_io_signal_A_cnt + 14'h1; // @[src/main/scala/SecondDriver.scala 44:29]
  reg  rotations_io_signal_B_sync_REG; // @[src/main/scala/SecondDriver.scala 40:31]
  reg  rotations_io_signal_B_sync; // @[src/main/scala/SecondDriver.scala 40:23]
  reg [13:0] rotations_io_signal_B_cnt; // @[src/main/scala/SecondDriver.scala 41:23]
  reg  rotations_io_signal_B_out; // @[src/main/scala/SecondDriver.scala 42:23]
  wire [13:0] _rotations_io_signal_B_cnt_T_1 = rotations_io_signal_B_cnt + 14'h1; // @[src/main/scala/SecondDriver.scala 44:29]
  wire [63:0] current_position_fixed_point = $signed(rotations_io_turns) * 32'sh222; // @[src/main/scala/SecondDriver.scala 67:76]
  wire [51:0] current_position_cm = current_position_fixed_point[63:12]; // @[src/main/scala/SecondDriver.scala 68:59]
  reg [23:0] txTimer; // @[src/main/scala/SecondDriver.scala 141:24]
  reg [1:0] txState; // @[src/main/scala/SecondDriver.scala 143:24]
  wire  _T_16 = ~tx_io_busy; // @[src/main/scala/SecondDriver.scala 149:14]
  wire [7:0] _GEN_60 = ~tx_io_busy ? 8'hff : 8'h0; // @[src/main/scala/SecondDriver.scala 144:14 149:27 150:22]
  wire [7:0] _GEN_63 = _T_16 ? current_position_cm[15:8] : 8'h0; // @[src/main/scala/SecondDriver.scala 144:14 155:27 156:22]
  wire [1:0] _GEN_65 = _T_16 ? 2'h0 : txState; // @[src/main/scala/SecondDriver.scala 155:27 158:19 143:24]
  wire [23:0] _GEN_66 = _T_16 ? 24'h0 : txTimer; // @[src/main/scala/SecondDriver.scala 155:27 159:19 141:24]
  wire [7:0] _GEN_67 = _T_16 ? current_position_cm[7:0] : 8'h0; // @[src/main/scala/SecondDriver.scala 144:14 162:27 163:22]
  wire [7:0] _GEN_71 = 2'h2 == txState ? _GEN_67 : 8'h0; // @[src/main/scala/SecondDriver.scala 144:14 147:21]
  wire  _GEN_72 = 2'h2 == txState & _T_16; // @[src/main/scala/SecondDriver.scala 145:15 147:21]
  wire [1:0] _GEN_73 = 2'h2 == txState ? _GEN_65 : txState; // @[src/main/scala/SecondDriver.scala 147:21 143:24]
  wire [23:0] _GEN_74 = 2'h2 == txState ? _GEN_66 : txTimer; // @[src/main/scala/SecondDriver.scala 147:21 141:24]
  wire [7:0] _GEN_75 = 2'h1 == txState ? _GEN_63 : _GEN_71; // @[src/main/scala/SecondDriver.scala 147:21]
  wire  _GEN_76 = 2'h1 == txState ? _T_16 : _GEN_72; // @[src/main/scala/SecondDriver.scala 147:21]
  wire [7:0] _GEN_79 = 2'h0 == txState ? _GEN_60 : _GEN_75; // @[src/main/scala/SecondDriver.scala 147:21]
  wire  _GEN_80 = 2'h0 == txState ? _T_16 : _GEN_76; // @[src/main/scala/SecondDriver.scala 147:21]
  wire [23:0] _txTimer_T_1 = txTimer + 24'h1; // @[src/main/scala/SecondDriver.scala 170:36]
  UartTx tx ( // @[src/main/scala/SecondDriver.scala 30:18]
    .clock(tx_clock),
    .reset(tx_reset),
    .io_data(tx_io_data),
    .io_start(tx_io_start),
    .io_tx(tx_io_tx),
    .io_busy(tx_io_busy)
  );
  DisplayMultiplexer display ( // @[src/main/scala/SecondDriver.scala 34:23]
    .clock(display_clock),
    .reset(display_reset),
    .io_seg(display_io_seg),
    .io_an(display_io_an)
  );
  RotationCounter rotations ( // @[src/main/scala/SecondDriver.scala 35:25]
    .clock(rotations_clock),
    .reset(rotations_reset),
    .io_signal_A(rotations_io_signal_A),
    .io_signal_B(rotations_io_signal_B),
    .io_turns(rotations_io_turns)
  );
  assign io_uart_tx = tx_io_tx; // @[src/main/scala/SecondDriver.scala 171:14]
  assign io_T1 = 1'h0; // @[src/main/scala/SecondDriver.scala 128:25 129:11 134:11]
  assign io_T2 = 1'h1; // @[src/main/scala/SecondDriver.scala 128:25 130:11 135:11]
  assign io_T3 = 1'h0; // @[src/main/scala/SecondDriver.scala 128:25 131:11 136:11]
  assign io_T4 = 1'h1; // @[src/main/scala/SecondDriver.scala 128:25 132:11 137:11]
  assign io_seg = display_io_seg; // @[src/main/scala/SecondDriver.scala 175:10]
  assign io_an = display_io_an; // @[src/main/scala/SecondDriver.scala 174:9]
  assign tx_clock = clock;
  assign tx_reset = reset;
  assign tx_io_data = txTimer >= 24'h2625a0 ? _GEN_79 : 8'h0; // @[src/main/scala/SecondDriver.scala 144:14 146:30]
  assign tx_io_start = txTimer >= 24'h2625a0 & _GEN_80; // @[src/main/scala/SecondDriver.scala 145:15 146:30]
  assign display_clock = clock;
  assign display_reset = reset;
  assign rotations_clock = clock;
  assign rotations_reset = reset;
  assign rotations_io_signal_A = rotations_io_signal_A_out; // @[src/main/scala/SecondDriver.scala 50:25]
  assign rotations_io_signal_B = rotations_io_signal_B_out; // @[src/main/scala/SecondDriver.scala 51:25]
  always @(posedge clock) begin
    rotations_io_signal_A_sync_REG <= io_photo_sensor_A; // @[src/main/scala/SecondDriver.scala 40:31]
    rotations_io_signal_A_sync <= rotations_io_signal_A_sync_REG; // @[src/main/scala/SecondDriver.scala 40:23]
    if (reset) begin // @[src/main/scala/SecondDriver.scala 41:23]
      rotations_io_signal_A_cnt <= 14'h0; // @[src/main/scala/SecondDriver.scala 41:23]
    end else if (rotations_io_signal_A_sync == rotations_io_signal_A_out) begin // @[src/main/scala/SecondDriver.scala 43:24]
      rotations_io_signal_A_cnt <= 14'h0; // @[src/main/scala/SecondDriver.scala 43:30]
    end else begin
      rotations_io_signal_A_cnt <= _rotations_io_signal_A_cnt_T_1; // @[src/main/scala/SecondDriver.scala 44:22]
    end
    if (reset) begin // @[src/main/scala/SecondDriver.scala 42:23]
      rotations_io_signal_A_out <= 1'h0; // @[src/main/scala/SecondDriver.scala 42:23]
    end else if (!(rotations_io_signal_A_sync == rotations_io_signal_A_out)) begin // @[src/main/scala/SecondDriver.scala 43:24]
      if (rotations_io_signal_A_cnt == 14'h2710) begin // @[src/main/scala/SecondDriver.scala 44:58]
        rotations_io_signal_A_out <= rotations_io_signal_A_sync; // @[src/main/scala/SecondDriver.scala 44:64]
      end
    end
    rotations_io_signal_B_sync_REG <= io_photo_sensor_B; // @[src/main/scala/SecondDriver.scala 40:31]
    rotations_io_signal_B_sync <= rotations_io_signal_B_sync_REG; // @[src/main/scala/SecondDriver.scala 40:23]
    if (reset) begin // @[src/main/scala/SecondDriver.scala 41:23]
      rotations_io_signal_B_cnt <= 14'h0; // @[src/main/scala/SecondDriver.scala 41:23]
    end else if (rotations_io_signal_B_sync == rotations_io_signal_B_out) begin // @[src/main/scala/SecondDriver.scala 43:24]
      rotations_io_signal_B_cnt <= 14'h0; // @[src/main/scala/SecondDriver.scala 43:30]
    end else begin
      rotations_io_signal_B_cnt <= _rotations_io_signal_B_cnt_T_1; // @[src/main/scala/SecondDriver.scala 44:22]
    end
    if (reset) begin // @[src/main/scala/SecondDriver.scala 42:23]
      rotations_io_signal_B_out <= 1'h0; // @[src/main/scala/SecondDriver.scala 42:23]
    end else if (!(rotations_io_signal_B_sync == rotations_io_signal_B_out)) begin // @[src/main/scala/SecondDriver.scala 43:24]
      if (rotations_io_signal_B_cnt == 14'h2710) begin // @[src/main/scala/SecondDriver.scala 44:58]
        rotations_io_signal_B_out <= rotations_io_signal_B_sync; // @[src/main/scala/SecondDriver.scala 44:64]
      end
    end
    if (reset) begin // @[src/main/scala/SecondDriver.scala 141:24]
      txTimer <= 24'h0; // @[src/main/scala/SecondDriver.scala 141:24]
    end else if (txTimer >= 24'h2625a0) begin // @[src/main/scala/SecondDriver.scala 146:30]
      if (!(2'h0 == txState)) begin // @[src/main/scala/SecondDriver.scala 147:21]
        if (2'h1 == txState) begin // @[src/main/scala/SecondDriver.scala 147:21]
          txTimer <= _GEN_66;
        end else begin
          txTimer <= _GEN_74;
        end
      end
    end else begin
      txTimer <= _txTimer_T_1; // @[src/main/scala/SecondDriver.scala 170:25]
    end
    if (reset) begin // @[src/main/scala/SecondDriver.scala 143:24]
      txState <= 2'h0; // @[src/main/scala/SecondDriver.scala 143:24]
    end else if (txTimer >= 24'h2625a0) begin // @[src/main/scala/SecondDriver.scala 146:30]
      if (2'h0 == txState) begin // @[src/main/scala/SecondDriver.scala 147:21]
        if (~tx_io_busy) begin // @[src/main/scala/SecondDriver.scala 149:27]
          txState <= 2'h1; // @[src/main/scala/SecondDriver.scala 152:19]
        end
      end else if (2'h1 == txState) begin // @[src/main/scala/SecondDriver.scala 147:21]
        txState <= _GEN_65;
      end else begin
        txState <= _GEN_73;
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
  rotations_io_signal_A_sync_REG = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  rotations_io_signal_A_sync = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  rotations_io_signal_A_cnt = _RAND_2[13:0];
  _RAND_3 = {1{`RANDOM}};
  rotations_io_signal_A_out = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  rotations_io_signal_B_sync_REG = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  rotations_io_signal_B_sync = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  rotations_io_signal_B_cnt = _RAND_6[13:0];
  _RAND_7 = {1{`RANDOM}};
  rotations_io_signal_B_out = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  txTimer = _RAND_8[23:0];
  _RAND_9 = {1{`RANDOM}};
  txState = _RAND_9[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
