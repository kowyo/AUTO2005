% Clear workspace, close all figures and clear command window
close all; 
clear; 
clc;

% Define filter parameters
Fs = 100; % sample rate
Wp = 0.4; % passband edge frequency
Ws = 0.8; % stopband edge frequency
Wp2 = 2*Fs*tan(Wp/(2)); % passband edge frequency
Ws2 = 2*Fs*tan(Ws/(2)); % stopband edge frequency
Rp = 3; % passband ripple
Rs = 15; % stopband attenuation

% Calculate filter order and cutoff frequency
[n, Wn] = buttord(Wp2, Ws2, Rp, Rs, 's');

% Design Butterworth filter
[b, a] = butter(n, Wn, 'low', 's');

% Convert to discrete-time filter
[numz, denz] = bilinear(b, a, Fs);

% Plot Magnitude Response
subplot(2, 1, 1);
freqz(numz, denz, Fs);
title('Bilinear Transform');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;

% Plot Impulse Response
subplot(2, 1, 2);
impz(numz, denz, Fs);
title('Impulse Response');
xlabel('Time');
ylabel('Amplitude');
grid on;