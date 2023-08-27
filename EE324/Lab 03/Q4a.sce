s = %s;
tStep = 0.0001;
tMax = 30;
t = 0:tStep:tMax;

G_1 = 1 / (s^2 + 1);
G_2 = 1 / (s^2 + s + 1);
G_3 = 1 / (s^2 + 4*s + 1);
sys1 = syslin('c',G_1);
sys2 = syslin('c',G_2);
sys3 = syslin('c',G_3);
gp1 = csim('step', t, sys1);
gp2 = csim('step', t, sys2);
gp3 = csim('step', t, sys3);

y = [];
dims = 1;
y = cat(dims, y, csim('step', t, sys1));
y = cat(dims, y, csim('step', t, sys2));
y = cat(dims, y, csim('step', t, sys3));
plot(t',y'); xlabel(" t" ); ylabel(" Step Response" );
legend(["$G_1$";"$G_2$";"$G_3$"],opt=4);

disp(percentOvershoot(gp1), peakTime(gp1,tStep), delayTime(gp1,tStep), riseTime(gp1,tStep), settlingTime(gp1,tStep))
disp(percentOvershoot(gp2), peakTime(gp2,tStep), delayTime(gp2,tStep), riseTime(gp2,tStep), settlingTime(gp2,tStep))
disp(percentOvershoot(gp3), peakTime(gp3,tStep), delayTime(gp3,tStep), riseTime(gp3,tStep), settlingTime(gp3,tStep))
  
// --> disp(percentOvershoot(gp3), peakTime(gp3,tStep), delayTime(gp3,tStep), riseTime(gp3,tStep), settlingTime(gp3,tStep))
// 237.8846746883
// 3.1417
// 0.7899
// 0.7389
// 19.98700000000
// --> disp(percentOvershoot(gp2), peakTime(gp2,tStep), delayTime(gp2,tStep), riseTime(gp2,tStep), settlingTime(gp2,tStep))
// 16.30052807790
// 3.627700000000
// 1.2942
// 1.637700000000
// 8.0782
// --> disp(percentOvershoot(gp3), peakTime(gp3,tStep), delayTime(gp3,tStep), riseTime(gp3,tStep), settlingTime(gp3,tStep))
// 0.
// 0.
// 2.8462
// 8.0652
// 14.04990000000