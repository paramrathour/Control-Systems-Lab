s = %s;
tStep = 0.001;
tMax = 10;
t = 0:tStep:tMax;

G = 9 / (s^2 + 2*s + 9);
sys = syslin('c',G);
gp = csim('step', t, sys);

disp(riseTime(gp,tStep))
// 0.456
disp(percentOvershoot(gp))
// 32.92608491895
[z, p, k] = tf2zp(sys)
 // z  = 
 //    []
 // p  = 
 //  -1. + 2.828427124746i
 //  -1. - 2.828427124746i
 // k  = 
 //   9.

G_1 = G * (s+5);
sys = syslin('c',G_1);
gp = csim('step', t, sys);

disp(riseTime(gp,tStep))
// 0.356
disp(percentOvershoot(gp))
// 40.10436548888