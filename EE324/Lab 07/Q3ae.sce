s = %s 
tMax = 20;
tStep = 0.01;
t = 0:tStep:tMax;
gp1 = csim('step', t, G/(1+G));
gp2 = csim('step', t, Gn/(1+Gn));
plot(t,gp1,'b'); xlabel("t" ); ylabel("Step Response");
plot(t,gp2,'g'); xlabel("t" ); ylabel("Step Response");
legend(['Before';'After'], opt = 4);
settlingTime(gp1, tStep)
settlingTime(gp2, tStep)
xs2pdf(0,'Q3a2');
evans(G);
xs2pdf(0,'Q3a11');
evans(Gn);
xs2pdf(0,'Q3a12');