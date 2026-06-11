module BCD(
  input  [5:0] io_b_number, // @[\\src\\main\\scala\\BCD.scala 5:14]
  output [7:0] io_out // @[\\src\\main\\scala\\BCD.scala 5:14]
);
  wire [5:0] tens = io_b_number / 4'ha; // @[\\src\\main\\scala\\BCD.scala 9:26]
  wire [5:0] _GEN_0 = io_b_number % 6'ha; // @[\\src\\main\\scala\\BCD.scala 10:26]
  wire [3:0] ones = _GEN_0[3:0]; // @[\\src\\main\\scala\\BCD.scala 10:26]
  assign io_out = {tens[3:0],ones}; // @[\\src\\main\\scala\\BCD.scala 11:16]
endmodule
module SevenSegDec(
  input  [4:0] io_in, // @[\\src\\main\\scala\\DispMux.scala 56:14]
  output [6:0] io_out // @[\\src\\main\\scala\\DispMux.scala 56:14]
);
  wire [6:0] _io_out_T_32 = 5'h0 == io_in ? 7'h3f : 7'h0; // @[\\src\\main\\scala\\DispMux.scala 61:39]
  wire [6:0] _io_out_T_34 = 5'h1 == io_in ? 7'h6 : _io_out_T_32; // @[\\src\\main\\scala\\DispMux.scala 61:39]
  wire [6:0] _io_out_T_36 = 5'h2 == io_in ? 7'h5b : _io_out_T_34; // @[\\src\\main\\scala\\DispMux.scala 61:39]
  wire [6:0] _io_out_T_38 = 5'h3 == io_in ? 7'h4f : _io_out_T_36; // @[\\src\\main\\scala\\DispMux.scala 61:39]
  wire [6:0] _io_out_T_40 = 5'h4 == io_in ? 7'h66 : _io_out_T_38; // @[\\src\\main\\scala\\DispMux.scala 61:39]
  wire [6:0] _io_out_T_42 = 5'h5 == io_in ? 7'h6d : _io_out_T_40; // @[\\src\\main\\scala\\DispMux.scala 61:39]
  wire [6:0] _io_out_T_44 = 5'h6 == io_in ? 7'h7d : _io_out_T_42; // @[\\src\\main\\scala\\DispMux.scala 61:39]
  wire [6:0] _io_out_T_46 = 5'h7 == io_in ? 7'h7 : _io_out_T_44; // @[\\src\\main\\scala\\DispMux.scala 61:39]
  wire [6:0] _io_out_T_48 = 5'h8 == io_in ? 7'h7f : _io_out_T_46; // @[\\src\\main\\scala\\DispMux.scala 61:39]
  wire [6:0] _io_out_T_50 = 5'h9 == io_in ? 7'h6f : _io_out_T_48; // @[\\src\\main\\scala\\DispMux.scala 61:39]
  wire [6:0] _io_out_T_52 = 5'ha == io_in ? 7'h77 : _io_out_T_50; // @[\\src\\main\\scala\\DispMux.scala 61:39]
  wire [6:0] _io_out_T_54 = 5'hb == io_in ? 7'h7c : _io_out_T_52; // @[\\src\\main\\scala\\DispMux.scala 61:39]
  wire [6:0] _io_out_T_56 = 5'hc == io_in ? 7'h39 : _io_out_T_54; // @[\\src\\main\\scala\\DispMux.scala 61:39]
  wire [6:0] _io_out_T_58 = 5'hd == io_in ? 7'h5e : _io_out_T_56; // @[\\src\\main\\scala\\DispMux.scala 61:39]
  wire [6:0] _io_out_T_60 = 5'he == io_in ? 7'h79 : _io_out_T_58; // @[\\src\\main\\scala\\DispMux.scala 61:39]
  wire [6:0] _io_out_T_62 = 5'hf == io_in ? 7'h71 : _io_out_T_60; // @[\\src\\main\\scala\\DispMux.scala 61:39]
  wire [6:0] _io_out_T_64 = 5'h10 == io_in ? 7'h3c : _io_out_T_62; // @[\\src\\main\\scala\\DispMux.scala 61:39]
  wire [6:0] _io_out_T_66 = 5'h11 == io_in ? 7'h76 : _io_out_T_64; // @[\\src\\main\\scala\\DispMux.scala 61:39]
  wire [6:0] _io_out_T_68 = 5'h12 == io_in ? 7'h6 : _io_out_T_66; // @[\\src\\main\\scala\\DispMux.scala 61:39]
  wire [6:0] _io_out_T_70 = 5'h13 == io_in ? 7'hf : _io_out_T_68; // @[\\src\\main\\scala\\DispMux.scala 61:39]
  wire [6:0] _io_out_T_72 = 5'h14 == io_in ? 7'h38 : _io_out_T_70; // @[\\src\\main\\scala\\DispMux.scala 61:39]
  wire [6:0] _io_out_T_74 = 5'h15 == io_in ? 7'h70 : _io_out_T_72; // @[\\src\\main\\scala\\DispMux.scala 61:39]
  wire [6:0] _io_out_T_76 = 5'h16 == io_in ? 7'h3f : _io_out_T_74; // @[\\src\\main\\scala\\DispMux.scala 61:39]
  wire [6:0] _io_out_T_78 = 5'h17 == io_in ? 7'h73 : _io_out_T_76; // @[\\src\\main\\scala\\DispMux.scala 61:39]
  wire [6:0] _io_out_T_80 = 5'h18 == io_in ? 7'h67 : _io_out_T_78; // @[\\src\\main\\scala\\DispMux.scala 61:39]
  wire [6:0] _io_out_T_82 = 5'h19 == io_in ? 7'h31 : _io_out_T_80; // @[\\src\\main\\scala\\DispMux.scala 61:39]
  wire [6:0] _io_out_T_84 = 5'h1a == io_in ? 7'h6d : _io_out_T_82; // @[\\src\\main\\scala\\DispMux.scala 61:39]
  wire [6:0] _io_out_T_86 = 5'h1b == io_in ? 7'h78 : _io_out_T_84; // @[\\src\\main\\scala\\DispMux.scala 61:39]
  wire [6:0] _io_out_T_88 = 5'h1c == io_in ? 7'h3f : _io_out_T_86; // @[\\src\\main\\scala\\DispMux.scala 61:39]
  assign io_out = 5'h1d == io_in ? 7'h0 : _io_out_T_88; // @[\\src\\main\\scala\\DispMux.scala 61:39]
