s = %s 
tMax = 20;
tStep = 0.01;
t = 0:tStep:tMax;
gp1 = csim('step', t, G/(1+G));
gp2 = csim('step', t, Gn/(1+Gn));
plot(t,gp1,'b'); xlabel("t" ); ylabel("Step Response");
plot(t,gp2,'g'); xlabel("t" ); ylabel("Step Response");
legend(['Before';'After'], opt = 4);
xs2pdf(0,'Q3b2');
evans(G);
xs2pdf(0,'Q3b11');
evans(Gn);
xs2pdf(0,'Q3b12');
ax = gca();
ax.data_bounds=[-100 -2;0 2];