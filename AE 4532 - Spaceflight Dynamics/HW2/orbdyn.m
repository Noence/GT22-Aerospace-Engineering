%% AE 4532 Orbit Dyanmics without J2
% By: Noe Lepez Da Silva Duarte, Created: 08 Feb. 2022
%(Copy-pasted from HW 1 script)

function dr = orbdyn(t, x)
    mu = 3.986E5;
    
    dr(1) = x(4); %x-vel
    dr(2) = x(5); %y-vel
    dr(3) = x(6); %z-vel
    dr(4) = -mu*(x(1))/(norm([x(1);x(2);x(3)])^3);
    dr(5) = -mu*(x(2))/(norm([x(1);x(2);x(3)])^3);
    dr(6) = -mu*(x(3))/(norm([x(1);x(2);x(3)])^3);
    dr = dr(:);
end