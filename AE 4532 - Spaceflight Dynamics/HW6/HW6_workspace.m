%% AE 4532 HW 6 Part 2 Workspace
% By: Noe Lepez Da Silva Duarte
% Created: 04 April 2022

clear
close all
clc

%% Q4

I = [35,0,0;0,14,0;0,0,8];

% a
w_deg = [28;0;5.5];
w_rad = w_deg*pi/180;
T = 0.5*transpose(w_rad)*I*w_rad;
H = I*w_rad;

% b
options = odeset('RelTol',1e-12,'AbsTol',1e-12);
t = 0:1:150;
[t_i,w_i] = ode45(@odes,t,w_rad,options);

f1 = figure;
hold on
plot(t_i,w_i(:,1))
plot(t_i,w_i(:,2))
plot(t_i,w_i(:,3))
title("Angular Velocity Components")
xlabel("Time, t [s]")
ylabel("Angular Velocity, {\omega} [rad/s]")
legend("{\omega}_1","{\omega}_2","{\omega}_3")
grid on
hold off
% saveas(f1,"ang_vel_4b.png")

% c
A = I(1,1);
B = I(2,2);
C = I(3,3);

Ht = [A*w_i(:,1) B*w_i(:,2) C*w_i(:,3)];
Htmag = sqrt(Ht(:,1).^2 + Ht(:,2).^2 + Ht(:,3).^2);

Hmag = norm(H);
Hdev = Htmag - Hmag;

f2 = figure;
plot(t_i,Hdev)
title("Angular Momentum (Mag) Deviation")
xlabel("Time, t [s]")
ylabel("Angular Momentum (Mag) Deviation, {\Delta}H_{mag} [kgm^{2}/s]")
grid on
% saveas(f2,"hdev_4c.png")

Tdev = (0.5*((A*w_i(:,1).^2) + (B*w_i(:,2).^2) + (C*w_i(:,3).^2))) - T;

f3 = figure;
plot(t_i,Tdev)
title("Kinetic Energy Deviation")
xlabel("Time, t [s]")
ylabel("Kinetic Energy Deviation, {\Delta}T [kgm^{2}/s^{2}]")
grid on
% saveas(f3,"tdev_4c.png")

% d
f4 = figure;
H_ell = [Hmag/(2*A) Hmag/(2*B) Hmag/(2*C)];
view(9,26)
axis vis3d
[xx,yy,zz] = ellipsoid(0, 0, 0, H_ell(1), H_ell(2), H_ell(3));
globe = surf(xx,yy,zz, 'FaceColor', 'b', 'EdgeColor', 'none');
alpha 0.25
hold on
E_ell = sqrt([T/(2*A) T/(2*B) T/(2*C)]);
view(0,26)
axis vis3d
[xx,yy,zz] = ellipsoid(0, 0, 0, E_ell(1), E_ell(2), E_ell(3));
globe2 = surf(xx,yy,zz, 'FaceColor', 'r', 'EdgeColor', 'none');
alpha 0.25
plot3(w_i(:,1)/2,w_i(:,2)/2,w_i(:,3)/2,'Color','g') % /2 for radial distance
plot3(-w_i(:,1)/2,-w_i(:,2)/2,-w_i(:,3)/2,'Color','g')
axis equal
xlabel("b1 [rad/s]")
ylabel("b2 [rad/s]")
zlabel("b3 [rad/s]")
legend('H-ellipsoid', 'T-ellipsoid','{\omega}(t)')
hold off
% saveas(f4,"4d_Polhode.png")

% e
w_deg = [0;30;4];
w_rad = w_deg*pi/180;
T = 0.5*transpose(w_rad)*I*w_rad;
H = I*w_rad;
Hmag = norm(H);

options = odeset('RelTol',1e-12,'AbsTol',1e-12);
t = 0:1:150;
[t_i,w_i] = ode45(@odes,t,w_rad,options);

f5 = figure;
hold on
plot(t_i,w_i(:,1))
plot(t_i,w_i(:,2))
plot(t_i,w_i(:,3))
title("Angular Velocity Components")
xlabel("Time, t [s]")
ylabel("Angular Velocity, {\omega} [rad/s]")
legend("{\omega}_1","{\omega}_2","{\omega}_3")
grid on
hold off
% saveas(f5,"ang_vel_4e.png"')

% f
f6 = figure;
H_ell = [Hmag/(2*A) Hmag/(2*B) Hmag/(2*C)];
view(9,26)
axis vis3d
[xx,yy,zz] = ellipsoid(0, 0, 0, H_ell(1), H_ell(2), H_ell(3));
globe = surf(xx,yy,zz, 'FaceColor', 'b', 'EdgeColor', 'none');
alpha 0.25
hold on
E_ell = sqrt([T/(2*A) T/(2*B) T/(2*C)]);
view(0,26)
axis vis3d
[xx,yy,zz] = ellipsoid(0, 0, 0, E_ell(1), E_ell(2), E_ell(3));
globe2 = surf(xx,yy,zz, 'FaceColor', 'r', 'EdgeColor', 'none');
alpha 0.25
plot3(w_i(:,1)/2,w_i(:,2)/2,w_i(:,3)/2,'Color','g') % /2 for radial distance
plot3(-w_i(:,1)/2,-w_i(:,2)/2,-w_i(:,3)/2,'Color','g')
axis equal
xlabel("b1 [rad/s]")
ylabel("b2 [rad/s]")
zlabel("b3 [rad/s]")
legend('H-ellipsoid', 'T-ellipsoid','{\omega}(t)')
hold off
saveas(f6,"4f_Polhode.png")

function dw = odes(~, w)

A = 35;
B = 14;
C = 8;

dw = zeros(3,1);

dw(1) = ((B - C)/A)*w(2)*w(3);
dw(2) = ((C - A)/B)*w(1)*w(3);
dw(3) = ((A - B)/C)*w(1)*w(2);


end