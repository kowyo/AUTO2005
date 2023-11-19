## 运行结果

![task1](https://mitcher-1316637614.cos.ap-nanjing.myqcloud.com/hoa/task1.png?imageSlim)

<center>连续周期方波信号的分解与合成</center>

![task2](https://mitcher-1316637614.cos.ap-nanjing.myqcloud.com/hoa/task2.png?imageSlim)

<center>离散方波信号 采样频率1</center>

![task2_2](https://mitcher-1316637614.cos.ap-nanjing.myqcloud.com/hoa/task2_2.png?imageSlim)

<center>离散方波信号 采样频率2</center>

![task3](/Users/mitcher/Library/CloudStorage/OneDrive-Personal/Documents/Course-2023-Fall/信号分析与处理/labs/lab1/task3.png)

<center>锯齿波信号</center>

## 代码

### Task 1: 连续周期方波信号的分解与合成

```matlab
% Fourier Series
clc; clear; close all;

% Define the time domain
t = linspace(0, 4*pi)';

% Define the square wave
x = square(0.5*pi*(t-2));

% Plot the square wave and its Fourier series for different numbers of terms
for n = [1 5 49 501]
    % Calculate the Fourier series
    f = FS(n);
    y = f(t);
    
    % Find the index of the current number of terms
    n_index = find([1 5 49 501] == n);
    
    % Plot the square wave
    subplot(2, 2, n_index)
    plot(t, x)
    hold on
    
    % Plot the Fourier series
    subplot(2, 2, n_index)
    plot(t, y)
    
    % Set the y-axis limits
    ylim([-1.5 1.5])
    
    % Add a legend
    legend('square wave', 'Fourier series')
    
    % Add a grid
    grid on;
    
    % Add a title
    title(['Fourier series n = ', num2str(n)])
    
    % Release the hold on the current plot
    hold off;
end

% Define the Fourier series function
function f = FS(n)
    % Initialize the coefficients
    b = zeros(1, n);
    
    % Calculate the coefficients
    for i = 1:n
        if mod(i, 2) == 0
            b(i) = 0;
        else
            b(i) = -4/(i*pi);
        end
    end
    
    % Define the Fourier series
    f = @(t) arrayfun(@(t) sum(b .* sin(0.5 * pi * t * (1:n))), t);
end
```

### Task 2: 离散方波信号的分解与合成

```matlab
% Discrete Fourier Series
clc; clear; close all;

% Define the range of n
n = 1:100;

% Calculate the original signal
origin = arrayfun(@mysqure, n);

% Plot the original signal
subplot(2,1,1)
stem(n, origin);
title('Origin Signal')
ylim([-1.5 1.5])
xlim([0 20])
hold on;    

% Define the sample period
samplePeriod = 61; % samplePeriod should be designed carefully

% Define the number of terms
k = samplePeriod - 1;

% Calculate the Discrete Fourier Series
dfs = DFS(@mysqure, k, samplePeriod);

% Calculate the Discrete Fourier Series for the range of n
y = dfs(n);

% Plot the Discrete Fourier Series
subplot(2,1,2)
stem(n, y)
title(['Discrete Fourier Series k=', num2str(k)])
ylim([-1.5 1.5])
xlim([0 20])

% Define the Discrete Fourier Series function
function f = DFS(func, K, N)
    % Initialize the coefficients
    xk = zeros(1, K);
    
    % Calculate the coefficients
    for k = 1:K
        for n = 1:N
            xk(k) = xk(k) + func(n-1)*exp(-1j*k*(n-1)*2*pi/N);
        end
    end
    
    % Normalize the coefficients
    xk = xk / N;
    
    % Define the Discrete Fourier Series
    f = @(n) arrayfun(@(n) sum(xk .* exp(1j*(1:K)*(n)*2*pi/N)), n);
end

% Define the square wave function
function result = mysqure(n)
    result = square(0.5*pi*(n-2));
end
```

### Task 3: 观察周期锯齿波信号的分解与合成

```matlab
% Clear the command window, clear workspace, and close all figures
clc; clear; close all;

% Define the frequency and sampling frequency
f = 0.25;
fs = 1000;

% Define the time period and time vector
T = 2*(1/f);
t = 0:1/fs:T-1/fs;

% Define the sawtooth wave
x = sawtooth(2*pi*f*t);

% Define the number of terms in the Fourier series
n = 7;

% Call the FourierSeries function to calculate and plot the Fourier series
FourierSeries(t, x, n)

% Define the Fourier series function
function FourierSeries(x, y, n)
    % Initialize the Fourier series coefficients
    a = [];
    b = [];
    c = [];
    s = [];
    
    % Calculate the period and angular frequency
    T = max(x) - min(x);
    w = 2*pi/T;
    
    % Calculate the constant term in the Fourier series
    a0 = 2*trapz(x, y)/T;
    
    % Calculate the Fourier series coefficients
    for i = 1:n
        % Calculate the cosine coefficients
        c(:, i) = diag(y' * cos(i * w * x));
        a(i) = 2 * trapz(x, c(:, i)) / T;
        
        % Calculate the sine coefficients
        s(:, i) = diag(y' * sin(i * w * x));
        b(i) = 2 * trapz(x, s(:, i)) / T;
    end
    
    % Initialize the Fourier series
    M = zeros(size(x));
    
    % Calculate the Fourier series
    for i = 1:n
        M = M + a(i) * cos(i * w * x) + b(i) * sin(i * w * x);
    end
    
    % Add the constant term to the Fourier series
    f = a0 / 2 + M;
    
    % Plot the original wave and the Fourier series
    figure
    plot(x, y)
    hold on
    plot(x, f);
    title(['Fourier series n = ', num2str(n)])
    
    % Add a legend with LaTeX interpreter
    h = legend('$$ Sawtooth wave $$', 'Fourier series');
    set(h, 'Interpreter', 'latex');
end
```



## 思考题

1. 简述连续周期信号频谱的特点

   > 连续周期信号的频谱是离散的

2. 简述离散周期信号频谱的特点

   > 离散从时域看，是对连续信号进行抽样得到的。从频域看，是对连续信号的频谱进行周期性搬移。所以，离散信号的频谱都是周期的。并且周期等于抽样频率。

3. 以周期矩形脉冲信号为例，分析:当信号的周期 *T* 和脉冲宽度*τ*发生变化的时候，信号的频谱将如何变化? 离散时间矩形周期信号当采样间隔发生变化时，信号的频谱会如何变化?

   > a. 周期T的变化：
   >
   > 如果周期 *T* 发生变化，频谱中的基本频率会随之改变。频率为基本频率的谐波成分的间隔将按照频率的倒数（频率=1/T）的整数倍发生变化。较大的周期将导致较低的基本频率和更宽的谱线。
   >
   > b. 脉冲宽度 *τ* 的变化：
   >
   > 脉冲宽度 *τ* 的变化将影响频谱的宽度。较小的脉冲宽度将导致更宽的频谱，因为更宽的频带包含更多的高频分量。较大的脉冲宽度则导致较窄的频谱。
   >
   > 
   >
   > 对于离散时间矩形周期信号，采样间隔的变化将影响信号的抽样过程。采样定理表明，采样频率应该至少是信号最高频率的两倍。如果采样间隔增大，可能发生混叠，即高于采样频率一半的频率成分将被错误地还原为低于采样频率一半的频率。这将导致频谱中出现混叠的成分，使得信号失真。
