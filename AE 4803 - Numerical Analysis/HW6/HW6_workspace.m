%% AE 4803 HW 6 Workspace
% By: Noe Lepez Da Silva Duarte
% Created: 09 April 2022

clear
close all
clc

%% Q1
eqn = @(x,y) -1.2*y +7*exp(-0.3*x);

h5 = EE_solver(eqn, 0.5, 3, 0, 2);
h05 = EE_solver(eqn, 0.05, 3, 0, 2);
h005 = EE_solver(eqn, 0.005, 3, 0, 2);

eqn_t = @(x) (70/9)*exp(-0.3*x)-(43/9)*exp(-1.2*x);
soln_true = [eqn_t(0.5);
             eqn_t(1);
             eqn_t(1.5);
             eqn_t(2)];

err5 = abs([h5(1,2);h5(2,2);h5(3,2);h5(4,2)] - soln_true);
err05 = abs([h05(10,2);h05(20,2);h05(30,2);h05(40,2)] - soln_true);
err005 = abs([h005(100,2);h005(200,2);h005(300,2);h005(400,2)] - soln_true);
x_ax = [0.5;1.0;1.5;2.0];

fig1 = figure;
plot(x_ax, [err5,err05,err005])
set(gca, 'YScale', 'log')
legend("h = 0.5", "h = 0.05", "h = 0.05", 'location', 'best')
xlabel('x')
ylabel('Trunctation error')
saveas(fig1, 'q1.png')

%% Q2

eqn = @(x,y) y*(-2*x +1/x);
h5 = mid_solver(eqn, 0.5, 0, 0, 2);
h2 =  mid_solver(eqn, 0.2, 0, 0, 2);

y_t = @(x) x*exp(-x^2);

t_soln2 = [];
for i = 0.2:0.2:2
    t_soln2 = [t_soln2;y_t(i)];
end

t_soln5 = [];
for i = 0.5:0.5:2
    t_soln5 = [t_soln5;y_t(i)];
end

fig2 = figure;
plot(h2(1:end-1,1), abs(h2(1:end-1,2)-t_soln2))
hold on
plot(h5(:,1), abs(h5(:,2)-t_soln5))
set(gca, 'YScale', 'log')
legend("h = 0.2", "h = 0.5", 'location', 'best')
xlabel('x')
ylabel('Trunctation error')
saveas(fig2, 'q2.png')

%% Q3 

eqn = @(x,y) 4*(x/y)- x*y;

soln5 = RK45(eqn, 0.5, 3, 0, 2);
soln_me = RK45(eqn, 0.05, 3, 0, 2);
[t, soln_mat] = ode45(eqn, 0:0.05:2, 3);

fig3 = figure;
plot(t, [soln_mat, soln_me(:,2)])
xlabel('x')
ylabel('y')
legend("ode45", "RK4")
saveas(fig3, 'Q3_c.png')

soln_t05 = [];
eqn_t = @(x) sqrt(4+5*exp(-x^2));
for i = 0:0.05:2
    soln_t05 = [soln_t05;eqn_t(i)];
end

soln_t5 = [];
for i = 0:0.5:2
    soln_t5 = [soln_t5;eqn_t(i)];
end

fig4 = figure;
plot(t, [abs(soln_mat-soln_t05), (soln_me(:,2)-soln_t05)])
hold on
plot(soln5(:,1), abs(soln5(:,2)-soln_t5))
set(gca, 'YScale', 'log')
xlabel('x')
ylabel('Trunctation error')
legend("ode45", "RK4", "h=0.5", 'Location','best')
saveas(fig4, 'Q3_d.png')

%% Q4
eqn = @(h) -(0.02^2 *sqrt(2*9.81*h))/(h*(2*4-h));
height = RK45(eqn, 0.5, 6.5, 0, 30000);

fig5 = figure;
plot(height(:,1), height(:,2))
xlabel("Time (s)")
ylabel("Height (m)")
saveas(fig5, "q4.png")

%% Q5
eqn1 = @(x,y,z) (-y+z)*exp(1-x)+0.5*y;
eqn2 = @(y,z) y-z^2;

soln1 = EEm_solver(eqn1,eqn2,0.1, [3,0.2], 0, 5);
soln01 = EEm_solver(eqn1,eqn2,0.01, [3,0.2], 0, 5);
soln05 = EEm_solver(eqn1,eqn2,0.05, [3,0.2], 0, 5);

