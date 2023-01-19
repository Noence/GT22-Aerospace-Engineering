%% HW 5 Part 1 Workspace
% By: Noe Lepez Da Silva Duarte
% Created: 23 March 2022

clc
clear 
close all

%% Q1
%Part a

I_a = [2,0,0;
       0,2,1;
       0,1,2];

[eig_v, eig_n] = eig(I_a);

%Part b

I_b = [2,0,-1;
       0,2,1;
       -1,1,3];

[eig_v, eig_n] = eig(I_b);

%% Q2

m1= 1.5*3;
m2 = 3*3;
m3 = 2.5*3;
m4 = 0.5*3;

% Part b
COM1 = [0;1.5/2;0]*m1;
COM2 = [3/2;1.5;0]*m2;
COM3 = [3;1.5;2.5/2]*m3;
COM4 = [3;1.5+(0.5/2);2.5]*m4;

COM = (COM1+COM2+COM3+COM4)/(m1+m2+m3+m4);

% Part c
%Rod 1
I1=slender_rod_MOI(m1, 1.5, 'y');
I1_o = parralel_axis(I1, 0,1.5/2,0, m1);

%Rod 2
I2=slender_rod_MOI(m2, 3, 'x');
I2_o = parralel_axis(I2, 3/2,1.5,0, m2);

%Rod 3
I3=slender_rod_MOI(m3, 2.5, 'z');
I3_o = parralel_axis(I3, 3,1.5,2.5/2, m3);

%Rod 4
I4=slender_rod_MOI(m4, 0.5, 'y');
I4_o = parralel_axis(I4, 3,1.5+0.5/2,2.5, m3);

I_o = I1_o+I2_o+I3_o+I4_o;

% Part d
I_COM = parralel_axis_rev(I_o, COM(1),COM(2), COM(3), m1+m2+m3+m4);


% Part e
[eig_v, eig_n] = eig(I_COM);
