import chisel3._
import chisel3.util._
import chisel3.experimental.FixedPoint

class Driver(Kp: Double, Ki: Double, Kd: Double, PWM_frequency: Int = 30000, manual_speed_step_ms: Int = 2, grace_period_seconds: Int = 2) extends Module {
  val io = IO(new Bundle {
    val uart_rx               = Input(Bool())
    val photo_sensor_A        = Input(Bool())
    val photo_sensor_B        = Input(Bool())
    val over_current_positive = Input(Bool())
    val over_current_negative = Input(Bool())
    val error_cleared         = Input(Bool())
    val detector_toggle       = Input(Bool())
    val uart_tx               = Output(Bool())
    val OC_lights             = Output(UInt(16.W))
    val T1                    = Output(Bool())
    val T2                    = Output(Bool())
    val T3                    = Output(Bool())
    val T4                    = Output(Bool())
    val seg                   = Output(UInt(8.W))
    val an                    = Output(UInt(4.W))
  })
  
  val pidWidth = 32
  val pidDP = 12

  val rx                   = Module(new UartRx)
  val tx                   = Module(new UartTx)
  val pwm_signal           = Module(new DCMotorPwm(PWM_frequency))
  val pid                  = Module(new PIDController(pidWidth, pidDP))
  val stuck_detector       = Module(new StuckDetector)
  val display              = Module(new DisplayMultiplexer)
  val rotations            = Module(new RotationCounter)
  val error_clear_debounce = Module(new Debouncer)
  val encoder_stuck        = Module(new EncoderStuckDetector(200))

  def filter(in: Bool): Bool = {
    val sync = in
    val cnt  = RegInit(0.U(14.W))
    val out  = RegInit(false.B)
    when(sync === out) { cnt := 0.U }
    .otherwise { cnt := cnt + 1.U; when(cnt === 1000.U) { out := sync } }
    out
  }

  rx.io.rx                       := io.uart_rx
  rotations.io.signal_A          := filter(io.photo_sensor_A)
  rotations.io.signal_B          := filter(io.photo_sensor_B)
  display.io.dots                := 0.U
  error_clear_debounce.io.btn_in := io.error_cleared

  stuck_detector.io.external_overcurrent_input := (io.over_current_positive || io.over_current_negative)
  
  io.OC_lights := 0.U
  val pid_timer = RegInit(0.U(17.W))
  val pid_tick  = pid_timer === 99999.U
  when(pid_tick) { pid_timer := 0.U } .otherwise { pid_timer := pid_timer + 1.U }

  // Scaling and states
  val target_position_cm = RegInit(0.S(32.W))
  val control_mode       = RegInit(true.B)
  val manual_brake       = RegInit(false.B)
  val system_active      = RegInit(false.B)
  val initial_offset     = RegInit(0.S(32.W))

  val current_turns = rotations.io.turns - initial_offset
  val cm_per_pulse  = FixedPoint.fromDouble(1.0 / 7.5, pidWidth.W, pidDP.BP)
  
  val full_pos_calc = current_turns.asFixedPoint(0.BP) * cm_per_pulse
  val current_position_fixed_point = RegNext(full_pos_calc(31, 0).asFixedPoint(pidDP.BP))
  val current_position_cm = Mux(system_active, ((current_position_fixed_point.asUInt + (1 << (pidDP - 1)).U) >> pidDP).asSInt, 0.S)

  val sHeader :: sCMD :: sValue :: Nil = Enum(3)
  val uartState = RegInit(sHeader)
  val CMDByte = RegInit(0.U(8.W))
  val reset_triggered = WireDefault(false.B)
  
  val target_updated = RegInit(false.B)
  when(pid_tick) { target_updated := false.B }


  // Ramping manual speeds
  val manual_speed       = RegInit(512.U(10.W))
  val manual_ramped      = RegInit(512.U(10.W))
  val speed_increment_ms = manual_speed_step_ms
  val cycles             = speed_increment_ms * 100000
  val ramp_timer         = RegInit(0.U(log2Up(cycles).W))
  val ramp_tick          = ramp_timer === (cycles - 1).U
  val new_cmd_pulse = WireDefault(false.B)


  when(ramp_tick) {
    ramp_timer := 0.U
    when(manual_ramped < manual_speed) {
      manual_ramped := manual_ramped + 1.U
    }.elsewhen(manual_ramped > manual_speed) { 
      manual_ramped := manual_ramped - 1.U 
    } 
  }.otherwise { ramp_timer := ramp_timer + 1.U }

