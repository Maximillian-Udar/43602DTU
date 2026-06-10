error id: C8424DA5678613748499BBDA724AB27F
file:///C:/Users/maxim/FPGA_Programs/src/main/scala/PWM.scala
### java.lang.IndexOutOfBoundsException: -1

occurred in the presentation compiler.



action parameters:
offset: 1119
uri: file:///C:/Users/maxim/FPGA_Programs/src/main/scala/PWM.scala
text:
```scala
import chisel3._
import chisel3.util._

class PwmFsmAnalogOut extends Module {
  val io = IO(new Bundle {
    val switch_state = Input(Bool())
    val pwmOut       = Output(Bool())
    val seg          = Output(UInt(8.W))
    val an           = Output(UInt(4.wrapString()))
  })

  val input_debounce = Module(new Debouncer)
  val rising_edge    = Module(new RisingFsm)

  input_debounce.io.btn_in := io.switch_state
  rising_edge.io.din       := input_debounce.io.out
  val rise                 = rising_edge.io.risingEdge

  // 2. State Machine Definitions
  object State extends ChiselEnum {
    val s10, s25, s50, s75, s90 = Value
  }
  val stateReg = RegInit(State.s10)

  when (rise) {
    switch (stateReg) {
      is (State.s10) { stateReg := State.s25 }
      is (State.s25) { stateReg := State.s50 }
      is (State.s50) { stateReg := State.s75 }
      is (State.s75) { stateReg := State.s90 }
      is (State.s90) { stateReg := State.s10 }
    }
  }

  val dutyCycle = Wire(UInt(12.W))
  dutyCycle := 0.U 

  switch (stateReg) {
    is (State.s10) { dutyCycle := 333.U ,@@ }  // 10% of 3333
    is (State.s25) { dutyCycle := 833.U  }  // 25% of 3333
    is (State.s50) { dutyCycle := 1667.U }  // 50% of 3333
    is (State.s75) { dutyCycle := 2500.U }  // 75% of 3333
    is (State.s90) { dutyCycle := 3000.U }  // 90% of 3333
  }

  val pwmCounter = RegInit(0.U(12.W))
  
  when (pwmCounter === 3332.U) {
    pwmCounter := 0.U
  } .otherwise {
    pwmCounter := pwmCounter + 1.U
  }

  io.pwmOut := pwmCounter < dutyCycle

  // SSD output
  val SSD = Module(new DisplayMultiplexer)
  val duty_BCD = Module(new BCD)
  SSD.io.disp_content := Cat(0.U(1.W))
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