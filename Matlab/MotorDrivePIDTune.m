% Use the parameters from your script
s = tf('s');

% 1. Electrical Part: V -> Current
% 2. Mechanical Part: Current -> Velocity
% 3. Translation Part: Velocity -> Position (Integrator + Scaling)

% The standard DC motor transfer function (Voltage to Angular Velocity) is:
G_velocity = Kt / ((L*s + R)*(J*s + B) + Ke*Kt);

% Convert Angular Velocity to Position in meters:
G_plant = G_velocity * (1/s) * rad_to_m;

% Target a response time (bandwidth). 
% Start with 1.0 rad/s. If it's too aggressive for the 1A limit, lower this.
target_bandwidth = .5; 

opts = pidtuneOptions('PhaseMargin', 90); 

[C, info] = pidtune(G_plant, 'pid', 0.5, opts);

Kp_careful = C.Kp;
Ki_careful = C.Ki;
Kd_careful = C.Kd;

fprintf('Tuned Gains: Kp=%.2f, Ki=%.2f, Kd=%.2f\n', Kp_careful, Ki_careful, Kd_careful);

% Create the closed-loop system
T = feedback(C*G_plant, 1);

% Simulate moving 0.3 meters
figure;
step(0.3 * T);
title('Linear Step Response (Ignores 1A Limit)');
grid on;

bode(G_plant);
grid on;
title('Frequency Response of the Target Retrieval Motor');