function [E] = Kepler_Solver(t, ecc, M0, a)
% This function computes the solution to Kepler's Equation at the given
% epoch. The time is measured with respect to the initial Mean Anomaly
% given. The function inputs are as follows:
% - t = time since initial mean anomaly [s].
% - ecc = orbit of interest eccentricity.
% - M0 = initial mean anomaly [rad].
% - a = orbit of interest semi-major axis [m].
%
% The function output 'E' corresponds to the Eccentric Anomaly associated
% with the epoch of interest in radians.
%

% Define Earth's gravitational parameter.
mu = 3.986004418e14;                                    % [m^3/s^2]

% Define tolerance of Newton-Raphson solver.
tol = 1e-6;

% Compute mean anomaly at epoch.
M = M0 + sqrt(mu/(a^3))*t;

% Compute initial gues for Newton-Raphson solver. This is based off
% equation (2.16) from Prussing & Conway's "Orbital Mechanics."
u = M + ecc;
E0 = (M*(1 - sin(u)) + u*sin(M))/(1 + sin(M) - sin(u));

% Create F(X) = 0 function handle for Kepler's Equation.
Fx = @(E) E - ecc*sin(E) - M;

% Create F'(x) = 0 function handle for Kepler's Equation.
Fx_prime = @(E) 1 - ecc*cos(E);

% Compute Newton-Raphson solution to Kepler's Equation.
E = NewtRaph(E0, tol, Fx, Fx_prime);

end