## 运行结果

![task1](https://mitcher-1316637614.cos.ap-nanjing.myqcloud.com/hoa/lab3_task1.jpg?imageSlim)

<center>Fig1: 列2和列3分别是三角脉冲信号和矩形脉冲信号的幅度谱和相位谱</center></center>

![lab3_task2](https://mitcher-1316637614.cos.ap-nanjing.myqcloud.com/hoa/lab3_task2.jpg?imageSlim)

<center>Fig2: 两个离散序列及其卷积后序列的幅度谱</center>

![lab3_task3_1](https://mitcher-1316637614.cos.ap-nanjing.myqcloud.com/hoa/lab3_task3_1.jpg?imageSlim)

<center>Fig3: 三种采样频率下，信号采样后取128点离散序列，离散序列时域波形和频谱幅度谱</center>

![lab3_task3__2](https://mitcher-1316637614.cos.ap-nanjing.myqcloud.com/hoa/lab3_task3__2.jpg?imageSlim)

<center>Fig4: <br>x4: 采样频率为60Hz时x(t)的64点离散序列<br>x4 padded: 采样频率为60Hz时x(t)补零加长到128点到离散序列<br>x5: 采样频率为60Hz时x(t)的128点离散序列</center>

## 代码

### Task 1: 两个离散序列及其卷积后序列的幅度谱

```matlab
% Task 1: FFT of Triangle and Square Waves
clc; clear; close all;

% Define parameters
num_points = 10000;
sampling_rate = 1000;
time_vector = 0:10;

% Generate triangle and square waves
triangle_wave = generate_triangle_wave(time_vector);
square_wave = generate_square_wave(time_vector);

% Compute FFT of the waves
fft_triangle_wave = fft(triangle_wave, num_points);
fft_square_wave = fft(square_wave, num_points);
frequency_vector = sampling_rate*(0:num_points-1)/num_points;

% Plot time domain representation
plot_time_domain(time_vector, triangle_wave, square_wave);

% Plot frequency domain representation (magnitude)
plot_frequency_domain_magnitude(frequency_vector, fft_triangle_wave, fft_square_wave);

% Plot frequency domain representation (phase)
plot_frequency_domain_phase(frequency_vector, fft_triangle_wave, fft_square_wave);

% Function to generate triangle wave
function wave = generate_triangle_wave(time_vector)
    wave = arrayfun(@triangle_wave_value, time_vector);
end

% Function to generate square wave
function wave = generate_square_wave(time_vector)
    wave = arrayfun(@square_wave_value, time_vector);
end

% Function to compute value of triangle wave at a given time
function value = triangle_wave_value(time)
    if time >= 0 && time <= 4
        value = time+1;
    elseif time >= 5 && time <= 8
        value = 9-time;
    else
        value = 0;
    end
end

% Function to compute value of square wave at a given time
function value = square_wave_value(time)
    if time >= 0 && time <= 6
        value = 1;
    else
        value = 0;
    end
end

% Function to plot time domain representation
function plot_time_domain(time_vector, triangle_wave, square_wave)
    subplot(2, 3, 1);
    stem(time_vector, triangle_wave);
    title("Triangle Wave in Time Domain");
    xlabel("n");
    ylabel("x[n]");
    subplot(2, 3, 4);
    stem(time_vector, square_wave);
    title("Square Wave in Time Domain");
    xlabel("n");
    ylabel("x[n]");
end

% Function to plot frequency domain representation (magnitude)
function plot_frequency_domain_magnitude(frequency_vector, fft_triangle_wave, fft_square_wave)
    subplot(2, 3, 2);
    plot(frequency_vector, abs(fft_triangle_wave), "LineWidth",3);
    title("Triangle Wave in Frequency Domain");
    xlabel("f (Hz)");
    ylabel("|fft(x)|");
    subplot(2, 3, 5);
    plot(frequency_vector, abs(fft_square_wave), "LineWidth",3);
    title("Square Wave in Frequency Domain");
    xlabel("f (Hz)");
    ylabel("|fft(x)|");
end

% Function to plot frequency domain representation (phase)
function plot_frequency_domain_phase(frequency_vector, fft_triangle_wave, fft_square_wave)
    subplot(2, 3, 3);
    plot(frequency_vector, angle(fft_triangle_wave), "LineWidth",3);
    title("Triangle Wave Phase Angle");
    xlabel("f (Hz)");
    ylabel("Phase Angle");
    subplot(2, 3, 6);
    plot(frequency_vector, angle(fft_square_wave), "LineWidth",3);
    title("Square Wave Phase Angle");
    xlabel("f (Hz)");
    ylabel("Phase Angle");
end
```

### Task 2: 两个离散序列及其卷积后序列的幅度谱

```matlab
%% Task 2: Convolution
% Define parameters
N = 20000;
Fs = 1000;
n = 0:13;

% Compute sequences and their FFTs
x1 = sequence1(n);
Y1 = fft(x1, N);

x2 = sequence2(n);
Y2 = fft(x2, N);

x3 = sequence3(n);
Y3 = fft(x3, N);

x4 = sequence4(n);
Y4 = fft(x4, N);

% Compute convolutions in frequency domain
convolution1 = ifft(Y1.*Y2);
convolution2 = ifft(Y3.*Y4);

%% Plotting
% Plot x1, x2 and their convolution
subplot(2, 3, 1);
stem(x1);
title('x1');

subplot(2, 3, 2);
stem(x2);
title('x2');

subplot(2, 3, 3);
stem(convolution1(1:14));
title('x1 * x2');

% Plot x3, x4 and their convolution
subplot(2, 3, 4);
stem(x3);
title('x3');

subplot(2, 3, 5);
stem(x4);
title('x4');

subplot(2, 3, 6);
stem(convolution2(1:14));
title('x3 * x4');

%% Function Definitions
% Define sequence1
function x = sequence1(n)
    x = arrayfun(@sequence1_value, n);
end

function x_val = sequence1_value(n)
    if n >= 0 && n <= 4
        x_val = n+1;
    elseif n >= 5 && n <= 9
        x_val = 10-n;
    else
        x_val = 0;
    end
end

% Define sequence2
function x = sequence2(n)
    x = arrayfun(@sequence2_value, n);
end

function x_val = sequence2_value(n)
    if n >= 0 && n <= 5
        x_val = 2^n;
    elseif n >= 6 && n <= 11
        x_val = -2^(n-6);
    else
        x_val = 0;
    end
end

% Define sequence3
function x = sequence3(n)
    x = arrayfun(@sequence3_value, n);
end

function x_val = sequence3_value(n)
    if n >= 0 && n <= 6
        x_val = (0.8)^n;
    elseif n >= 7 && n <= 11
        x_val = n - 3;
    else
        x_val = 0;
    end
end

% Define sequence4
function x = sequence4(n)
    x = arrayfun(@sequence4_value, n);
end

function x_val = sequence4_value(n)
    if n >= 0 && n <= 4
        x_val = n - 1;
    elseif n >= 5 && n <= 12
        x_val = -0.6^(n-6);
    else
        x_val = 0;
    end
end
```

### Task 3: 两个正弦信号叠加

```matlab
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
```

## 思考题

1. 阐述线性卷积、圆周卷积和周期卷积的区别和(或)联系。用 FFT 计算线性卷积时. FFT 的长度N应满足什么条件?

> 1. **线性卷积**：
>    - 线性卷积是一种在两个输入序列（通常是信号或图像）之间进行操作的数学运算。
>    - 在离散信号处理中，线性卷积的定义是通过对两个序列的元素进行加权求和来生成输出序列。
>    - 线性卷积不考虑序列的周期性或循环性。
>
> 2. **圆周卷积**：
>    - 圆周卷积考虑了序列的周期性。它是在考虑序列首尾相连、形成一个环状结构的情况下进行的卷积操作。
>    - 圆周卷积通常用于处理循环信号，其中序列在周期边界处连接。
>    - 圆周卷积可以通过线性卷积和取模运算的组合来实现。
>
> 3. **周期卷积**：
>    - 周期卷积是一种特殊形式的卷积，其中输入序列是周期信号，而输出序列也是具有相同周期性质的信号。
>    - 周期卷积与圆周卷积有相似之处，因为它们都涉及考虑信号的周期性。
>
> 关于使用FFT计算线性卷积时，FFT的长度N需要满足以下条件：
>
> - 如果两个输入序列的长度分别为M和N，那么进行线性卷积的FFT的长度应为M + N - 1。
> - 也就是说，如果将两个序列分别用零填充到长度为M + N - 1，然后对它们进行FFT，得到的乘积的逆FFT将给出线性卷积的结果。
>
> 这种零填充和FFT计算线性卷积的方法可以有效地加速卷积运算，特别是在处理大型数据时。FFT的长度通常选择为2的幂，以利用FFT算法的效率。

2. 实数序列的频域幅度谱和相位谱有什么规律? 虚数序列的频域幅度谱和相位谱有什么规律?

> **实数序列的频域幅度谱和相位谱：**
>
> 1. **频域幅度谱：** 对于实数序列，其频域幅度谱是对称的，关于频谱中心对称。即，如果频域中存在一个频率分量，其幅度为A，那么在相应的负频率上也会有一个幅度为A的分量。这是因为实数序列的傅里叶变换是共轭对称的。
>
> 2. **相位谱：** 实数序列的相位谱也是共轭对称的。如果在频域中存在一个频率分量的相位为φ，那么相应的负频率上的相位将为-φ。
>
> **虚数序列的频域幅度谱和相位谱：**
>
> 1. **频域幅度谱：** 虚数序列的频域幅度谱同样是关于频谱中心对称的，但是与实数序列不同，它是反对称的。如果频域中存在一个频率分量，其幅度为A，那么在相应的负频率上会有一个幅度为-A的分量。
>
> 2. **相位谱：** 虚数序列的相位谱也是反对称的。如果在频域中存在一个频率分量的相位为φ，那么相应的负频率上的相位将为 -φ。
>

3. 同一连续信号离散化后有两种情况，第一种是取较长的离散序列求 FFT;第二种是取较短的离散序列，结尾补零扩展成与第一种中的长度相等，再求 FFT。在上述两种情况下，信号的频谱有何异同点?

> 第一种情况：取较长的离散序列求FFT
>
> 1. **频谱分辨率：** 由于使用较长的离散序列，频谱的分辨率相对较高。这意味着能够更精细地分辨信号中不同频率的成分。
>
> 2. **计算代价：** 长序列的FFT计算通常需要更多的计算资源和时间，特别是对于大型数据集。
>
> 第二种情况：取较短的离散序列，结尾补零扩展成与第一种中的长度相等，再求FFT
>
> 1. **频谱分辨率：** 虽然最终的FFT结果的长度与第一种情况相同，但是由于初始序列较短，频谱的分辨率相对较低。这意味着在频率域中可能无法捕捉到信号中较高频率的变化。
>
> 2. **零填充效应：** 在较短的序列末尾进行零填充可能引入一些额外的振铃效应，这是由于在频域中产生了额外的频率成分，虽然它们实际上不存在于原始信号中。
>
> 如果需要高频谱分辨率并且计算资源允许，可以选择第一种情况。如果计算资源有限或者对频谱分辨率要求不高，第二种情况可能更合适。
