%% AE 4361 - HW 2 Question 3
% Noe Lepez Da Silva Duarte

clc
close all 
clearvars

a=2.5;

time = linspace(0,300,10000);
q_list = [];
z_list = [];

for t = time
    z = pos(t, a);
    z_list = [z_list z];
    v = vel(t, a);
    rho = rho_fnc(z);
    q = q_fnc(rho, v);
    q_list = [q_list q];
end

figure(1)
plot(z_list./1000, q_list)
xlabel("Altitude, z (km)")
ylabel("Dynamic pressure, q (N/m^2)")
title("Noe Lepez Da Silva Duarte")
grid on
Gx = gcf;
Gx.Position(3:4) = Gx.Position(3:4)*2;
Ax = gca;
Ax.FontSize = Ax.FontSize *2;
saveas(figure(1),'HW2_Q3_plot.jpg')

% Part d)
q_max = max(q_list);
max_position = find(q_list==q_max);
t_max = time(max_position);
z_max = z_list(max_position);


function z=pos(t, a)
    z = 0.5*a*t^2;
end

function v=vel(t, a)
    v=a*t;
end

function q=q_fnc(rho,v)
    q = 0.5 * rho * v^2;
end

function rho=rho_fnc(z)
    rho = 1.367 *exp(-z/(7.64*1000));
end