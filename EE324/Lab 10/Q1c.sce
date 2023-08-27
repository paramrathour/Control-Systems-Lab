s = %s;
G1 = (s+4)*(s+7)/((s+5)*(s+3));
G2 = (s+7)/((s+5)*(s+3));
SS1 = tf2ss(G1);
SS2 = tf2ss(G2);
disp(SS1("D"), SS2("D"))
--> 1, 0

--> Example output of tf2ss
 SS1(1)  (state-space system:)
  "lss"  "A"  "B"  "C"  "D"  "X0"  "dt"

 SS1(2)= A matrix =
  -3.5559105   0.1022364
   7.8522364  -4.4440895

 SS1(3)= B matrix =
  -2.7131204
   2.9392138

 SS1(4)= C matrix =
  -1.1057379  -2.220D-16

 SS1(5)= D matrix =
   1.

 SS1(6)= X0 (initial state) =
   0.
   0.

 SS1(7)= Time domain =
    []