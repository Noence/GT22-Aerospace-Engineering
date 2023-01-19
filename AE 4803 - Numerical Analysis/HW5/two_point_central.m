%% Derivative using two-point central difference 
% By: Noe Lepez Da Silva Duarte
% Created: 21 March 2022

function soln = two_point_central(f, pnt, h)

    f1 = f(pnt-h);
    f2 = f(pnt+h);

    soln = (f2-f1)/(2*h);

end