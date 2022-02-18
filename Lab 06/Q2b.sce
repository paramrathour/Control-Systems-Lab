s = %s;
G = 1/((s+3)*(s+4)*(s+12));
z = 0.01
PI = (s+z)/s
TF = G * PI
evans(TF);
plot([-10 0], [8 8], 'm');
plot([-10 0], [-8 -8], 'm');
xs2pdf(0,'Q2b1');

s = %s;
G = 1/((s+3)*(s+4)*(s+12));
z = 0.01
PI = (s+z)/s
TF = G * PI
evans(TF);
plot([-10 0], [9 9], 'm');
plot([-10 0], [-9 -9], 'm');
xs2pdf(0,'Q2b2');

kValues = 969:1e-3:1e4;
threshold = 1e-5;
breakLoop = 0;
for i = 1:length(kValues)
    k = kValues(i);
    G = k * TF;
    [zeroes, poles, k] = tf2zp(G/(1+G));
    for j = 1:length(poles)
        p = poles(j);
        if abs(8 - imag(p)) < threshold
            disp(k, p);
            breakLoop = 1;
            break;
        end
    end
    if breakLoop == 1
        break;
    end
end
kValues = 1331:1e-3:1e4;
threshold = 1e-5;
breakLoop = 0;
for i = 1:length(kValues)
    k = kValues(i);
    G = k * TF;
    [zeroes, poles, k] = tf2zp(G/(1+G));
    for j = 1:length(poles)
        p = poles(j);
        if abs(9 - imag(p)) < threshold
            disp(k, p);
            breakLoop = 1;
            break;
        end
    end
    if breakLoop == 1
        break;
    end
end
