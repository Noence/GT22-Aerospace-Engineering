%% AE 4361 Geodetic coordinates to ECEF
% By: Noe Lepez Da Silva Duarte
% Created: 20 Feb. 2022

function [r] = LatLong2ECEF(geodetic)
% This function computes an object's position in ECEF from geodetic 
% latitude, longitude and height
% - geodetic - array with [lat, long, h]
% - lat - Latitude (phi) [deg]
% - long - Longitude (lambda) [deg]
% - h - height [km]
%
% The function outputs r = [x;y;z] in [km]

% Define Earth's radius
r_E = 6371;                                            % [km]

phi = deg2rad(geodetic(1));
lamb = deg2rad(geodetic(2));

r = (r_E+geodetic(3))* [cos(lamb)*cos(phi);sin(lamb)*cos(phi);sin(phi)];

end