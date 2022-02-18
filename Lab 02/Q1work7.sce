t = 0:step:15;
sys = syslin('c' , 1/(s^2 + 2*s +1));
gp = csim('step', t, sys2);
plot(t',gp); xlabel("t"); ylabel("Step Response")
legend(['Second Order']);
ax = gca();
ax.data_bounds=[0 0;15 1.5];
xs2pdf(0,'Q3b');