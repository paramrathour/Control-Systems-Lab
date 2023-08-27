s = %s;
G = 1/(s^2+3*s+2);
OSp = 10
zeta = -log(OSp/100)/sqrt(%pi^2+(log(OSp/100))^2)
slope = -sqrt(1-zeta*zeta)/zeta;
evans(G, 100);
x = -2;
plot([0 x], [0 slope*x], 'm');
xs2pdf(0,'Q2a');