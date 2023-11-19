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