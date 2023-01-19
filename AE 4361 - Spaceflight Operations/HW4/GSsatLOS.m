%% Lat & Long to azimuth and elevation
% By: Noe Lepez Da Silva Duarte
% Date: 14 Feb. 2022

function [azi, ele] = GSsatLOS(gamma)
% This function determines azimuth and elevation of a satellite for given
% latitudes, longitudes and heights
% 
% - Gamma = nx4 array representing [time (s), latitude (deg), longitude 
%           (deg), height (m)]
%
% The outputs, azi and ele, are azimuth and elevation angles of the
% satellite

% Constants
r_E = 6371E3;                                   % [m]

% 1. Calculate the ground station's position in ECEF
phi_GS = deg2rad(48.096);
lamb_GS = deg2rad(-119.781);

r_GS_ecef = r_E*[cos(lamb_GS)*cos(phi_GS);sin(lamb_GS)*cos(phi_GS);sin(phi_GS)];

% Turn the position vector into individual lat and long in rad
lamb = deg2rad(gamma(3));
phi = deg2rad(gamma(2));
% Find the satellite's position in ECEF
r_SAT_ecef = (r_E+gamma(4))* [cos(lamb)*cos(phi);sin(lamb)*cos(phi);sin(phi)];
% Calculate the line of sight vector
r_LOS = r_SAT_ecef - r_GS_ecef;
r_LOS_norm = (r_LOS)/(norm(r_LOS));
% Turn the unit vector of r_LOS into topocentric coordinates
r_LOS_norm_top = topocentric(phi, lamb, r_LOS_norm);

% Calculate Azimuth and Elevation angles
psi = atan2(r_LOS_norm_top(2),r_LOS_norm_top(1));
azi = rad2deg((pi/2)-psi);
ele = rad2deg(asin(r_LOS_norm_top(3)));


    function [r_top] = topocentric(phi, lambda, r_ecef)
        rot_mat = [-sin(lambda), cos(lambda), 0;
                 -sin(phi)*cos(lambda), -sin(phi)*sin(lambda), cos(phi);
                 cos(phi)*cos(lambda), cos(phi)*sin(lambda), sin(phi)];

        r_top = rot_mat * r_ecef;
    end

end