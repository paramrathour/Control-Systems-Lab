s = %s;
G0 = 4;
G1 = s;
G2 = 2*s;
G3 = 1/(s+1);
GLA = G1 + G2;
GM = G1/(1+G1);
GLB = G2;
GLA = GLA * GM;
GL = GLA + GLB;
HR = G0 + 1;
GR = G3/(1+G3*HR);
G = GL * GR;
T = G/(1+G)

--> s = %s;
--> G0 = 4;
--> G1 = s;
--> G2 = 2*s;
--> G3 = 1/(s+1);
--> GLA = G1 + G2;
--> GM = G1/(1+G1);
--> GLB = G2;
--> GLA = GLA * GM;
--> GL = GLA + GLB;
--> HR = G0 + 1;
--> GR = G3/(1+G3*HR);
--> G = GL * GR;
--> T = G/(1+G)
T  = 
   0.3333333s +0.8333333s²  
   -----------------------  
         1 +1.5s +s²        