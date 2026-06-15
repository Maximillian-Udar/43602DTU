module Debouncer(
  input   clock,
  input   reset,
  input   io_btn_in, // @[\\src\\main\\scala\\Functions.scala 182:14]
  output  io_out // @[\\src\\main\\scala\\Functions.scala 182:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg  btn_sync_REG; // @[\\src\\main\\scala\\Functions.scala 188:33]
  reg  btn_sync; // @[\\src\\main\\scala\\Functions.scala 188:25]
  reg  btnDebReg; // @[\\src\\main\\scala\\Functions.scala 189:26]
  reg [31:0] cntReg; // @[\\src\\main\\scala\\Functions.scala 190:23]
  wire  tick = cntReg == 32'h1869f; // @[\\src\\main\\scala\\Functions.scala 191:21]
  wire [31:0] _cntReg_T_1 = cntReg + 32'h1; // @[\\src\\main\\scala\\Functions.scala 194:20]
  reg  btnCleanPrev; // @[\\src\\main\\scala\\Functions.scala 200:29]
  assign io_out = btnDebReg & ~btnCleanPrev; // @[\\src\\main\\scala\\Functions.scala 201:23]
  always @(posedge clock) begin
    btn_sync_REG <= io_btn_in; // @[\\src\\main\\scala\\Functions.scala 188:33]
    btn_sync <= btn_sync_REG; // @[\\src\\main\\scala\\Functions.scala 188:25]
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 189:26]
      btnDebReg <= 1'h0; // @[\\src\\main\\scala\\Functions.scala 189:26]
    end else if (tick) begin // @[\\src\\main\\scala\\Functions.scala 195:15]
      btnDebReg <= btn_sync; // @[\\src\\main\\scala\\Functions.scala 197:15]
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 190:23]
      cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 190:23]
    end else if (tick) begin // @[\\src\\main\\scala\\Functions.scala 195:15]
      cntReg <= 32'h0; // @[\\src\\main\\scala\\Functions.scala 196:12]
    end else begin
      cntReg <= _cntReg_T_1; // @[\\src\\main\\scala\\Functions.scala 194:10]
    end
    btnCleanPrev <= btnDebReg; // @[\\src\\main\\scala\\Functions.scala 200:29]
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
  input   io_din, // @[\\src\\main\\scala\\Functions.scala 296:14]
  output  io_risingEdge // @[\\src\\main\\scala\\Functions.scala 296:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg  stateReg; // @[\\src\\main\\scala\\Functions.scala 306:25]
  wire  _GEN_0 = io_din | stateReg; // @[\\src\\main\\scala\\Functions.scala 312:20 313:18 306:25]
  assign io_risingEdge = ~stateReg & io_din; // @[\\src\\main\\scala\\Functions.scala 308:17 310:21]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 306:25]
      stateReg <= 1'h0; // @[\\src\\main\\scala\\Functions.scala 306:25]
    end else if (~stateReg) begin // @[\\src\\main\\scala\\Functions.scala 310:21]
      stateReg <= _GEN_0;
    end else if (stateReg) begin // @[\\src\\main\\scala\\Functions.scala 310:21]
      if (~io_din) begin // @[\\src\\main\\scala\\Functions.scala 318:21]
        stateReg <= 1'h0; // @[\\src\\main\\scala\\Functions.scala 319:18]
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
  input  [4:0] io_in, // @[\\src\\main\\scala\\Functions.scala 256:14]
  output [6:0] io_out // @[\\src\\main\\scala\\Functions.scala 256:14]
);
  wire [6:0] _io_out_T_32 = 5'h0 == io_in ? 7'h3f : 7'h0; // @[\\src\\main\\scala\\Functions.scala 261:39]
  wire [6:0] _io_out_T_34 = 5'h1 == io_in ? 7'h6 : _io_out_T_32; // @[\\src\\main\\scala\\Functions.scala 261:39]
  wire [6:0] _io_out_T_36 = 5'h2 == io_in ? 7'h5b : _io_out_T_34; // @[\\src\\main\\scala\\Functions.scala 261:39]
  wire [6:0] _io_out_T_38 = 5'h3 == io_in ? 7'h4f : _io_out_T_36; // @[\\src\\main\\scala\\Functions.scala 261:39]
  wire [6:0] _io_out_T_40 = 5'h4 == io_in ? 7'h66 : _io_out_T_38; // @[\\src\\main\\scala\\Functions.scala 261:39]
  wire [6:0] _io_out_T_42 = 5'h5 == io_in ? 7'h6d : _io_out_T_40; // @[\\src\\main\\scala\\Functions.scala 261:39]
  wire [6:0] _io_out_T_44 = 5'h6 == io_in ? 7'h7d : _io_out_T_42; // @[\\src\\main\\scala\\Functions.scala 261:39]
  wire [6:0] _io_out_T_46 = 5'h7 == io_in ? 7'h7 : _io_out_T_44; // @[\\src\\main\\scala\\Functions.scala 261:39]
  wire [6:0] _io_out_T_48 = 5'h8 == io_in ? 7'h7f : _io_out_T_46; // @[\\src\\main\\scala\\Functions.scala 261:39]
  wire [6:0] _io_out_T_50 = 5'h9 == io_in ? 7'h6f : _io_out_T_48; // @[\\src\\main\\scala\\Functions.scala 261:39]
  wire [6:0] _io_out_T_52 = 5'ha == io_in ? 7'h77 : _io_out_T_50; // @[\\src\\main\\scala\\Functions.scala 261:39]
  wire [6:0] _io_out_T_54 = 5'hb == io_in ? 7'h7c : _io_out_T_52; // @[\\src\\main\\scala\\Functions.scala 261:39]
  wire [6:0] _io_out_T_56 = 5'hc == io_in ? 7'h39 : _io_out_T_54; // @[\\src\\main\\scala\\Functions.scala 261:39]
  wire [6:0] _io_out_T_58 = 5'hd == io_in ? 7'h5e : _io_out_T_56; // @[\\src\\main\\scala\\Functions.scala 261:39]
  wire [6:0] _io_out_T_60 = 5'he == io_in ? 7'h79 : _io_out_T_58; // @[\\src\\main\\scala\\Functions.scala 261:39]
  wire [6:0] _io_out_T_62 = 5'hf == io_in ? 7'h71 : _io_out_T_60; // @[\\src\\main\\scala\\Functions.scala 261:39]
  wire [6:0] _io_out_T_64 = 5'h10 == io_in ? 7'h3c : _io_out_T_62; // @[\\src\\main\\scala\\Functions.scala 261:39]
  wire [6:0] _io_out_T_66 = 5'h11 == io_in ? 7'h76 : _io_out_T_64; // @[\\src\\main\\scala\\Functions.scala 261:39]
  wire [6:0] _io_out_T_68 = 5'h12 == io_in ? 7'h6 : _io_out_T_66; // @[\\src\\main\\scala\\Functions.scala 261:39]
  wire [6:0] _io_out_T_70 = 5'h13 == io_in ? 7'hf : _io_out_T_68; // @[\\src\\main\\scala\\Functions.scala 261:39]
  wire [6:0] _io_out_T_72 = 5'h14 == io_in ? 7'h38 : _io_out_T_70; // @[\\src\\main\\scala\\Functions.scala 261:39]
  wire [6:0] _io_out_T_74 = 5'h15 == io_in ? 7'h70 : _io_out_T_72; // @[\\src\\main\\scala\\Functions.scala 261:39]
  wire [6:0] _io_out_T_76 = 5'h16 == io_in ? 7'h3f : _io_out_T_74; // @[\\src\\main\\scala\\Functions.scala 261:39]
  wire [6:0] _io_out_T_78 = 5'h17 == io_in ? 7'h73 : _io_out_T_76; // @[\\src\\main\\scala\\Functions.scala 261:39]
  wire [6:0] _io_out_T_80 = 5'h18 == io_in ? 7'h67 : _io_out_T_78; // @[\\src\\main\\scala\\Functions.scala 261:39]
  wire [6:0] _io_out_T_82 = 5'h19 == io_in ? 7'h31 : _io_out_T_80; // @[\\src\\main\\scala\\Functions.scala 261:39]
  wire [6:0] _io_out_T_84 = 5'h1a == io_in ? 7'h6d : _io_out_T_82; // @[\\src\\main\\scala\\Functions.scala 261:39]
  wire [6:0] _io_out_T_86 = 5'h1b == io_in ? 7'h78 : _io_out_T_84; // @[\\src\\main\\scala\\Functions.scala 261:39]
  wire [6:0] _io_out_T_88 = 5'h1c == io_in ? 7'h3f : _io_out_T_86; // @[\\src\\main\\scala\\Functions.scala 261:39]
  assign io_out = 5'h1d == io_in ? 7'h0 : _io_out_T_88; // @[\\src\\main\\scala\\Functions.scala 261:39]
