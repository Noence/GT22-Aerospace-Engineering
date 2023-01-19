%% AE 4532 - HW 3 Part 1 Workspace
% By: Noe Lepez Da Silva Duarte
% Created: 22 Feb. 2022

clc
clear
close all

mu_E = 3.986E5;                                 %[km^3/s^2]
R_E = 6.3781E3;                                 %[km]

%% Q2

t = 4*60*60;
w = sqrt(mu_E/(42164)^3);
[A, B, C, D] = CW(w, t);
rho_o = [-7250; 12500; 0];
drho_o = [-1.045; 3.2; 0];
drho_op = -(B^-1)*A*rho_o;

[rho_f_vec]= [A B;C D]*[rho_o;drho_op];

dV1 = norm(drho_op - drho_o);
dV2 = norm(rho_f_vec(4:6));

dV_tot = abs(dV1)+abs(dV2);
