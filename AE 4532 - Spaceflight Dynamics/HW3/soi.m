%% Sphere of influence calculator
% By: Noe Lepez Da Silva Duarte
% Created: 22 Feb. 2022

function [r] = soi(m_p, d)
% This function computes a planet's sphere of influence and outputs the 
% radius in km.
% - m_p - mass of planet [kg]
% - d - distance from the Sun [km]
%
% The function outputs r, the radius of sphere of influence in km

% Constants
m_s = 1.99E30;                               %[kg]

% Calculate the soi radius
r = ((m_p/m_s)^(2/5))*d;
end