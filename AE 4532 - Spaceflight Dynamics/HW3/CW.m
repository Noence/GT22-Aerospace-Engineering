%% Calculate A,B,C,D for relative equation of motion
% By: Noe Lepez Da Silva Duarte
% Created: 22 Feb. 2022

function [A,B,C,D] = CW(w,t)
% This function computes the A, B, C, D matrices for relative equation 
% of motion
% - w - Omega [rad/s]
% - t - Time [s]
%
% The function outputs r = [A, B, C, D] matrices

wt = w*t;

A = [4-3*cos(wt), 0, 0;
     6*(sin(wt)-wt), 1, 0;
     0, 0, cos(wt)];

B = [(1/w)*sin(wt), (2/w)*(1-cos(wt)), 0;
     (2/w)*(cos(wt)-1), (1/w)*(4*sin(wt)-3*wt), 0;
     0, 0, (1/w)*sin(wt)];

C = [3*w*sin(wt), 0, 0;
     6*w*(cos(wt)-1), 0, 0;
     0, 0, -w*sin(wt)];

D = [cos(wt), 2*sin(wt), 0;
     -2*sin(wt), 4*cos(wt)-3, 0
     0, 0, cos(wt)];

end