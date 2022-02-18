s = %s;
tStep = 0.001;
tMax = 29.8452;
t = 0:tStep:tMax;

G = [1 / (s^2 + 1); 1 / (s^2 + s + 1); 1 / (s^2 + 4*s + 1)];
y = [];
legendValues = [];
dims = 1;
for x = 1:length(G)
	str = "$G_{" + string(x) + "}$";	
	legendValues = cat(dims, legendValues, str);
	sys = syslin('c',G(2)(x),G(3)(x));
	gp = csim('step', t, sys);
	y = cat(dims, y, csim('step', t, sys));
	disp(str,percentOvershoot(gp), peakTime(gp,tStep), delayTime(gp,tStep), riseTime(gp,tStep), settlingTime(gp,tStep))
end
plot(t',y'); xlabel(" t" ); ylabel(" Step Response" );
legend(legendValues,opt=4);
xs2pdf(0,'Q4');

  99.99999999696
  3.1417
  1.047300000000
  1.0197
  26.68360000000

  16.30302851835
  3.627700000000
  1.2942
  1.637700000000
  8.076400000000

  0.
  0.
  2.8637
  8.2173
  14.81230000000