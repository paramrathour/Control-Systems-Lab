s = %s;
a = 49; b = 16;
sys = syslin('c' , a/(s+b));
step = 0.0001;
tmax = 2;
t = 0:step:tmax;
gp = csim('step', t, sys);
plot2d(t,gp); xlabel("t"); ylabel("Step Response");
xs2pdf(0,'1b');

finalValue = gp($);

Tc = 0;	Ts = 0;	Tr = 0;
for x = 1:tmax/step
	if gp(x) > 0.9*finalValue
		Tr = Tr + x;
		break
	end
	if gp(x) < 0.63*finalValue
		Tc = x;
	end
	if gp(x) < 0.1*finalValue
		Tr = -x;
	end
end

Tc = Tc * step;
Tr = Tr * step;

for x = tmax/step:-1:1
	if abs(gp(x)-finalValue) > 0.02*finalValue
		Ts = x * step;
		break
	end
end
disp(Tc,Ts,Tr)

aTimes = [];
for x = 1:100
	systemp = syslin('c' , a*x/(s+b));
	gptemp = csim('step', t, systemp);
	aTimes($+1) = riseTime(gptemp, step, tmax);
end
bTimes = [];
for x = 1:100
	systemp = syslin('c' , a/(s+b*x));
	gptemp = csim('step', t, systemp);
	bTimes($+1) = riseTime(gptemp, step, tmax);
end


bTimes
for x = 4:-1:-3
	disp(abs(x))
end

aTimes = list();
for x = 1:100
	aTimes($+1) = x;
end
bTimes = list();
for x = 1:100
	bTimes($+1) = x;
end