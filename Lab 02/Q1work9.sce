s = %s;                          // define the symbolic variable 's'
a = 1;
y = [];
dims = 1;
G1 = (s+5)/((s+2)*(s+4))
G2 = (s+5)/(s+4)
G3 = 1/(s+2)
sys1 = syslin('c' , G1);
sys2 = syslin('c' , G2);
sys3 = syslin('c' , G3);


plots(sys1,sys2,sys3,0.1);