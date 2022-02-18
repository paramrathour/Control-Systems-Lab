s = %s;
tStep = 0.001;
tMax = 20;
t = 0:tStep:tMax;

TF = 9 / (s^2 + 2*s + 9);
G = [TF ; TF * (s + 0.1) / 0.1;TF * (s + 1) / 1; TF * (s + 5) / 5; TF * (s + 20) / 20; TF * 20 / (s + 20)];
y = [];
legendValues = [];
dims = 1;
for x = 1:length(G)
	str = "$G_{" + string(x) + "}$";	
	legendValues = cat(dims, legendValues, str);
	sys = syslin('c',G(2)(x),G(3)(x));
	gp = csim('step', t, sys);
	y = cat(dims, y, csim('step', t, sys));
	disp(riseTime(gp,tStep), percentOvershoot(gp));
end
plot(t',y'); xlabel(" t" ); ylabel(" Step Response" );
legend(legendValues,opt=4);
// ax = gca();
// ax.data_bounds=[0 0;10 1.5];
xs2pdf(0,'Q3');