%% Second order derivative of an array of points 
% By: Noe Lepez Da Silva Duarte
% Created: 21 March 2022

function dy = s_der_arr(x, y)
% This function uses 4 point forward difference and 4 point backward
% differece to calculate the derivatives as the first and last points, and
% uses 3 point central difference approximation for all other points. 
% As such, the input array must consist of at least 4 points.

h = x(2)-x(1);

dy = [(2*y(1)-5*y(2)+4*y(3)-y(4))/(h^2)];

for i = 2:length(y)-1

    dy_inter = (y(i+1)-2*y(i)+y(i-1))/(h^2);
    dy = [dy, dy_inter];

end

dy = [dy, (-y(end-3)+4*y(end-2)-5*y(end-1)+2*y(end))/(2*h)];

end