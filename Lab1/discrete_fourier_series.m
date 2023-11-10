n = 1:100;

% Plot Origin Signal
origin = zeros(1, length(n));
for i = 1:length(n)
    origin(i) = mysqure(i);
end
subplot(2,1,1)
plot(n, origin, 'o');
title('Origin Signal')
ylim([-1.5 1.5])
xlim([0 10])
hold on;

% Discrete Fourier Series
samplePeriod = 61; % samplePeriod should be designed carefully
k = samplePeriod - 1;
f = @mysqure;
dfs = DFS(f, k, samplePeriod);
y = dfs(n);
subplot(2,1,2)
plot(n, y)
title(['Discrete Fourier Series k=', num2str(k)])
ylim([-1.5 1.5])
xlim([0 10])


function f = DFS(func, K, N)
    xk = zeros(1, K);
    for k = 1:K
        for n = 1:N
            xk(k) = xk(k) + func(n-1)*exp(-1j*k*(n-1)*2*pi/N);
        end
    end
    xk = xk / N;
    f = @(n) arrayfun(@(n) sum(xk .* exp(1j*(1:K)*(n)*2*pi/N)), n);
end

function result = mysqure(n)
    result = square(0.5*pi*(n-2));
end