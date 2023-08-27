s = %s;
tMax = 2;
tStep = 0.01;
t = 0:tStep:tMax;
aValues = -1:0.01:1;
y = [];
dims = 1;
for x = 1:length(aValues)
	a = aValues(x);
	G = simp((s + 5 + a) / (s^2 + 11 * s + 30));
	sys = syslin('c',G);
	y = cat(dims, y, csim('step', t, sys));
end
plot(t',y'); xlabel(" t" ); ylabel(" Step Response" );
xs2pdf(0,'Q1a');

s = %s;
tMax = 2;
tStep = 0.01;
t = 0:tStep:tMax;
aValues = -1:0.1:1;
legendValues = []
y = [];
dims = 1;
for x = 1:length(aValues)
	a = aValues(x);
	str = "$a = " + string(a) + "$";	
	legendValues = cat(dims, legendValues, str);
	G = simp((s + 5 + a)/(s^2 + 11 * s + 30));
	sys = syslin('c',G);
	y = cat(dims, y, csim('step', t, sys));
end
plot2d(t',y'); xlabel(" t" ); ylabel(" Step Response" );
legend(legendValues,opt=4);
xs2pdf(0,'Q1aLR');