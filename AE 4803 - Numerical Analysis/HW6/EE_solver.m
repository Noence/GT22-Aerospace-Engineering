%% Euler explicit method solver
% By: Noe Lepez Da Silva Duarte
% Created: 09 March 2022

function soln = EE_solver(eqn, h, y0, xi, xf)

xc = xi;
yc = y0;
soln = [];

    while xc<xf
        dydx = eqn(xc, yc);
        yc = yc + dydx*h;
        xc = xc + h;
        soln = [soln; xc, yc];
    end

end