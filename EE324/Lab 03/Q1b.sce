s = %s;
G = simp(1 / (s^2 - s - 6));
sys = syslin('c',G);
tStep = 0.001;
t = 0:tStep:2;
gp = csim('step', t, sys);
plot(t,gp); xlabel("t"); ylabel("Step Response");
xs2pdf(0,'Q1b1');

s = %s;
G = simp((s - 3) / (s^2 - s - 6));
sys = syslin('c',G);
tStep = 0.001;
t = 0:tStep:3;
gp = csim('step', t, sys);
plot(t,gp); xlabel("t"); ylabel("Step Response");
xs2pdf(0,'Q1b2');

s = %s;
tStep = 0.001;
t = 0:tStep:2;
aValues = -0.05:0.01:0.05;
legendValues = []
y = [];
dims = 1;
for x = 1:length(aValues)
	a = aValues(x);
	str = "$a = " + string(a) + "$";	
	legendValues = cat(dims, legendValues, str);
	G = simp((s - 3 + a) / (s^2 - s - 6));
	sys = syslin('c',G);
	y = cat(dims, y, csim('step', t, sys));
end
plot(t',y'); xlabel(" t" ); ylabel(" Step Response" );
legend(legendValues,opt=4);
xs2pdf(0,'Q1b3');