endmodule
module DisplayMultiplexer(
  input         clock,
  input         reset,
  input  [19:0] io_disp_content, // @[\\src\\main\\scala\\Functions.scala 206:14]
  output [7:0]  io_seg, // @[\\src\\main\\scala\\Functions.scala 206:14]
  output [3:0]  io_an // @[\\src\\main\\scala\\Functions.scala 206:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [4:0] decoder_io_in; // @[\\src\\main\\scala\\Functions.scala 235:23]
  wire [6:0] decoder_io_out; // @[\\src\\main\\scala\\Functions.scala 235:23]
  reg [16:0] cnt; // @[\\src\\main\\scala\\Functions.scala 217:20]
  wire  _cnt_T = cnt == 17'h1869f; // @[\\src\\main\\scala\\Functions.scala 218:18]
  wire [16:0] _cnt_T_2 = cnt + 17'h1; // @[\\src\\main\\scala\\Functions.scala 218:54]
  reg [1:0] digit; // @[\\src\\main\\scala\\Functions.scala 221:22]
  wire [1:0] _digit_T_1 = digit + 2'h1; // @[\\src\\main\\scala\\Functions.scala 223:20]
  wire  _T = 2'h0 == digit; // @[\\src\\main\\scala\\Functions.scala 228:17]
  wire  _T_1 = 2'h1 == digit; // @[\\src\\main\\scala\\Functions.scala 228:17]
  wire  _T_2 = 2'h2 == digit; // @[\\src\\main\\scala\\Functions.scala 228:17]
  wire  _T_3 = 2'h3 == digit; // @[\\src\\main\\scala\\Functions.scala 228:17]
  wire [4:0] _GEN_1 = 2'h3 == digit ? io_disp_content[19:15] : 5'h0; // @[\\src\\main\\scala\\Functions.scala 227:14 228:17 232:26]
  wire [4:0] _GEN_2 = 2'h2 == digit ? io_disp_content[14:10] : _GEN_1; // @[\\src\\main\\scala\\Functions.scala 228:17 231:26]
  wire [4:0] _GEN_3 = 2'h1 == digit ? io_disp_content[9:5] : _GEN_2; // @[\\src\\main\\scala\\Functions.scala 228:17 230:26]
  wire [3:0] _currentDot_T = 4'h4 >> digit; // @[\\src\\main\\scala\\Functions.scala 236:27]
  wire  currentDot = _currentDot_T[0]; // @[\\src\\main\\scala\\Functions.scala 236:27]
  wire [6:0] sevSeg = decoder_io_out; // @[\\src\\main\\scala\\Functions.scala 213:27 238:10]
  wire [7:0] fullSeg = {currentDot,sevSeg}; // @[\\src\\main\\scala\\Functions.scala 239:28]
  wire [3:0] _GEN_5 = _T_3 ? 4'h8 : 4'h1; // @[\\src\\main\\scala\\Functions.scala 244:17 248:22 214:27]
  wire [3:0] _GEN_6 = _T_2 ? 4'h4 : _GEN_5; // @[\\src\\main\\scala\\Functions.scala 244:17 247:22]
  wire [3:0] _GEN_7 = _T_1 ? 4'h2 : _GEN_6; // @[\\src\\main\\scala\\Functions.scala 244:17 246:22]
  wire [3:0] select = _T ? 4'h1 : _GEN_7; // @[\\src\\main\\scala\\Functions.scala 244:17 245:22]
  SevenSegDec decoder ( // @[\\src\\main\\scala\\Functions.scala 235:23]
    .io_in(decoder_io_in),
    .io_out(decoder_io_out)
  );
  assign io_seg = ~fullSeg; // @[\\src\\main\\scala\\Functions.scala 251:13]
  assign io_an = ~select; // @[\\src\\main\\scala\\Functions.scala 252:13]
  assign decoder_io_in = 2'h0 == digit ? io_disp_content[4:0] : _GEN_3; // @[\\src\\main\\scala\\Functions.scala 228:17 229:26]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 217:20]
      cnt <= 17'h0; // @[\\src\\main\\scala\\Functions.scala 217:20]
    end else if (cnt == 17'h1869f) begin // @[\\src\\main\\scala\\Functions.scala 218:13]
      cnt <= 17'h0;
    end else begin
      cnt <= _cnt_T_2;
    end
    if (reset) begin // @[\\src\\main\\scala\\Functions.scala 221:22]
      digit <= 2'h0; // @[\\src\\main\\scala\\Functions.scala 221:22]
    end else if (_cnt_T) begin // @[\\src\\main\\scala\\Functions.scala 222:14]
      digit <= _digit_T_1; // @[\\src\\main\\scala\\Functions.scala 223:11]
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
module PWMTest(
  input        clock,
  input        reset,
  input        io_switch_state, // @[\\src\\main\\scala\\PWMgateTest.scala 5:14]
  input        io_brake, // @[\\src\\main\\scala\\PWMgateTest.scala 5:14]
  output       io_T1, // @[\\src\\main\\scala\\PWMgateTest.scala 5:14]
  output       io_T2, // @[\\src\\main\\scala\\PWMgateTest.scala 5:14]
  output       io_T3, // @[\\src\\main\\scala\\PWMgateTest.scala 5:14]
  output       io_T4, // @[\\src\\main\\scala\\PWMgateTest.scala 5:14]
  output [7:0] io_seg, // @[\\src\\main\\scala\\PWMgateTest.scala 5:14]
  output [3:0] io_an // @[\\src\\main\\scala\\PWMgateTest.scala 5:14]
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  input_debounce_clock; // @[\\src\\main\\scala\\PWMgateTest.scala 31:30]
  wire  input_debounce_reset; // @[\\src\\main\\scala\\PWMgateTest.scala 31:30]
  wire  input_debounce_io_btn_in; // @[\\src\\main\\scala\\PWMgateTest.scala 31:30]
  wire  input_debounce_io_out; // @[\\src\\main\\scala\\PWMgateTest.scala 31:30]
  wire  rising_edge_clock; // @[\\src\\main\\scala\\PWMgateTest.scala 32:30]
  wire  rising_edge_reset; // @[\\src\\main\\scala\\PWMgateTest.scala 32:30]
  wire  rising_edge_io_din; // @[\\src\\main\\scala\\PWMgateTest.scala 32:30]
  wire  rising_edge_io_risingEdge; // @[\\src\\main\\scala\\PWMgateTest.scala 32:30]
  wire  displayMux_clock; // @[\\src\\main\\scala\\PWMgateTest.scala 117:26]
  wire  displayMux_reset; // @[\\src\\main\\scala\\PWMgateTest.scala 117:26]
  wire [19:0] displayMux_io_disp_content; // @[\\src\\main\\scala\\PWMgateTest.scala 117:26]
  wire [7:0] displayMux_io_seg; // @[\\src\\main\\scala\\PWMgateTest.scala 117:26]
  wire [3:0] displayMux_io_an; // @[\\src\\main\\scala\\PWMgateTest.scala 117:26]
  reg [11:0] pwmCounter; // @[\\src\\main\\scala\\PWMgateTest.scala 23:27]
  wire [11:0] _pwmCounter_T_1 = pwmCounter + 12'h1; // @[\\src\\main\\scala\\PWMgateTest.scala 27:30]
  reg [2:0] stateReg; // @[\\src\\main\\scala\\PWMgateTest.scala 42:25]
  wire  _T_3 = 3'h0 == stateReg; // @[\\src\\main\\scala\\PWMgateTest.scala 45:23]
  wire  _T_6 = 3'h1 == stateReg; // @[\\src\\main\\scala\\PWMgateTest.scala 45:23]
  wire  _T_9 = 3'h2 == stateReg; // @[\\src\\main\\scala\\PWMgateTest.scala 45:23]
  wire  _T_12 = 3'h3 == stateReg; // @[\\src\\main\\scala\\PWMgateTest.scala 45:23]
  wire  _T_15 = 3'h4 == stateReg; // @[\\src\\main\\scala\\PWMgateTest.scala 45:23]
  wire [2:0] _GEN_1 = 3'h4 == stateReg ? 3'h0 : stateReg; // @[\\src\\main\\scala\\PWMgateTest.scala 45:23 42:25 50:33]
  wire [2:0] _GEN_2 = 3'h3 == stateReg ? 3'h4 : _GEN_1; // @[\\src\\main\\scala\\PWMgateTest.scala 45:23 49:33]
  wire [2:0] _GEN_3 = 3'h2 == stateReg ? 3'h3 : _GEN_2; // @[\\src\\main\\scala\\PWMgateTest.scala 45:23 48:33]
  wire [11:0] _GEN_7 = _T_15 ? 12'hbb7 : 12'h0; // @[\\src\\main\\scala\\PWMgateTest.scala 64:21 82:21 57:34]
  wire [4:0] _GEN_8 = _T_15 ? 5'h9 : 5'h0; // @[\\src\\main\\scala\\PWMgateTest.scala 64:21 83:10 60:20]
  wire [11:0] _GEN_10 = _T_12 ? 12'h9c3 : _GEN_7; // @[\\src\\main\\scala\\PWMgateTest.scala 64:21 78:21]
  wire [4:0] _GEN_11 = _T_12 ? 5'h7 : _GEN_8; // @[\\src\\main\\scala\\PWMgateTest.scala 64:21 79:10]
  wire [4:0] _GEN_12 = _T_12 ? 5'h5 : 5'h0; // @[\\src\\main\\scala\\PWMgateTest.scala 64:21 79:21]
  wire [11:0] _GEN_13 = _T_9 ? 12'h682 : _GEN_10; // @[\\src\\main\\scala\\PWMgateTest.scala 64:21 74:21]
  wire [4:0] _GEN_14 = _T_9 ? 5'h5 : _GEN_11; // @[\\src\\main\\scala\\PWMgateTest.scala 64:21 75:10]
  wire [4:0] _GEN_15 = _T_9 ? 5'h0 : _GEN_12; // @[\\src\\main\\scala\\PWMgateTest.scala 64:21 75:21]
  wire [11:0] _GEN_16 = _T_6 ? 12'h341 : _GEN_13; // @[\\src\\main\\scala\\PWMgateTest.scala 64:21 70:21]
  wire [4:0] _GEN_17 = _T_6 ? 5'h2 : _GEN_14; // @[\\src\\main\\scala\\PWMgateTest.scala 64:21 71:10]
  wire [4:0] _GEN_18 = _T_6 ? 5'h5 : _GEN_15; // @[\\src\\main\\scala\\PWMgateTest.scala 64:21 71:21]
  wire [11:0] dutyThreshold = _T_3 ? 12'h14d : _GEN_16; // @[\\src\\main\\scala\\PWMgateTest.scala 64:21 66:21]
  wire [4:0] d2 = _T_3 ? 5'h1 : _GEN_17; // @[\\src\\main\\scala\\PWMgateTest.scala 64:21 67:10]
  wire [4:0] d1 = _T_3 ? 5'h0 : _GEN_18; // @[\\src\\main\\scala\\PWMgateTest.scala 64:21 67:21]
  wire  pwmSignal = pwmCounter < dutyThreshold; // @[\\src\\main\\scala\\PWMgateTest.scala 88:30]
  wire  _conduct_T4_T = ~pwmSignal; // @[\\src\\main\\scala\\PWMgateTest.scala 106:19]
  wire  conduct_T2 = io_brake ? 1'h0 : pwmSignal; // @[\\src\\main\\scala\\PWMgateTest.scala 103:16 95:18 98:16]
  wire  conduct_T4 = io_brake ? 1'h0 : ~pwmSignal; // @[\\src\\main\\scala\\PWMgateTest.scala 100:16 106:16 95:18]
  wire [9:0] displayMux_io_disp_content_lo = {d1,5'h1d}; // @[\\src\\main\\scala\\PWMgateTest.scala 118:36]
  wire [9:0] displayMux_io_disp_content_hi = {5'h0,d2}; // @[\\src\\main\\scala\\PWMgateTest.scala 118:36]
  Debouncer input_debounce ( // @[\\src\\main\\scala\\PWMgateTest.scala 31:30]
    .clock(input_debounce_clock),
    .reset(input_debounce_reset),
    .io_btn_in(input_debounce_io_btn_in),
    .io_out(input_debounce_io_out)
  );
  RisingFsm rising_edge ( // @[\\src\\main\\scala\\PWMgateTest.scala 32:30]
    .clock(rising_edge_clock),
    .reset(rising_edge_reset),
    .io_din(rising_edge_io_din),
    .io_risingEdge(rising_edge_io_risingEdge)
  );
  DisplayMultiplexer displayMux ( // @[\\src\\main\\scala\\PWMgateTest.scala 117:26]
    .clock(displayMux_clock),
    .reset(displayMux_reset),
    .io_disp_content(displayMux_io_disp_content),
    .io_seg(displayMux_io_seg),
    .io_an(displayMux_io_an)
  );
  assign io_T1 = io_brake | _conduct_T4_T; // @[\\src\\main\\scala\\PWMgateTest.scala 107:16 95:18 97:16]
  assign io_T2 = ~conduct_T2; // @[\\src\\main\\scala\\PWMgateTest.scala 113:12]
  assign io_T3 = io_brake | pwmSignal; // @[\\src\\main\\scala\\PWMgateTest.scala 104:16 95:18 99:16]
  assign io_T4 = ~conduct_T4; // @[\\src\\main\\scala\\PWMgateTest.scala 114:12]
  assign io_seg = displayMux_io_seg; // @[\\src\\main\\scala\\PWMgateTest.scala 120:10]
  assign io_an = displayMux_io_an; // @[\\src\\main\\scala\\PWMgateTest.scala 121:10]
  assign input_debounce_clock = clock;
  assign input_debounce_reset = reset;
  assign input_debounce_io_btn_in = io_switch_state; // @[\\src\\main\\scala\\PWMgateTest.scala 34:28]
  assign rising_edge_clock = clock;
  assign rising_edge_reset = reset;
  assign rising_edge_io_din = input_debounce_io_out; // @[\\src\\main\\scala\\PWMgateTest.scala 35:28]
  assign displayMux_clock = clock;
  assign displayMux_reset = reset;
  assign displayMux_io_disp_content = {displayMux_io_disp_content_hi,displayMux_io_disp_content_lo}; // @[\\src\\main\\scala\\PWMgateTest.scala 118:36]
  always @(posedge clock) begin
    if (reset) begin // @[\\src\\main\\scala\\PWMgateTest.scala 23:27]
      pwmCounter <= 12'h0; // @[\\src\\main\\scala\\PWMgateTest.scala 23:27]
    end else if (pwmCounter >= 12'hd04) begin // @[\\src\\main\\scala\\PWMgateTest.scala 24:44]
      pwmCounter <= 12'h0; // @[\\src\\main\\scala\\PWMgateTest.scala 25:16]
    end else begin
      pwmCounter <= _pwmCounter_T_1; // @[\\src\\main\\scala\\PWMgateTest.scala 27:16]
    end
    if (reset) begin // @[\\src\\main\\scala\\PWMgateTest.scala 42:25]
      stateReg <= 3'h2; // @[\\src\\main\\scala\\PWMgateTest.scala 42:25]
    end else if (rising_edge_io_risingEdge) begin // @[\\src\\main\\scala\\PWMgateTest.scala 44:15]
      if (3'h0 == stateReg) begin // @[\\src\\main\\scala\\PWMgateTest.scala 45:23]
        stateReg <= 3'h1; // @[\\src\\main\\scala\\PWMgateTest.scala 46:33]
      end else if (3'h1 == stateReg) begin // @[\\src\\main\\scala\\PWMgateTest.scala 45:23]
        stateReg <= 3'h2; // @[\\src\\main\\scala\\PWMgateTest.scala 47:33]
      end else begin
        stateReg <= _GEN_3;
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
  pwmCounter = _RAND_0[11:0];
  _RAND_1 = {1{`RANDOM}};
  stateReg = _RAND_1[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
