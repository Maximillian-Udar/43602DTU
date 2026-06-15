error id: C8424DA5678613748499BBDA724AB27F
file:///C:/Users/maxim/43602DTU/Chisel/src/main/scala/MotorDriver.scala
### java.lang.IndexOutOfBoundsException: -1

occurred in the presentation compiler.



action parameters:
offset: 3513
uri: file:///C:/Users/maxim/43602DTU/Chisel/src/main/scala/MotorDriver.scala
text:
```scala
import chisel3._
import chisel3.util._
import chisel3.experimental.FixedPoint
import chisel3.experimental.FixedPointConversions._

class MotorDriver extends Module {
    val io = IO(new Bundle{
        // Inputs
        val uart_rx          = Input(Bool())
        val photo_diode_A    = Input(Bool())
        val photo_diode_B    = Input(Bool())
        val over_current_pos = Input(Bool())
        val over_current_neg = Input(Bool())
        // Outputs
        val uart_tx         = Output(Bool())
        val T1              = Output(Bool()) 
        val T2              = Output(Bool()) 
        val T3              = Output(Bool()) 
        val T4              = Output(Bool()) 
        val seg             = Output(UInt(8.W))
        val an              = Output(UInt(4.W))
    })

    val rx               = Module(new UartRx)
    val tx               = Module(new UartTx)
    val rotation_counter = Module(new RotationCounter)
    val pwm_gen          = Module(new DCMotorPwm)
    val pid              = Module(new PIDController)
    val stuck_detector   = Module(new StuckDetector)
    val disp_mux         = Module(new DisplayMultiplexer)


    disp_mux.io.dots := "b0000".U
    disp_mux.io.disp_content := Cat(SegSymbol.Blank.asUInt, SegSymbol.Blank.asUInt, SegSymbol.Blank.asUInt, SegSymbol.Blank.asUInt)
    io.an := disp_mux.io.an
    io.seg := disp_mux.io.seg

    val target_position = RegInit(0.U(8.W))
    val manual_speed    = RegInit(512.U(10.W))
    val control_mode    = RegInit(false.B)
    val manual_brake    = RegInit(false.B)     

    rx.io.rx := io.uart_rx
    val cmdByte = RegInit(0.U(8.W))
    val isValueByte = RegInit(false.B)

    when(rx.io.done) {
        when(!isValueByte) {
            cmdByte := rx.io.data
            isValueByte := true.B
        }.otherwise {
            switch(cmdByte) {
                is(0x01.U) { // Set Target Position (Meters)
                    target_position := rx.io.data
                    control_mode := true.B
                    manual_brake := false.B
                }
                is(0x02.U) { // Set Manual Movement
                    control_mode := false.B
                    switch(rx.io.data) {
                        is(0.U) { manual_speed := 512.U; manual_brake := false.B } // Stop
                        is(1.U) { manual_speed := 650.U; manual_brake := false.B } // Slow Fwd
                        is(2.U) { manual_speed := 900.U; manual_brake := false.B } // Fast Fwd
                        is(3.U) { manual_speed := 374.U; manual_brake := false.B } // Slow Back
                        is(4.U) { manual_speed := 124.U; manual_brake := false.B } // Fast Back
                        is(5.U) { manual_brake := true.B }                         // Brake
                    }
                }
            }
            isValueByte := false.B
        }
    }

    rotation_counter.io.signal_A := io.photo_diode_A
    rotation_counter.io.signal_B := io.photo_diode_B
    
    val current_pos_m = (rotation_counter.io.turns * 1398.U) >> 20

    pid.io.setPoint    := target_position.asFixedPoint(12.BP)
    pid.io.measuredVal := current_pos_m(3, 0).asFixedPoint(12.BP)
    pid.io.resetBuffer := !control_mode || manual_brake
    
    pid.io.kp := 80.F(12.BP)
    pid.io.ki := 0.F(12.BP)
    pid.io.kd := 1.F(12.BP)

    val pid_duty_shifted = pid.io.controlOut + 0.5.F(12.BP) 
    val pid_duty = (pid_duty_shifted.asUInt >> 2)(9,@@)

    stuck_detector.io.externalOvercurrentInput := (io.over_current_pos || io.over_current_neg)
    stuck_detector.io.clearShutdown            := (rx.io.done && cmdByte === 0xFF.U)

    pwm_gen.io.duty_cycle := Mux(control_mode, pid_duty, manual_speed)
    val brake_active = (stuck_detector.io.motorDisable || manual_brake)
    
    when (brake_active) {
        pwm_gen.io.brake         := true.B
        disp_mux.io.disp_content := Cat(SegSymbol.S.asUInt, SegSymbol.T.asUInt, SegSymbol.O.asUInt, SegSymbol.P.asUInt)
    }

    io.T1 := pwm_gen.io.T1
    io.T2 := pwm_gen.io.T2
    io.T3 := pwm_gen.io.T3
    io.T4 := pwm_gen.io.T4

    val txTimer = RegInit(0.U(24.W))
    tx.io.data  := current_pos_m(7,0)
    tx.io.start := false.B
    when(txTimer >= 10000000.U) {
        when(!tx.io.busy) {
            tx.io.start := true.B
            txTimer := 0.U
        }
    }.otherwise { txTimer := txTimer + 1.U }
    io.uart_tx := tx.io.tx
}
```


presentation compiler configuration:
Scala version: 3.3.7-bin-nonbootstrapped
Classpath:
<HOME>\AppData\Local\Coursier\cache\v1\https\repo1.maven.org\maven2\org\scala-lang\scala3-library_3\3.3.7\scala3-library_3-3.3.7.jar [exists ], <HOME>\AppData\Local\Coursier\cache\v1\https\repo1.maven.org\maven2\org\scala-lang\scala-library\2.13.16\scala-library-2.13.16.jar [exists ]
Options:





#### Error stacktrace:

```
scala.collection.LinearSeqOps.apply(LinearSeq.scala:129)
	scala.collection.LinearSeqOps.apply$(LinearSeq.scala:128)
	scala.collection.immutable.List.apply(List.scala:79)
	dotty.tools.dotc.util.Signatures$.applyCallInfo(Signatures.scala:244)
	dotty.tools.dotc.util.Signatures$.computeSignatureHelp(Signatures.scala:101)
	dotty.tools.dotc.util.Signatures$.signatureHelp(Signatures.scala:88)
	dotty.tools.pc.SignatureHelpProvider$.signatureHelp(SignatureHelpProvider.scala:46)
	dotty.tools.pc.ScalaPresentationCompiler.signatureHelp$$anonfun$1(ScalaPresentationCompiler.scala:498)
	scala.meta.internal.pc.CompilerAccess.withSharedCompiler(CompilerAccess.scala:149)
	scala.meta.internal.pc.CompilerAccess.withNonInterruptableCompiler$$anonfun$1(CompilerAccess.scala:133)
	scala.meta.internal.pc.CompilerAccess.onCompilerJobQueue$$anonfun$1(CompilerAccess.scala:210)
	scala.meta.internal.pc.CompilerJobQueue$Job.run(CompilerJobQueue.scala:153)
	java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1136)
	java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:635)
	java.base/java.lang.Thread.run(Thread.java:840)
```
#### Short summary: 

java.lang.IndexOutOfBoundsException: -1