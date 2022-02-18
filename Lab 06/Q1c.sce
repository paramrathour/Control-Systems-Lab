TF = 1/((s+3)*(s+4)*(s+12));
evans(TF);
xs2pdf(0,'Q1c');

kValues = 0:1e-3:1e4;
breakLoop = 0;
for i = 1:length(kValues)
    k = kValues(i);
    G = k * TF;
    [zeroes, poles, k] = tf2zp(G/(1+G));
    for j = 1:length(poles)
        p = poles(j);
        if imag(p) > 0
            disp(k);
            breakLoop = 1;
            break;
        end
    end
    disp(k);
    if breakLoop == 1
        break;
    end
end
--> 2.127