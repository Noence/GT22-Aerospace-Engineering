%% AE 4803 - HW 2 - Q1_a & b
% By: Noe Lepez Da Silva Duarte
% Date: 02 Feb. 2022

function [x_r, iters, Ea] = bisection_true(func, bracket, error, x0)

iters = 0;
x_np = 0;
converged = false;

while not(converged)

    x_n = sum(bracket)/2;
    
    inter_n = func(x_n);
    inter_1 = func(bracket(1));
    
    Et = abs(x0-x_n);
    Ea = abs((x_n-x_np)/x_n);
    
    if Et <= error
        x_r = x_n;
        converged = true;
    elseif inter_n * inter_1<0
        bracket(2) = x_n;
    elseif inter_n * inter_1>0
        bracket(1) = x_n;
    end
    iters = iters +1;
    x_np = x_n;
end
end
