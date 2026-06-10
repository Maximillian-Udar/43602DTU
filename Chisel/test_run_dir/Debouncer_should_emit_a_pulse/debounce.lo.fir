FIRRTL version 1.2.0
circuit debounce :
  module debounce :
    input clock : Clock
    input reset : UInt<1>
    input io_btn_in : UInt<1> @[src/main/scala/Debouncer.scala 5:16]
    output io_out : UInt<1> @[src/main/scala/Debouncer.scala 5:16]
    output io_state : UInt<1> @[src/main/scala/Debouncer.scala 5:16]

    reg btn_sync_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), btn_sync_REG) @[src/main/scala/Debouncer.scala 11:35]
    reg btn_sync : UInt<1>, clock with :
      reset => (UInt<1>("h0"), btn_sync) @[src/main/scala/Debouncer.scala 11:27]
    reg btnDebReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), btnDebReg) @[src/main/scala/Debouncer.scala 12:28]
    reg cntReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), cntReg) @[src/main/scala/Debouncer.scala 13:25]
    node tick = eq(cntReg, UInt<4>("h9")) @[src/main/scala/Debouncer.scala 14:23]
    node _cntReg_T = add(cntReg, UInt<1>("h1")) @[src/main/scala/Debouncer.scala 17:22]
    node _cntReg_T_1 = tail(_cntReg_T, 1) @[src/main/scala/Debouncer.scala 17:22]
    node _GEN_0 = mux(tick, UInt<1>("h0"), _cntReg_T_1) @[src/main/scala/Debouncer.scala 17:12 18:17 19:16]
    node _GEN_1 = mux(tick, btn_sync, btnDebReg) @[src/main/scala/Debouncer.scala 18:17 20:19 12:28]
    reg btnCleanPrev : UInt<1>, clock with :
      reset => (UInt<1>("h0"), btnCleanPrev) @[src/main/scala/Debouncer.scala 23:31]
    node _io_out_T = eq(btnCleanPrev, UInt<1>("h0")) @[src/main/scala/Debouncer.scala 24:28]
    node _io_out_T_1 = and(btnDebReg, _io_out_T) @[src/main/scala/Debouncer.scala 24:25]
    io_out <= _io_out_T_1 @[src/main/scala/Debouncer.scala 24:12]
    io_state <= btnDebReg @[src/main/scala/Debouncer.scala 25:14]
    btn_sync_REG <= io_btn_in @[src/main/scala/Debouncer.scala 11:35]
    btn_sync <= btn_sync_REG @[src/main/scala/Debouncer.scala 11:27]
    btnDebReg <= mux(reset, UInt<1>("h0"), _GEN_1) @[src/main/scala/Debouncer.scala 12:{28,28}]
    cntReg <= mux(reset, UInt<32>("h0"), _GEN_0) @[src/main/scala/Debouncer.scala 13:{25,25}]
    btnCleanPrev <= btnDebReg @[src/main/scala/Debouncer.scala 23:31]
