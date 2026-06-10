FIRRTL version 1.2.0
circuit adding :
  module adding :
    input clock : Clock
    input reset : UInt<1>
    input io_in1 : UInt<16> @[FPGA_Programs/src/main/scala/adder.scala 5:14]
    input io_in2 : UInt<16> @[FPGA_Programs/src/main/scala/adder.scala 5:14]
    output io_out : UInt<16> @[FPGA_Programs/src/main/scala/adder.scala 5:14]

    node _io_out_T = add(io_in1, io_in2) @[FPGA_Programs/src/main/scala/adder.scala 11:20]
    node _io_out_T_1 = tail(_io_out_T, 1) @[FPGA_Programs/src/main/scala/adder.scala 11:20]
    io_out <= _io_out_T_1 @[FPGA_Programs/src/main/scala/adder.scala 11:10]
