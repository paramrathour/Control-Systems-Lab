s = %s;
n = 3;
A = [[grand("uin",intMin,intMax) 0 0] ; [0 grand("uin",intMin,intMax) 0] ; [0 0 grand("uin",intMin,intMax)]];
--> 7.   0.   0.
    0.   1.   0.
    0.   0.   4.
B = grand(n,1,"uin",intMin+1,intMax);
--> 9.
    4.
    4.
C = grand(1,n,"uin",intMin+1,intMax);
--> 10.   5.   8.
D = grand("uin",intMin,intMax);
--> 4.
G1 = D + C*inv(s*eye(n,n) - A)*B;
--> 1032 -770s +94s² +4s³  
    ---------------------  
     -28 +39s -12s² +s³    
disp(spec(A));
--> 1.
    4.
    7.
[z, p, k] = tf2zp(G1);
disp(p);
--> 7. + 0.i
    4. + 0.i
    1. + 0.i
Bnew = B;
Bnew(2) = 0;
--> 9.
    0.
    4.
G2 = D + C*inv(s*eye(n,n) - A)*Bnew;
--> -472 +78s +4s²  
    --------------  
     28 -11s +s²    
[z, p, k] = tf2zp(G2);
disp(p);
--> 7. + 0.i
    4. + 0.i
Cnew = C;
Cnew(1) = 0;
--> 0.   5.   8.
G3 = D + Cnew*inv(s*eye(n,n) - A)*B;
--> -96 +32s +4s²  
    -------------  
      4 -5s +s²         
[z, p, k] = tf2zp(G3);
disp(p);
--> 4. + 0.i
    1. + 0.i