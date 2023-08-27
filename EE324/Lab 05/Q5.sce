s = %s;
G1 = 500/((s+1)*(s+5)*(s+100));
evans(G1);
xs2pdf(0,'Q5rl1');
G2 = 5/((s+1)*(s+5));
evans(G2);
xs2pdf(0,'Q5rl2');

tMax = 5;
tStep = 0.01;
t = 0:tStep:tMax;
K = 1;
y = [];
dims = 1;
TF1 = K * G1 / (1 + K * G1);
TF2 = K * G2 / (1 + K * G2);
sys1 = syslin('c',TF1);
sys2 = syslin('c',TF2);
y = cat(dims, y, csim('step', t, sys1));
y = cat(dims, y, csim('step', t, sys2));
plot(t',y'); xlabel("t"); ylabel("Step Response" );
legend(['$G_1$','$G_2$']);
xs2pdf(0,'Q5sr1');

K = 10;
y = [];
dims = 1;
TF1 = K * G1 / (1 + K * G1);
TF2 = K * G2 / (1 + K * G2);
sys1 = syslin('c',TF1);
sys2 = syslin('c',TF2);
y = cat(dims, y, csim('step', t, sys1));
y = cat(dims, y, csim('step', t, sys2));
plot(t',y'); xlabel("t"); ylabel("Step Response" );
legend(['$G_1$','$G_2$']);
xs2pdf(0,'Q5sr2');


K = 20;
y = [];
dims = 1;
TF1 = K * G1 / (1 + K * G1);
TF2 = K * G2 / (1 + K * G2);
sys1 = syslin('c',TF1);
sys2 = syslin('c',TF2);
y = cat(dims, y, csim('step', t, sys1));
y = cat(dims, y, csim('step', t, sys2));
plot(t',y'); xlabel("t"); ylabel("Step Response" );
legend(['$G_1$','$G_2$']);
xs2pdf(0,'Q5sr3');


K = 30;
y = [];
dims = 1;
TF1 = K * G1 / (1 + K * G1);
TF2 = K * G2 / (1 + K * G2);
sys1 = syslin('c',TF1);
sys2 = syslin('c',TF2);
y = cat(dims, y, csim('step', t, sys1));
y = cat(dims, y, csim('step', t, sys2));
plot(t',y'); xlabel("t"); ylabel("Step Response" );
legend(['$G_1$','$G_2$']);
xs2pdf(0,'Q5sr4');


K = 40;
y = [];
dims = 1;
TF1 = K * G1 / (1 + K * G1);
TF2 = K * G2 / (1 + K * G2);
sys1 = syslin('c',TF1);
sys2 = syslin('c',TF2);
y = cat(dims, y, csim('step', t, sys1));
y = cat(dims, y, csim('step', t, sys2));
plot(t',y'); xlabel("t"); ylabel("Step Response" );
legend(['$G_1$','$G_2$']);
xs2pdf(0,'Q5sr5');


K = 50;
y = [];
dims = 1;
TF1 = K * G1 / (1 + K * G1);
TF2 = K * G2 / (1 + K * G2);
sys1 = syslin('c',TF1);
sys2 = syslin('c',TF2);
y = cat(dims, y, csim('step', t, sys1));
y = cat(dims, y, csim('step', t, sys2));
plot(t',y'); xlabel("t"); ylabel("Step Response" );
legend(['$G_1$','$G_2$']);
xs2pdf(0,'Q5sr6');