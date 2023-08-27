G =  1 / (s*(s^2 + 3*s + 5));
evans(G);
xs2pdf(0,'Q3rl');

function Tr = riseTime(gp, tStep)
    finalValue = gp($);
    Tr = 0;
    for x = 1:length(gp)
        if gp(x) > 0.9*finalValue
            Tr = Tr + x;
            break
        end
        if gp(x) < 0.1*finalValue
            Tr = -x;
        end
    end
    Tr = Tr * tStep;
endfunction

s = %s;
tMax = 20;
tStep = 0.01;
t = 0:tStep:tMax;
kValues = 0:0.01:20;
kTimes = [];
for x = 1:length(kValues)
	k = kValues(x);
	G =  k / (s*(s^2 + 3*s + 5));
	TF = G / (1 + G);
	sys = syslin('c', TF);
	gp = csim('step', t, sys);
	kTimes($+1) = riseTime(gp, tStep);
end
plot(kValues(2:$)',kTimes(2:$));
xlabel("$K_p$" ); ylabel("Rise Time" );
xs2pdf(0,'Q3');

minTr = tMax;
minTrK = 0;
reqTr = 1.5;
reqK = [];
for x = 2:length(kValues)
  if kTimes(x) < minTr
    minTrK = kValues(x);
    minTr = kTimes(x);
  end
  if abs(kTimes(x) - reqTr) < 0.001
    reqK($+1) = kValues(x);
  end
end
disp(min(reqK));
disp(minTrK, minTr);
--> disp(min(reqK));
ans  =
   3.7600000
--> disp(minTrK, minTr);
   14.99
   0.27