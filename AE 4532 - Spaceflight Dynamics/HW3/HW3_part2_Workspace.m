%% AE 4532 - HW 3 Part 2 Workspace
% By: Noe Lepez Da Silva Duarte
% Created: 22 Feb. 2022

clc
clear
close all

% Constants
G = 6.6726E-11;                                 %[N*m^2/kg^2]
%Earth
mu_E = 3.986E5;                                 %[km^3/s^2]
R_E = 6.3781E3;                                 %[km]
m_E = 5.974E24;                                 %[kg]
AU = 1.496E8;                                   %[km]

%Sun
m_S = 1.99E30;                                  %[kg]
R_S = 6.9599E5;                                 %[km]
mu_S = 1.327E11;                                %[km^3/s^2]

%% Q4

%Jupiter
m_jup = m_E * 317.928;
d_jup = AU * 5.2028;
r_soi_jup = soi(m_jup, d_jup);

%Neptune
m_nep = m_E * 17.135;
d_nep = AU * 30.0611;
r_soi_nep = soi(m_nep, d_nep);

% r_soi_earth = soi(m_E, AU)

%% Q5

%Earth to Mars
d_E = AU;
d_M = 1.5237*AU;
[TOF_EM, syn_EM] = TOFHoh_planets(d_E, d_M);

%Mars to Uranus
d_U = 19.1914 * AU;
[TOF_MU, syn_MU] = TOFHoh_planets(d_M, d_U);

%Venus to Saturn
d_V = 0.7233 * AU;
d_S = 9.5388 * AU;
[TOF_VS, syn_VS] = TOFHoh_planets(d_V, d_S);

%% Q6

% Part a
d_ura = 19.1914 * AU;
m_ura = 14.531 * m_E;
r_soi_ura = soi(m_ura, d_ura);

% Part b 

%Earth departure
%Step 1
v_sp1 = sqrt(mu_S/AU);
%Step 2
v1 = sqrt(2*mu_S*((1/AU)-(1/(AU+d_ura))));
%Step 3
v_inf1 = v1 - v_sp1;
%Step 4
r_park1 = 250+R_E;
v_park1 = sqrt(mu_E/r_park1);
%Step 5
v_h1 = sqrt(((2*mu_E)/r_park1)+v_inf1^2);
%Step 6
dV1 = v_h1 - v_park1;

%Uranus arrival
mu_e_units = G * m_E;
mu_factor = mu_E/mu_e_units;
mu_ura = G * m_ura * mu_factor;

%Step 1
v_sp2 = sqrt(mu_S/d_ura);
%Step 2
v2 = sqrt(2*mu_S*((1/d_ura)-(1/(AU+d_ura))));
%Step 3
v_inf2 = v2 - v_sp2;
%Step 4
r_park2 = 8000+4.007*R_E;
v_park2 = sqrt(mu_ura/r_park2);
%Step 5
v_h2 = sqrt(((2*mu_ura)/r_park2)+v_inf2^2);
%Step 6
dV2 = v_park2 - v_h2;

dV_tot = abs(dV1) + abs(dV2);


% Test with in-class exercise
% % a
% d_ura = 1.5237 * AU;
% m_ura = 0.1074 * m_E;
% r_soi_ura = soi(m_ura, d_ura);
% 
% % b 
% %Earth departure
% %Step 1
% v_sp1 = sqrt(mu_S/AU);
% %Step 2
% v1 = sqrt(2*mu_S*((1/AU)-(1/(AU+d_ura))));
% %Step 3
% v_inf1 = v1 - v_sp1;
% %Step 4
% r_park1 = 250+R_E;
% v_park1 = sqrt(mu_E/r_park1);
% %Step 5
% v_h1 = sqrt(((2*mu_E)/r_park1)+v_inf1^2);
% %Step 6
% dV1 = v_h1 - v_park1;
% 
% %Uranus arrival
% mu_e_units = G * m_E;
% mu_factor = mu_E/mu_e_units;
% mu_ura = G * m_ura * mu_factor;
% 
% %Step 1
% v_sp2 = sqrt(mu_S/d_ura);
% %Step 2
% v2 = sqrt(2*mu_S*((1/d_ura)-(1/(AU+d_ura))));
% %Step 3
% v_inf2 = v2 - v_sp2;
% %Step 4
% r_park2 = 8000+4.007*R_E;
% v_park2 = sqrt(mu_ura/r_park2);
% %Step 5
% v_h2 = sqrt(((2*mu_ura)/r_park2)+v_inf2^2);
% %Step 6
% dV2 = v_park2 - v_h2;
% 
% dV_tot = abs(dV1) + abs(dV2)

% Part c

[T12, syn_EU] = TOFHoh_planets(AU, d_ura);
n2 = sqrt(mu_S/d_ura^3);
phi_o = rad2deg(pi - n2*(T12*60*60*24));