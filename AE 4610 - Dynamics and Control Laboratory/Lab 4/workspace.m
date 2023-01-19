%% Lab 4 Workspace
% By: Noe Lepez Da Silva Duarte
% Created: 05 March 2022

clc
clear
close all

%% Part A

% Constants
m_l = 0.065;                                                % [kg]
L_l = 0.419;                                                % [m]
b_l = 2.083*10^-2;                                          % [m]
h_l = 8.128 * 10^-4;                                        % [m]
E = 200*10^9;                                                    % [GPa]
I = 9.32 * 10^(-13);                                        % [m^4]
B_eq = 0.015;                                               % [Nm/(rad/s)
J_eq = 0.00208;                                             % [kg*m^2]
R_m = 2.6;                                                  % [Ohm]
k_t = 7.68 *10^-3;                                          % [Nm]
nu_m = 0.69;                                                
k_m = 7.68*10^-3;                                           % [V/(rad/s)]
K_g = 70;
nu_g = 0.90;
J_l = (m_l*L_l^2)/3;
m = m_l/L_l;
const1 = sqrt(E*I/m);
w_1 = const1*(1.875/L_l)^2;
w_2 = const1*(4.694/L_l)^2;
w_3 = const1*(7.855/L_l)^2;

tip = load("Tip");
mid = load("Mid");
base = load("Base");

% Tip
tip_alpha = tip.data_alpha(:,2);
tip_time = tip.data_alpha(:,1);

figure(1)
plot(tip_time, tip_alpha)
xlabel("Time (s)")
ylabel("Deflection (deg)")
grid on
% saveas(figure(1), "tip_deflection.png")

[tip_peaks, tip_peaks_loc] = findpeaks(tip_alpha, tip_time, 'MinPeakProminence',1);
tip_period= mean(diff(tip_peaks_loc(1:end)));

del_tip = (1/(5-1))*log(tip_peaks(1)/tip_peaks(5));
zeta_tip = 1/sqrt(1+(2*pi/del_tip));
omega_d_tip = 2*pi/tip_period;
omega_n_tip = omega_d_tip/sqrt(1-zeta_tip^2);
K_s_tip = (omega_n_tip^2)*J_l;

% Mid
mid_alpha = mid.data_alpha(:,2);
mid_time = mid.data_alpha(:,1);

figure(2)
plot(mid_time, mid_alpha)
xlabel("Time (s)")
ylabel("Deflection (deg)")
grid on
% saveas(figure(2), "mid_deflection.png")

[mid_peaks, mid_peaks_loc] = findpeaks(mid_alpha, mid_time, 'MinPeakProminence',1);
mid_period= mean(diff(mid_peaks_loc(1:end)));

del_mid = (1/(5-1))*log(mid_peaks(1)/mid_peaks(5));
zeta_mid = 1/sqrt(1+(2*pi/del_mid));
omega_d_mid = 2*pi/mid_period;
omega_n_mid = omega_d_mid/sqrt(1-zeta_mid^2);
K_s_mid = (omega_n_mid^2)*J_l;


% Base
base_alpha = base.data_alpha(:,2);
base_time = base.data_alpha(:,1);

figure(3)
plot(base_time, base_alpha)
xlabel("Time (s)")
ylabel("Deflection (deg)")
grid on
% saveas(figure(3), "base_deflection.png")

[base_peaks, base_peaks_loc] = findpeaks(base_alpha, base_time, 'MinPeakProminence',1);
base_period= mean(diff(base_peaks_loc(1:end)));

del_base = (1/(5-1))*log(base_peaks(1)/base_peaks(5));
zeta_base = 1/sqrt(1+(2*pi/del_base));
omega_d_base = 2*pi/base_period;
omega_n_base = omega_d_base/sqrt(1-zeta_base^2);
K_s_base = (omega_n_base^2)*J_l;

K_s = mean([K_s_tip, K_s_base, K_s_mid]);

%% Part B

c_sig = load("chirp_signal");

output_alpha = c_sig.output_alpha;
time = c_sig.time;

% figure(1)
% plot(time, output_alpha)
% xlabel("Time (s)")
% ylabel("Alpha (Hz)")

dT = time(2)-time(1);
Fs = 1/dT;
L = length(output_alpha)-1;
f = Fs*(0:(L/2))/L;
Ya = fft(output_alpha);
Pa2 = abs(Ya/L);
Pa1 = Pa2(1:L/2+1);
Pa1(2:end-1) = 2*Pa1(2:end-1);
% Frequency Response (FFT)
plot(f,Pa1)
xlim([0 150])
xlabel('Frequency (Hz)')
ylabel('|Amplitude {\alpha}|')
title('Single-Sided Amplitude Spectrum of \alpha')
% Angular Deflection vs. Time
figure
plot(time,output_alpha)
xlabel('Time (s)')
ylabel('Deflection Angle, \alpha (deg)')
title('Flexible Link Angle vs Time')

%% Part C

mode1 = load("first_mode_24rads");
mode2 = load("second_mode_20.47hz");
[amp_peaks, amp_peaks_loc] = findpeaks(Pa1, f, 'MinPeakProminence',0.15);
freq1 = amp_peaks_loc(1)*2*pi;
freq2 = amp_peaks_loc(2)*2*pi;
beta1 = (sqrt(freq1/const1));
beta2 = (sqrt(freq2/const1));

x_l = linspace(0,1,100);

v_1 = mode_shape(beta1, x_l, L_l);
v_2 = mode_shape(beta2, x_l, L_l);

figure(5)
plot(x_l, v_1)
hold on
plot(x_l, v_2)
legend('mode 1', 'mode 2', 'location', 'best')
xlabel('x/l')
ylabel('V(x)')

function v = mode_shape(b,x_l,L_l)
    
v = [];
const = (cos(b*L_l)+cosh(b*L_l))/(sin(b*L_l)+sinh(b*L_l));

for x = x_l
    bx = b*x*L_l;
    v_inter = cosh(bx)-cos(bx);
    v_inter = v_inter + const*(sin(bx)-sinh(bx));
    v = [v, v_inter];
end


end