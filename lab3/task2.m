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