  when(!system_active) {
    manual_ramped := 512.U
    manual_speed  := 512.U
}
  
  // Recieve data
  when (rx.io.done) {
    switch (uartState){
      is(sHeader) { when(rx.io.data === 0xAA.U) { uartState := sCMD}}
      is(sCMD) { CMDByte := rx.io.data; uartState := sValue}
      is(sValue) {
        switch(CMDByte) {
          is(0x01.U) { // Auto mode
            when(!system_active) { initial_offset := rotations.io.turns }
            target_position_cm := (rx.io.data).asSInt
            system_active := true.B
            control_mode := true.B 
            manual_brake := false.B
            target_updated := true.B
            new_cmd_pulse := true.B
          }
          is(0x02.U) { // Manual mode
            when(!system_active) { initial_offset := rotations.io.turns }
            system_active := true.B
            control_mode := false.B
            manual_brake := false.B
            switch(rx.io.data) {
              is(0.U) { manual_speed := 512.U; manual_brake := true.B } // Brake
              is(1.U) { manual_speed := 720.U; manual_brake := false.B } // sf
              is(2.U) { manual_speed := 730.U; manual_brake := false.B } // ff
              is(3.U) { manual_speed := 325.U; manual_brake := false.B } // sb
              is(4.U) { manual_speed := 305.U; manual_brake := false.B } // fb
            }
            new_cmd_pulse := true.B
          }
          is(0xFF.U) { reset_triggered := true.B }
        }
        uartState := sHeader
      }
    }
  }
  stuck_detector.io.clear_shutdown := (error_clear_debounce.io.out || reset_triggered)

  val grace_limit = (grace_period_seconds*100000000).U 
  val grace_timer = RegInit(grace_limit)

  when(new_cmd_pulse) {
    grace_timer := 0.U
  }.elsewhen(grace_timer < grace_limit) {
    grace_timer := grace_timer + 1.U
  }

  val in_grace_period = grace_timer < grace_limit

  val stillness_limit = 50000000.U
  val stillness_timer = RegInit(0.U(26.W))
  
  when(rotations.io.pulse || new_cmd_pulse) {
    stillness_timer := 0.U
  }.elsewhen(stillness_timer < stillness_limit) {
    stillness_timer := stillness_timer + 1.U
  }
  
  val motor_is_still = stillness_timer === stillness_limit

  // PID and PWM out
  val target_turns = RegNext((target_position_cm * 15.S) / 2.S)
  val tolerance = 0.S
  val in_tolerance_zone = control_mode && Mux(system_active, 
                          (current_turns >= target_turns - tolerance && 
                           current_turns <= target_turns + tolerance), true.B)
  
  // Removed motor_is_still to prevent premature integrator reset
  val at_position = in_tolerance_zone && (current_turns === target_turns)
  
  pid.io.measuredVal := current_position_fixed_point
  pid.io.setPoint := target_position_cm.asFixedPoint(0.BP)
  pid.io.tick := pid_tick
  pid.io.resetBuffer := !control_mode || manual_brake || !system_active || at_position
  
  pid.io.kp := Kp.F(pidWidth.W, pidDP.BP)
  pid.io.ki := Ki.F(pidWidth.W, pidDP.BP)
  pid.io.kd := Kd.F(pidWidth.W, pidDP.BP)
  
  val raw_pid_out = pid.io.controlOut.asSInt

  // Balanced offsets to overcome stiction in both directions
  val pid_offset = RegNext(Mux(raw_pid_out === 0.S, 0.S, Mux(raw_pid_out > 0.S, (raw_pid_out >> 4) + 80.S, (raw_pid_out >> 4) - 80.S)))

  val pid_duty_raw = 512.S + pid_offset
  val pid_duty = Mux(at_position, 512.U, Mux(pid_duty_raw > 1023.S, 1023.U, Mux(pid_duty_raw < 0.S, 0.U, pid_duty_raw.asUInt)))

  val active_duty = Mux(control_mode, pid_duty, manual_ramped)
  val is_moving_back = active_duty < 512.U
  val is_moving_fwd = active_duty > 512.U

  val block_neg = Mux(system_active, current_position_cm <= 0.S, false.B) && is_moving_back
  val block_pos = Mux(system_active, current_position_cm >= 90.S, false.B) && is_moving_fwd


