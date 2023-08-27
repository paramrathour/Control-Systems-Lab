s = %s;
tMax = 10;
tStep = 0.01;
t = 0:tStep:tMax;
K = 4.439;
G = K/(s^2+3*s+2);
G = syslin('c', G);
gp = csim('step', t, G/(1+G));
Ts = settlingTime(gp, tStep)
OSp = 10;
zeta = -log(OSp/100)/sqrt(%pi^2+(log(OSp/100))^2);
slope = -sqrt(1-zeta*zeta)/zeta;
Real = -log(0.02*sqrt(1-zeta^2))/(Ts/2);
z = Real + %i*slope*Real;
p1 = -1;
p2 = -2;
zc = -10;
theta = atan(slope)*180/%pi - atan(imag(z-p1),real(z-p1))*180/%pi - atan(imag(z-p2),real(z-p2))*180/%pi + atan(imag(z-zc),real(z-zc))*180/%pi
pc = Real + slope*Real/tan(theta*%pi/180)
// --> -15.148441
Gn = G * (s-zc)/(s-pc)
x = -2;
plot([0 x], [0 slope*x], 'm');
xs2pdf(0,'Q3a');