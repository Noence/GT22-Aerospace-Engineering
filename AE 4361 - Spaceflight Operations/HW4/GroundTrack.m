function GroundTrack(Lat, Lon)
% This function generates a ground track plot for the latitude and
% longitude coordinates for a given satellite. The input variables are the
% following:
%
% - Lat = nx1 array of latitude coordinates. Must be in degrees.
% - Lon = nx1 array of longitude coordinates. Must be in degrees.
%
% The function will output the associated ground track as a figure. Note
% that the starting point of the ground track will be marked by a green
% point and the final point by a yellow point.
%

% Modify the longitude coordinates if necessary.
Lon = Lon + 360*(Lon < 0);               % Get longitude in range 0-360.

% Shift longitude cordinates to comply with -180 to 180 range.
Lon = Lon - 360*(Lon > 180);

% Plot the ground track.
plot(Lon, Lat, '.','LineWidth', 1.5, 'Color', [0.6350 0.0780 0.1840]);

% Configure plot.
axis equal;
set(gca,'XLim',[-180 180],'YLim',[-90 90], ... 
    'XTick', [-180 -120 -60 0 60 120 180], ...
    'Ytick',[-90 -60 -30 0 30 60 90]);
hold on;

% Highlight the starting and ending points.
scatter(Lon(1), Lat(1), ...
        'filled', 'MarkerEdgeColor', [0 0 0], ...
        'MarkerFaceColor', [0.4660 0.6740 0.1880])   % Start

scatter(Lon(end), Lat(end), ...
        'filled', 'MarkerEdgeColor', [0 0 0], ...
        'MarkerFaceColor', [0.9290 0.6940 0.1250])   % End 

% Add background to figure.
im = imread('Blue_Marble_2002.png');
handle = image([-180 180], -[-90 90], im);
uistack(handle, 'bottom')

% Add plot labels.
xlabel('Longitude [Deg]');
ylabel('Latitude [Deg]');
hold off

end
