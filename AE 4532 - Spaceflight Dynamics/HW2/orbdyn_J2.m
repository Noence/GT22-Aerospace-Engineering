%% Orbit Dynamics with J2
% By: Noe Lepez Da Silva Duarte, Created: 08 Feb. 2022


function dr = orbdyn_J2(t, x)
    mu = 3.986E5;
    J2 = 0.00108263;
    Re = 6378.135;

    dr(1) = x(4); %x-vel
    dr(2) = x(5); %y-vel
    dr(3) = x(6); %z-vel

    r = norm([x(1);x(2);x(3)]);
    a_J2_mat = [(1-5*(x(3)/r)^2)*x(1)/r;
                (1-5*(x(3)/r)^2)*x(2)/r;
                (3-5*(x(3)/r)^2)*x(3)/r];
    a_J2 = -(3/2)*J2*(mu/r^2)*((Re/r)^2)*a_J2_mat;

    dr(4) = -(mu*(x(1))/(r^3))+a_J2(1);
    dr(5) = -(mu*(x(2))/(r^3))+a_J2(2);
    dr(6) = -(mu*(x(3))/(r^3))+a_J2(3);
    dr = dr(:);
end