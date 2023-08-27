z = 1/4;
sys = syslin('c' , 1/(s*s+2*z*s+1));
gp = csim('step', t, sys);
plot(t,[]); xlabel("t"); ylabel("Step Response")

t = 0:step:30;
z = 0:0.25:2
y = [];
dims = 1;
for x = 1:9
	zeta = z(x);
	sys = syslin('c' , 1/(s*s+2*zeta*s+1));
	y= cat(dims, y, csim('step', t, sys));
end
plot(t',y'); xlabel("t"); ylabel("Step Response")
legend(['First Order';'Second Order']);