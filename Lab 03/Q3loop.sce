s = %s;
tStep = 0.001;
tMax = 20;
t = 0:tStep:tMax;

TF = 9 / (s^2 + 2*s + 9);
G = [TF ; TF * (s + 5); TF / (s + 1); TF / (s + 20)];
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
xs2pdf(0,'Q3');

0.456
32.93214093340
0.356
40.11070831184
2.178
0.000000000008
0.465
32.54212889471