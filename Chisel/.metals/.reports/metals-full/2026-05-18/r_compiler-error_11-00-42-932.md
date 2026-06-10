error id: 37BE407576BD90A515D06EC2E06530B8
file://<WORKSPACE>/src/main/scala/thermo.scala
### java.lang.IndexOutOfBoundsException: -1

occurred in the presentation compiler.



action parameters:
offset: 400
uri: file://<WORKSPACE>/src/main/scala/thermo.scala
text:
```scala
import chisel3._
import chisel3.util._

class ThermometerDigital extends Module {
  val io = IO(new Bundle {
    val sensor_in = Input(Bool())
    val seg       = Output(UInt(7.W))
    val an        = Output(UInt(4.W))
  })

  val display = Module(new DisplayMultiplexer(100000))

  val CHAR_H = 18.U(5.W)
  val CHAR_O = 16.U(5.W)
  val CHAR_T = 1.U(5.W)
  val CHAR_C = 12.U(5.W)
  val CHAR_L = 17.U(@@)

  val letter = Mux(io.sensor_in,
    Cat(CHAR_H, CHAR_O, CHAR_T, 18.U(5.W)),
    Cat(CHAR_C, CHAR_O, 17.U(5.W), 13.U(5.W))
  )

  display.io.disp_content := letter
  io.seg := display.io.seg
  io.an  := display.io.an
}

// Boilerplate to generate Verilog
object ThermometerMain extends App {
  emitVerilog(new ThermometerDigital)
}

```


presentation compiler configuration:
Scala version: 3.3.7-bin-nonbootstrapped
Classpath:
<HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/scala-lang/scala3-library_3/3.3.7/scala3-library_3-3.3.7.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.16/scala-library-2.13.16.jar [exists ]
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
	java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1090)
	java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:614)
	java.base/java.lang.Thread.run(Thread.java:1474)
```
#### Short summary: 

java.lang.IndexOutOfBoundsException: -1