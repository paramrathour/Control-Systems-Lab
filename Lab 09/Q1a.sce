s = %s;
fMin = 1e-1;
fMax = 1e2;
G1 = 10/(s*(s/5+1)*(s/20+1));
G1 = syslin('c', G1);
lag = (s+3)/(s+1);
lead = (s+1)/(s+3);
G2 = lag * G1;
G3 = lead * G1;
disp(g_margin(G1), p_margin(G1));
--> 7.9588002
--> 22.535942
nyquist(G1, (fMin,fMax));
xs2pdf(0, 'Q1a');
disp(g_margin(G2), p_margin(G2));
--> 2.0762546
--> 4.0247332
nyquist(G2, (fMin,fMax));
xs2pdf(0, 'Q1b');
disp(g_margin(G3), p_margin(G3));
--> 11.759539
--> 43.173118
nyquist(G3, (fMin,fMax));
xs2pdf(0, 'Q1c');