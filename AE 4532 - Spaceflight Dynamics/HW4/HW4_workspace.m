%% AE 4532 HW 4 Workspace
% By: Noe Lepez Da Silva Duarte
% Created: 08 March 2022

clc
clear
close all

%% Q2

R_bf = [-0.5417, -0.8027, 0.2495;
        -0.6428, 0.5868, 0.4924;
        -0.5417, 0.1063, -0.8338];

nu = acos((trace(R_bf)-1)/2);

e= (1/(2*sin(nu)))*[R_bf(2,3)-R_bf(3,2);
                    R_bf(3,1)-R_bf(1,3);
                    R_bf(1,2)-R_bf(2,1)];

[vec, val] = eig(R_bf);

q_r = [cos(nu/2);e*sin(nu/2)];

quater = q_finder(R_bf);

%% Q3
r3_1 = deg2rad(40);
r1 = deg2rad(65);
r3_3 = deg2rad(160);


r3_1_mat = [cos(r3_1) sin(r3_1) 0;
     -sin(r3_1) cos(r3_1) 0;
     0 0 1];

r1_mat = [1 0 0;
      0 cos(r1) sin(r1);
      0 -sin(r1) cos(r1)];

r3_3_mat = [cos(r3_3) sin(r3_3) 0;
     -sin(r3_3) cos(r3_3) 0;
     0 0 1];



q_3_1 = q_finder(r3_1_mat);
q_1 = q_finder(r1_mat);
q_3_3 = q_finder(r3_3_mat);

q313 = q_mult(q_3_3, q_mult(q_1, q_3_1));
q313_s = [q313(1); -q313(2:end)];

a = [0; 2.347;8.453;7.916];

soln = q_mult(q_mult(q313, a), q313_s);

%% Q5

r1 = [1;1;1];
m1 = 10;
v1 = [0.5;1.25;0.1];

r2 = [-2;3;5];
m2 = 6;
v2 = [-0.25;0.4;2.5];

r3 = [6;-1;-8];
m3 = 3.5;
v3 = [1.2;-2.5;0.25];

r4 = [-3;-4;9];
m4 = 7.5;
v4 = [0.4;-4.5;-1.25];

m_t = m1+m2+m3+m4;

r_c = (r1*m1 +r2*m2+r3*m3+r4*m4)/(m_t);
v_c = (v1*m1 +v2*m2+v3*m3+v4*m4)/(m_t);
Ho_C = m_t*cross(r_c,v_c);

r1_c = r1-r_c;
v1_c = v1-v_c;
r2_c = r2-r_c;
v2_c = v2-v_c;
r3_c = r3-r_c;
v3_c = v3-v_c;
r4_c = r4-r_c;
v4_c = v4-v_c;

Hc_1 = m1*cross(r1_c,v1_c);
Hc_2 = m2*cross(r2_c,v2_c);
Hc_3 = m1*cross(r3_c,v3_c);
Hc_4 = m1*cross(r4_c,v4_c);

Hc = Hc_1 + Hc_2 + Hc_3 + Hc_4;

I1 = mom_tensor(r1);
I2 = mom_tensor(r2);
I3 = mom_tensor(r3);
I4 = mom_tensor(r4);
I = I1+I2+I3+I4;

I1_c = mom_tensor(r1_c);
I2_c = mom_tensor(r2_c);
I3_c = mom_tensor(r3_c);
I4_c = mom_tensor(r4_c);
I_c = I1_c+I2_c+I3_c+I4_c;
