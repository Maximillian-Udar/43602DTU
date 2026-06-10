module Debouncer(
  input   clock,
  input   reset,
  input   io_btn_in, // @[\\src\\main\\scala\\Debouncer.scala 4:14]
  output  io_out // @[\\src\\main\\scala\\Debouncer.scala 4:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg  btn_sync_REG; // @[\\src\\main\\scala\\Debouncer.scala 10:33]
  reg  btn_sync; // @[\\src\\main\\scala\\Debouncer.scala 10:25]
  reg  btnDebReg; // @[\\src\\main\\scala\\Debouncer.scala 11:26]
  reg [31:0] cntReg; // @[\\src\\main\\scala\\Debouncer.scala 12:23]
  wire  tick = cntReg == 32'h1869f; // @[\\src\\main\\scala\\Debouncer.scala 13:21]
  wire [31:0] _cntReg_T_1 = cntReg + 32'h1; // @[\\src\\main\\scala\\Debouncer.scala 16:20]
  reg  btnCleanPrev; // @[\\src\\main\\scala\\Debouncer.scala 22:29]
  assign io_out = btnDebReg & ~btnCleanPrev; // @[\\src\\main\\scala\\Debouncer.scala 23:23]
  always @(posedge clock) begin
    btn_sync_REG <= io_btn_in; // @[\\src\\main\\scala\\Debouncer.scala 10:33]
    btn_sync <= btn_sync_REG; // @[\\src\\main\\scala\\Debouncer.scala 10:25]
    if (reset) begin // @[\\src\\main\\scala\\Debouncer.scala 11:26]
      btnDebReg <= 1'h0; // @[\\src\\main\\scala\\Debouncer.scala 11:26]
    end else if (tick) begin // @[\\src\\main\\scala\\Debouncer.scala 17:15]
      btnDebReg <= btn_sync; // @[\\src\\main\\scala\\Debouncer.scala 19:15]
    end
    if (reset) begin // @[\\src\\main\\scala\\Debouncer.scala 12:23]
      cntReg <= 32'h0; // @[\\src\\main\\scala\\Debouncer.scala 12:23]
    end else if (tick) begin // @[\\src\\main\\scala\\Debouncer.scala 17:15]
      cntReg <= 32'h0; // @[\\src\\main\\scala\\Debouncer.scala 18:12]
    end else begin
      cntReg <= _cntReg_T_1; // @[\\src\\main\\scala\\Debouncer.scala 16:10]
    end
    btnCleanPrev <= btnDebReg; // @[\\src\\main\\scala\\Debouncer.scala 22:29]
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
module RisingFsm(
  input   clock,
  input   reset,
  input   io_din, // @[\\src\\main\\scala\\RisingFsm.scala 5:14]
  output  io_risingEdge // @[\\src\\main\\scala\\RisingFsm.scala 5:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg  stateReg; // @[\\src\\main\\scala\\RisingFsm.scala 15:25]
  wire  _GEN_0 = io_din | stateReg; // @[\\src\\main\\scala\\RisingFsm.scala 21:20 22:18 15:25]
  assign io_risingEdge = ~stateReg & io_din; // @[\\src\\main\\scala\\RisingFsm.scala 17:17 19:21]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\RisingFsm.scala 15:25]
      stateReg <= 1'h0; // @[\\src\\main\\scala\\RisingFsm.scala 15:25]
    end else if (~stateReg) begin // @[\\src\\main\\scala\\RisingFsm.scala 19:21]
      stateReg <= _GEN_0;
    end else if (stateReg) begin // @[\\src\\main\\scala\\RisingFsm.scala 19:21]
      if (~io_din) begin // @[\\src\\main\\scala\\RisingFsm.scala 27:21]
        stateReg <= 1'h0; // @[\\src\\main\\scala\\RisingFsm.scala 28:18]
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
  stateReg = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
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
module PwmFsmAnalogOut(
  input        clock,
  input        reset,
  input        io_switch_state, // @[\\src\\main\\scala\\DCMotorPWM.scala 5:14]
  output       io_pwmOut, // @[\\src\\main\\scala\\DCMotorPWM.scala 5:14]
  output [7:0] io_seg, // @[\\src\\main\\scala\\DCMotorPWM.scala 5:14]
  output [3:0] io_an // @[\\src\\main\\scala\\DCMotorPWM.scala 5:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  input_debounce_clock; // @[\\src\\main\\scala\\DCMotorPWM.scala 13:30]
  wire  input_debounce_reset; // @[\\src\\main\\scala\\DCMotorPWM.scala 13:30]
  wire  input_debounce_io_btn_in; // @[\\src\\main\\scala\\DCMotorPWM.scala 13:30]
  wire  input_debounce_io_out; // @[\\src\\main\\scala\\DCMotorPWM.scala 13:30]
  wire  rising_edge_clock; // @[\\src\\main\\scala\\DCMotorPWM.scala 14:30]
  wire  rising_edge_reset; // @[\\src\\main\\scala\\DCMotorPWM.scala 14:30]
  wire  rising_edge_io_din; // @[\\src\\main\\scala\\DCMotorPWM.scala 14:30]
  wire  rising_edge_io_risingEdge; // @[\\src\\main\\scala\\DCMotorPWM.scala 14:30]
  wire  displayMux_clock; // @[\\src\\main\\scala\\DCMotorPWM.scala 76:26]
  wire  displayMux_reset; // @[\\src\\main\\scala\\DCMotorPWM.scala 76:26]
  wire [19:0] displayMux_io_disp_content; // @[\\src\\main\\scala\\DCMotorPWM.scala 76:26]
  wire [7:0] displayMux_io_seg; // @[\\src\\main\\scala\\DCMotorPWM.scala 76:26]
  wire [3:0] displayMux_io_an; // @[\\src\\main\\scala\\DCMotorPWM.scala 76:26]
  reg [2:0] stateReg; // @[\\src\\main\\scala\\DCMotorPWM.scala 23:25]
  wire  _T_2 = 3'h0 == stateReg; // @[\\src\\main\\scala\\DCMotorPWM.scala 26:23]
  wire  _T_5 = 3'h1 == stateReg; // @[\\src\\main\\scala\\DCMotorPWM.scala 26:23]
  wire  _T_8 = 3'h2 == stateReg; // @[\\src\\main\\scala\\DCMotorPWM.scala 26:23]
  wire  _T_11 = 3'h3 == stateReg; // @[\\src\\main\\scala\\DCMotorPWM.scala 26:23]
  wire  _T_14 = 3'h4 == stateReg; // @[\\src\\main\\scala\\DCMotorPWM.scala 26:23]
  wire [2:0] _GEN_0 = 3'h4 == stateReg ? 3'h0 : stateReg; // @[\\src\\main\\scala\\DCMotorPWM.scala 26:23 23:25 31:33]
  wire [2:0] _GEN_1 = 3'h3 == stateReg ? 3'h4 : _GEN_0; // @[\\src\\main\\scala\\DCMotorPWM.scala 26:23 30:33]
  wire [2:0] _GEN_2 = 3'h2 == stateReg ? 3'h3 : _GEN_1; // @[\\src\\main\\scala\\DCMotorPWM.scala 26:23 29:33]
  wire [11:0] _GEN_6 = _T_14 ? 12'hbb8 : 12'h0; // @[\\src\\main\\scala\\DCMotorPWM.scala 42:13 48:21 70:17]
  wire [3:0] _GEN_7 = _T_14 ? 4'h9 : 4'h0; // @[\\src\\main\\scala\\DCMotorPWM.scala 43:13 48:21 71:17]
  wire [11:0] _GEN_9 = _T_11 ? 12'h9c4 : _GEN_6; // @[\\src\\main\\scala\\DCMotorPWM.scala 48:21 65:17]
  wire [3:0] _GEN_10 = _T_11 ? 4'h7 : _GEN_7; // @[\\src\\main\\scala\\DCMotorPWM.scala 48:21 66:17]
  wire [2:0] _GEN_11 = _T_11 ? 3'h5 : 3'h0; // @[\\src\\main\\scala\\DCMotorPWM.scala 48:21 67:17]
  wire [11:0] _GEN_12 = _T_8 ? 12'h683 : _GEN_9; // @[\\src\\main\\scala\\DCMotorPWM.scala 48:21 60:17]
  wire [3:0] _GEN_13 = _T_8 ? 4'h5 : _GEN_10; // @[\\src\\main\\scala\\DCMotorPWM.scala 48:21 61:17]
  wire [2:0] _GEN_14 = _T_8 ? 3'h0 : _GEN_11; // @[\\src\\main\\scala\\DCMotorPWM.scala 48:21 62:17]
  wire [11:0] _GEN_15 = _T_5 ? 12'h341 : _GEN_12; // @[\\src\\main\\scala\\DCMotorPWM.scala 48:21 55:17]
  wire [3:0] _GEN_16 = _T_5 ? 4'h2 : _GEN_13; // @[\\src\\main\\scala\\DCMotorPWM.scala 48:21 56:17]
  wire [2:0] _GEN_17 = _T_5 ? 3'h5 : _GEN_14; // @[\\src\\main\\scala\\DCMotorPWM.scala 48:21 57:17]
  wire [11:0] dutyCycle = _T_2 ? 12'h14d : _GEN_15; // @[\\src\\main\\scala\\DCMotorPWM.scala 48:21 50:17]
  wire [3:0] _GEN_19 = _T_2 ? 4'h1 : _GEN_16; // @[\\src\\main\\scala\\DCMotorPWM.scala 48:21 51:17]
  wire [2:0] _GEN_20 = _T_2 ? 3'h0 : _GEN_17; // @[\\src\\main\\scala\\DCMotorPWM.scala 48:21 52:17]
  wire [4:0] d3 = {{1'd0}, _GEN_19}; // @[\\src\\main\\scala\\DCMotorPWM.scala 36:23]
  wire [4:0] d2 = {{2'd0}, _GEN_20}; // @[\\src\\main\\scala\\DCMotorPWM.scala 37:23]
  wire [9:0] displayMux_io_disp_content_hi = {d3,d2}; // @[\\src\\main\\scala\\DCMotorPWM.scala 78:36]
  reg [11:0] pwmCounter; // @[\\src\\main\\scala\\DCMotorPWM.scala 84:27]
  wire [11:0] _pwmCounter_T_1 = pwmCounter + 12'h1; // @[\\src\\main\\scala\\DCMotorPWM.scala 88:30]
  Debouncer input_debounce ( // @[\\src\\main\\scala\\DCMotorPWM.scala 13:30]
    .clock(input_debounce_clock),
    .reset(input_debounce_reset),
    .io_btn_in(input_debounce_io_btn_in),
    .io_out(input_debounce_io_out)
  );
  RisingFsm rising_edge ( // @[\\src\\main\\scala\\DCMotorPWM.scala 14:30]
    .clock(rising_edge_clock),
    .reset(rising_edge_reset),
    .io_din(rising_edge_io_din),
    .io_risingEdge(rising_edge_io_risingEdge)
  );
  DisplayMultiplexer displayMux ( // @[\\src\\main\\scala\\DCMotorPWM.scala 76:26]
    .clock(displayMux_clock),
    .reset(displayMux_reset),
    .io_disp_content(displayMux_io_disp_content),
    .io_seg(displayMux_io_seg),
    .io_an(displayMux_io_an)
  );
  assign io_pwmOut = pwmCounter < dutyCycle; // @[\\src\\main\\scala\\DCMotorPWM.scala 90:27]
  assign io_seg = displayMux_io_seg; // @[\\src\\main\\scala\\DCMotorPWM.scala 81:10]
  assign io_an = displayMux_io_an; // @[\\src\\main\\scala\\DCMotorPWM.scala 82:10]
  assign input_debounce_clock = clock;
  assign input_debounce_reset = reset;
  assign input_debounce_io_btn_in = io_switch_state; // @[\\src\\main\\scala\\DCMotorPWM.scala 16:28]
  assign rising_edge_clock = clock;
  assign rising_edge_reset = reset;
  assign rising_edge_io_din = input_debounce_io_out; // @[\\src\\main\\scala\\DCMotorPWM.scala 17:28]
  assign displayMux_clock = clock;
  assign displayMux_reset = reset;
  assign displayMux_io_disp_content = {displayMux_io_disp_content_hi,10'h3b7}; // @[\\src\\main\\scala\\DCMotorPWM.scala 78:36]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\DCMotorPWM.scala 23:25]
      stateReg <= 3'h0; // @[\\src\\main\\scala\\DCMotorPWM.scala 23:25]
    end else if (rising_edge_io_risingEdge) begin // @[\\src\\main\\scala\\DCMotorPWM.scala 25:15]
      if (3'h0 == stateReg) begin // @[\\src\\main\\scala\\DCMotorPWM.scala 26:23]
        stateReg <= 3'h1; // @[\\src\\main\\scala\\DCMotorPWM.scala 27:33]
      end else if (3'h1 == stateReg) begin // @[\\src\\main\\scala\\DCMotorPWM.scala 26:23]
        stateReg <= 3'h2; // @[\\src\\main\\scala\\DCMotorPWM.scala 28:33]
      end else begin
        stateReg <= _GEN_2;
      end
    end
    if (reset) begin // @[\\src\\main\\scala\\DCMotorPWM.scala 84:27]
      pwmCounter <= 12'h0; // @[\\src\\main\\scala\\DCMotorPWM.scala 84:27]
    end else if (pwmCounter == 12'hd04) begin // @[\\src\\main\\scala\\DCMotorPWM.scala 85:32]
      pwmCounter <= 12'h0; // @[\\src\\main\\scala\\DCMotorPWM.scala 86:16]
    end else begin
      pwmCounter <= _pwmCounter_T_1; // @[\\src\\main\\scala\\DCMotorPWM.scala 88:16]
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
  stateReg = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  pwmCounter = _RAND_1[11:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
