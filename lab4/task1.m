clc; clear; close all;

% Define filter specifications
Wp = 300; % Passband frequency
Ws = 500; % Stopband frequency
Rp = 3;   % Passband ripple
Rs = 20;  % Stopband attenuation

% Calculate the minimum order and cutoff frequency for a Butterworth filter
[n, Wn] = buttord(Wp, Ws, Rp, Rs, 's');

% Design the Butterworth filter
[b, a] = butter(n, Wn, 'low', 's');

% Compute the frequency response of the filter
[H, W] = freqs(b, a, 1000);

% Plot the magnitude response of the filter
subplot(2, 1, 1);
plot(W, 20 * log10(abs(H)));
xlabel('Frequency (rad/s)');
ylabel('Magnitude (dB)');
title('Butterworth Lowpass Filter');
axis([0 600 -30 8]);
grid on;

% Create a transfer function model
Hs = tf(b, a);

% Plot the impulse response of the filter
subplot(2, 1, 2);
impulse(Hs);
title('Impulse Response of Butterworth Lowpass Filter');
xlabel('Time');
ylabel('Amplitude');
grid on;