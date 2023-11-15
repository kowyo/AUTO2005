% Task 1: FFT of Triangle and Square Waves
N = 10000;
Fs = 1000;
n = 0:10;

x_tri = triangle(n);
x_sqr = square(n);

X_tri_fft = fft(x_tri, N);
X_sqr_fft = fft(x_sqr, N);
f = Fs*(0:N-1)/N;

% Time Domain
subplot(2, 3, 1);
stem(n, x_tri);
title("Triangle Wave in Time Domain");
xlabel("n");
ylabel("x[n]");
subplot(2, 3, 4);
stem(n, x_sqr);
title("Square Wave in Time Domain");
xlabel("n");
ylabel("x[n]");

% Magnitude
subplot(2, 3, 2);
plot(f, abs(X_tri_fft), "LineWidth",3);
title("Triangle Wave in Frequency Domain");
xlabel("f (Hz)");
ylabel("|fft(x)|");
subplot(2, 3, 5);
plot(f, abs(X_sqr_fft), "LineWidth",3);
title("Square Wave in Frequency Domain");
xlabel("f (Hz)");
ylabel("|fft(x)|");

% Phase Angle
subplot(2, 3, 3);
plot(f, angle(X_tri_fft), "LineWidth",3);
title("Triangle Wave Phase Angle");
xlabel("f (Hz)");
ylabel("Phase Angle");
subplot(2, 3, 6);
plot(f, angle(X_sqr_fft), "LineWidth",3);
title("Square Wave Phase Angle");
xlabel("f (Hz)");
ylabel("Phase Angle");




function x = triangle(n)
    function x_val = triangle_val(n)
        if n >= 0 && n <= 4
            x_val = n+1;
        elseif n >= 5 && n <= 8
            x_val = 9-n;
        else
            x_val = 0;
        end
    end
    x = arrayfun(@triangle_val, n);
end

function x = square(n)
    function x_val = square_val(n)
        if n >= 0 && n <= 6
            x_val = 1;
        else
            x_val = 0;
        end
    end
    x = arrayfun(@square_val, n);
end
