s = %s;
n = 2;
G1 = (s+3)/(s^2+5*s+4);
SSc1 = tf2des(G1)
-->    SSc1(1)
  "des"  "A"  "B"  "C"  "D"  "E"
       SSc1(2)
  -1.5384615   0.3076923
   4.3076923  -3.4615385
       SSc1(3)
  -1.1094004
   1.6641006
       SSc1(4)
  -0.9013878   5.551D-17
       SSc1(5)
   0.
       SSc1(6)
   1.   0.
   0.   1.

simp_mode(%F);
G2 = (s+1)/(s^2+5*s+4);
SSc2 = tf2des(G2);
-->    SSc2(1)
  "des"  "A"  "B"  "C"  "D"  "E"
       SSc2(2)
  -4.0000000
       SSc2(3)
  -1.2649111
       SSc2(4)
  -0.7905694
       SSc2(5)
   0.
       SSc2(6)
   1.
T = eye(2,2);
A = SSc2("A"); B = SSc2("B"); C = SSc2("C"); D = SSc2("D");
Anew = inv(T)*A*T
--> -4.   0.
     0.  -4.
Bnew = inv(T)*[SSc2("B");0]
-->  -1.2649111
   	 0.
Cnew = [SSc2("C"), 0]*T
-->  -0.7905694 0
Dnew =  D
-->  0
simp_mode(%T);
G3 = Dnew + Cnew*inv(s*eye(n,n) - Anew)*Bnew;
-->  1    
    ----  
    4 +s  