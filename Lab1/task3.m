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