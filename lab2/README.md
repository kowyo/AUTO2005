## 运行结果

<img src="https://mitcher-1316637614.cos.ap-nanjing.myqcloud.com/hoa/task11.jpg?imageSlim" />

![task2](https://mitcher-1316637614.cos.ap-nanjing.myqcloud.com/hoa/task_2.jpg?imageSlim)

注：第三列是傅立叶逆变换

## 代码

```matlab
% Fast Fourier Transform
clc; clear; close all;

% Define parameters
totalTime = 0.064;
samplingFrequencies = [1000 300 200];
samplingPeriods = 1 ./ samplingFrequencies;
numSamples = round(totalTime .* samplingFrequencies);

% Initialize arrays
signalTimeDomain = zeros(length(samplingFrequencies), max(numSamples));
signalFrequencyDomain = zeros(length(samplingFrequencies), max(numSamples));

% Compute FFT for each sampling frequency
for freqIndex = 1:length(numSamples)
    for sampleIndex = 1:numSamples(freqIndex)
        signalTimeDomain(freqIndex, sampleIndex) = myfun1(sampleIndex * samplingPeriods(freqIndex));
    end
    signalFrequencyDomain(freqIndex, 1:numSamples(freqIndex)) = fft(signalTimeDomain(freqIndex, 1:numSamples(freqIndex)));
end

% Plot time and frequency domain signals for each sampling frequency
figure
for freqIndex = 1:length(numSamples)
    subplot(3, 2, 2*freqIndex-1)
    stem((1:numSamples(freqIndex)) * samplingPeriods(freqIndex), signalTimeDomain(freqIndex, 1:numSamples(freqIndex)))
    title(['amplitude-time fs = ', num2str(samplingFrequencies(freqIndex)), 'Hz'])
    
    subplot(3, 2, 2*freqIndex)
    plot((1:numSamples(freqIndex)) * samplingPeriods(freqIndex), signalFrequencyDomain(freqIndex, 1:numSamples(freqIndex)))
    title(['amplitude-frequency fs = ', num2str(samplingFrequencies(freqIndex)), 'Hz'])
end

% Define parameters for second part
numSamples2 = [32 16];
angularFrequency = 2*pi ./ numSamples2;

% Initialize arrays
signalTimeDomain2 = zeros(length(numSamples2), max(numSamples2));
signalFrequencyDomain2 = zeros(length(numSamples2), max(numSamples2));
signalTimeDomain3 = zeros(length(numSamples2), max(numSamples2));

% Compute FFT and inverse FFT for each number of samples
for sampleIndex = 1:length(numSamples2)
    for n = 1:numSamples2(sampleIndex)
        signalTimeDomain2(sampleIndex, n) = myfun2(n-1);
    end
    signalFrequencyDomain2(sampleIndex, 1:numSamples2(sampleIndex)) = fft(signalTimeDomain2(sampleIndex, 1:numSamples2(sampleIndex)));
    signalTimeDomain3(sampleIndex, 1:numSamples2(sampleIndex)) = ifft(signalFrequencyDomain2(sampleIndex, 1:numSamples2(sampleIndex)));
end

% Plot time and frequency domain signals for each number of samples
figure
for sampleIndex = 1:length(numSamples2)
    subplot(2, 3, 3*sampleIndex-2)
    stem((1:numSamples2(sampleIndex)), signalTimeDomain2(sampleIndex, 1:numSamples2(sampleIndex))) 
    title(['amplitude-sequency N = ', num2str(numSamples2(sampleIndex))])
    
    subplot(2, 3, 3*sampleIndex-1)
    plot((1:numSamples2(sampleIndex)) * angularFrequency(sampleIndex), signalFrequencyDomain2(sampleIndex, 1:numSamples2(sampleIndex)))
    title(['amplitude-frequency N = ', num2str(numSamples2(sampleIndex))])
    
    subplot(2, 3, 3*sampleIndex)
    plot((1:numSamples2(sampleIndex)), signalTimeDomain3(sampleIndex, 1:numSamples2(sampleIndex)))
    title(['amplitude-frequency N = ', num2str(numSamples2(sampleIndex))])
end

% Define function for first part
function y = myfun1(x)
    amplitude = 444.128;
    decayRate = 50*sqrt(2)*pi;
    frequency = 50*sqrt(2)*pi;
    y = amplitude * exp(-decayRate * x) * sin(frequency * x) * (x > 0);
end

% Define function for second part
function y = myfun2(n)
    if n >= 0 && n <= 13
        y = n + 1;
    elseif n >= 14 && n <= 26
        y = 27 - n;
    else
        y = 0;
    end
end
```

## 思考题

1. 如果序列$x(n)$的长度为M, 希望得到其频谱$X(e^{jw})$在$[0, 2\pi]$上的N点等间隔采样，当N<M时，如何用一次最少点数的 DFT 得到该频谱采样?

> 当N<M时，我们可以使用零填充（zero-padding）的方法来实现在频域上对频谱进行更密集的采样，而无需增加原始序列的长度。零填充是在原始序列的末尾添加零值，从而使序列的长度达到或超过所需的N点。
>
> 设原始序列为$x(n)$，长度为M，我们希望得到其频谱$X(e^{jw})$在$[0, 2\pi]$上的N点等间隔采样。首先，计算原始序列的N点DFT，记为$X_k$，其中$k=0,1,\ldots,N-1$：
> $$
> X_k = \sum_{n=0}^{N-1} x(n)e^{-j\frac{2\pi}{N}kn}, \quad k = 0,1,\ldots,N-1.
> $$
> 由于N<M，我们可以将原始序列$x(n)$零填充到长度N，得到新序列$x_p(n)$，其中$p = \max(M, N)$：
> $$
> x_p(n) = \begin{cases} x(n), & 0 \leq n < M \\ 0, & M \leq n < N \end{cases}
> $$
> 然后，计算新序列的N点DFT，记为$X_p(k)$：
> $$
> X_p(k) = \sum_{n=0}^{N-1} x_p(n)e^{-j\frac{2\pi}{N}kn}, \quad k = 0,1,\ldots,N-1
> $$
> 这样，我们就得到了在频域上更密集采样的$X_p(k)$。由于零填充部分不影响原始序列的频谱，因此$X_p(k)$的前M个点与原始序列的N点DFT $X_k$ 相同。
>
> 通过这种方法，我们用一次最少点数的DFT得到了所需频谱的N点等间隔采样。
>

2. 在时域采样的验证过程中，为什么采用 DFT(离散傅里叶变换)或者 FFT(快速傅里叶变换)求模拟信号的幅频特性？

> 1. **频域表示：** DFT和FFT将信号从时域转换到频域，提供了信号的频谱信息。频谱表示能够展示信号在不同频率上的成分，这对于理解信号的频率特性和频率分布非常有用。
> 2. **频谱分辨率：** 通过使用DFT或FFT，可以选择合适的变换点数，从而获得所需的频谱分辨率。较大的点数可以提供更详细的频域信息，但相应地需要更多的计算。
> 3. **离散系统分析：** DFT和FFT适用于离散信号，而许多系统和实际测量产生的信号都是离散的。通过在离散时域上进行分析，可以更好地了解信号是如何在数字系统中进行处理的。
> 4. **FFT的效率：** FFT是一种高效的算法，能够在计算上更快地完成傅里叶变换。这对于大规模数据集或实时信号处理是至关重要的。
> 5. **窗函数：** 在DFT或FFT中，可以使用窗函数来处理有限长度信号的边界效应。窗函数有助于减小频谱泄漏（spectral leakage）的影响，提高频域分析的准确性。
