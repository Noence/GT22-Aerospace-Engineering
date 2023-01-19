%% AE 4631 - HW 4 workspace
% By: Noe Lepez Da Silva Duarte
% Date: 12 Feb. 2022

clc
clear
close all
%% Q1
% Test
% a = 6.796620707e6; i = 51.6439; e = 2.404e-4; RAAN = 86.8571; w = 1.8404;
% t = 15000;
% 
% t_arr = linspace(0,t,15001);
% pos_arr = [];
% 
% for j = t_arr
%     [lat, lon, h] = oe2LatLong(a,e,i,RAAN,w,j);
%     pos_arr = [pos_arr ; lat, lon];
% 
% end
% 
% GroundTrack(pos_arr(:,1), pos_arr(:,2))
% title('ISS Ground Track - Noe Lepez')

% Part a - Planet Lab's FLOCK 2P-6

a = 6.864718799e6; i = 97.3262; e = 8.8380e-4; RAAN = 218.6861; 
w = 216.6629; t = 17000;

t_arr = linspace(0,t,t+1);
pos_arr = [];

for j = t_arr
    [lat, lon, h] = oe2LatLong(a,e,i,RAAN,w,j);
    pos_arr = [pos_arr ; lat, lon, h];

end

% Create the ground track
GroundTrack(pos_arr(:,1), pos_arr(:,2))
title('FLOCK 2P-6 Ground track - Noe Lepez')
Gx = gcf;
Gx.Position(3:4) = Gx.Position(3:4)*2;
Ax = gca;
saveas(figure(1), "q1_a.png")

% Create the 3D ground track
Plot3D_Earth(pos_arr(:,1), pos_arr(:,2), pos_arr(:,3), 2)
title('FLOCK 2P-6 3D Ground track- Noe Lepez')
Gx = gcf;
Gx.Position(3:4) = Gx.Position(3:4)*2;
Ax = gca;
saveas(figure(2), "q1_a_3d.png")

% Part b - Molniya 2-9 Communication Satellite
% Clear the previous figure and vars
clc
clear
close all

a = 2.323698972e7; i = 64.0370; e = 0.680478; RAAN = 343.6936; 
w = 288.0884; t = 86400;

t_arr = linspace(0,t,t+1);
pos_arr = [];

for j = t_arr
    [lat, lon, h] = oe2LatLong(a,e,i,RAAN,w,j);
    pos_arr = [pos_arr ; lat, lon, h];

end

% Create the ground track
GroundTrack(pos_arr(:,1), pos_arr(:,2))
title('Molniya 2-9 Communication Satellite Ground track - Noe Lepez')
Gx = gcf;
Gx.Position(3:4) = Gx.Position(3:4)*2;
Ax = gca;
saveas(figure(1), "q1_b.png")

% Create the 3D ground track
Plot3D_Earth(pos_arr(:,1), pos_arr(:,2), pos_arr(:,3), 2)
title('Molniya 2-9 Communication Satellite 3D Ground track - Noe Lepez')
% Gx = gcf;
% Gx.Position(3:4) = Gx.Position(3:4)*2;
% Ax = gca;
saveas(figure(2), "q1_b_3d.png")

%% Q2
% Clear the previous figure and vars
clc
clear
close all

% Part a
phi_GS = deg2rad(48.096);
lamb_GS = deg2rad(-119.781);

r_GS_ecef = 6371E3*[cos(lamb_GS)*cos(phi_GS);
                    sin(lamb_GS)*cos(phi_GS);
                    sin(phi_GS)];

% Part b
% Test
% a = 6.796620707e6; i = 51.6439; e = 2.404e-4; RAAN = 86.8571; w = 1.8404;
% t = 65000;
% 
% t_arr = linspace(0,t,t+1);
% pos_arr = [];
% 
% for j = t_arr
%     [lat, lon, h] = oe2LatLong(a,e,i,RAAN,w,j);
%     pos_arr = [pos_arr ; j, lat, lon, h];
% 
% end
% 
% test_out = GSVisibilityCheck(pos_arr);
% test_out(1,:)

% Planet Lab's FLOCK 2P-6

a = 6.864718799e6; i = 97.3262; e = 8.8380e-4; RAAN = 218.6861; 
w = 216.6629; t = 40000;

t_arr = linspace(0,t,t+1);
pos_arr = [];

for j = t_arr
    [lat, lon, h] = oe2LatLong(a,e,i,RAAN,w,j);
    pos_arr = [pos_arr ; j, lat, lon, h];

end

vis = GSVisibilityCheck(pos_arr);
vis(1,:)

%% Q3
% Part a
[azi, elev] = GSsatLOS(vis(1,:));

% Part b

% Test
% a = 6.796620707e6; i = 51.6439; e = 2.404e-4; RAAN = 86.8571; w = 1.8404;
% t = 65000;
% 
% t_arr = linspace(0,t,t+1);
% pos_arr = [];
% 
% for j = t_arr
%     [lat, lon, h] = oe2LatLong(a,e,i,RAAN,w,j);
%     pos_arr = [pos_arr ; j, lat, lon, h];
% end
% 
% test_out = GSVisibilityCheck(pos_arr);

c = 1;
theta = [];
rho = [];
elev_arr = [];
azi_arr = [];
while c<=length(vis)
    [azi, elev] = GSsatLOS(vis(c,:));
    elev_arr = [elev_arr;elev];
    azi_arr = [azi_arr;azi];
    % Transfrom azimuth and elevation into theta and rho
    theta = [theta;azi*(pi/180)];
    rho = [rho;1-(elev/90)];
    c = c+1;
end


% Plot theta and rho
figure(6)
polarplot(theta, rho, 'r.')
hold on
rlim([0 1])
ax = gca;
ax.ThetaZeroLocation = 'top';
ax.ThetaDir = 'clockwise';
ax.RTickLabel = {};
title("Noe Lepez - 14 Feb. 2022")
saveas(figure(6), "Q3b.png")


