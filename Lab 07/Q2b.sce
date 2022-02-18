s = %s 
tMax = 1000;
tStep = 0.01;
t = 0:tStep:tMax;
p = 0.02;
z = 20 * p;
PI = (s+z)/(s+p);
K = 4.439;
G = K/(s^2+3*s+2);
TF = G * PI;
G = syslin('c', G);
TF = syslin('c', TF);
G = csim('step', t, G/(1+G));
TF = csim('step', t, TF/(1+TF));
plot(t,G,'b'); xlabel("t" ); ylabel("Step Response");
plot(t,TF,'g'); xlabel("t" ); ylabel("Step Response");
legend(['Before';'After'], opt = 4);
xs2pdf(0,'Q2b');