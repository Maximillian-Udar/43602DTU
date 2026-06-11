import chisel3._
import chisel3.util._

class MotorStop extends Module {
    val io = IO(new Bundle{
        val motor_cleared         = Input(Bool())
        val motor_stop_signal     = Output(Bool())
    })
    io.motor_stop_signal := false.B
    
    val sIdle :: sMotorKill :: Nil = Enum(2)
    val stateReg = RegInit(sIdle)

    val rising_confirm   = Module(new RisingFsm)
    val debounce         = Module(new Debouncer)

    rising_confirm.io.btn_in := io.motor_cleared
    val rise = rising_confirm.io.out

    switch(stateReg) {
        is(sMotorKill) {
            io.motor_stop_signal := true.B

            when (io.motor_cleared) {
                stateReg := sIdle
            }
        }
        is (sIdle) {
            io.motor_stop_signal := false.B

            when (!io.motor_cleared) {
                stateReg := sMotorKill
            }
        }
    }

}