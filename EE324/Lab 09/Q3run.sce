s = %s;
C = 100/(s+30);
C = syslin('c', C);
gainMargin = g_margin(C)
[phaseMargin, gainCrossoverFrequency] = p_margin(C)
timeDelay = ((phaseMargin * %pi / 180) / (2 * %pi)) / gainCrossoverFrequency

n = 5;
fact = [];
product = 1;
for i = 1:2*n
	product = product * i;
	fact($+1) = product;
end
function f = Factorial(n)
	if n == 0
		f = 1;
	else
		f = fact(n);
	end
endfunction
t = timeDelay;
numerator = 0;
denominator = 0;
for i = 0:n
	value =  Factorial(2*n-i) * Factorial(n) / (Factorial(2*n) * Factorial(i) * Factorial(n-i));
	numerator = numerator + (-t*s)^i * value;
	denominator = denominator + (t*s)^i * value;
end
G = numerator / denominator;
TF = C*G;
gainMargin = g_margin(TF)
[phaseMargin, gainCrossoverFrequency] = p_margin(TF)
timeDelay = ((phaseMargin * %pi / 180) / (2 * %pi)) / gainCrossoverFrequency
