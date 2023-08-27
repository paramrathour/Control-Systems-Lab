s = %s;
G1 = (10*s+2000)/(s^3+202*s^2+490*s+18001);
G1 = syslin('c', G1);
gainMargin = g_margin(G1);
--> Inf
phaseMargin = p_margin(G1);
--> []
show_margins(G1);
xs2pdf(0, 'Q5a');

K = (1/0.1 - 1) / (2000/18001);
--> 81.0045

G2 = K * G1;
-->	162009 +810.045s     
   	----------------------  
   	18001 +490s +202s² +s³  
[gainMargin, phaseCrossoverFrequency] = g_margin(G2);
--> Inf, []
[phaseMargin, gainCrossoverFrequency] = p_margin(G2);
--> 4.2426012, 4.7688891
show_margins(G2);
xs2pdf(0, 'Q5b');

G3 = G2 * (s+1);
-->	162009 +162819.05s +810.045s²  
   	-----------------------------  
   	   18001 +490s +202s² +s³      
[gainMargin, phaseCrossoverFrequency] = g_margin(G3);
--> Inf, []
[phaseMargin, gainCrossoverFrequency] = p_margin(G3);
--> 90.070741, 128.94005
show_margins(G3);
xs2pdf(0, 'Q5c');

x = 0.5;
G4 = G2 * (s+x) / x
[gainMargin, phaseCrossoverFrequency] = g_margin(G4)
[phaseMargin, gainCrossoverFrequency] = p_margin(G4)


show_margins(G4);