close all; clear; clc;
Fs = 100; % sample rate
Wp = 0.4; % passband edge frequency
Ws = 0.8; % stopband edge frequency
Wp2 = 2*Fs*tan(Wp/(2)); % passband edge frequency
Ws2 = 2*Fs*tan(Ws/(2)); % stopband edge frequency
Rp = 3; % passband ripple
Rs = 15; % stopband attenuation
[n, Wn] = buttord(Wp2, Ws2, Rp, Rs, 's');
[b, a] = butter(n, Wn, 'low', 's');

subplot(2, 1, 1);
[numz, denz] = bilinear(b, a, Fs);
H = tf(numz, denz);
freqz(numz, denz, Fs);
title('Bilinear Transform');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;

subplot(2, 1, 2);
impz(numz, denz, Fs);
title('Impulse Response');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;