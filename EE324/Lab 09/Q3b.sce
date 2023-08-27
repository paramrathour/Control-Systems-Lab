s = %s;
C = 100/(s+30);
C = syslin('c', C);
gainMargin = g_margin(C);
--> inf
[phaseMargin, gainCrossoverFrequency] = p_margin(C);
--> 107.45760, 15.182414
timeDelay = ((phaseMargin * %pi / 180) / (2 * %pi)) / gainCrossoverFrequency;
--> 0.0196605

n = 6;
fact = [];
product = 1;
for i = 1:2*n
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
G = numerator / denominator;
-->	1 -0.0098302s +0.0000439s² -0.0000001s³ +1.886D-10s⁴ -1.854D-13s⁵ +8.681D-17s⁶  
   	------------------------------------------------------------------------------  
   	1 +0.0098302s +0.0000439s² +0.0000001s³ +1.886D-10s⁴ +1.854D-13s⁵ +8.681D-17s⁶  
TF = C*G;
-->     100 -0.9830233s +0.0043924s² -0.0000115s³ +1.886D-08s⁴ -1.854D-11s⁵ +8.681D-15s⁶       
   ------------------------------------------------------------------------------------------  
   30 +1.294907s +0.011148s² +0.0000474s³ +0.0000001s⁴ +1.942D-10s⁵ +1.880D-13s⁶ +8.681D-17s⁷  
gainMargin = g_margin(TF);
--> -0.1004913
[phaseMargin, gainCrossoverFrequency] = p_margin(TF);
--> 3.300D-08, 15.182414
timeDelay = ((phaseMargin * %pi / 180) / (2 * %pi)) / gainCrossoverFrequency;
--> 6.037D-12s

show_margins(C);
xs2pdf(0, 'Q3a');
show_margins(TF);
xs2pdf(0, 'Q3b');