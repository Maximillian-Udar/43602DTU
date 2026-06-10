error id: file://<WORKSPACE>/src/main/scala/clock_watch.scala:
file://<WORKSPACE>/src/main/scala/clock_watch.scala
empty definition using pc, found symbol in pc: 
empty definition using semanticdb
empty definition using fallback
non-local guesses:
	 -chisel3/minute_BCD/io/out.
	 -chisel3/minute_BCD/io/out#
	 -chisel3/minute_BCD/io/out().
	 -chisel3/util/minute_BCD/io/out.
	 -chisel3/util/minute_BCD/io/out#
	 -chisel3/util/minute_BCD/io/out().
	 -minute_BCD/io/out.
	 -minute_BCD/io/out#
	 -minute_BCD/io/out().
	 -scala/Predef.minute_BCD.io.out.
	 -scala/Predef.minute_BCD.io.out#
	 -scala/Predef.minute_BCD.io.out().
offset: 1904
uri: file://<WORKSPACE>/src/main/scala/clock_watch.scala
text:
```scala
import chisel3._
import chisel3.util._

class ClockModule extends Module {
  val io = IO(new Bundle {
    val up_hour = Input(Bool())
    val down_hour = Input(Bool())
    val up_minute = Input(Bool())
    val down_minute = Input(Bool())
    val set = Input(Bool())
    val seg = Output(UInt(7.W))
    val an = Output(UInt(4.W))
  })

  val hours = RegInit(0.U(5.W))
  val minutes = RegInit(0.U(6.W))
  val cntReg = RegInit(0.U(33.W))
  val tick = cntReg === 5999999999L.U

  // Modules
  val minute_BCD = Module(new BCD)
  val hour_BCD = Module(new BCD)
  minute_BCD.io.b_number := minutes
  hour_BCD.io.b_number := hours

  // up/down debounce
  val hour_up_debounce = Module(new debouncer)
  val hour_down_debounce = Module(new debouncer)
  val minute_up_debounce = Module(new debouncer)
  val minute_down_debounce = Module(new debouncer)

  hour_up_debounce.io.btn_in := io.up_hour
  hour_down_debounce.io.btn_in := io.down_hour
  minute_up_debounce.io.btn_in := io.up_minute
  minute_down_debounce.io.btn_in := io.down_minute

  // Setter Logic
  when (io.set) {
    when(minute_up_debounce.io.out) {
      minutes := Mux(minutes === 59.U, 0.U, minutes + 1.U)
    } .elsewhen(minute_down_debounce.io.out) {
      minutes := Mux(minutes === 0.U, 59.U, minutes - 1.U)
    } .elsewhen(hour_up_debounce.io.out) {
      hours := Mux(hours === 23.U, 0.U, hours + 1.U)
    } .elsewhen(hour_down_debounce.io.out) {
      hours := Mux(hours === 0.U, 23.U, hours - 1.U)
    }
  } .otherwise {
    // Counter Logic
    cntReg := cntReg + 1.U
    when (tick) {
      cntReg := 0.U
      when (minutes === 59.U) {
        minutes := 0.U
        hours := Mux(hours === 23.U, 0.U, hours + 1.U)
      } .otherwise {
        minutes := minutes + 1.U
      }
    }
  }

  val dispMux = Module(new DisplayMultiplexer())
  dispMux.io.disp_content := Cat(tens(7, 0), ones(7, 0))
  dispMux.io.minutes := minute_BCD.io.out@@
  dispMux.io.hours := hour_BCD.io.out

  // Connect Outputs
  io.seg := dispMux.io.seg
  io.an := dispMux.io.an
}

object clock extends App {
  emitVerilog(new ClockModule)
}
```


#### Short summary: 

empty definition using pc, found symbol in pc: 