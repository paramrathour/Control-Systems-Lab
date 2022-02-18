s = %s;
n = 3;
intMin = 0;
intMax = 10;
T = grand(n,n,"uin",intMin,intMax);
--> 6.    9.   0.
    3.    4.   6.
    10.   7.   5.
A = grand(n,n,"uin",intMin,intMax);
-->	4.   3.   5.
    2.   8.   2.
    3.   0.   3.
B = grand(n,1,"uin",intMin,intMax);
--> 2.
	7.
	6.
C = grand(1,n,"uin",intMin,intMax);
--> 5. 7. 8.
D = grand(1,1,"uin",intMin,intMax);
--> 6
G1 = D + C*inv(s*eye(n,n) - A)*B;
-->	354 -332s +17s² +6s³  
   	--------------------  
   	 24 +47s -15s² +s³    

Anew = inv(T)*A*T;
Bnew = inv(T)*B;
Cnew = C*T;
G2 = D + Cnew*inv(s*eye(n,n) - Anew)*Bnew;
--> 354 -332s +17s² +6s³  
    --------------------  
     24 +47s -15s² +s³    
[z, p, k] = tf2zp(G1);
disp(p, spec(A));
--> 10.122807 + 0.i
    5.3226279 + 0.i
   -0.4454348 + 0.i

   -0.4454348 + 0.i
    10.122807 + 0.i
    5.3226279 + 0.i
