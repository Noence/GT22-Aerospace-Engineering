function Plot3D_Earth(Lat, Lon, h, fig)
% This function creates a 3-dimensional representation of the orbit of a
% given satellite based on the vehicle's latitude and longitude
% coordinates. The function inputs are as follows:
%
% - Lat = nx1 array of latitude coordinates. Must be in degrees.
% - Lon = nx1 array of longitude coordinates. Must be in degrees.
% - h = nx1 array of altitude coordinates. Must be in meters.
% - fig = figure handle to generate the plot in. For example, created a
%         figure as follows: f = figure(1), then 'f' would be 'fig'.
%
% The function outputs the orbit overlapped on a 3-dimensional
% representation of the Earth. Note that the function inputs can either be
% in the Earth-Centered Earth-Fixed (ECEF) or Earth-Centered Inertial )ECI)
% reference frames.
%

% Extract figure.
f = figure(fig);

% Define Earth parameters.
Re = 6.3712e6;                               % Equatorial radius [m].

% Compute radius from altitude.
r = h + Re;                                  % Radius of position [m].

% Compute vehicle x-y-z coordinates from latitude and longitude. 
xs = cosd(Lon).*cosd(Lat).*r;
ys = sind(Lon).*cosd(Lat).*r;
zs = sind(Lat).*r;

% Import topographic map of the Earth.
image = '1024px-Land_ocean_ice_2048.jpg';
set(gca, 'NextPlot','add', 'Visible','off');

% Configure plot settings.
axis auto;
axis vis3d;
hold on;

% Create ellipsoid coordinates.
[x, y, z] = ellipsoid(0, 0, 0, Re, Re, Re, 180);

% Generate Earth figure.
globe = surf(x, y, -z, 'FaceColor', 'none', 'EdgeColor', 0.5*[1 1 1]);
view([26,20]);

% Add texture to Earth figure.
cdata = imread(image);
set(globe, 'FaceColor', 'texturemap', 'CData', cdata, ...
    'FaceAlpha', 1, 'EdgeColor', 'none');
set(f,'color','k');

% Plot the orbit.
plot3(xs, ys, zs, 'r', 'Linewidth', 2);

end