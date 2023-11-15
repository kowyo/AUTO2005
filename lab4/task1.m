close all; clear; clc;
Wp = 300;
Ws = 500;
Rp = 3;
Rs = 20;
[n, Wn] = buttord(Wp, Ws, Rp, Rs, 's');
[b, a] = butter(n, Wn, 'low', 's');
[H, W] = freqs(b, a, 1000);
subplot(2, 1, 1);
plot(W, 20 * log10(abs(H)));
xlabel('Frequency (rad/s)');
ylabel('Magnitude (dB)');
title('Butterworth Lowpass Filter');
axis([0 600 -30 8]);
grid on;
Hs = tf(b, a);

% Impulse response
subplot(2, 1, 2);
impulse(Hs);
title('Impulse Response of Butterworth Lowpass Filter');
xlabel('Time (s)');
ylabel('Amplitude');
axis([0 0.1]);
grid on;
