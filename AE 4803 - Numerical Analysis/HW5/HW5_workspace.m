%% HW 5 Workspace
% By: Noe Lepez Da Silva Duarte
% Created: 21 March 2022

clc
clear
close all

%% Q2

f = @(x) (x^2 - 1)/(x^3 * tan(x));
pnt = 2;
% err = logspace(-12, 0, 1000);
err = linspace(10^(-12), 1, 1000);
soln_frwd = [];
soln_cent = [];


for i =err
    soln = two_point_forward(f, pnt, i);
    soln_frwd = [soln_frwd, soln];

    solnc = two_point_central(f, pnt, i);
    soln_cent = [soln_cent, solnc];
end

figure(1)
plot(err, soln_frwd, err, soln_cent)
xlabel("Step size")
ylabel("Calculated value")
legend("Forward difference", "Central difference", 'Location','best')
% saveas(figure(1), 'solns.png')

err_frwd = abs(soln_frwd+0.42494);
err_cent = abs(soln_cent+0.42494);

figure(2)
loglog(err, err_frwd, err, err_cent)
xlabel("Step size")
ylabel("True error")
legend("Forward difference", "Central difference", 'Location','best')
% saveas(figure(2), 'errors.png')

%% Q3

t = [0:10:80];
v = [13.41,12.96,12.07,10.73,8.05,5.36,2.23,0.45,0];

a = [(-3*v(1)+4*v(2)-v(3))/(2*10E-3)];

for i = 2:length(v)-1

    a_inter = (v(i+1)-v(i-1))/(2*10E-3);
    a = [a, a_inter];

end

a = [a, (v(end-2)-4*v(end-1)+3*v(end))/(2*10E-3)];
F = 907*a;

figure(3)
plot(t,F)
xlabel("Time (ms)")
ylabel("Force (N)")
saveas(figure(3), "fvt.png")

%% Q4

t = [0:4:32];
r = [18.80,18.86,18.95,19.04,19.15,19.26,19.38,19.49,19.62]*10^3;
th = [0.785,0.779,0.770,0.759,0.748,0.735,0.721,0.707,0.692];

dr = f_der_arr(t,r);
dr2 = s_der_arr(t,r);
dth = f_der_arr(t,th);
dth2 = s_der_arr(t,th);

v_arr = [];
a_arr = [];

for i = 1:length(t)
    
    v = sqrt(dr(i)^2 + (r(i)*dth(i))^2);
    v_arr = [v_arr, v];

    a = sqrt((dr2(i)-r(i)*dth(i)^2)^2 + (r(i)*dth2(i)+2*dr(i)*dth(i))^2);
    a_arr = [a_arr, a];

end

figure(4)
plot(t, v_arr)
xlabel("Time (s)")
ylabel("Velocity (m/s)")
grid on
% saveas(figure(4), 'q4_v.png')

figure(5)
plot(t, a_arr)
xlabel("Time (s)")
ylabel("Acceleration (m/s^2)")
grid on
% saveas(figure(5), 'q4_a.png')

%% Q5

f=@(x) 1/(sqrt(x^3 +1));
a=0;
b=3;
soln_a = trapz_r(f, a, b, 2);
soln_b = trapz_r(f, a, b, 10);
soln_c = s13_r(f, a, b, 2);
soln_d = s13_r(f, a, b, 10);
soln_e = gauss_2pnt(f, a, b);

%% Q6

f=@(x) x^3 * sin(x^2);
a=0;
b=pi;
soln_a = trapz_r(f, a, b, 2);
soln_b = trapz_r(f, a, b, 10);
soln_c = s13_r(f, a, b, 2);
soln_d = s13_r(f, a, b, 10);
soln_e = gauss_2pnt(f, a, b);

%% Q7

f_s = @(r) r;
f_v = @(r) r^2;
a = 0;
b = 15.24;

% Trapezoidal rule
s_t = 4*pi*trapz_r(f_s, a, b, 6);
v_t = 2*pi*trapz_r(f_v, a, b, 6);

% Simpson 1/3 rule
s_13 = 4*pi*s13_r(f_s, a, b, 6);
v_13 = 2*pi*s13_r(f_v, a, b, 6);

% Simpson 3/8 rule
s_38 = 4*pi*s38_r(f_s, a, b, 6);
v_38 = 2*pi*s38_r(f_v, a, b, 6);

%% Q8

f = @(t) exp(-t^2);

I_tr = 2*(1/sqrt(pi))*trapz_r(f,0,2,10);
I_13 = 2*(1/sqrt(pi))*s13_r(f, 0, 2, 10);

%% Q9
rho = 75000; %kg/m^3, stainless steel
f=@(x) (x+0.01)^-1 * (cos(x))^2;

trapz_r(f, 0, 4.71, 10)


