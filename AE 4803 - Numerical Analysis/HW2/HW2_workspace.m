%% AE 4803 - HW 2 Workspace
% By: Noe Lepez Da Silva Duarte

clc
close all
clear

%Q1_a & Q1_b

% fnc = @(x) x^3 -exp(-x/2);
% bracket = [0,2];
% error = 0.001;
% x0 = 0.866;
% [ans, iterations, Ea] = bisection_true(fnc, bracket, error, x0);
% 
% 
% % Q1_c
% % [ans, iterations] = false_position(fnc, bracket, Ea)
% 
% % Q1_d
% fnc_p = @(x) 3*x^2 +0.5*exp(-x/2);
% [ans, iterations] = Newt_Raph(0, Ea, fnc, fnc_p)

%Q2_a
fnc = @(x) x^5 - 180;
fnc_p = @(x) 5*x^4;
init = 3 ;
Ea = 0.0001;
% [sol_1, iterations_1] = Newt_Raph(init, Ea, fnc, fnc_p);
% init = 10;
% [sol_2, iterations_2] = Newt_Raph(init, Ea, fnc, fnc_p);
% 
% figure(1)
% plot(linspace(1,length(iterations_1), length(iterations_1)), iterations_1)
% hold on
% plot(linspace(1,length(iterations_2), length(iterations_2)), iterations_2)
% xlabel("Iteration number")
% ylabel("Calculated root")
% legend("Initial conition = 3", "Initial conition = 10")
% saveas(figure(1),"Q2_a","png")

%Q2_b
% init = 0 ;
% [sol, iterations] = Newt_Raph(init, Ea, fnc, fnc_p);
% figure(2)
% plot(linspace(1,length(iterations), length(iterations)), iterations)
% hold on
% xlabel("Iteration number")
% ylabel("Calculated root")
% saveas(figure(2),"Q2_b","png")

%Q3
% initial_guess = [1;1];
% error = 0.001;
% 
% syms x y
% func_1 = @(x,y) 4*x^2 - y^3 + 28;
% func_2 = @(x,y) 3*x^3 + 4*y^2 - 145;
% 
% func_1_dx = @(x) 8*x;
% func_1_dy = @(y) -3*y^2;
% func_2_dx = @(x) 9*x^2;
% func_2_dy = @(y) 8*y;
% 
% [sol, iter] = Newt_Raph_simu(initial_guess,func_1, func_2, func_1_dx, ...
%     func_1_dy, func_2_dx, func_2_dy, error)


% Q4
% init = -1;
% Ea = 0.001;
% fnc = @(d) (1/3) * pi * d^2 *(1.35 - d) - (7/103);
% fnc_p = @(d) -(pi*d*(10*d-9))/10;
% [sol, iterations] = Newt_Raph(init, Ea, fnc, fnc_p);
% figure(2)
% plot(linspace(1,length(iterations), length(iterations)), iterations)
% hold on
% xlabel("Iteration number")
% ylabel("Calculated root")
% saveas(figure(2),"Q2_b","png")

%Q5
init = 1;
Ea = 0.0001;
e = 0.0006506;
M = 0.137193;
fnc = @(E) E-e*sin(E)-M;
fnc_p = @(E) 1-e*cos(E);
[sol, iterations, errors] = Newt_Raph(init, Ea, fnc, fnc_p);

f = 2*atan(tan(sol/2)*((1-e)/(1+e))^(-1/2));
radius = 6731*(1-e*cos(sol));

figure(2)
plot(linspace(1,length(iterations), length(iterations)), iterations)
hold on
xlabel("Iteration number")
ylabel("Calculated root")
saveas(figure(2),"Q5_iter","png")

figure(3)
plot(linspace(1,length(iterations), length(iterations)), errors)
hold on
xlabel("Iteration number")
ylabel("Approximate error (%)")
saveas(figure(3),"Q5_err","png")

