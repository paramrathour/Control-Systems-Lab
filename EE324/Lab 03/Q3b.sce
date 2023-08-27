s = %s;
tStep = 0.001;
tMax = 10;
t = 0:tStep:tMax;

G = 9 / (s^2 + 2 * s + 9);
G_2 = G / (s + 1);
sys = syslin('c',G_2);
gp = csim('step', t, sys);

disp(riseTime(gp,tStep))
// 2.177
disp(percentOvershoot(gp))
// 0

G_3 = G / (s + 20);
sys = syslin('c',G_3);
gp = csim('step', t, sys);

disp(riseTime(gp,tStep))
// 0.465
disp(percentOvershoot(gp))
// 32.53622762867