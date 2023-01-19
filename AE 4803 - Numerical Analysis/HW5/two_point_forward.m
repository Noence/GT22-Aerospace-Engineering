%% Derivative using two-point forward difference 
% By: Noe Lepez Da Silva Duarte
% Created: 21 March 2022

function soln = two_point_forward(f, pnt, h)

    f1 = f(pnt);
    f2 = f(pnt+h);

    soln = (f2-f1)/h;

end