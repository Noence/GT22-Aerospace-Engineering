function [r_ECI] = OrbElem2Pos(a, e, i, Omega, omega, t)
% This function is utilized to convert the orbital elements, for a 
% particular spacecraft, to the respective position and velocity
% vectors for that epoch. The function takes as an input:
% - 'a' = semi-major axis [m].
% - 'e' = eccentricity.
% - 'i' = inclination [degrees].
% - 'Omega' = right ascencion of ascending node [degrees].
% - 'omega' = argument of perigee [degrees].
% - 't' = time since periapse passage [s].
%
% The function then outputs an 'r_ECI' position vector. Note that the 
% vector is a 3x1 column vector defined in the Earth-Centered Inertial
% (ECI) reference frame.
%

% Extract Earth Constants
mu = 3.986004418e14;        % Gravitational Parameter [m^3/s^2]

% Define Trigonometric Functions Function Handles.
C = @(x) cosd(x);
S = @(x) sind(x);

% Define Rotation Matrix Function Handles.
RotX = @(angle) [1 0 0; ...                 % X-Axis / 1-Rotation
                 0 C(angle) S(angle); ...
                 0 -S(angle) C(angle)];

RotZ = @(angle) [C(angle) S(angle) 0; ...   % Z-Axis / 3-Rotation
                -S(angle) C(angle) 0; ...
                 0 0 1];

%%%%%%%%%%%%%%%%%%% SOLVING FOR POSITION (E) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute Eccentric Anomaly (E).
E = Kepler_Solver(t, e, 0, a);

% Compute the True Anomaly (f).         
f = 2*atand(sqrt((1+e)/(1-e))*tan(E/2));    % [deg]

%%%%%%%%%%%%%%%%%%% PERIFOCAL FRAME CALCULATIONS %%%%%%%%%%%%%%%%%%%%%%%%%             
% Create 3-1-3 Rotation Matrix from Perifocal Frame to Earth Centered 
% Inertial (ECI) Frame. This will be the transpose of the ECI to Perifocal
% Rotation Matrix given by rotation with the following order:
%   1. Right Ascension of Ascending Node (Omega).
%   2. Inclination (i).
%   3. Argument of Perigee (omega).
ECI_2_Peri = RotZ(omega)*RotX(i)*RotZ(Omega);     % ECI to Perifocal.
Peri_2_ECI = ECI_2_Peri';                         % Perifocal to ECI.

% Compute the perifocal frame coordinates unit vector.
r_peri = [cosd(f); sind(f); 0];                   % Unitless.

%%%%%%%%%%%%%%%%%%%%%%% ECI FRAME CALCULATIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve for Position Magnitude (r).
r = a*(1 - e^2)/(1 + e*cosd(f));                   % Position [m]

% Determine the Position Vector in the ECI Frame.
r_ECI = Peri_2_ECI*r_peri;                        % Unitless.

% Add Magnitude to ECI Frame Position Vector.
r_ECI = r_ECI*r;                                  % Position [m].
      
end