s = %s;
n = 3;
a11 = grand("uin",intMin,intMax);
a12 = grand("uin",intMin,intMax);
a22 = grand("uin",intMin,intMax);
a23 = grand("uin",intMin,intMax);
a33 = a22;
A = [[a11 a12 0] ; [0 a22 a23] ; [0 0 a33]];
--> 1.   8.   0.
    0.   2.   5.
    0.   0.   2.
B = grand(n,1,"uin",intMin+1,intMax);
--> 1.
    7.
    3.
C = grand(1,n,"uin",intMin+1,intMax);
--> 5.   7.   10.
D = grand("uin",intMin,intMax);
--> 5.
G1 = D + C*inv(s*eye(n,n) - A)*B;
--> 93 +168s +59s² +5s³  
   -------------------  
     -4 +8s -5s² +s³    
disp(spec(A));
--> 1.
    2.
    2.
[z, p, k] = tf2zp(G1);
disp(p);
--> 2. + 0.i
    2. + 0.i
    1. + 0.i
A(1,2) = C(2) * (A(1,1) - A(2,2)) / C(1);
--> 1.   -1.4   0.
    0.   2.    5.
    0.   0.    2.
G2 = D + C*inv(s*eye(n,n) - A)*B;
--> -23 +69s +5s²  
    -------------  
      2 -3s +s²    
disp(spec(A));
--> 1.
    2.
    2.
[z, p, k] = tf2zp(G2);
disp(p);
--> 2. + 0.i
    1. + 0.i