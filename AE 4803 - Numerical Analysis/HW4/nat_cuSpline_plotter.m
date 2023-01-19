%% Natural cubic spline plotter
% By: Noe Lepez Da Silva Duarte
% Created: 07 March 2022

function nat_cuSpline_plotter(coeffs, x, y)

figure(1)
scatter(x,y)
hold on

i=1;
while i<length(x)
    
    points = linspace(x(i), x(i+1), 1000);
    plot_points =[];
    for j = points
        inter_pnt = coeffs(1) + coeffs(2)*j +coeffs(3)*j^2+coeffs(4)*j^3;
        plot_points = [plot_points inter_pnt];
    end

    coeffs = coeffs(5:end);
    
    plot(points, plot_points, 'r')
    i = i+1;
end

end