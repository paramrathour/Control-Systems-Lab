T = 2*pi*sqrt(lp/g);
f = 1/T;
jp = 1/4*mp*g*lp/(pi^2*f^2)
jeq = ma*r^2/3%+me*re^2
den = jp*jeq + mp*lp^2*jeq + jp*mp*r^2;
rden = den*rm;
a32 = r*mp^2*lp^2*g/den;
a33 = -kt*km*(jp + mp*lp^2)/rden;
a42 = -mp*lp*g*(jeq + mp*r^2)/den;
a43 = mp*lp*kt*r*km/rden;
b31 = kt*(jp + mp*lp^2)/rden;
b41 = -mp*lp*kt*r/rden;
A = [0, 0, 1, 0; 0, 0, 0, 1; 0 ,a32, a33, 0; 0, a42, a43, 0];
B = [0; 0; b31; b41];
C = eye(4);
Q = [4, 0, 0, 0; 0, 0.1 , 0, 0; 0 , 0, 1.5, 0; 0, 0, 0, 35 ];
R = 2;
N = 0;
[k,s,e]=lqr(A, B, Q, R, N);
k
y = A-B*k;
eig(A)
eig(y)