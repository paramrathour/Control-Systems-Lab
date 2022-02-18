s = %s;                          // define the symbolic variable 's'
sys = syslin('c' , 1/s);
step = 0.001;
t = 0:step:100;
gp = csim('step', t, sys);
plot(t,gp); xlabel("t"); ylabel("Step Response");
xs2pdf(0,'Q4a');

z = %z;                          // define the symbolic variable 's'
h = 1/z;
sys = tf2ss(h);
u = ones(1,20);
gdp = dsimul(sys, u);
plot(u,gdp); xlabel("u"); ylabel("Step Response");
xs2pdf(0,'Q4b');