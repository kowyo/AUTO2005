close all; clear; clc;
Fs = 100; % sample rate
Wp = 0.4*Fs; % passband edge frequency
Ws = 0.8*Fs; % stopband edge frequency

Rp = 3; % passband ripple
Rs = 15; % stopband attenuation
[n, Wn] = buttord(Wp, Ws, Rp, Rs, 's');
[b, a] = butter(n, Wn, 'low', 's');

subplot(2, 1, 1);
[bz, az] = impinvar(b, a, Fs);

% Impulse Response
[impResp, t] = impz(bz, az);
xlabel('Time (s)');
ylabel('Amplitude');
title('Impulse Response');
grid on;

% Magnitude
subplot(2, 1, 2);
Hz = tf(bz, az, 1 / Fs)
freqz(bz, az);
xlabel('Frequency (rad/s)');
ylabel('Magnitude (dB)');
title('Butterworth Lowpass Filter');
grid on;