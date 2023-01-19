%% AE 4803 HW 4 Workspace
% By: Noe Lepez Da Silva Duarte
% Created: 06 March 2022

clc
clear
close all

%% Q2

% part a
x_list = [6.26, 9.83, 13.41, 16.99, 20.56];
y_lst = [320, 490, 540, 500, 480];
lagrange_inter(x_list, y_lst, 15)


% part b
newt_inter(x_list,y_lst, 15)

%% Q5 
x_list = [1,3,4,5];
y_lst = [0.60653066, 0.22313016, 0.13533528, 0.08208];
[SOLN, COEFFS ] = newt_inter(x_list,y_lst, 2.5);

%% Q7

x = [8,11,15,18,22];
y = [5,9,10,8,7];

[soln_coeffs, soln] = nat_cuSpline(x, y, 12.7);

nat_cuSpline_plotter(soln_coeffs, x, y)

%% Q8

c_y = [0, 3, 5, 6.5, 5.5];
c_x = [0, 8, 12, 17, 18];


[soln_coeffs, soln] = nat_cuSpline(c_x, c_y, 16);

nat_cuSpline_plotter(soln_coeffs, c_x, c_y)
ylabel("Load P (mN)")
xlabel("Deflection (micro-m)")
saveas(figure(1), 'soln_plot_q8.png')
hold off