  // Encoder stuck
  val is_driving = system_active && !at_position && !manual_brake && (active_duty =/= 512.U) && !in_grace_period
  encoder_stuck.io.moving_requested := is_driving
  encoder_stuck.io.pulse_detected := rotations.io.pulse
  encoder_stuck.io.clear_shutdown   := (error_clear_debounce.io.out || reset_triggered)
  val active_stuck = Mux(io.detector_toggle, stuck_detector.io.motor_disable, encoder_stuck.io.motor_disable)
  when(active_stuck){
    io.OC_lights := "b1111111111111111".U
  }

  pwm_signal.io.duty_cycle := RegNext(Mux(block_neg || block_pos, 512.U, active_duty), 512.U)
  val motor_stopped = manual_brake || !system_active || at_position || block_neg || block_pos || active_stuck
  pwm_signal.io.brake := motor_stopped

  when (!system_active) { // Brake
    io.T1 := false.B
    io.T2 := true.B
    io.T3 := false.B
    io.T4 := true.B
  } .otherwise { // Drive H-bridge
    io.T1 := pwm_signal.io.T1
    io.T2 := pwm_signal.io.T2
    io.T3 := pwm_signal.io.T3
    io.T4 := pwm_signal.io.T4 
  }

  // Transmit
  val txTimer = RegInit(0.U(24.W))
  val sSync :: sHigh :: sLow :: sT3 :: sT2 :: sT1 :: sT0 :: Nil = Enum(7)
  val txState = RegInit(sSync)
  tx.io.data := 0.U
  tx.io.start := false.B
  when(txTimer >= 2500000.U) {
    switch(txState) {
      is(sSync) { 
        when(!tx.io.busy) { 
          tx.io.data := 0xFF.U
          tx.io.start := true.B
          txState := sHigh 
        }}
      is(sHigh) { 
        when(!tx.io.busy) { 
          tx.io.data := current_position_cm(15, 8).asUInt
          tx.io.start := true.B
          txState := sLow
          txTimer := 0.U 
        }}
      is(sLow) { 
        when(!tx.io.busy) { 
          tx.io.data := current_position_cm(7, 0).asUInt
          tx.io.start := true.B
          txState := sT3
          txTimer := 0.U 
        }}
      is(sT3) {
        when(!tx.io.busy) {
          tx.io.data := rotations.io.total_rotations(31, 24)
          tx.io.start := true.B
          txState := sT2
          txTimer := 0.U
        }}
      is(sT2) { 
        when(!tx.io.busy) { 
          tx.io.data := rotations.io.total_rotations(23, 16)
          tx.io.start := true.B
          txState := sT1
          txTimer := 0.U 
        }}
      is(sT1) { 
        when(!tx.io.busy) { 
          tx.io.data := rotations.io.total_rotations(15, 8)
          tx.io.start := true.B
          txState := sT0
          txTimer := 0.U 
        }}
      is(sT0) { 
        when(!tx.io.busy) { 
          tx.io.data := rotations.io.total_rotations(7, 0)
          tx.io.start := true.B
          txState := sSync
          txTimer := 0.U 
        }}
    }
  }.otherwise { txTimer := txTimer + 1.U }
  io.uart_tx := tx.io.tx



  // Display
  io.an := display.io.an; io.seg := display.io.seg
  
  val letters_AUTO = Cat(SegSymbol.A.asUInt, SegSymbol.U.asUInt, SegSymbol.T.asUInt, SegSymbol.O.asUInt)
  val letters_MAN  = Cat(SegSymbol.M.asUInt, SegSymbol.A.asUInt, SegSymbol.N.asUInt, SegSymbol.Blank.asUInt)
  val letters_STOP = Cat(SegSymbol.S.asUInt, SegSymbol.T.asUInt, SegSymbol.O.asUInt, SegSymbol.P.asUInt)
  val letters_OC   = Cat(SegSymbol.O.asUInt, SegSymbol.C.asUInt, SegSymbol.Blank.asUInt, SegSymbol.Blank.asUInt)

  display.io.disp_content := Mux(stuck_detector.io.motor_disable, letters_OC, 
                             Mux(motor_stopped, letters_STOP, 
                             Mux(control_mode, letters_AUTO, letters_MAN)))
}

object GenerateAllVerilog extends App {
  val matlab_Kp = .6
  val matlab_Ki = 0.15
  val matlab_Kd = 0.2
  val Ts = 0.001
  emitVerilog(new Driver(matlab_Kp, matlab_Ki * Ts, matlab_Kd / Ts, 25000, 2, 2), Array("-td", "Verilog"))
}