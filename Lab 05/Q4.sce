s = %s;
G = 0.11*(s+0.6)/(6*s^2+3.6127*s+0.0572);
evans(G, 50);
xs2pdf(0,'Q4rl');

tMax = 10;
tStep = 0.01;
t = 0:tStep:tMax;
K_p = (1/0.01 - 1) / (0.11*0.6/0.0572);
G = K_p * G;
TF = G / (1+G);
sys = syslin('c',TF);
gp = csim('step', t, sys);
plot(t,gp); xlabel("t" ); ylabel("Step Response" );
xs2pdf(0,'Q4sr');