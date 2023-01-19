%% Time of flight of Hohmann transfer for interplanetary transfer
% By: Noe Lepez Da Silva Duarte
% Created: 22 Feb. 2022

function [TOF, syn] = TOFHoh_planets(d1, d2)
% This function computes the time of flight the time taken on a Hohmann 
% transfer ellipse to go from one planet to another and the synodic period
% between the two.
% - d1, d2 - Distance between a planet and the sun [km]
%
% The function outputs TOF [days], the time of flight to go from planet 1 to
% planet 2, and the synodic period between the two [days]

% Constants
mu_S = 1.327E11;                                %[km^3/s^2]
stoday = 1/(60*60*24);

% Calculate time of flight
TOF = (pi *sqrt((d1+d2)^3/(8*mu_S)))*stoday;

% Calculate the synodic period
n1 = mean_motion(d1);
n2 = mean_motion(d2);

syn = (2*pi/(abs(n1-n2)))*stoday;

    function n = mean_motion(d)
        n = sqrt(mu_S/d^3);
    end
end