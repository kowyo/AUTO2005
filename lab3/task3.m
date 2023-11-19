% Task 3
clc; clear; close all; % Clear console, variables, and close all figures

% Define frequencies
f1 = 5;
f2 = 9;

% Define sampling frequencies
Fs1 = 5;
Fs2 = 15;
Fs3 = 40;
Fs4 = 60;

% Define time vectors for each sampling frequency
t1 = 0:1/Fs1:127*1/Fs1;
t2 = 0:1/Fs2:127*1/Fs2;
t3 = 0:1/Fs3:127*1/Fs3;
t4 = 0:1/Fs4:63*1/Fs4;
t4_padded = [t4, 64*1/Fs4:1/Fs4:127*1/Fs4]; % Padded time vector for Fs4
t5 = 0:1/Fs4:127*1/Fs4;

% Define signals for each time vector
x1 = sin(2*pi*f1*t1) + sin(2*pi*f2*t1);
x2 = sin(2*pi*f1*t2) + sin(2*pi*f2*t2);
x3 = sin(2*pi*f1*t3) + sin(2*pi*f2*t3);
x4 = sin(2*pi*f1*t4) + sin(2*pi*f2*t4);
x4_padded = [x4, zeros(1,128 - length(x4))]; % Padded signal for Fs4
x5 = sin(2*pi*f1*t5) + sin(2*pi*f2*t5);

% Compute magnitude spectrum for each signal
X1 = abs(fft(x1));
X2 = abs(fft(x2));
X3 = abs(fft(x3));
X4 = abs(fft(x4));
X4_padded = abs(fft(x4_padded)); % Magnitude spectrum for padded signal
X5 = abs(fft(x5));

% Plotting signals and their magnitude spectrums
% Figure 1
figure(1);
subplot(2,3,1);
plot(t1,x1);
title('x1(t)');
xlabel('t');
ylabel('x1(t)');
subplot(2,3,2);
plot(t2,x2);
title('x2(t)');
xlabel('t');
ylabel('x2(t)');
subplot(2,3,3);
plot(t3,x3);
title('x3(t)');
xlabel('t');
ylabel('x3(t)');
subplot(2,3,4);
plot(X1);
title('X1(f) fs = 5Hz');
xlabel('f');
ylabel('X1(f)');
subplot(2,3,5);
plot(X2);
title('X2(f) fs = 15Hz');
xlabel('f');
ylabel('X2(f)');
subplot(2,3,6);
plot(X3);
title('X3(f) fs = 40Hz');
xlabel('f');
ylabel('X3(f)');

% Figure 2
figure(2);
subplot(2,3,1);
plot(t4,x4);
title('x4(t)');
xlabel('t');
ylabel('x4(t)');
subplot(2,3,2);
plot(t4_padded, x4_padded);
title('x4(t) padded');
xlabel('t');
ylabel('x4(t)');
subplot(2,3,4);
plot(X4);
title('X4(f) fs = 60Hz');
xlabel('f');
ylabel('X4(f)');
subplot(2,3,5);
plot(X4_padded);
title('X4(f) fs = 60Hz padded');
xlabel('f');
ylabel('X4(f)');
subplot(2,3,3);
plot(t5,x5);
title('x5(t)');
xlabel('t');
ylabel('x5(t)');
subplot(2,3,6);
plot(X5);
title('X5(f) fs = 60Hz');
xlabel('f');
ylabel('X5(f)');