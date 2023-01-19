%% AE 4361 Question 1
% By: Noe Lepez Da Silva Duarte
% Created: 20 Feb. 2022

clc
clear
close all

%% Q1

% Constants
h = 400*1000;                           %[m]
r_E = 6371*1000;                        %[m]
A_ISS = 1000;                           %[m^2]
m_ISS = 2.5E5;                          %[kg]
rho = 3.8E-12;                          %[kg/m^3]
mu = 3.986E14;                          %[m^3/s^2]
Cd = 2;

% Part a
r_ISS = h+r_E;
k_d = 0.5*(Cd*A_ISS*rho)/(m_ISS);
v_ISS = sqrt(mu/r_ISS);
f_d = -k_d*v_ISS^2;

r_ISS_lst = [];

time = linspace(0,24*60*60,24*60*60+1);
for i = time
    dt = i;
    w_ISS = f_d*(v_ISS*dt);
    da = (-w_ISS * 2 * r_ISS^2)/(mu);
    a_new = r_ISS - da;
    r_ISS_lst = [r_ISS_lst, a_new];
end

figure(1)
plot(time/(60*60), (r_ISS_lst-r_E)/1000)
hold on
grid on
xlabel('time (hrs)'); ylabel("Altitude (km)")
title("ISS altitude over 24 hours - Noe Lepez")
% saveas(figure(1), 'Q1_a.png')

% Part b
dv = abs(f_d * dt);

% Part c
m_prop = (m_ISS+7150) *(1-exp((-dv)/(9.81*302)));