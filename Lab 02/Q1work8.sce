s = %s;                          // define the symbolic variable 's'
sys = syslin('c' , 1/s);
step = 0.001;
t = 0:step:100;
gp = csim('step', t, sys);
plot(t,gp); xlabel("t"); ylabel("Step Response");
xs2pdf(0,'Q4a');