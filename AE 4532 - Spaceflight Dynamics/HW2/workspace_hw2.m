%% AE 4532 - Homework 2 part 1 Workspace
% By: Noe Lepez Da Silva Duarte
% Date: 08 Feb. 2022

clc
clear
close all

%% Q1
M = 1.25;   %[RAD]
e = 0.673;
tol = 1E-5;
E = kepler_solver(e, M, tol);

%% Q2

clc
clear
close all

% Part a
a = 12000;  %km
e = 0.6; 
i = 60;   %deg
RAAN = 45; %deg
w = 170;   %deg
f = 225;  %deg
mu = 3.986 * 10^5; %km^3/s^2
[r,v] = oe2eci(a,e,i,RAAN,w,f,mu)

% Part b
r_vec = [9889.74;-6157.12;2034.55]; %km
v_vec = [5.2165; 1.9489; -6.1424]; %km/s
[a,e,i,RAAN,omega,nu] = rv2oe(r_vec, v_vec, mu);

%% Q3
r0 = [-2.6501;-6.2045;-0.79878]*10^3;
v0 = [3.7145;-2.3881;6.2605];
final_t = 24*60*60;
t = linspace(0,final_t, 10e4);
options = odeset('RelTol',1e-12,'AbsTol',1e-12);
[t_i_J2,r_i_J2] = ode45(@orbdyn_J2,t,[r0;v0],options);
[t_i,r_i] = ode45(@orbdyn,t,[r0;v0],options);

diff_r = abs(r_i_J2(:,1:3)-r_i(:,1:3));
mag_diff_r = [];
[rows, ~] = size(diff_r);
for i = 1:rows
    inter_diff = norm(transpose(diff_r(i,1:3)));
    mag_diff_r = [mag_diff_r;inter_diff];
end

figure(1)
plot(t_i/3600, mag_diff_r)
xlabel("Time (hr)")
ylabel("Absolute difference (km)")
title("Absolute difference when J2 is accounted for vs. time")
Gx = gcf;
Gx.Position(3:4) = Gx.Position(3:4)*2;
Ax = gca;
Ax.FontSize = Ax.FontSize *2;
saveas(figure(1),'Q3_graph', 'png')

%% Q4
clc
clear
close all

% Part a
r_i = [7444;-2450;-1975];       %km
v_i = [4.123;5.054;-1.442];     %km/s
mu = 3.985*10^5;                %km^3/s^2

[a,e,i,RAAN,omega,f] = rv2oe(r_i, v_i, mu);
e = e(end);

% Part b
E_ti = acos(((norm(r_i)/a)-1)/-e);
M_ti = E_ti - e*sin(E_ti);

% Part c
M = M_ti + sqrt(mu/a^3)*900;
tol = 1E-5;
E = kepler_solver(e, M, tol);
f_900s_rad = 2*atan(tan(E/2)*(((1-e)/(1+e))^-1/2));
f_900s = rad2deg(f_900s_rad);

% Part d
[r_900s_vec, v_900s_vec] = oe2eci(a,e,i,RAAN,omega,f_900s,mu);
r_900s = norm(r_900s_vec);
v_900s = norm(v_900s_vec);

% Part e
t = linspace(0,900, 10e4);
options = odeset('RelTol',1e-12,'AbsTol',1e-12);
[t_f,r_f] = ode45(@orbdyn_J2,t,[r_i;v_i],options);
rv_test = r_f(end,:);
r_test = norm(rv_test(1,1:3));
v_test = norm(rv_test(1,4:6));

% Part g
t = linspace(0,4032.86, 10e4);
options = odeset('RelTol',1e-12,'AbsTol',1e-12);
[t_f,r_f] = ode45(@orbdyn,t,[r_i;v_i],options);
rv_final = r_f(end,:);
r_final = norm(rv_final(1,1:3));
v_final = norm(rv_final(1,4:5));

% Part h
t = linspace(0,4026, 10e4);
options = odeset('RelTol',1e-12,'AbsTol',1e-12);
[t_fJ2,r_fJ2] = ode45(@orbdyn_J2,t,[r_i;v_i],options);
rv_finalJ2 = r_fJ2(end,:);
r_finalJ2 = norm(rv_finalJ2(1,1:3));
v_finalJ2 = norm(rv_finalJ2(1,4:5));



%% Q8
r = [0;0;1];
v = [1;0;0];
mu = 1;

rv2oe(r,v,mu)
