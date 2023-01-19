%% Lab 3 Workspace
% By: Noe Lepez Da Silva Duarte
% Created: 14 Feb. 2022

clc
clear
close all

% Constants 
J_th = 1.1;                                 %[km*m^2]
J_ph = 0.04969;                             %[km*m^2]
J_ps = 1.1;                                 %[km*m^2]
l_a = 0.63;                                 %[m]
l_h = 0.18;                                 %[m]
K_f = 0.0784;                               %[N/V]
F_g = 0.63;                                 %[N]

% 1.
wn_p = sqrt((9/4^2)+(pi^2/3.1^2));
z_p = 3/(4*wn_p);
wn_r = sqrt((9/1.9^2)+(pi^2/1.3^2));
z_r = 3/(1.9*wn_p);

% Pitch (theta)
K_th_p = ((J_th*wn_p^2)/(K_f*l_a));
% K_th_d = ((J_th*(2*z_p*wn_p))/(K_f*l_a))*0.95;
K_th_d = ((J_th*(2*z_p*wn_p))/(K_f*l_a));
K_th_i = 0.04*K_th_p;

% Roll (phi)
K_ph_p = (J_ph*wn_r^2)/(K_f*l_h);
K_ph_d = ((J_ph*(2*z_r*wn_r))/(K_f*l_h))*0.5;
% K_ph_d = ((J_ph*(2*z_r*wn_r))/(K_f*l_h));

% 2. Yaw (psi)
tau = 4.1/log(9);
K_r_p = (J_ps/(F_g*l_a*tau));
K_r_i = 0.01*K_r_p;

% 3. Pitch
pitch_output = sim("pitch_sim");
pitch_time = pitch_output.get('tout');
pitch_data = pitch_output.get('pitch_out');

% stepinfo(pitch_data, pitch_time, 'SettlingTimeThreshold', 0.05)
% 
% figure(1)
% plot(pitch_time, pitch_data)
% xlabel('Time (s)')
% ylabel('Pitch (rad)')
% Gx = gcf;
% Gx.Position(3:4) = Gx.Position(3:4)*2;
% Ax = gca;
% Ax.FontSize = Ax.FontSize *2;
% saveas(figure(1), 'pitch1.png')

% 4. Roll
roll_output = sim("roll_sim");
roll_time = roll_output.get('tout');
roll_data = roll_output.get('roll_out');

% stepinfo(roll_data, roll_time, 'SettlingTimeThreshold', 0.05)

% figure(2)
% plot(roll_time, roll_data)
% xlabel('Time (s)')
% ylabel('Roll (rad)')
% Gx = gcf;
% Gx.Position(3:4) = Gx.Position(3:4)*2;
% Ax = gca;
% Ax.FontSize = Ax.FontSize *2;
% saveas(figure(2), 'roll1.png')

% 5. Yaw
yaw_output = sim("yaw_sim");
yaw_time = yaw_output.get('tout');
yaw_rate_data = yaw_output.get('yaw_rate');
yaw_data = yaw_output.get('yaw_out');

stepinfo(yaw_rate_data(1:end/2), yaw_time(1:end/2), 'SettlingTimeThreshold', 0.05)
% 
% figure(3)
% plot(yaw_time, yaw_rate_data)
% xlabel('Time (s)')
% ylabel('Yaw rate (rad/s)')
% Gx = gcf;
% Gx.Position(3:4) = Gx.Position(3:4)*2;
% Ax = gca;
% Ax.FontSize = Ax.FontSize *2;
% saveas(figure(3), 'yawrate1.png')
% 
% figure(69)
% plot(yaw_time, yaw_data)
% xlabel('Time (s)')
% ylabel('Yaw (rad)')
% Gx = gcf;
% Gx.Position(3:4) = Gx.Position(3:4)*2;
% Ax = gca;
% Ax.FontSize = Ax.FontSize *2;
% saveas(figure(69), 'yaw1.png')

