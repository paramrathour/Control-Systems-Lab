s = %s;
G = 10/(s*(s+2)*(s+4));
Kvalues = 0:0.1:100;
pR = [];
pI = [];
for i = 1:length(Kvalues)
    K = Kvalues(i);
    TF = CLTFPositiveUnity(G,K);
    [zeroes, poles, k] = tf2zp(TF);
    for  j = 1:length(poles)
        p = poles(j);
        pR($+1) = real(p);
        pI($+1) = imag(p);
    end
end
scatter(pR,pI);
xlabel("Real Axis"); ylabel("Imaginary Axis");
xs2pdf(0,'Q2b');