%% Midpoint method solver
% By: Noe Lepez Da Silva Duarte
% Created: 09 March 2022

function soln = mid_solver(eqn, h, y0, xi, xf)

xc = xi;
yc = y0;
soln = [];

    while xc<xf
        if xc == 0
            x_half = xc+h/2;
            dydx = 1;
            yc_half = yc + dydx*h/2;
            xc = xc + h;
            dydx = eqn(x_half, yc_half);
            yc = yc + dydx*h;
            soln = [soln; xc, yc];
        else
            x_half = xc+h/2;
            dydx = eqn(xc, yc);
            yc_half = yc + dydx*h/2;
            xc = xc + h;
            dydx = eqn(x_half, yc_half);
            yc = yc + dydx*h;
            soln = [soln; xc, yc];
        end
    end

end