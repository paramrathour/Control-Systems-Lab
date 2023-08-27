s = %s;                          // define the symbolic variable 's'
a = 1;
y = [];
dims = 1;
tau = 0.1;
t = [0:tau:10];
G1 = (s+5)/((s+2)*(s+4))
G2 = (s+5)/(s+4)
G3 = 1/(s+2)
sys1 = syslin('c' , G1);
sys2 = syslin('c' , G2);
sys3 = syslin('c' , G3);

y = cat(dims, y, csim('step', t, sys1));

temp1 = csim('step', t, sys2);
deff('u=timefun(t)','u=temp1(t/tau)');
y = cat(dims, timefun, csim(temp1, t, sys3));

temp2 = csim('step', t, sys3);
deff('u=timefun(t)','u=temp2(t/tau)');
y = cat(dims, timefun, csim(temp2, t, sys2));

plot(t',y'); xlabel("t"); ylabel("Step Response")
legend(['a';'b';'c']);
xs2pdf(0,'Q5a'); 