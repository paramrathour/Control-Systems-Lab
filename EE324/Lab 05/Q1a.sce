s = %s;
TF = 10/(s^3+4*s^2+5*s+10);
G = TF / (1 - TF);
evans(G, 20);
xs2pdf(0,'Q1a');