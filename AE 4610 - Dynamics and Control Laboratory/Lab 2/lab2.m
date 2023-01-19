clc
clearvars
close all

%% Part A

v3 = load("open_loop_3V");
v35 = load("open_loop_3.5V");
v4 = load("open_loop_4V");

%Plot
figure(1)
ax = gca;
hold on
plot(v3.time,v3.theta_dot)
plot(v35.time,v35.theta_dot)
plot(v4.time,v4.theta_dot)
xlabel("Time (s)")
ylabel("Angular velocity (rad/s)")
legend('3V','3.5V', '4V', 'Location', 'best')
ax.XTick = 1:10;
ax.YTick = 1:20;
grid on
% saveas(figure(1), 'output_motor.png')


%Steady-state value
ss_v3 = mean(v3.theta_dot(125:end,1));
ss_v35 = mean(v35.theta_dot(125:end,1));
ss_v4 = mean(v4.theta_dot(125:end,1));

%DC gain
g_3 = ss_v3/3;
g_35 = ss_v35/3.5;
g_4 = ss_v4/4;

g_av = mean([g_3, g_35, g_4]);

%Time constants
tc_v3 = v3.time(find(v3.theta_dot<= 1.02 *0.632 * ss_v3 & v3.theta_dot>= 0.98 *0.632 * ss_v3));
tc_v35 = v35.time(find(v35.theta_dot<= 1.01 *0.632 * ss_v35 & v35.theta_dot>= 0.99 *0.632 * ss_v35));
tc_v4 = mean(v4.time(find(v4.theta_dot<= 1.03 *0.632 * ss_v4 & v4.theta_dot>= 0.97 *0.632 * ss_v4)));

tc_av = mean([tc_v3, tc_v35, tc_v4]);

%Simulink
D = [tc_av 1];
Kp = g_av;
sim_output = sim("partA_sim");
% set_param('partA_sim/transfer1','D','D','N','N')
sim_time = sim_output.get('tout');
sim_data = sim_output.get('sim_dat');
sin_real = load("open_loop_sinusoid.mat");

figure(2)
hold on
ax = gca;
plot(sin_real.time,sin_real.theta_dot, 'b')
plot(sim_time,sim_data, 'r--')
xlabel("Time (s)")
ylabel("Angular velocity (rad/s)")
legend('Real','Simulated', 'Location', 'northeast')
ax.XTick = 1:10;
ax.YTick = -15:2:15;
grid on
saveas(figure(2), 'output_sin.png')

%% Part B
found_gain = 4.601;
tc = 0.2167;
C = 1;
den = [tc 1 0];
G = tf(found_gain , den);

% controlSystemDesigner(G,C)

Ki_g = 0;
Kp_g = 3.355;
Kd_g = 0.335;

sim_output = sim("partB_sim");
% set_param('partA_sim/transfer1','D','D','N','N')
sim_time = sim_output.get('tout');
sim_data = sim_output.get('simout');
sim_inp = sim_output.get('input_arr');

Ki_g = 0.05;
sim_output = sim("partB_sim");
% set_param('partA_sim/transfer1','D','D','N','N')
sim_time2 = sim_output.get('tout');
sim_data2 = sim_output.get('simout');
sim_inp2 = sim_output.get('input_arr');

figure(3)
hold on
plot(sim_time,sim_data, 'b')
plot(sim_time2,sim_data2, 'r--')
grid on
xlabel("Time (s)")
ylabel("Response")
legend('PD','PID', 'location', 'northwest')
axes('Position',[.69 .2 .2 .2])
box on
plot(sim_time(end-100:end),sim_data(end-100:end),'b', sim_time2(end-100:end),sim_data2(end-100:end), 'r--')
saveas(figure(3),'ramp_res.png')


figure(4)
hold on
plot(sim_time,abs(sim_data-sim_inp), 'b')
plot(sim_time2,abs(sim_data2-sim_inp2), 'r--')
xlabel("Time (s)")
ylabel("Error")
grid on
legend('PD','PID', 'location', 'southeast')
saveas(figure(4),'ramp_err.png')

