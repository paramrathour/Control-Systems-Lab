s = %s;
C = 100/(s+30);
C = syslin('c', C);
gainMargin = g_margin(C);
--> inf
[phaseMargin, gainCrossoverFrequency] = p_margin(C);
--> 107.45760, 15.182414
timeDelay = ((phaseMargin * %pi / 180) / (2 * %pi)) / gainCrossoverFrequency;
--> 0.0196605
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
	numerator = numerator + (-t*s)^i * Factorial(2*n-i) * Factorial(n) / (Factorial(2*n) * Factorial(i) * Factorial(n-i));
	denominator = denominator + (t*s)^i * Factorial(2*n-i) * Factorial(n) / (Factorial(2*n) * Factorial(i) * Factorial(n-i));
end
G = numerator / denominator;
-->	1 -0.0098302s +0.0000429s² -0.0000001s³ +1.482D-10s⁴ -9.714D-14s⁵  
   	-----------------------------------------------------------------  
   	1 +0.0098302s +0.0000429s² +0.0000001s³ +1.482D-10s⁴ +9.714D-14s⁵  
TF = C*G;
-->	100 -0.9830233s +0.0042948s² -0.0000106s³ +1.482D-08s⁴ -9.714D-12s⁵        
   	------------------------------------------------------------------------------  
   	30 +1.294907s +0.0111187s² +0.0000461s³ +0.0000001s⁴ +1.511D-10s⁵ +9.714D-14s⁶  
gainMargin = g_margin(TF);
--> -0.0781446
[phaseMargin, gainCrossoverFrequency] = p_margin(TF);
--> 0.0000053, 15.182414
timeDelay = ((phaseMargin * %pi / 180) / (2 * %pi)) / gainCrossoverFrequency;
--> 9.685D-10

show_margins(C);
xs2pdf(0, 'Q3a');
show_margins(TF);
xs2pdf(0, 'Q3b');