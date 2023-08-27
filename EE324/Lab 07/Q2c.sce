s = %s;
tMax = 10;
tStep = 0.01;
t = 0:tStep:tMax;
TF = K/(s^2+3*s+2);
y = [];
pValues = [0.01 0.02 0.05 0.1 0.2 0.26]
legendValues = [];
dims = 1;
for i = 1:length(pValues)
    p = pValues(i);
    z = 20 * p;
    str = "$P = " + string(p) + "$";    
    legendValues = cat(dims, legendValues, str);
    PI = (s+z)/(s+p);    
    sys = syslin('c', TF*PI/(1+TF*PI));
    gp = csim('step', t, sys);
    y = cat(dims, y, csim('step', t, sys));
    // disp(riseTime(gp,tStep), percentOvershoot(gp));
end
plot(t',y'); xlabel(" t" ); ylabel(" Step Response" );
legend(legendValues,opt=4);
// ax = gca();
// ax.data_bounds=[0 0;10 1.5];
xs2pdf(0,'Q2c');