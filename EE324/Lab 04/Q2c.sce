s = %s;
G = 10/(s*(s+2)*(s+4));
Kvalues = 0:0.1:10;
Kcritical = -1;
b = 0;
for i = 1:length(Kvalues)
    if b == 1
        break;
    end
    K = Kvalues(i);
    TF = CLTFPositiveUnity(G,K);
    [zeroes, poles, k] = tf2zp(TF);
    for  j = 1:length(poles)
        if real(poles(j)) > 0
            Kcritical = K;
            b = 1
            break
        end
    end
end
Kcritical