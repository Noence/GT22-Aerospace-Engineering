%% AE 4631 HW 7 workspace
% By: Noe Lepez Da Silva Duarte
% Created: 26 March 2022

clc
clear
close all

r_E = 6371;                                 % [km]
r_sat = 384400;                             % [km]
c_km = 3E5;                                 % [km/s]
c_m = 3E8;                                  % [m/s]
f = 1.9E9;                                  % [1/s]
P_t = 40;                                   % [W]
A_r = pi*2^2;                               % [m^2]
lambda = c_m/f;                             % [m]
T_s = 280;                                  % [K]

% r_E = 6371;                                 % [km]
% r_sat = 7371;                             % [km]
% c_km = 3E5;                                 % [km/s]
% c_m = 3E8;                                  % [m/s]
% f = 2E9;                                  % [1/s]
% P_t = 1;                                   % [W]
% A_r = pi;                               % [m^2]
% lambda = c_m/f;                             % [m]
% T_s = 300;                                  % [K]


% Q1
th_t_rad = 2*asin(r_E/r_sat);
th_t = rad2deg(th_t_rad);

% Q2
G_t = 0.55 * 41253/th_t^2;
G_t_dB = 10*log10(G_t);

% Q3
G_t_dB_p = G_t_dB - 4.9;

% Q4
r_max = sqrt(r_sat^2-r_E^2);

% Q5
Pr_Pt = (c_km/(4*pi))^2 * 1/(r_max*f)^2;
Pr_pt_dB = 10*log10(Pr_Pt);

% Q6
P_r = 10*log10(P_t) + G_t_dB_p - 2 + Pr_pt_dB;
P_r_dBm = 30 + P_r;

% Q7
G_r = (4*pi*0.55*A_r)/(lambda^2);
G_r_dB = 10*log10(G_r);

% Q8
E_bit_dBJ = P_r + G_r_dB -10*log10(10^6);
E_bit_dBmJ = E_bit_dBJ + 30;

% Q9
N_o = 1.38E-23 * T_s;
N_o_dBm = 10*log10(N_o * 10^3);

% Q10
Eb_No_dB = E_bit_dBmJ - N_o_dBm;






