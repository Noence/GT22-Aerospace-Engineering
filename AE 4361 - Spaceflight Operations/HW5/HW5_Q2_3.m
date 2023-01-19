%% AE 4361 Question 2 & 3
% By: Noe Lepez Da Silva Duarte
% Created: 20 Feb. 2022

clc
clear
close all
format long

%% Q2

% Sat positions
QZS1 = [-11.28, 127.27, 34666.42];
QZS2 = [41.68, 137.46, 38886.86];
QZS3 = [0.050, 127.02, 35790.31];
QZS4 = [-11.12, 149.14, 34588.99];
% Part a

QZS1_ECEF = LatLong2ECEF(QZS1);
QZS2_ECEF = LatLong2ECEF(QZS2);
QZS3_ECEF = LatLong2ECEF(QZS3);
QZS4_ECEF = LatLong2ECEF(QZS4);

% Part b
rho_1 = norm(QZS1_ECEF);
rho_2 = norm(QZS2_ECEF);
rho_3 = norm(QZS3_ECEF);
rho_4 = norm(QZS4_ECEF);

%% Q3
rho1 = 36536.1926;
rho2 = 39061.5413;
rho3 = 36817.8847;
rho4 = 36735.0892;
err = 1E-4;

user_pos = pos_sol(rho1,QZS1_ECEF, rho2,QZS2_ECEF,rho3,QZS3_ECEF,rho4,QZS4_ECEF,err);

% Find lat, long, h
h = norm(user_pos(1:3)) - 6371;
lamb = atan2(user_pos(2),user_pos(1));
phi = (asin(user_pos(3,1)/norm(user_pos(1:3))));
% Turn lambda and phi into degrees
lat = rad2deg(phi);
lon = rad2deg(lamb);

lat=35.658581;long= 139.745438;
user_pos_p = LatLong2ECEF([lat, long, 0.001]);

ranges = range_find(QZS1_ECEF, QZS2_ECEF, QZS3_ECEF, QZS4_ECEF, user_pos_p);

user_pos = pos_sol(ranges(1),QZS1_ECEF, ranges(2),QZS2_ECEF,ranges(3),QZS3_ECEF,ranges(4),QZS4_ECEF,err);
