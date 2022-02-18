s = %s;
G = (s + 0.01) / (s^3 + (101 / 50) * s^2 + (126 / 25) * s + 0.1);
sys = syslin('c',G);
tStep = 0.01;
t = 0:tStep:200;
y = [];
dims = 1;
y = cat(dims, y, csim('step', t, sys));

[z, p, k] = tf2zp(G)
 // z  = 
 //  -0.01
 // p  = 
 //  -1.   + 2.i
 //  -1.   - 2.i
 //  -0.02 + 0.i
 // k  = 
 //   1.

G = G / ((s + 0.01) / 0.01) * ((s + 0.02) / 0.02);
sys = syslin('c',G);
y = cat(dims, y, csim('step', t, sys));

plot(t',y'); xlabel(" t" ); ylabel(" Step Response" );
legend(["$G_1$";"$G_2$"],opt=4);
ax = gca();
ax.data_bounds=[0 0;200 0.3];
xs2pdf(0,'Q2b');