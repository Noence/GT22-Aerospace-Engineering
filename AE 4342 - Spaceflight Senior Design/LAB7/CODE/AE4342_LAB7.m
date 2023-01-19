close all
clc
clear

%% AE 4342 - LAB 7
cspice_furnsh('naif0012.tls');  %This loads the leap second kernel
cspice_furnsh('pck00010.tpc');  %This loads the planetary constants kernel
cspice_furnsh('de440.bsp'); %This loads the planetary ephemerides kernel
% cspice_furnsh('071004AP_SCPSE_07272_07328.bsp'); % Uncomment for problem
% 5


%% Problem 1
t0_depart = 'Aug 01, 2026 12:0:0.0';
t0_arrive = 'Mar 01, 2027 12:0:0.0';
% t0_depart = 'Jun 20, 2005 12:0:0.0';
% t0_arrive = 'Dec 01, 2005 12:0:0.0';
depart_time = cspice_str2et(t0_depart); %Computes ephemeris time 
arrive_time = cspice_str2et(t0_arrive); %Computes ephemeris time 

%% Problem 2
[e_state, ~] = cspice_spkezr('EARTH BARYCENTER', depart_time,'ECLIPJ2000', 'NONE','SUN');
[m_state, ~] = cspice_spkezr('MARS BARYCENTER', arrive_time,'ECLIPJ2000', 'NONE','SUN');

%% Problem 3
mu = 1.327E11;
lnc = 'Feb 27, 2027 12:0:0.0';
arr = 'Jul 13, 2028 12:0:0.0';

% lnc = 'Nov 07, 2005 12:0:0.0';
% arr = 'Feb 24, 2007 12:0:0.0';


  
lnc_time = cspice_str2et(lnc); %Computes ephemeris time 
arr_time = cspice_str2et(arr); %Computes ephemeris time 
x_axis = linspace(depart_time, lnc_time, 100);
y_axis = linspace(arrive_time, arr_time, 100);

nrev = 0;
c3 = [];
vf = [];

[state, ~]= cspice_spkezr('EARTH',depart_time,'ECLIPJ2000','NONE','SUN');

for i=1:length(y_axis)
    for j = 1:length(x_axis)
        [v_earth,~] = cspice_spkezr('3',x_axis(j),'ECLIPJ2000','NONE','SUN');
        v_earth= v_earth(4:6);
        [e_state, ~] = cspice_spkezr('EARTH', x_axis(j),'ECLIPJ2000', 'NONE','SUN');
        [v_mars,~] = cspice_spkezr('4',y_axis(i),'ECLIPJ2000','NONE','SUN');
        [m_state, ~] = cspice_spkezr('4', y_axis(i),'ECLIPJ2000', 'NONE','SUN');
        v_mars= v_mars(4:6);
        tof = y_axis(i)-x_axis(j);
        [vi_s,vf_s]=glambert(mu, e_state, m_state, tof, nrev);
        c3_s = norm(v_earth - vi_s)^2;
        vf_inf = norm(v_mars-vf_s);
        c3(i,j)=c3_s;
        vf(i,j)= vf_inf;
    end
end

timx = cspice_et2utc(x_axis, 'C', 0);
timx2 = datenum(timx,'yyyy mm dd');

timy = cspice_et2utc(y_axis, 'C', 0);
timy2 = datenum(timy,'yyyy mm dd');

c3_levels = [0 5 10 15 20 25 30];
vf_levels = [0 1 2 3 4 5 6 7 8 9 10]; 

fig1 = figure;
[x,y] = contour(timx2,timy2,c3, c3_levels);
% [x,y] = contour(timx2,timy2,vf, vf_levels);

clabel(x,y);
grid on
ax=gca;
datetick('x','dd-mm-yy')
datetick('y','dd-mm-yy')
saveas(fig1, "C2.png")

%% Problem 4

times = linspace(cspice_str2et('Oct 23, 2026 12:0:0.0'),cspice_str2et('Oct 23, 2028 12:0:0.0'),562);
[e_state, ~] = cspice_spkezr('EARTH', 846005000,'ECLIPJ2000', 'NONE','SUN');
[m_state, ~] = cspice_spkezr('MARS BARYCENTER', 870265000,'ECLIPJ2000', 'NONE','SUN');
tof = 870265000-846005000;
[vi_s,vf_s]=glambert(mu, e_state, m_state, tof, 0);

strt = [e_state(1:3);vi_s];

[t,ans] = ode45(@odes, [0 24000000], strt);


earth_positions = [];
mars_positions = [];
for i=1:562
    [earth_pos, ~]= cspice_spkezr('EARTH', times(i),'ECLIPJ2000', 'NONE','SUN');
    earth_positions = [earth_positions earth_pos(1:3)];
    [mars_pos, ~] = cspice_spkezr('4', times(i),'ECLIPJ2000', 'NONE','SUN');
    mars_positions = [mars_positions mars_pos(1:3)];

end


fig2 = figure('color','white');
hold on
plot3(ans(:,1),ans(:,2),ans(:,3))
plot3(earth_positions(1,:),earth_positions(2,:),earth_positions(3,:))
plot3(mars_positions(1,:),mars_positions(2,:),mars_positions(3,:))
xlabel('x [km]');
ylabel('y [km]');
zlabel('z [km]');
axis equal
title('Satellite Orbit');
grid on
saveas(fig2, 'orbit.png')

function dr = odes(t, x)
mu = 1.327E11;

dr(1) = x(4); %x-vel
dr(2) = x(5); %y-vel
dr(3) = x(6); %z-vel
dr(4) = -mu*(x(1))/(norm([x(1);x(2);x(3)])^3);
dr(5) = -mu*(x(2))/(norm([x(1);x(2);x(3)])^3);
dr(6) = -mu*(x(3))/(norm([x(1);x(2);x(3)])^3);
dr = dr(:);
end

%% Problem 5

% init = 'Oct 05, 2007 12:0:0.0';
% fin = 'Nov 05, 2007 10:0:0.0';
% depart_time = cspice_str2et(init); %Computes ephemeris time 
% arrive_time = cspice_str2et(fin); %Computes ephemeris time 
% 
% times = linspace(depart_time, arrive_time, 1000);
% positions = [];
% sun_pos = []
% for i=1:length(times)
%     [cas_state, ~] = cspice_spkezr('CASSINI', times(i),'ECLIPJ2000', 'NONE','SATURN');
%     positions = [positions cas_state(1:3)];
% end
% 
% [sat_state, ~] = cspice_spkezr('SATURN', times(i),'ECLIPJ2000', 'NONE','SATURN');
% 
% figure('color','white');
% 
% plot3(positions(1,:),positions(2,:),positions(3,:))
% hold on
% xlabel('x [km]');
% ylabel('y [km]');
% zlabel('z [km]');
% axis equal
% title('Cassini Orbit');
% grid on
% [X,Y,Z] = sphere;
% r = 58232;
% X2 = X * r;
% Y2 = Y * r;
% Z2 = Z * r;
% surf(X2,Y2,Z2,'FaceColor', [1 1 0]);
% 
% hold off