% 6. Full system
K_r_p = (J_ps/(F_g*l_a*tau))*0.65;
K_r_i = 0.03*K_r_p;
% 
% full_output = sim("full_sim");
% full_time = full_output.get('tout');
% pitch_data = full_output.get('pitch_out');
% yaw_data = full_output.get('yaw_out');
% yaw_rate_data = full_output.get('yaw_rate');
% roll_data = full_output.get('roll_out');
% 
% % figure(11)
% % plot(full_time(1:2000), yaw_data(1:2000))
% % xlabel('Time (s)')
% % ylabel('Yaw (rad)')
% % Gx = gcf;
% % Gx.Position(3:4) = Gx.Position(3:4)*2;
% % Ax = gca;
% % Ax.FontSize = Ax.FontSize *2;
% % saveas(figure(11), 'Yaw_full_test.png')
% 
% % figure(12)
% % plot(full_time(1:12000), yaw_rate_data(1:12000))
% % xlabel('Time (s)')
% % ylabel('Yaw rate (rad/s)')
% % Gx = gcf;
% % Gx.Position(3:4) = Gx.Position(3:4)*2;
% % Ax = gca;
% % Ax.FontSize = Ax.FontSize *2;
% % saveas(figure(12), 'Yaw_rate_full_test.png')
% % stepinfo(yaw_rate_data(10000:12000), full_time(10000:12000), 'SettlingTimeThreshold', 0.05)
% 
% figure(6)
% plot(full_time, yaw_data)
% xlabel('Time (s)')
% ylabel('Yaw (rad)')
% Gx = gcf;
% Gx.Position(3:4) = Gx.Position(3:4)*2;
% Ax = gca;
% Ax.FontSize = Ax.FontSize *2;
% saveas(figure(6), 'Yaw_full_20.png')
% 
% figure(7)
% plot(full_time, yaw_rate_data)
% xlabel('Time (s)')
% ylabel('Yaw rate (rad/s)')
% Gx = gcf;
% Gx.Position(3:4) = Gx.Position(3:4)*2;
% Ax = gca;
% Ax.FontSize = Ax.FontSize *2;
% saveas(figure(7), 'yaw_rate_full_20.png')
% % stepinfo(yaw_rate_data(1:end/2), full_time(1:end/2), 'SettlingTimeThreshold', 0.05)
% 
% figure(8)
% plot(full_time, roll_data)
% xlabel('Time (s)')
% ylabel('Roll (rad)')
% Gx = gcf;
% Gx.Position(3:4) = Gx.Position(3:4)*2;
% Ax = gca;
% Ax.FontSize = Ax.FontSize *2;
% saveas(figure(8), 'Roll_full_20.png')
% 
% % stepinfo(pitch_data(10000:11800), full_time(10000:11800)-100, 'SettlingTimeThreshold', 0.05)
% 
% figure(5)
% plot(full_time, pitch_data)
% xlabel('Time (s)')
% ylabel('Pitch (rad)')
% Gx = gcf;
% Gx.Position(3:4) = Gx.Position(3:4)*2;
% Ax = gca;
% Ax.FontSize = Ax.FontSize *2;
% saveas(figure(5), 'pitch_full_20.png')

%% Part c

clc
clear
close all

RP_pitchstep = load("1B/RP_pitchstep");
RP_rollstep = load("1B/RP_rollstep");
RPY_yawstep = load("1B/RPY_yawstep");

