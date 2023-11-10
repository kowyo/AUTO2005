t = linspace(0, 4*pi)';
x = square(0.5*pi*(t-2));

for n = [1 5 49 501]
    f = FS(n);
    y = f(t);
    n_index = find([1 5 49 501] == n);
    subplot(2, 2, n_index)
    plot(t, x)
    hold on
    subplot(2, 2, n_index)
    plot(t, y)
    ylim([-1.5 1.5])
    legend('square wave', 'Fourier series')
    grid on;
    title(['Fourier series n = ', num2str(n)])
    hold off;
end


function f = FS(n)
    b = zeros(1, n);
    for i = 1:n
        if mod(i, 2) == 0
            b(i) = 0;
        else
            b(i) = -4/(i*pi);
        end
    end
    f = @(t) arrayfun(@(t) sum(b .* sin(0.5 * pi * t * (1:n))), t);
end
    
