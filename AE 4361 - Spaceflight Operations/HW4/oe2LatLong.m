%% Orbital elements to lat/long/h
% By: Noe Lepez Da Silva Duarte
% Date: 12 Feb. 2022

function [lat, lon, h] = oe2LatLong(a,e,i,RAAN,w,t)
% This function computes an object's position in Earth Certered Earth Fixed
% reference frame coordinates from its orbital elements. It also calculates
% True anomaly from time using the Kepler_Solver function (when calculating
% radius)
% - a - Semi-major axis [m]
% - e - Eccentricity 
% - i - Inclination [deg]
% - RAAN - Right Ascension of Ascending Node [deg]
% - w = Argument of Perigee [deg]
% - t = time since initial mean anomaly [s].
%
% The function outputs latitude and longitude in degrees and altitude (h)
% in meters.
%

% Define Earth's gravitational parameter.
mu = 3.986004418e14;                                    % [m^3/s^2]
% Define Earths rotational velocity
w_E= 7.272*10^-5;                                       % [rad/s]
% Define Earth's radius
r_E = 6371000;                                          % [m]

% 1. Finding radius in ECI
[r_x, r_y, r_z] = oe2eci(a,e,i,RAAN,w,t);

% 2. Transfrom to ECEF
% Rotation from ECI to ECEF
a_E = w_E * t;
R3 = [cos(a_E) sin(a_E) 0;
         -sin(a_E) cos(a_E) 0;
         0 0 1];
r_ECI = [r_x;r_y;r_z];
r_ECEF = R3 * r_ECI;

% 3. Find lat, long, h
h = norm(r_ECI) - r_E;
lamb = atan2(r_ECEF(2),r_ECEF(1));
phi = (asin(r_ECEF(3,1)/norm(r_ECI)));
% Turn lambda and phi into degrees
lat = rad2deg(phi);
lon = rad2deg(lamb);

end

