s = %s;
omega0 = 50 * 2 * %pi;
omegaC = 1;
H = (s^2+omega0^2)/(s^2+omegaC*s+omega0^2);
H = syslin('c', H);
bode(H);
xs2pdf(0, 'Q2a');

omegaZ = 50 * 2 * %pi;
omegaP = omegaZ;
Q = 1;
H = (s^2+omegaZ^2)/(s^2+(omegaP/Q)*s+omegaP^2)
H = syslin('c', H);
bode(H);
xs2pdf(0, 'Q2a');

y = [];
QValues = [1/8 1/4 1/2 1 2 4 8];
legendValues = [];
dims = 1;
for i = 1:length(QValues)
	Q = QValues(i);
	str = "$Q = " + string(Q) + "$" ;
	legendValues = cat(dims, legendValues, str);
	H = (s^2+omegaZ^2)/(s^2+(omegaP/Q)*s+omegaP^2)
	// H = (s^2+omega0^2)/(s^2+2*k*s+omega0^2);
	H = syslin('c', H);
	y = cat(dims, y, H);
end
// plot(t',y'); xlabel(" $t$" ); ylabel(" Step Response" );
fMin = 2e1;
fMax = 1e2;
bode(y, fMin, fMax);
// bode(y);
legend(legendValues,opt=4);
xs2pdf(0, 'Q2b');