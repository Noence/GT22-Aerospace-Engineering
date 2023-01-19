function [sol, iter, F_E] = NewtRaph(x0, tol, func, func_prime)
% This function computes the solution F(x) = 0, using the Newton-Rhapson 
% method, for a given function F(x). Note that the function has to be in a
% format such that the right-hand-side of the function is equal to zero.
% The inputs of the function are:
% - 'x0' : Initial guess for the solution to F(x) = 0.
% - 'tol' : The tolerance used to determine when a solution has been
%           obtained.
% - 'func' : Function handle for the F(x) function.
% - 'func_prime' : Function handle for the derivative of the F(x) function.
%
% The function returns a 'sol' value which corresponds to the solution,
% that fulfills the given tolerance, for the expression F(x) = 0. In
% addition, the function also returns an array containing the solution for
% each iteration and the value of F(E) to evaluate the progress.
%

% Define placeholder for tolerance.
diff = 1;

% Define placeholder for computed solution.
sol_old = x0;

% Define array for iteration tracker.
iter = x0;
F_E = func(x0);

% Iterate solution until tolerance criterion is met.
    while(diff >= tol) 
       % Compute new solution.
       sol = sol_old - func(sol_old)/func_prime(sol_old);
        
       % Compute current solution tolerance.
       diff =  abs(sol - sol_old);
       
       % Update Solutions
       F_E = [F_E, func(sol_old)];
       sol_old = sol;
       iter = [iter, sol];
    end
end