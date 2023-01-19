%% First order derivative of an array of points 
% By: Noe Lepez Da Silva Duarte
% Created: 21 March 2022

function dy = f_der_arr(x, y)
% This function uses 3 point forward difference and 3 point backward
% differece to calculate the derivatives as the first and last points, and
% uses central difference approximation for all other points. As such, the
% input array must consist of at least 3 points.

h = x(2)-x(1);

dy = [(-3*y(1)+4*y(2)-y(3))/(2*h)];

for i = 2:length(y)-1

    dy_inter = (y(i+1)-y(i-1))/(2*h);
    dy = [dy, dy_inter];

end

dy = [dy, (y(end-2)-4*y(end-1)+3*y(end))/(2*h)];

end