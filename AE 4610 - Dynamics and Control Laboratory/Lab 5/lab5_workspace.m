%% Lab 5 Workspace
% By: Noe Lepez Da Silva Duarte
% Created: 21 March 2022

clc
clear
close all

%% Part 1

m_p = 0.21;
m_c = 0.815;
l_p = 0.305;
g = 9.81;
a1= 2.3305;

A = [0, 0, 1, 0;
     0, 0, 0, 1;
     0, -3*m_p*g/(m_p+4*m_c), -4*10.4152/(m_p+4*m_c), 0;
     0, 3*(m_p+m_c)*g/((m_p+4*m_c)*l_p), 3*10.4152/((m_p+4*m_c)*l_p), 0];

B = [0;
     0;
     4*a1/(m_p+4*m_c);
     -3*a1/((m_p+4*m_c)*l_p)];

Q = [4, 0, 0, 0;
     0, 1.6211, 0, 0;
     0, 0, 0, 0;
     0, 0, 0, 0];

R = [0.01];

[k,s,e] = lqr(A,B,Q,R);

A_n = A-B*k;

eig_vals_OL = eig(s);

eig_vals_CL = eig(A-B*k);

damp(A-B*k);

C = [1,0,0,0;
     0,1,0,0;
     0,0,1,0;
     0,0,0,1];

D = [0;0;0;0];

%% Part 2

pend_data = load("lqr");
x = pend_data.x;
xc = pend_data.x_command;
th = pend_data.theta;
thd = pend_data.theta_dot;
time = pend_data.time;

output = sim("pendulum_sim");
time_s = output.get('tout');
data = output.get('pend');

figure(1)
plot(time,x, time_s, data(:,1), time, xc)
grid on
xlabel("Time (s)")
ylabel("Horizontal distance (m)")
legend("Output", "Simulation", "Command", "Location","best")
saveas(figure(1), "x.png")

figure(2)
plot(time,th, time_s, rad2deg(data(:,2)))
grid on
xlabel("Time (s)")
ylabel("Angle (deg)")
legend("Output", "Simulation", "Location","best")
saveas(figure(2), "th.png")

figure(3)
plot(time,thd, time_s, rad2deg(data(:,4)))
grid on
xlabel("Time (s)")
ylabel("Angular velocity (deg/s)")
legend("Output", "Simulation", "Location","best")
saveas(figure(3), "thd.png")

% figure(4)
% plot(time, data(:,1))
% grid on
% xlabel("Time (s)")
% ylabel("Horizontal distance (m)")
% saveas(figure(4), "x_sim.png")
% 
% figure(5)
% plot(time,rad2deg(data(:,2)))
% grid on
% xlabel("Time (s)")
% ylabel("Angle (deg)")
% saveas(figure(5), "th_sim.png")
% 
% figure(6)
% plot(time,rad2deg(data(:,4)))
% grid on
% xlabel("Time (s)")
% ylabel("Angular velocity (deg/s)")
% saveas(figure(6), "thd_sim.png")
