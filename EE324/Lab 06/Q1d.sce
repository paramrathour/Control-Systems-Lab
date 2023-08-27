s = %s;
TF = 1/((s+3)*(s+4)*(s+12));
evans(TF);
xs2pdf(0,'Q1d1');

s = %s;
tMax = 5;
tStep = 0.01;
t = 0:tStep:tMax;
TF = 1/((s+3)*(s+4)*(s+12));
kValues = 0:0.1:1;
legendValues = []
y = [];
dims = 1;
for x = 1:length(kValues)
	k = kValues(x);
	str = ' $k = ' + string(k) + ' $' ;
	legendValues = cat(dims, legendValues, str);
	G = TF*k;
	sys = syslin('c',G/(1+G));
	y = cat(dims, y, csim('step', t, sys));
end
plot(t',y'); xlabel("t"); ylabel("Step Response");
legend(legendValues,opt=4);
// legend(['$k=0$','$k=0.1$','$k=0.2$','$k=0.3$','$k=0.4$','$k=0.5$','$k=0.6$','$k=0.7$','$k=0.8$','$k=0.9$','$k=1$'],opt=4);
xs2pdf(0,'Q1d2');

s = %s;
TF = 1/((s+3)*(s+4)*(s+12));
kValues = 0:0.1:1;
y = [];
dims = 1;
for x = 1:length(kValues)
	k = kValues(x);
	y = cat(dims, y, 1/(1+k*(1/(3*4*12))));
end
plot(kValues,y'); xlabel("k"); ylabel("Steady State Error");
ax = gca();
ax.data_bounds=[0 0.99;1 1];
xs2pdf(0,'Q1d3');