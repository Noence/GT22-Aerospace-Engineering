%% AE 4803 - HW 2 - Q1_c
% By: Noe Lepez Da Silva Duarte
% Date: 02 Feb. 2022

function [x_r, iters] = false_position(func, bracket, error)

iters = 0;
x_np = 0;
converged = false;

while not(converged)
    
    f_u = func(bracket(2));
    f_l = func(bracket(1));
    x_n = (bracket(1) * f_u - bracket(2) * f_l)/(f_u-f_l);
    
    condition = f_l * func(x_n);

    Ea = abs((x_n-x_np)/x_n);
    
    if Ea <= error
        x_r = x_n;
        converged = true;
    elseif condition<0
        bracket(2) = x_n;
    elseif condition>0
        bracket(1) = x_n;
    end
    iters = iters +1;
    x_np = x_n;
end
end