fig6 = figure;
plot(soln1(:,1), soln1(:,2), 'r')
hold on
plot(soln1(:,1), soln1(:,3), 'r--')
plot(soln01(:,1), soln01(:,2), 'b')
plot(soln01(:,1), soln01(:,3), 'b--')
plot(soln05(:,1), soln05(:,2), 'g')
plot(soln05(:,1), soln05(:,3), 'g--')
legend("y - h = 0.1","z - h = 0.1", "y - h = 0.01","z - h = 0.01", "y - h = 0.05","z - h = 0.05")
xlabel("Time (s)")
ylabel("Output")
saveas(fig6, "Q5_c.png")

[t45, soln45] = ode45(@odes,[0;5],[3,0.2]);
[t23, soln23] = ode23(@odes,[0;5],[3,0.2]);
[t113, soln113] = ode113(@odes,[0;5],[3,0.2]);

fig7 = figure;
plot(t45, soln45(:,1), 'r')
hold on
plot(t45, soln45(:,2), 'r--')
plot(t23, soln23(:,1), 'b')
plot(t23, soln23(:,2), 'b--')
plot(t113, soln113(:,1), 'g')
plot(t113, soln113(:,2), 'g--')
legend("y - ode45","z - ode45", "y - ode23","z - ode23", "y - ode113","z - ode113", "Location","best")
saveas(fig7, "q5_d.png")

function dw = odes(t, X)

y = X(1); z = X(2);
dw = [(-y+z)*exp(1-t)+0.5*y;y - z^2];

end

%% Q6

[t45, soln45] = ode45(@odes,[1E-15,2],[0,1]);

fig8 = figure;
plot(t45,soln45(:,1))
xlabel('x')
ylabel('y')
saveas(fig8, 'Q6.png')

function bressel = odes(x, Y)
nu = 1;
y = Y(1); z = Y(2);
dydx = z;
dzdx = (1.0 / x^2)* (-x * z - (x^2 - nu^2) * y);

bressel = [dydx;dzdx];
end

%% Q7 

[t45, soln45] = ode45(@odes,[0,1],[1;0;0;0]);
fig9 = figure;
plot(t45,soln45)
xlabel('Time')
ylabel('Solution')
legend('x1','x2','x3','x4', 'Location','best')
saveas(fig9, 'Q7.png')



function IVP = odes(~, Y)

A = [3, -3, 2, -1;
     12, -12, 10, -5;
     15, -15, 14, -7;
     6, -6, 6, -3];

x1 = Y(1);x2 = Y(2); x3 = Y(3); x4 = Y(4);

IVP = A*Y;
end


%% Q8 
tic;
[soln10, dys10] = shoot_beam(10, 100);
t10 = toc;
tic;
[soln1, dys1] = shoot_beam(1, 100);
t1 = toc;
tic;
[soln01, dys01] = shoot_beam(0.1, 100);
t01 = toc;

fig10 = figure;
plot(soln10(1:11,1), soln10(1:11,2))
hold on
% plot(soln10(12:22,1), soln10(12:22,2))
plot(soln10(23:33,1), soln10(23:33,2))
legend(sprintf('dy0 = %f', dys10(1)), sprintf('dy0 = %f', dys10(3)), 'Location','best')
saveas(fig10, 'Q8_10s.png')

fig11 = figure;
plot(soln1(1:101,1), soln1(1:101,2))
hold on
% plot(soln1(102:202,1), soln1(102:202,2))
plot(soln1(203:303,1), soln1(203:303,2))
legend(sprintf('dy0 = %f', dys1(1)), sprintf('dy0 = %f', dys1(3)), 'Location','best')
saveas(fig11, 'Q8_1s.png')

fig12 = figure;
plot(soln01(1:1001,1), soln01(1:1001,2))
hold on
% plot(soln01(1002:2002,1), soln01(1002:2002,2))
plot(soln01(2003:3003,1), soln01(2003:3003,2))
legend(sprintf('dy0 = %f', dys01(1)), sprintf('dy0 = %f', dys01(3)), 'Location','best')
saveas(fig12, 'Q8_01s.png')

% part b


A = [(10^(-7)-2) , 1 , 0;
    1 ,(10^(-7)-2) , 1;
    0 ,(10^(-7)-2) , 1];

ys = [0];

for i = 2:98
    B = [99* 10^-8;(-i+100)* 10^-8;10^-8];
    soln = A\B;
    if i == 2
        ys = [ys; soln(1);soln(2)];
    elseif i == 98
        ys = [ys;soln(2);soln(3)];
    else
        ys = [ys; soln(2)];
    end
end

ys = [ys;0];

fig13 = figure;
plot(0:100, ys)
xlabel("x")
ylabel("y")
saveas(fig13, "Q8b.png")
