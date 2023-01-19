%% AE 4803 - HW 2 - Q1_b
% By: Noe Lepez Da Silva Duarte
% Date: 02 Feb. 2022

function [x_r, iters] = bisection_approx(func, bracket, error)

iters = 0;
converged = false;
x_np = 0;

while not(converged)
    
    x_n = sum(bracket)/2;
    
    inter_n = func(x_n);
    inter_1 = func(bracket(1));
    Ea = abs((x_n-x_np)/x_n);
    
    
    if Ea <= error
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
