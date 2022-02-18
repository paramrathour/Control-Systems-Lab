s = %s;
C = 100/(s+30);
C = syslin('c', C);
gainMargin = g_margin(C)
[phaseMargin, gainCrossoverFrequency] = p_margin(C)
timeDelay = ((phaseMargin * %pi / 180) / (2 * %pi)) / gainCrossoverFrequency

n = 6;
fact = [];
product = 1;
for i = 1:2*n+1
	fact($+1) = product;
	product = product * i;
end
function f = Factorial(n)
	f = fact(n+1);
endfunction
t = timeDelay;
numerator = 0;
denominator = 0;
for i = 0:n
	value =  Factorial(2*n-i) * Factorial(n) / (Factorial(2*n) * Factorial(i) * Factorial(n-i));
	numerator = numerator + (-t*s)^i * value;
	denominator = denominator + (t*s)^i * value;
end
G = numerator / denominator
TF = C*G
gainMargin = g_margin(TF)
[phaseMargin, gainCrossoverFrequency] = p_margin(TF)
timeDelay = ((phaseMargin * %pi / 180) / (2 * %pi)) / gainCrossoverFrequency
