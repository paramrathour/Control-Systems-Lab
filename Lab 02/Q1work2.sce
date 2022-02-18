a)

--> s = %s 							// The quicker alternative to using s = poly (0, 's')

--> a = 49; b = 16;

--> sys = syslin('c' , a/(s+b));

--> step = 0.00001;

--> t = 0:step:2;

--> gp = csim('step', t, sys);

--> plot2d(t,gp); xlabel("t"); ylabel("Step Response");

--> xs2pdf(0,'1b');

b)

--> finalValue = gp($);

--> Tc = 0;	Ts = 0;	Tr = 0;
--> for x = 1:tmax/step
--> 	if gp(x) > 0.9*finalValue
--> 		Tr = Tr + x;
--> 		break
--> 	end
--> 	if gp(x) < 0.63*finalValue
--> 		Tc = x;
--> 	end
--> 	if gp(x) < 0.1*finalValue
--> 		Tr = -x;
--> 	end
--> end

--> Tc = Tc * step;
--> Tr = Tr * step;

--> for x = tmax/step:-1:1
--> 	if abs(gp(x)-finalValue) > 0.02*finalValue
--> 		Ts = x * step;
--> 		break
--> 	end
--> end
--> disp(Tc,Ts,Tr)
   0.0621500
   0.2445200
   0.1373400

c)
--> aV = [1:100]
--> plot(aV,aTimes); xlabel("Multiples of a"); ylabel("Rise Time");
--> ax = gca()
--> ax.data_bounds=[1 0;100 0.2];
--> xs2pdf(0,'1c');

d)
--> bV = [1:100]
--> plot(bV,bTimes); xlabel("Multiples of b"); ylabel("Rise Time");
--> ax = gca()
--> ax.data_bounds=[1 0;100 0.2];
--> xs2pdf(0,'1d');

   Extra


cIndices = find(gp < 0.63*finalValue);
Tc = step*max(cIndices)

sIndices = find(gp < 0.98*finalValue);
Ts = step*max(sIndices)
