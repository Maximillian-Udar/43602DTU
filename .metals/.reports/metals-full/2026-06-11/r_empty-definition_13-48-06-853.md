error id: file:///C:/Users/maxim/43602DTU/Chisel/src/main/scala/MotorStop.scala:
file:///C:/Users/maxim/43602DTU/Chisel/src/main/scala/MotorStop.scala
empty definition using pc, found symbol in pc: 
empty definition using semanticdb
empty definition using fallback
non-local guesses:

offset: 446
uri: file:///C:/Users/maxim/43602DTU/Chisel/src/main/scala/MotorStop.scala
text:
```scala
import chisel3._
import chisel3.util._

class MotorStop extends Module {
    val io = IO(new Bundle{
        val motor_cleared     = Input(Bool())
        val motor_stop_signal = Output(Bool())
    })
    
    val sIdle :: sMotorKill :: Nil = Enum(2)
    val stateReg = RegInit(sMotorKill)

    val rising_input = Module(new RisingFsm)
    val debounce     = Module(new Debouncer)

    val InputSync = RegNext(RegNext(io.motor_kill@@))

    rising_input.io.btn_in := InputSync
    val rise = 

}
```


#### Short summary: 

empty definition using pc, found symbol in pc: 