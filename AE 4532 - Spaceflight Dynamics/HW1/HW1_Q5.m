%% AE 4532 Question 5
clc
close all 
clearvars

X0 = [5410.196306; -3155.187927; -3410.525863];
V0 = [5.0978938949; 3.69940690; 4.638173117];

t = linspace(0,172800, 10e3);
options = odeset('RelTol',1e-12,'AbsTol',1e-12);
[t_i,r_i] = ode45(@orbdyn,t,[X0;V0],options);

figure(1)
npanels=20;
erad = 6378.135; % equatorial radius (km)
prad = 6371.009; % polar radius (km)
axis(2e4*[-1 1 -1 1 -1 1]);
view(9,26);
hold on;
axis vis3d;
plot3(r_i(:,1),r_i(:,2),r_i(:,3))
[xx, yy, zz] = ellipsoid(0, 0, 0, erad, erad, prad, npanels);
globe = surf(xx, yy, -zz, 'FaceColor', 'none', 'EdgeColor', 0.5*[1 1 1]);
legend("Earth","Orbit")
title("Noe Lepez - 23 Jan 2022")
axis equal
xlabel('x [km]');
ylabel('y [km]');
zlabel('z [km]');
Gx = gcf;
Gx.Position(3:4) = Gx.Position(3:4)*2;
Ax = gca;
Ax.FontSize = Ax.FontSize *2;
saveas(figure(1),'Q5_plot.jpg')

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
