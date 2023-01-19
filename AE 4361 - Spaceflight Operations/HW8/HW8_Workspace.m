%% AE 4361 HW 8 Workspace
% By: Noe Lepez Da Silva Duarte
% Created: 02 April 2022

clear
close all
clc

%% Q1
% Part a
mf = 1000;                                              % [kg]
ve = 4400;                                              % [m/s]
dv = 9400+3260+680+1730;                                % [m/s]

mi = mf/(exp(-dv/ve))

% Part b
mass_fac = (exp(-dv/ve))*100

% Part c
dv_intercept = 9400+3260;                               % [m/s]
mi_intercept = mf/(exp(-dv_intercept/ve))

% Part d
dv_int_surf = 680+1730;                                 % [m/s]
mi_int_surf = mf/(exp(-dv_int_surf/ve))

% Part e
mass_fac_e = mf*100/(mi_int_surf+mi_intercept-1000)

%% Q3
a = 0.6;
e = 0.8;
SB_const = 5.67E-8;                                       % [W/(m^2 K^4)]
A_in_min = 0.1^2;                                         % [m^2]
a_h = sqrt(2*0.05^2);                                     % [m]
A_in_max = (a_h^2)*3*sqrt(3)/2;                           % [m^2]
A_out = 6*0.1^2;                                          % [m^2]
I_earth = 1366;                                           % [W/m^2]

% Part a
P_in_min = I_earth * a * A_in_min;                        % [W]
P_in_max = I_earth * a * A_in_max;                        % [W]

P_o = e*SB_const*A_out;

T_min_K = ((P_in_min)/(P_o))^(1/4);                       % [K]
T_max_K = ((P_in_max)/(P_o))^(1/4);                       % [K]

T_min = T_min_K -273.15                                   % [C]
T_max = T_max_K -273.15                                   % [C]

% Part b
P_int = 8;
T_min_K = ((P_in_min+P_int)/(P_o))^(1/4);                 % [K]
T_max_K = ((P_in_max+P_int)/(P_o))^(1/4);                 % [K]

T_min_b = T_min_K -273.15                                 % [C]
T_max_b = T_max_K -273.15                                 % [C]


% Part c
I_mars = I_earth/1.5^2;
P_int_mars = P_int/1.5^2;

P_in_min_mars = I_mars * a * A_in_min;                    % [W]
P_in_max_mars = I_mars * a * A_in_max;                    % [W]
T_min_K = ((P_in_min_mars+P_int_mars)/(P_o))^(1/4);       % [K]
T_max_K = ((P_in_max_mars+P_int_mars)/(P_o))^(1/4);       % [K]

T_min_mars = T_min_K -273.15                              % [C]
T_max_mars = T_max_K -273.15                              % [C]
