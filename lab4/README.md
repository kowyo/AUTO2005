## 运行效果

![image-20231119173904227](https://mitcher-1316637614.cos.ap-nanjing.myqcloud.com/hoa/image-20231119173904227.png?imageSlim)

<center>Fig 1: 模拟低通滤波器设计</center>

![image-20231119173932266](https://mitcher-1316637614.cos.ap-nanjing.myqcloud.com/hoa/image-20231119173932266.png?imageSlim)

<center>Fig 2: 冲激响应不变法</center>

![image-20231119174228649](https://mitcher-1316637614.cos.ap-nanjing.myqcloud.com/hoa/image-20231119174228649.png?imageSlim)

<center>Fig 3: 双线性变换法</center>

## 代码

### Task 1: 模拟低通滤波器设计

```matlab
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
```

### Task 2: 冲激响应不变法

```matlab
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
```

### Task 3: 双线性变换法

```matlab
close all; clear; clc;

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
```

## 思考题

1. 总结巴特沃思低通滤波器幅频特性的特点。

> 1. **平坦的幅频特性：** 巴特沃斯低通滤波器的最显著特点之一是其在通带内具有平坦的幅频特性，即在通带内频率响应是均匀的。这意味着在通带范围内，滤波器不引入幅度失真。
> 2. **最大平滑度：** 与其他一些滤波器相比，巴特沃斯低通滤波器在通带与阻带之间的过渡区域具有最大平滑度。这种平滑度是通过在频域中最小化幅度响应的波动来实现的，这有助于防止频率过渡时的不希望的振荡。
> 3. **相位响应的非线性：** 尽管幅频特性平坦，但相位响应在通带与阻带之间的过渡区域是非线性的。这意味着在滤波器的通带与阻带之间，信号的相位会发生变化。在某些应用中，相位响应可能是关键考虑因素。
> 4. **阻带截止：** 巴特沃斯低通滤波器的阻带是在截止频率之后，滤波器对信号的衰减开始急剧增加的区域。阻带截止的特性有助于滤除高频噪声或不需要的信号成分。

2. 双线性变换法中模拟频率与数字频率之间的关系是非线性的，在设计数字滤波器时， 应如何处理这种非线性关系?

> 1. **补偿：** 预补偿是一种常见的处理非线性关系的方法。它通过在模拟滤波器设计中对频率进行调整，使得频率扭曲在双线性变换后被补偿。预补偿的目标是在进行双线性变换之前调整模拟频率，以考虑变换引入的非线性扭曲。
>
>    预补偿的公式为：
>    $$
>    ω_d=\frac 2 T tan⁡(\frac {ω_a T}{2})
>    $$
>    其中：
>
>    - $ω_d$ 是数字滤波器设计时的数字频率。
>    - $ω_a$ 是模拟滤波器设计时的模拟频率。
>    - T是采样周期。
>
> 2. **频率域纠正：** 在设计完成后，可以通过在数字滤波器的频率响应上进行纠正，以补偿双线性变换引入的频率扭曲。这可以通过对数字滤波器的频率响应进行纠正滤波器的增益来实现。
>
>    频率域纠正的目标是通过在数字频率上应用校正函数来修正频率扭曲。
>
> 3. **优化设计：** 选择合适的采样率和模拟频率，以尽量减小频率扭曲的影响。适当选择采样率和模拟频率可以减小非线性关系引入的误差。