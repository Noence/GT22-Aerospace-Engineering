%% Euler explicit method solver - multiple equations
% By: Noe Lepez Da Silva Duarte
% Created: 09 March 2022

function soln = EEm_solver(eqny, eqnz, h, y0s, xi, xf)

xc = xi;
yc = y0s(1);
zc = y0s(2);
soln = [];

    while xc<xf
        dydx = eqny(xc, yc, zc);
        dzdx = eqnz(yc, zc);
        yc = yc + dydx*h;
        zc = zc + dzdx*h;
        xc = xc + h;
        soln = [soln; xc, yc, zc];
    end

end