s = %s;                          // define the symbolic variable 's'
y = [];
t = 0:step:15;
dims = 1;
sys1 = syslin('c' , 2/(s+2));
y = cat(dims, y, csim('step', t, sys1));
sys2 = syslin('c' , 2/(s^2 + 3*s +2));
y = cat(dims, y, csim('step', t, sys2));
plot(t',y'); xlabel("t"); ylabel("Step Response")
legend(['First Order';'Second Order']);
ax = gca();
ax.data_bounds=[0 0;15 1.5];
xs2pdf(0,'Q3a'); 