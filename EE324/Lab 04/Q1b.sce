s = %s;
G1 = s;
G2 = 1/s;
G = G1*G1 ;
G = G+G2;
G = G*G2;
H = G1+G1;
TF = G/(1+G*H);

--> s = %s;
--> G1 = s;
--> G2 = 1/s;
--> G = G1*G1 ;
--> G = G+G2;
--> G = G*G2;
--> H = G1+G1;
--> TF = G/(1+G*H)
 TF  = 
      1 +s³     
   -----------  
   2s +s² +2s⁴  