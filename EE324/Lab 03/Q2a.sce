s = %s;
G = 85 / (s^3 + 7 * s^2 + 27 * s + 85);
sys = syslin('c',G);
tStep = 0.001;
t = 0:tStep:8;
y = [];
dims = 1;
y = cat(dims, y, csim('step', t, sys));

[z, p, k] = tf2zp(G)
 // z  = 
 //    []
 // p  = 
 //  -5. + 0.i
 //  -1. + 4.i
 //  -1. - 4.i
 // k  = 
 //   85.

G = G * ((s + 5) / 5);
sys = syslin('c',G);
y = cat(dims, y, csim('step', t, sys));

plot(t',y'); xlabel(" t" ); ylabel(" Step Response" );
legend(["$G_1$";"$G_2$"],opt=4);
xs2pdf(0,'Q2a');