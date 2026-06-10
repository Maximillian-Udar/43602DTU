error id: file://<WORKSPACE>/src/main/scala/MultiAlarm.scala:
file://<WORKSPACE>/src/main/scala/MultiAlarm.scala
empty definition using pc, found symbol in pc: 
empty definition using semanticdb
empty definition using fallback
non-local guesses:
	 -chisel3/hours.
	 -chisel3/hours#
	 -chisel3/hours().
	 -chisel3/util/hours.
	 -chisel3/util/hours#
	 -chisel3/util/hours().
	 -hours.
	 -hours#
	 -hours().
	 -scala/Predef.hours.
	 -scala/Predef.hours#
	 -scala/Predef.hours().
offset: 4714
uri: file://<WORKSPACE>/src/main/scala/MultiAlarm.scala
text:
```scala
import chisel3._
import chisel3.util._

class MultiAlarm(frequency: Int = 100000000L) extends Module {
    val io = IO(new Bundle{
        // Alarm inputs
        val set_alarm1       = Input(Bool())
        val set_alarm2       = Input(Bool())
        val toggle_alarm     = Input(Bool())

        // Time inputs
        val up_hour          = Input(Bool())
        val down_hour        = Input(Bool())
        val up_minute        = Input(Bool())
        val down_minute      = Input(Bool())
        val set_clock        = Input(Bool())

        // Outputs
        val alarm_indicator  = Output(Bool())
        val seg              = Output(UInt(8.W))
        val an               = Output(UInt(4.W))
    })
    // General
    val cntReg = RegInit(0.U(33.W))
    val tick = cntReg === (frequency - 1).U
    val alarm1_active = false.B
    val alarm2_active = false.B
    val minutes = RegInit(0.U(6.W))
    val hours = RegInit(0.U(5.W))
    val minutes_alarm1 = RegInit(0.U(6.W))
    val hours_alarm1 = RegInit(0.U(5.W))
    val minutes_alarm2 = RegInit(0.U(6.W))
    val hours_alarm2 = RegInit(0.U(5.W))
    io.alarm_indicator := false.B

    // Modules
    val minutes_BCD           = Module(new BCD)
    val seconds_BCD           = Module(new BCD)
    val alarm1_minutes_BCD    = Module(new BCD)
    val alarm1_hours_BCD      = Module(new BCD)
    val alarm2_minutes_BCD    = Module(new BCD)
    val alarm2_hours_BCD      = Module(new BCD)
    val rising_edge           = Module(new RisingFsm)
    val dispMux               = Module(new DisplayMultiplexer)
    val hour_up_debounce      = Module(new Debouncer)
    val hour_down_debounce    = Module(new Debouncer)
    val minute_up_debounce    = Module(new Debouncer)
    val minute_down_debounce  = Module(new Debouncer)
    val alarm_toggle_debounce = Module(new Debouncer)

    // Debouncer
    hour_up_debounce.io.btn_in     := io.up_hour
    hour_down_debounce.io.btn_in   := io.down_hour
    minute_up_debounce.io.btn_in   := io.up_minute
    minute_down_debounce.io.btn_in := io.down_minute
    alarm_toggle_debounce.io.btn_in := io.toggle_alarm
    // BCD 
    minute_BCD.io.b_number := minutes
    hour_BCD.io.b_number := hours
    alarm1_minutes_BCD := alarm1_minutes
    alarm1_hours_BCD := alarm1_hours
    alarm2_minutes_BCD := alarm2_minutes
    alarm2_hours_BCD := alarm2_hours
    // Rising edge
    rising_edge.io.din := alarm_toggle_debounce.io.out
    val rise = rising_edge.io.risingEdge


    // Time set
    when (io.set_clock) {
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

    // Alarm set and toggle
    when (io.set_alarm1) {
        when(minute_up_debounce.io.out){
            minutes_alarm1 := Mux(minutes_alarm1 === 59.U, 0.U, minutes_alarm1 + 1.U)
        } .elsewhen (minute_down_debounce.io.out){
            minutes_alarm1 := Mux(minutes_alarm1 === 0.U, 59.U, minutes_alarm1 - 1.U)
        } .elsewhen (hour_up_debounce.io.out){
            hours_alarm1 := Mux(hours_alarm1 === 23.U, 0.U, hours_alarm1 + 1.U)
        } .elsewhen (hour_down_debounce.io.out){
            hours_alarm1 := Mux(hours_alarm1 === 0.U, 23.U, hours_alarm1 - 1.U)
        }
        when (rise) {
            alarm1_active = Mux(alarm1_active === false.B, true.B, false.B)
        }
    }.elsewhen (io.set_alarm2) {
        when(minute_up_debounce.io.out){
            minutes_alarm2 := Mux(minutes_alarm2 === 59.U, 0.U, minutes_alarm2 + 1.U)
        } .elsewhen (minute_down_debounce.io.out){
            minutes_alarm2 := Mux(minutes_alarm2 === 0.U, 59.U, minutes_alarm2 - 1.U)
        } .elsewhen (hour_up_debounce.io.out){
            hours_alarm2 := Mux(hours_alarm2 === 23.U, 0.U, hours_alarm2 + 1.U)
        } .elsewhen (hour_down_debounce.io.out){
            hours_alarm2 := Mux(hours_alarm2 === 0.U, 23.U, hours_alarm2 - 1.U)
        }
        when (rise) {
            alarm2_active = Mux(alarm2_active === false.B, true.B, false.B)
        }
    }
    when (alarm1_active && hours_alarm1 === minutes && minutes_alarm1 === hours@@){
        io.alarm_indicator := true.B
    }.elsewhen ()


}

```


#### Short summary: 

empty definition using pc, found symbol in pc: 