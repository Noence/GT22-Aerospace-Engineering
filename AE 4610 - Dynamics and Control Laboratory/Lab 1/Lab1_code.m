%% AE 4610 - Lab 1
% Noe Lepez Da Silva Duarte

close all
clearvars
clc
set(0,'defaultAxesFontSize', 10);

%% Question 1

A = [-0.02 0.1 0 -32.2 ; -0.040 -0.8 180 0 ; 0 -0.003 -1.0 0 ; 0 0 1 0];
B = [ 0 ; -8 ; -4 ; 0];
C = [0 0 0 1];
D=0;

% Part i
[V,S]=eig(A)

% Part ii
[num,den]=ss2tf(A,B,C,D);
G1=tf(num,den)

% Part iii
[z, p, k] = zpkdata(G1)

% Part iv
[A2, B2, C2, D2]=tf2ss(num,den)

% Part v
bode(G1)

% Part vi
C= [0 0 1 0; 0 0 0 1];
D= [0 ; 0];
G3 = ss(A,B,C,D);
[res,t] = step(0.02*G3);

subplot(2,1,1)
plot(t, res(:,1))
xlabel("Time (s)")
ylabel("Pitch attitude (rad)")
hold on
subplot(2,1,2)
plot(t, res(:,2))
xlabel("Time (s)")
ylabel("Pitch rate (rad/s)")

%% Question 2

G=tf([2] , [1 4 3 0]);
C=tf([1 0.5] , [1 1]);

rltool(G,C)

%% Question 3

G=tf([2], [1 0 0]);
C=tf([1 0.5], [1]);
rltool(G,C)

%% Question 4

a = sim("Q4");
response = a.get('simout');
time = a.get('tout');
subplot(2,1,1)
plot(time, response(:,2))
xlabel("Time (s)")
ylabel("Position")
hold on
subplot(2,1,2)
plot(time, response(:,1))
xlabel("Time (s)")
ylabel("Velocity")

%% Question 5

a = sim("Q5");
response = a.get('x');
time = a.get('tout');
plot(time, response(:,1))
xlabel("Time (s)")
ylabel("Position")

%% Question 6

for i = ["0.1", "0.4", "0.8", "1.5", "2"]
    hold on
    set_param('Q6/UnitStep','SampleTime', i)
    a = sim("Q6");
    response = a.get('simout');
    time = a.get('tout');
    plot(time, response(:,1))
end
legend(["0.1", "0.4", "0.8", "1.5", "2"])
xlabel("Time (s)")
ylabel("Response")

%% Question 7

A = [-0.02 0.1 0 -32.2 ; -0.040 -0.8 180 0 ; 0 -0.003 -1.0 0 ; 0 0 1 0];
B = [ 0 ; -8 ; -4 ; 0];
C = [0 -1 0 180;
    0 0 0 1];
D = [0;0];

a = sim("Q7");
set_param('Q7/State-Space','A','A','B','B','C','C','D','D')
Vc = a.get('Vc');
time = a.get('tout');
subplot(2,1,1)
plot(time, Vc)
xlabel("Time (s)")
ylabel("Vc (ft/s)")
hold on
subplot(2,1,2)
ths = a.get('ths');
plot(time, [ths(:,1), ths(:,2)])
xlabel("Time (s)")
ylabel("Pitch attitude (rad)")
legend('Response', 'Input')

%% Question 8

m = 4000;
inp = 1000/m;

A = [0 0 0 1 0 0;
     0 0 0 0 1 0;
     0 0 0 0 0 1;
     0 0 0 0 0 0;
     0 0 0 0 0 0;
     0 0 0 0 0 0];
B = [0 0 0;
     0 0 0;
     0 0 0;
     inp 0 0;
     0 inp 0;
     0 0 inp];

C = [1 0 0 0 0 0;
     0 1 0 0 0 0;
     0 0 1 0 0 0];

D = [0 0 0; 
     0 0 0; 
     0 0 0];

x_bias = (-200*5000)/(sqrt(200^2 + 200^2 + 100^2)*m);
y_bias = (-200*5000)/(sqrt(200^2 + 200^2 + 100^2)*m);
z_bias = (-100*5000)/(sqrt(200^2 + 200^2 + 100^2)*m);

a = sim("Q8");
set_param('Q8/spacecraft','A','A','B','B','C','C','D','D')
% set_param('Q8/x_force_bias','x_bias','x_bias')
% set_param('Q8/y_force_bias','y_bias','y_bias')
% set_param('Q8/z_force_bias','z_bias','z_bias')

positions = a.get('pos');
inputs = a.get('inputs');
while length(inputs) ~= length(positions)
    inputs = [inputs; inputs(1,:)];
end
time = a.get('tout');
subplot(3,1,1)
plot(time, [positions(:,1), inputs(:,1)])
xlabel("Time (s)")
ylabel("x position (m)")
legend('Response', 'Input')
hold on
subplot(3,1,2)
plot(time, [positions(:,2), inputs(:,2)])
xlabel("Time (s)")
ylabel("y position (m)")
legend('Response', 'Input')
subplot(3,1,3)
plot(time, [positions(:,3), inputs(:,3)])
xlabel("Time (s)")
ylabel("z position(m)")
legend('Response', 'Input')


