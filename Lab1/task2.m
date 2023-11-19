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