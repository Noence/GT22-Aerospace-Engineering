%% AE 4361 - Assignment 9 workspace
% By: Noe Lepez Da Silva Duarte
% Created: 13 April 2022

clc
clear 
close all

%% Constants
mu = 3.986E5;                       % [km^3/s^2]
r_E = 6371;                         % [km]
% w_E = 7.2921159E-5;               % [rad/s]
w_E = 360/86164.1;                  % [deg/s]

%% Q1 
% Part a
h = 6000;
a = 6371+h;                      % [km]  
T = 2*pi*sqrt(a^3/mu);              % [s]
turn = T*w_E;
lambda = turn/2;
w = 2*deg2rad(lambda) *r_E;

% Part b
k = sqrt(r_E^2 + a^2 -2*r_E*a*cos(deg2rad(lambda)));
eta = asin(sin(deg2rad(lambda)*r_E/k));

% Part c
sid_day = 4.1 + 56*60 + 23*60*60;
% num_passes = sid_day/T;
% final_ang = floor(num_passes)*T*w_E/(2*pi);
% rad2deg(final_ang)

turn_n = 2*pi/6;
T_n = turn_n/deg2rad(w_E);
a_n = (mu*(T_n/(2*pi))^2)^(1/3);
h_n = a_n - r_E;
h_n_lec = 42164*(6/1)^(-2/3) - 6371;

% Part d
alpha = asin((h_n+r_E)*sin(eta)/r_E);
alpha = pi-alpha;
lambda_n = pi-alpha-eta;

w_n = 2*lambda_n *r_E;

sat_numb = 2*pi*r_E/w_n;

%% Q2
h = 475;

gamma = asin(r_E*sin(deg2rad(90+25))/(r_E+h));
beta = 180-90-25-rad2deg(gamma);
n=360/(2*beta);

i = 90-30-beta;

T = 24;
PU = 360/T;


%% Q3

t = linspace(0,2*pi*2/(sqrt(3.986E5/(6371+400)^3)), 10e5);
options = odeset('RelTol',1e-12,'AbsTol',1e-12);
r_i = [0;0;-0.12;0.02;0;0.05];
[t,r] = ode45(@odes,t,r_i,options);

idx5 = find(t>(5.0*60) & t<(5.01*60));
idx45 = find(t==45*60);

fig1 = figure;
plot(r(:,2)/1000, r(:,1)/1000)
hold on
plot(r(idx5(1),2)/1000, r(idx5(1),1)/1000, 'ro')
% plot(r(idx45(1),2)/1000, r(idx45(1),1)/1000, 'go')
legend("Dragon relative position", "T=5min", "T=45 min", "Location","north")
axis square
axis ([-1, 1, -1, 1])
grid on
xlabel("Along track, r0*dtheta, km")
ylabel("Radial, dr, km")
title("Assignment 9 Problem 3c. Dragon capsule ISS departure, by Noe Lepez")
saveas(fig1, "Q3.png")

function CW = odes(~, Y)

r0 = 6371+400;
n = sqrt(3.986E5/(r0)^3);

r = Y(1);
th=Y(2);
z=Y(5);

mat = [0,0,1,0,0,0;
       0,0,0,1,0,0'
       3*n^2,0,0,2*n,0,0;
       0,0,-2*n,0,0,0;
       0,0,0,0,0,1;
       0,0,0,0,-n^2,0];
vec = [r;th;Y(3);Y(4);z;Y(6)];
CW = mat*vec;

end













