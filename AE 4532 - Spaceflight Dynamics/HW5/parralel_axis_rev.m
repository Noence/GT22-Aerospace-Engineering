%% Parallel axis theorem Reverse
% By: Noe Lepez Da Silva Duarte
% Created: 31 March 2022

function I_n = parralel_axis_rev(I,x,y,z,M)

par = [y^2+z^2, -x*y, -x*z;
       -x*y, x^2+z^2, -z*y;
       -z*x, -y*z, x^2+y^2]*M;

I_n = I - par;


end