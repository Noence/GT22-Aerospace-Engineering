%% Kepler's problem solver
% By: Noe Lepez Da Silva Duarte
% Date: 08 Feb. 2022

function [E] = kepler_solver(ecc, M, tol)

% - t = time since initial mean anomaly [s].
% - ecc = orbit of interest eccentricity.
% - M = mean anomaly [rad].
% - a = orbit of interest semi-major axis [km].
% - Mu = gravitational parameter [km^3/s^2]
%
% The function output 'E' corresponds to the Eccentric Anomaly associated
% with the epoch of interest in radians.
%

% Initial gues for Newton-Raphson solver.
E0 = 1;

% Create F(X) = 0 & F'(x) = 0 function handle for Kepler's Equation.
Fx = @(E) E - ecc*sin(E) - M;
Fx_p = @(E) 1 - ecc*cos(E);

% Compute Newton-Raphson solution to Kepler's Equation.
[E, ~, ~] = Newt_Raph(E0, tol, Fx, Fx_p);

end