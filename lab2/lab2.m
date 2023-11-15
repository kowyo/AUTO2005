% y = [];
% t = 1:0.01:100;
% for i = 1:100
%     y(i) = myfun(t(i));
% end
% plot(t(1:100), y)
Tp = 0.064;
fs = [1000 300 200];
Ts = [1/fs(1) 1/fs(2) 1/fs(3)];
N1 = round(Tp*fs);
x1 = zeros(length(fs), max(N1));
X1 = zeros(length(fs), max(N1));
for i = 1:length(N1)
    for j = 1:N1(i)
        x1(i, j) = myfun1(j*Ts(i));
    end
    X1(i, 1:N1(i)) = fft(x1(i, 1:N1(i)));
end

plot1 =[1 3 5];
plot2 = [2 4 6];
% for i = 1:length(N1)
%     subplot(3, 2, plot1(i))
%     plot((1:N1(i))*Ts(i), x1(i, 1:N1(i)))
%     title(['amplitude-time fs =', num2str(fs(i))])
%     subplot(3, 2, plot2(i))
%     plot((1:N1(i))*Ts(i), X1(i, 1:N1(i)))
%     title(['amplitude-frequency fs =', num2str(fs(i))])
% end

N2 = [32 16];
W = [2*pi/N2(1) 2*pi/N2(2)];
x2 = zeros(length(N2), max(N2));
X2 = zeros(length(N2), max(N2));
x3 = zeros(length(N2), max(N2));
for i = 1:length(N2)
    for j = 1:N2(i)
        x2(i, j) = myfun2(j-1);
    end
    X2(i, 1:N2(i)) = fft(x2(i, 1:N2(i)));
    x3(i, 1:N2(i)) = ifft(X2(i, 1:N2(i)));
end

plot3 =[1 4];
plot4 = [2 5];
plot5 = [3 6];
for i = 1:length(N2)
    subplot(2, 3, plot3(i))
    plot((1:N2(i)), x2(i, 1:N2(i)))
    title(['amplitude-sequency N =', num2str(N2(i))])
    subplot(2, 3, plot4(i))
    plot((1:N2(i))*W(i), X2(i, 1:N2(i)))
    title(['amplitude-frequency N =', num2str(N2(i))])
    subplot(2, 3, plot5(i))
    plot((1:N2(i)), x3(i, 1:N2(i)))
    title(['amplitude-frequency N =', num2str(N2(i))])
end

        
function y = myfun1(x)
    A = 444.128;
    alpha = 50*sqrt(2)*pi;
    w = 50*sqrt(2)*pi;
    y = A*exp(-alpha*x)*sin(w*x)*(x>0);
end

function y = myfun2(n)
    if n >= 0 && n <= 13
        y = n + 1;
    elseif n>=14 && n<=26
        y = 27 - n;
    else
        y = 0;
    end
end