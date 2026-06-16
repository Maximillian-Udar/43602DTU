%% 34602 Ingeniørarbejde 2: Target Retrieval System Simulation
% This script models the DC motor, H-Bridge limits, and PID Control

% --- 1. Electrical Parameters ---
V_supply = 10.0;    % Max voltage from H-Bridge (V)
I_limit = 2.0;      % Power Supply Current Limit (A)
R = 1.0;            % Armature resistance [Ohm]
L = 0.5e-3;         % Armature inductance [H]
Ke = 0.02;          % Back EMF constant [Vs/rad] (Adjusted to overcome TL)
Kt = 0.02;          % Torque constant [Nm/A]

% --- 2. Mechanical Parameters ---
TL = 1.8e-3;        % Static friction torque [Nm]
B = 0.4e-6;         % Viscous friction coefficient [Nms/rad]
J = 1.5e-6;         % Moment of inertia [kgm^2]

% --- 3. Scaling (7.5 turns = 1 cm) ---
% 1 rad -> (1/2pi) turns -> (1/(2pi*7.5)) cm -> (1/(2pi*7.5*100)) meters
rad_to_m = 1 / (2 * pi * 7.5 * 100);

% --- 4. Simulation Settings ---
dt = 0.0005;        % Time step (0.5ms for better numerical stability)
T_total = 20;        % Duration (5 seconds)
time = 0:dt:T_total;
N = length(time);

% --- 5. PID Controller Settings ---
target_pos = 1;   % Target position (meters)
curr_pos = 0;
Kp = 80;          % Proportional Gain
Ki = 0;          % Integral Gain
Kd = 1;           % Derivative Gain

% --- 6. Initialization ---
curr_vel = 0;
curr_current = 0;
integral_error = 0;
prev_error = 0;

% Storage for plotting
pos_log = zeros(1, N);
current_log = zeros(1, N);
voltage_log = zeros(1, N);

% --- 7. Main Simulation Loop ---
for k = 1:N
    % --- CONTROLLER (Simulating FPGA Logic) ---
    error = target_pos - curr_pos;
    
    % Derivative calculation
    d_error = (error - prev_error) / dt;
    
    % Anti-Windup Logic: Only integrate if the motor isn't starving for current
    if abs(curr_current) < I_limit * 0.95 
        integral_error = integral_error + (error * dt);
    end
    
    % Summing the PID terms
    V_out = (Kp * error) + (Ki * integral_error) + (Kd * d_error);
    
    % H-Bridge Voltage Saturation
    V_out = max(min(V_out, V_supply), -V_supply);
    
    % --- PLANT PHYSICS (Simulating the DC Motor) ---
    
    % Electrical: di/dt = (V - iR - Ke*w) / L
    di_dt = (V_out - (curr_current * R) - (curr_vel * Ke)) / L;
    curr_current = curr_current + (di_dt * dt);
    
    % Apply Power Supply Current Limit (CC Mode)
    curr_current = max(min(curr_current, I_limit), -I_limit);
    
    % Mechanical: dw/dt = (Torque_motor - Torque_friction) / J
    torque_motor = curr_current * Kt;
    
    % Corrected Friction: Resists motion based on current velocity direction
    if abs(curr_vel) < 1e-3 && abs(torque_motor) < TL
        % Static case: If torque is less than static friction, motor doesn't move
        dw_dt = 0;
        curr_vel = 0;
    else
        % Dynamic case: Friction opposes the direction of movement
        torque_friction = (B * curr_vel) + (TL * sign(curr_vel + 1e-9));
        dw_dt = (torque_motor - torque_friction) / J;
        curr_vel = curr_vel + (dw_dt * dt);
    end
    
    % Translation: Calculate meters moved
    curr_pos = curr_pos + (curr_vel * rad_to_m * dt);
    
    % Log data for plotting
    pos_log(k) = curr_pos;
    current_log(k) = curr_current;
    voltage_log(k) = V_out;
    
    % Update history for next iteration
    prev_error = error;
end

% --- 8. Plotting ---
figure('Color', 'w', 'Name', 'Target Retrieval System');

subplot(3,1,1);
plot(time, pos_log, 'b', 'LineWidth', 2);
ylabel('Position (m)');
grid on; title('System');
yline(target_pos, '--r', 'Target');

subplot(3,1,2);
plot(time, current_log, 'r', 'LineWidth', 1.5);
ylabel('Current (A)');
yline(I_limit, '--k', '1A Supply Limit');
yline(-I_limit, '--k');
grid on;

subplot(3,1,3);
plot(time, voltage_log, 'g', 'LineWidth', 1.5);
ylabel('H-Bridge (V)');
xlabel('Time (s)');
grid on;