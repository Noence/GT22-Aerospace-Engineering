%% Ground Station Visibility check
% By: Noe Lepez Da Silva Duarte
% Date: 13 Feb. 2022

function [gamma] = GSVisibilityCheck(Gamma)
% This function determines the visibility of a satellite for a given ground
% station (hardcoded in the function in this case)
% 
% - Gamma = nx4 array representing [time (s), latitude (deg), longitude 
%           (deg), height (m)]
%
% The output, gamma, is an mx4 array with all times, latitudes, longitudes,
% and heights at which the satellite will be visible to the ground station
%

% Constants
r_E = 6371E3;                                   % [m]
eps_0 = deg2rad(20);                            % [rad]

% 1. Calculate the ground station's position in ECEF
phi_GS = deg2rad(48.096);
lamb_GS = deg2rad(-119.781);

r_GS_ecef = r_E*[cos(lamb_GS)*cos(phi_GS);sin(lamb_GS)*cos(phi_GS);sin(phi_GS)];

% 2. Find when the satellite is visible to the station
gamma = [];
counter = 1;
while counter<=length(Gamma)
    % Turn the position vector into individual lat and long in rad
    lamb = deg2rad(Gamma(counter,3));
    phi = deg2rad(Gamma(counter,2));
    
    % Find the satellite's position in ECEF 
    r_SAT_ecef = (r_E+Gamma(counter,4))* [cos(lamb)*cos(phi);sin(lamb)*cos(phi);sin(phi)];

    % Calculate the line of sight vector
    r_LOS = r_SAT_ecef - r_GS_ecef;

    % Find topocentric RF
    del = acos(dot(r_LOS,r_GS_ecef)/(norm(r_LOS)*norm(r_GS_ecef)));
    eps = (pi/2)-del;

    if eps>eps_0
        gamma = [gamma;Gamma(counter,:)];
    end
    counter = counter + 1;
end

end