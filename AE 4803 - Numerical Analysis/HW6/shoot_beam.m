%% Shooting method for beam
% By: Noe Lepez Da Silva Duarte
% Created: 10 March 2022

function [soln, dys] = shoot_beam(h, L)

P_end = 1E-7;
Pc = 100;
soln = [];
xi = 0;
dy0=0;
dys = [];
Ps = [];

while Pc>P_end
    dys = [dys, dy0];
    [x, ys] = ode45(@odes, [xi:h:L], [0;dy0]);
    soln = [soln;x, ys];
    if ys(end,1)==0
        Pc = 0;
    elseif isempty(Ps)
        dy0 = 1;
        Ps = [ys(end,1)];
    else
        Pc = ys(end,1);
        Ps = [Ps(end), Pc];
        dy0 = (dys(end-1)*Ps(end)-dys(end)*Ps(end-1))/(Ps(end)-Ps(end-1));
        
    end

end


    function beam = odes(x, Y)
        y = Y(1);z=Y(2);
        dydx=z;
        dzdx = (10^-7)*y +(10^-8)*x*(x-L);
        beam = [dydx;dzdx];
    end

end