% Only pitch step control
% time = RP_pitchstep.time;
% pitch = RP_pitchstep.theta;
% pitch_command = RP_pitchstep.theta_command;
% roll = RP_pitchstep.phi; 
% roll_command = RP_pitchstep.phi_command;
% 
% figure(1)
% hold on
% plot(time, pitch)
% plot(time, pitch_command, 'r--')
% xlabel('Time (s)')
% ylabel('Pitch (deg)')
% legend('Output', 'Command')
% Gx = gcf;
% Gx.Position(3:4) = Gx.Position(3:4)*2;
% Ax = gca;
% Ax.FontSize = Ax.FontSize *2;
% saveas(figure(1), 'pitch_step.png')
% hold off
% 
% figure(2)
% hold on
% plot(time, roll)
% plot(time, roll_command, 'r--')
% xlabel('Time (s)')
% ylabel('Roll (deg)')
% legend('Output', 'Command')
% Gx = gcf;
% Gx.Position(3:4) = Gx.Position(3:4)*2;
% Ax = gca;
% Ax.FontSize = Ax.FontSize *2;
% saveas(figure(2), 'pitch_step_roll.png')
% hold off
% 
% Only roll step control
% time = RP_rollstep.time;
% pitch = RP_rollstep.theta;
% pitch_command = RP_rollstep.theta_command;
% roll = RP_rollstep.phi; 
% roll_command = RP_rollstep.phi_command;
% 
% figure(3)
% hold on
% plot(time, pitch)
% plot(time, pitch_command, 'r--')
% xlabel('Time (s)')
% ylabel('Pitch (deg)')
% legend('Output', 'Command')
% Gx = gcf;
% Gx.Position(3:4) = Gx.Position(3:4)*2;
% Ax = gca;
% Ax.FontSize = Ax.FontSize *2;
% saveas(figure(3), 'roll_step_pitch.png')
% hold off
% 
% figure(4)
% hold on
% plot(time, roll)
% plot(time, roll_command, 'r--')
% xlabel('Time (s)')
% ylabel('Roll (deg)')
% legend('Output', 'Command')
% Gx = gcf;
% Gx.Position(3:4) = Gx.Position(3:4)*2;
% Ax = gca;
% Ax.FontSize = Ax.FontSize *2;
% saveas(figure(4), 'roll_step.png')
% hold off

% Pitch, roll, yaw controls
time = RPY_yawstep.time;
pitch = RPY_yawstep.theta;
pitch_command = RPY_yawstep.theta_command;
roll = RPY_yawstep.phi; 
roll_command = RPY_yawstep.phi_command;
yaw = RPY_yawstep.psi;
yaw_rate = RPY_yawstep.yaw_rate;
yaw_rate_command = RPY_yawstep.yaw_rate_command;

figure(5)
hold on
plot(time, pitch)
plot(time, pitch_command, 'r--')
xlabel('Time (s)')
ylabel('Pitch (deg)')
legend('Output', 'Command')
Gx = gcf;
Gx.Position(3:4) = Gx.Position(3:4)*2;
Ax = gca;
Ax.FontSize = Ax.FontSize *2;
saveas(figure(5), 'RPY_pitch.png')
hold off

figure(6)
hold on
plot(time, roll_command, 'r--')
plot(time, roll, 'b')
xlabel('Time (s)')
ylabel('Roll (deg)')
legend('Command', 'Output')
Gx = gcf;
Gx.Position(3:4) = Gx.Position(3:4)*2;
Ax = gca;
Ax.FontSize = Ax.FontSize *2;
saveas(figure(6), 'RPY_roll.png')
hold off

figure(7)
hold on
plot(time, yaw_rate)
plot(time, yaw_rate_command, 'r--')
xlabel('Time (s)')
ylabel('Yaw rate (deg/s)')
legend('Output', 'Command')
Gx = gcf;
Gx.Position(3:4) = Gx.Position(3:4)*2;
Ax = gca;
Ax.FontSize = Ax.FontSize *2;
saveas(figure(7), 'RPY_yaw_rate.png')
hold off

figure(8)
hold on
plot(time, yaw)
xlabel('Time (s)')
ylabel('Yaw (deg)')
Gx = gcf;
Gx.Position(3:4) = Gx.Position(3:4)*2;
Ax = gca;
Ax.FontSize = Ax.FontSize *2;
saveas(figure(8), 'RPY_yaw.png')
hold off