endmodule
module DisplayMultiplexer(
  input         clock,
  input         reset,
  input  [19:0] io_disp_content, // @[\\src\\main\\scala\\DispMux.scala 6:14]
  output [7:0]  io_seg, // @[\\src\\main\\scala\\DispMux.scala 6:14]
  output [3:0]  io_an // @[\\src\\main\\scala\\DispMux.scala 6:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [4:0] decoder_io_in; // @[\\src\\main\\scala\\DispMux.scala 35:23]
  wire [6:0] decoder_io_out; // @[\\src\\main\\scala\\DispMux.scala 35:23]
  reg [16:0] cnt; // @[\\src\\main\\scala\\DispMux.scala 17:20]
  wire  _cnt_T = cnt == 17'h1869f; // @[\\src\\main\\scala\\DispMux.scala 18:18]
  wire [16:0] _cnt_T_2 = cnt + 17'h1; // @[\\src\\main\\scala\\DispMux.scala 18:54]
  reg [1:0] digit; // @[\\src\\main\\scala\\DispMux.scala 21:22]
  wire [1:0] _digit_T_1 = digit + 2'h1; // @[\\src\\main\\scala\\DispMux.scala 23:20]
  wire  _T = 2'h0 == digit; // @[\\src\\main\\scala\\DispMux.scala 28:17]
  wire  _T_1 = 2'h1 == digit; // @[\\src\\main\\scala\\DispMux.scala 28:17]
  wire  _T_2 = 2'h2 == digit; // @[\\src\\main\\scala\\DispMux.scala 28:17]
  wire  _T_3 = 2'h3 == digit; // @[\\src\\main\\scala\\DispMux.scala 28:17]
  wire [4:0] _GEN_1 = 2'h3 == digit ? io_disp_content[19:15] : 5'h0; // @[\\src\\main\\scala\\DispMux.scala 27:14 28:17 32:26]
  wire [4:0] _GEN_2 = 2'h2 == digit ? io_disp_content[14:10] : _GEN_1; // @[\\src\\main\\scala\\DispMux.scala 28:17 31:26]
  wire [4:0] _GEN_3 = 2'h1 == digit ? io_disp_content[9:5] : _GEN_2; // @[\\src\\main\\scala\\DispMux.scala 28:17 30:26]
  wire [3:0] _currentDot_T = 4'h0 >> digit; // @[\\src\\main\\scala\\DispMux.scala 36:27]
  wire  currentDot = _currentDot_T[0]; // @[\\src\\main\\scala\\DispMux.scala 36:27]
  wire [6:0] sevSeg = decoder_io_out; // @[\\src\\main\\scala\\DispMux.scala 13:27 38:10]
  wire [7:0] fullSeg = {currentDot,sevSeg}; // @[\\src\\main\\scala\\DispMux.scala 39:28]
  wire [3:0] _GEN_5 = _T_3 ? 4'h8 : 4'h1; // @[\\src\\main\\scala\\DispMux.scala 44:17 48:22 14:27]
  wire [3:0] _GEN_6 = _T_2 ? 4'h4 : _GEN_5; // @[\\src\\main\\scala\\DispMux.scala 44:17 47:22]
  wire [3:0] _GEN_7 = _T_1 ? 4'h2 : _GEN_6; // @[\\src\\main\\scala\\DispMux.scala 44:17 46:22]
  wire [3:0] select = _T ? 4'h1 : _GEN_7; // @[\\src\\main\\scala\\DispMux.scala 44:17 45:22]
  SevenSegDec decoder ( // @[\\src\\main\\scala\\DispMux.scala 35:23]
    .io_in(decoder_io_in),
    .io_out(decoder_io_out)
  );
  assign io_seg = ~fullSeg; // @[\\src\\main\\scala\\DispMux.scala 51:13]
  assign io_an = ~select; // @[\\src\\main\\scala\\DispMux.scala 52:13]
  assign decoder_io_in = 2'h0 == digit ? io_disp_content[4:0] : _GEN_3; // @[\\src\\main\\scala\\DispMux.scala 28:17 29:26]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\DispMux.scala 17:20]
      cnt <= 17'h0; // @[\\src\\main\\scala\\DispMux.scala 17:20]
    end else if (cnt == 17'h1869f) begin // @[\\src\\main\\scala\\DispMux.scala 18:13]
      cnt <= 17'h0;
    end else begin
      cnt <= _cnt_T_2;
    end
    if (reset) begin // @[\\src\\main\\scala\\DispMux.scala 21:22]
      digit <= 2'h0; // @[\\src\\main\\scala\\DispMux.scala 21:22]
    end else if (_cnt_T) begin // @[\\src\\main\\scala\\DispMux.scala 22:14]
      digit <= _digit_T_1; // @[\\src\\main\\scala\\DispMux.scala 23:11]
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
module PositionSensor(
  input        clock,
  input        reset,
  input        io_signal_A, // @[\\src\\main\\scala\\PositionSensor.scala 5:14]
  input        io_signal_B, // @[\\src\\main\\scala\\PositionSensor.scala 5:14]
  output [7:0] io_seg, // @[\\src\\main\\scala\\PositionSensor.scala 5:14]
  output [3:0] io_an // @[\\src\\main\\scala\\PositionSensor.scala 5:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  wire [5:0] turns_BCD_io_b_number; // @[\\src\\main\\scala\\PositionSensor.scala 35:25]
  wire [7:0] turns_BCD_io_out; // @[\\src\\main\\scala\\PositionSensor.scala 35:25]
  wire  dispmux_clock; // @[\\src\\main\\scala\\PositionSensor.scala 38:23]
  wire  dispmux_reset; // @[\\src\\main\\scala\\PositionSensor.scala 38:23]
  wire [19:0] dispmux_io_disp_content; // @[\\src\\main\\scala\\PositionSensor.scala 38:23]
  wire [7:0] dispmux_io_seg; // @[\\src\\main\\scala\\PositionSensor.scala 38:23]
  wire [3:0] dispmux_io_an; // @[\\src\\main\\scala\\PositionSensor.scala 38:23]
  reg  aSync_REG; // @[\\src\\main\\scala\\PositionSensor.scala 15:30]
  reg  aSync; // @[\\src\\main\\scala\\PositionSensor.scala 15:22]
  reg  bSync_REG; // @[\\src\\main\\scala\\PositionSensor.scala 16:30]
  reg  bSync; // @[\\src\\main\\scala\\PositionSensor.scala 16:22]
  reg  aReg; // @[\\src\\main\\scala\\PositionSensor.scala 19:21]
  wire  rise_A = aSync & ~aReg; // @[\\src\\main\\scala\\PositionSensor.scala 20:22]
  reg [9:0] turns; // @[\\src\\main\\scala\\PositionSensor.scala 23:22]
  wire [9:0] _turns_T_1 = turns + 10'h1; // @[\\src\\main\\scala\\PositionSensor.scala 28:22]
  wire [9:0] _turns_T_3 = turns - 10'h1; // @[\\src\\main\\scala\\PositionSensor.scala 30:22]
  wire [9:0] dispmux_io_disp_content_lo = {1'h0,turns_BCD_io_out[7:4],1'h0,turns_BCD_io_out[3:0]}; // @[\\src\\main\\scala\\PositionSensor.scala 43:33]
  BCD turns_BCD ( // @[\\src\\main\\scala\\PositionSensor.scala 35:25]
    .io_b_number(turns_BCD_io_b_number),
    .io_out(turns_BCD_io_out)
  );
  DisplayMultiplexer dispmux ( // @[\\src\\main\\scala\\PositionSensor.scala 38:23]
    .clock(dispmux_clock),
    .reset(dispmux_reset),
    .io_disp_content(dispmux_io_disp_content),
    .io_seg(dispmux_io_seg),
    .io_an(dispmux_io_an)
  );
  assign io_seg = dispmux_io_seg; // @[\\src\\main\\scala\\PositionSensor.scala 50:10]
  assign io_an = dispmux_io_an; // @[\\src\\main\\scala\\PositionSensor.scala 51:9]
  assign turns_BCD_io_b_number = turns[5:0]; // @[\\src\\main\\scala\\PositionSensor.scala 36:25]
  assign dispmux_clock = clock;
  assign dispmux_reset = reset;
  assign dispmux_io_disp_content = {10'h3bd,dispmux_io_disp_content_lo}; // @[\\src\\main\\scala\\PositionSensor.scala 43:33]
  always @(posedge clock) begin
    aSync_REG <= io_signal_A; // @[\\src\\main\\scala\\PositionSensor.scala 15:30]
    aSync <= aSync_REG; // @[\\src\\main\\scala\\PositionSensor.scala 15:22]
    bSync_REG <= io_signal_B; // @[\\src\\main\\scala\\PositionSensor.scala 16:30]
    bSync <= bSync_REG; // @[\\src\\main\\scala\\PositionSensor.scala 16:22]
    aReg <= aSync; // @[\\src\\main\\scala\\PositionSensor.scala 19:21]
    if (reset) begin // @[\\src\\main\\scala\\PositionSensor.scala 23:22]
      turns <= 10'h0; // @[\\src\\main\\scala\\PositionSensor.scala 23:22]
    end else if (rise_A) begin // @[\\src\\main\\scala\\PositionSensor.scala 26:16]
      if (~bSync) begin // @[\\src\\main\\scala\\PositionSensor.scala 27:18]
        turns <= _turns_T_1; // @[\\src\\main\\scala\\PositionSensor.scala 28:13]
      end else begin
        turns <= _turns_T_3; // @[\\src\\main\\scala\\PositionSensor.scala 30:13]
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
  turns = _RAND_5[9:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
