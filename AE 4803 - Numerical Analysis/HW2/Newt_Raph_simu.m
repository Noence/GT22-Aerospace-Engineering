%% AE 4803 - HW 2 - Q1_d
% By: Noe Lepez Da Silva Duarte
% Date: 02 Feb. 2022

function [x_n, iter] = Newt_Raph_simu(x0, f1, f2, J1_dx, J1_dy, J2_dx, ...
    J2_dy, error)
syms x y
iter = 0;
x_p = x0;
Ea = 100;

while(Ea >= error) 
       J10_dx = J1_dx(x_p(1));
       J10_dy = J1_dy(x_p(2));
       J20_dx = J2_dx(x_p(1));
       J20_dy = J2_dy(x_p(2));

       f1c = f1(x_p(1), x_p(2));
       f2c = f2(x_p(1), x_p(2));
       J0 = [J10_dx, J10_dy;J20_dx, J20_dy];
       x_n = -inv(J0)*[f1c;f2c];
       x_n = x_p+x_n;
       Ea = abs(norm(x_n)-norm(x_p))/norm(x_n);
       x_p = x_n;

       iter = iter + 1;
end
end