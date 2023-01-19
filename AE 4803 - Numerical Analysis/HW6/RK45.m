%% Ruge-Kutta 4th order solver
% By: Noe Lepez Da Silva Duarte
% Created: 09 March 2022

function soln = RK45(eqn, h, y0, xi, xf)

xc = xi;
yc = y0;
soln = [xi, y0];

    while xc<xf
        k1 = eqn(xc, yc);
        k2 = eqn(xc+h/2, yc+k1*h/2);
        k3 = eqn(xc+h/2, yc+k2*h/2);
        xc = xc+h;
        k4 = eqn(xc, yc+k3*h);
        yc = yc + (k1+2*k2+2*k3+k4)*h/6;
        
        soln = [soln;xc,yc];
    end

end