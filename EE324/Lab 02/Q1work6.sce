s = %s;                          // define the symbolic variable 's'
y = [];
t = 0:step:15;
dims = 1;
sys1 = syslin('c' , 3/(s+3));
y = cat(dims, y, csim('step', t, sys1));
sys2 = syslin('c' , 8/(s^2 + 6*s +8));
y = cat(dims, y, csim('step', t, sys2));
sys3 = syslin('c' , 9/(s^2 + 6*s +9));
y = cat(dims, y, csim('step', t, sys3));
plot(t',y'); xlabel("t"); ylabel("Step Response")
legend(['First Order';'Second Order';'Third Order']);
ax = gca();
ax.data_bounds=[0 0;15 1.5];
xs2pdf(0,'Q3a'); 