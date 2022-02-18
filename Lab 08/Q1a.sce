s = %s;
tMax = 10;
tStep = 0.001;
t = 0:tStep:tMax;
ratio = 5;
y = [];
kValues = [1/16 1/8 1/4 1/2 1 2 4 8 16];
legendValues = [];
dims = 1;
for i = 1:length(kValues)
    k = kValues(i);
    K1 = ratio * k;
    K2 = k;
	lagCompensator = (s+K1)/(s+K2);
    str = "$K = " + string(k) + "$";
    legendValues = cat(dims, legendValues, str);
    sys = syslin('c', lagCompensator/(1+lagCompensator));
    gp = csim('step', t, sys);
    y = cat(dims, y, gp);
end
plot(t',y'); xlabel("$t$"); ylabel("Step Response");
legend(legendValues,opt=4);
xs2pdf(0,'Q1a');