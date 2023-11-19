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