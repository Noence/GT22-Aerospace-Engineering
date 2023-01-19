%% HW 5 Part 2 Workspace
% By: Noe Lepez Da Silva Duarte
% Created: 23 March 2022

clc
clear 
close all

%% Q3

% Part a
rho = 150;                                  % [kg/m^3]
m1 = pi*1.5^2*2*rho;
m2 = 4*1.5*0.1*rho;
m3 = 4*1.5*0.1*rho;
m4 = (pi*1.5^2)*(2/3)*rho;
r = 3/2;

COM1 = [0;0;0]*m1;
COM2 = [0;-(1.5+4/2);0]*m2;
COM3 = [0;1.5+4/2;0]*m3;
COM4 = [0;0;1+2/4]*m4;

COM = (COM1+COM2+COM3+COM4)/(m1+m2+m3+m4);

% Part b
I1 = [(1/4)*m1*r^2+(1/12)*m1*2^2,0,0;
      0,(1/4)*m1*r^2+(1/12)*m1*2^2,0;
      0,0,0.5*m1*r^2];

I2 = [(1/12)*m2*(1.5^2+4^2),0,0;
      0,(1/12)*m2*(1.5^2+0.1^2),0;
      0,0,(1/12)*m2*(0.1^2+4^2)];

I3 = [(1/12)*m3*(1.5^2+4^2),0,0;
      0,(1/12)*m3*(1.5^2+0.1^2),0;
      0,0,(1/12)*m3*(0.1^2+4^2)];

I4 = [(3/80)*m4*(4*r^2+2^2),0,0;
      0,(3/80)*m4*(4*r^2+2^2),0;
      0,0,(3/10)*m4*r^2];

d1 = (COM1/m1)-COM;
I1_COM = parralel_axis(I1, d1(1),d1(2),d1(3),m1);

d2 = (COM2/m2)-COM;
I2_COM = parralel_axis(I2, d2(1),d2(2),d2(3),m2);

d3 = (COM3/m3)-COM;
I3_COM = parralel_axis(I3, d3(1),d3(2),d3(3),m3);

d4 = (COM4/m4)-COM;
I4_COM = parralel_axis(I4, d4(1),d4(2),d4(3),m4);

I_COM = I1_COM+I2_COM+I3_COM+I4_COM;

% Part c
[eig_v, eig_n] = eig(I_COM);

%% Q5

I = [10,-15,5;
     -15,30,0;
     5,0,45];

w5 = [5*5*5;3*5;10];

soln_a = I*w5;

T5 = 0.5*transpose(w5)*I*w5;

[eig_v, eig_n] = eig(I);

Rpb = [eig_v(:,1)';
       eig_v(:,2)';
       eig_v(:,3)'];

w5p = Rpb*w5;

alpha_p = Rpb*[50;3;0];

M1 = eig_n(1,1)*alpha_p(1)+(eig_n(3,3)-eig_n(2,2))*w5p(2)*w5p(3);
M2 = eig_n(2,2)*alpha_p(2)+(eig_n(1,1)-eig_n(3,3))*w5p(3)*w5p(1);
M3 = eig_n(3,3)*alpha_p(3)+(eig_n(2,2)-eig_n(1,1))*w5p(2)*w5p(1);