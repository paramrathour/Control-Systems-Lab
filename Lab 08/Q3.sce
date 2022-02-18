initialMagnitude = -75
K = 10^(initialMagnitude/20)*5000
G = K*(s+1)/((s+5)*(s+10)*(s+100));
G = syslin('c', G);
bode(G)
xs2pdf(0,'Q3');