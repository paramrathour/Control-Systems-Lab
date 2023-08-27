s = %s;
TF = 1/((s+3)*(s+4)*(s+12));
evans(TF);
zeta = 0.35;
slope = -sqrt(1-zeta*zeta)/zeta;
x = -10;
plot([0 x], [0 slope*x], 'm');
xs2pdf(0,'Q1b');

kValues = 0:1e-3:1e4;
threshold = 1e-5;
breakLoop = 0;
for i = 1:length(kValues)
    k = kValues(i);
    G = k * TF;
    [zeroes, poles, k] = tf2zp(G/(1+G));
    for j = 1:length(poles)
        p = poles(j);
        if abs(slope - imag(p)/real(p)) < threshold
            disp(k, p);
            breakLoop = 1;
            break;
        end
    end
    if breakLoop == 1
        break;
    end
end