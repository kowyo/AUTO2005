% Task 2: Convolution
N = 20000;
Fs = 1000;
n = 0:13;
x1 = myfun1(n);
x2 = myfun2(n);
x3 = myfun3(n);
x4 = myfun4(n);
Y1 = fft(x1, N);
Y2 = fft(x2, N);
Y3 = fft(x3, N);
Y4 = fft(x4, N);
conv1 = ifft(Y1.*Y2);
conv2 = ifft(Y3.*Y4);
subplot(2, 3, 1);
stem(x1);
title('x1');
subplot(2, 3, 2);
stem(x2);
title('x2');
subplot(2, 3, 3);
stem(conv1(1:14));
title('x1 * x2');
subplot(2, 3, 4);
stem(x3);
title('x3');
subplot(2, 3, 5);
stem(x4);
title('x4');
subplot(2, 3, 6);
stem(conv2(1:14));
title('x3 * x4');

function x = myfun1(n)
    function x_val = myfun1_val(n)
        if n >= 0 && n <= 4
            x_val = n+1;
        elseif n >= 5 && n <= 9
            x_val = 10-n;
        else
            x_val = 0;
        end
    end
    x = arrayfun(@myfun1_val, n);
end

function x = myfun2(n)
    function x_val = myfun2_val(n)
        if n >= 0 && n <= 5
            x_val = 2^n;
        elseif n >= 6 && n <= 11
            x_val = -2^(n-6);
        else
            x_val = 0;
        end
    end
    x = arrayfun(@myfun2_val, n);
end

function x = myfun3(n)
    function x_val = myfun3_val(n)
        if n >= 0 && n <= 6
            x_val = (0.8)^n;
        elseif n >= 7 && n <= 11
            x_val = n - 3;
        else
            x_val = 0;
        end
    end
    x = arrayfun(@myfun3_val, n);
end

function x = myfun4(n)
    function x_val = myfun4_val(n)
        if n >= 0 && n <= 4
            x_val = n - 1;
        elseif n >= 5 && n <= 12
            x_val = -0.6^(n-6);
        else
            x_val = 0;
        end
    end
    x = arrayfun(@myfun4_val, n);
end