error id: file://<WORKSPACE>/src/main/scala/AlarmClock.scala:
file://<WORKSPACE>/src/main/scala/AlarmClock.scala
empty definition using pc, found symbol in pc: 
empty definition using semanticdb
empty definition using fallback
non-local guesses:
	 -chisel3.
	 -chisel3#
	 -chisel3().
	 -chisel3/util.
	 -chisel3/util#
	 -chisel3/util().
	 -scala/Predef.
	 -scala/Predef#
	 -scala/Predef().
offset: 2625
uri: file://<WORKSPACE>/src/main/scala/AlarmClock.scala
text:
```scala
import chisel3._
import chisel3.util._

// Features two alarms

class Alarm extends Module {
    val io = IO(new Bundle{
        // Alarm stuff
        val set_alarm1       = Input(Bool())
        val set_alarm2       = Input(Bool())
        val toggle_alarm     = Input(Bool())

        // Clock stuff
        val up_hour          = Input(Bool())
        val down_hour        = Input(Bool())
        val up_minute        = Input(Bool())
        val down_minute      = Input(Bool())
        val set_clock        = Input(Bool())
        
        // Outputs
        val alarm_indicator  = Output(UInt(13.W))
        val seg              = Output(UInt(8.W))
        val an               = Output(4.W)
    })
    // General
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

    // Clock
    val hours = RegInit(0.U(5.W))
    val minutes = RegInit(0.U(6.W))

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

    // Alarm
    val hours_alarm1 = RegInit(0.U(5.W))
    val minutes_alarm1 = RegInit(0.U(6.W))
    val hours_alarm2 = RegInit(0.U(5.W))
    val minutes_alarm2 = RegInit(0.U(6.W))
    // Setter logic
    when (io.set_alarm1) {
        when(minute_up_debounce.io.out){
            minutes_alarm1 := Mux(minutes_alarm1 === 59.U, 0.U, minutes_alarm1 + 1.U@@)
        } .elsewhen (minute_down_debounce.io.out){
            
        }
    }

    // Outputs
}
```


#### Short summary: 

empty definition using pc, found symbol in pc: 