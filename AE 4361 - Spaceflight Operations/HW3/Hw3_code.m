%% AE 4361 HW 3
% By: Noe Lepez Da Silva Duarte
% Created: 05 Feb. 2022

clc
clear
close all

%% Q1
t = 9 *3600;
e = 0.549;
a=26610000;
M0=0;

E_Q1 = Kepler_Solver(t, e, M0, a);

%% Q2
mu = 3.986 * 10^5;
r_vec = [6045; 3490; 0];
v_vec = [-2.457; 6.618; 2.533];

[a_2,e_2,i_2,RAAN_2,omega_2,nu_2] = rv2oe(r_vec, v_vec, mu);


%% Q3
% Test
a = 6.796620707E6; e=2.404e-4;inc=51.6439;RAAN=86.8571;omega=1.8404;t=100;
[x,y,z]=oe2eci(a,e,inc,RAAN,omega,t)

% Part a
a = 8.612E6; e=0.1843301;inc=34.2396;RAAN=209.63;omega=129.0719;t=300;
[x_a,y_a,z_a]=oe2eci(a,e,inc,RAAN,omega,t);
ans_a = [x_a;y_a;z_a]

% Part b
a = 6.907E6; e=0.0002445;inc=28.4714;RAAN=10.7658;omega=340.0906;t=3600;
[x_b,y_b,z_b]=oe2eci(a,e,inc,RAAN,omega,t);
ans_b = [x_b;y_b;z_b]

% Part c
a = 2.323698972E7; e=0.680478;inc=64.0370;RAAN=343.6936;omega=288.0884;t=10000;
[x_c,y_c,z_c]=oe2eci(a,e,inc,RAAN,omega,t);
ans_c = [x_c;y_c;z_c]

% Part d
a = 6.722E6; e=0.0001762;inc=53.2164;RAAN=88.7877;omega=11.5745;t=900;
[x_d,y_d,z_d]=oe2eci(a,e,inc,RAAN,omega,t);
ans_d = [x_d;y_d;z_d]
