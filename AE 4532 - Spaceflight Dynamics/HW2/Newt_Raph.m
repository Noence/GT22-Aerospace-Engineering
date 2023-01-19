%% Newton-Raphson solver
% By: Noe Lepez Da Silva Duarte
% Date: 02 Feb. 2022

function [x_n, iter, E_arr] = Newt_Raph(x0, error, func, func_prime)

iter = [];
E_arr = [];
x_p = x0;
Ea = 1;

while(Ea >= error) 
       % Compute new solution.
       x_n = x_p - func(x_p)/func_prime(x_p);
        
       % Compute current solution tolerance.
       Ea = abs(x_n-x_p);
       
       % Update Solutions
       x_p = x_n;
       iter = [iter, x_n];
       E_arr = [E_arr Ea];
end
end