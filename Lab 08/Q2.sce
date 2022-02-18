s = %s;
G1 = 1/((s+1)*(s+%i)*(s-%i)*(s+2*%i)*(s-2*%i))
G1  = 
              1             
   -----------------------  
   4 +4s +5s² +5s³ +s⁴ +s⁵
evans(G1);
xs2pdf(0,'Q2a');

k = 3;
G2 = 1/(((s+k)+1)*((s+k)+%i)*((s+k)-%i)*((s+k)+2*%i)*((s+k)-2*%i))
G2  = 
                   1                  
   ---------------------------------  
   520 +682s +374s² +107s³ +16s⁴ +s⁵  
G2 = syslin('c', G2);
bode(G2);
xs2pdf(0,'Q2b');

G3 = (s+20)^0/(((s+k)+1)*((s+k)+%i)*((s+k)-%i)*((s+k)+2*%i)*((s+k)-2*%i))
G3 = syslin('c', G3);
bode(G3);
xs2pdf(0,'Q2c0');
G3 = (s+20)^1/(((s+k)+1)*((s+k)+%i)*((s+k)-%i)*((s+k)+2*%i)*((s+k)-2*%i))
G3 = syslin('c', G3);
bode(G3);
xs2pdf(0,'Q2c1');
G3 = (s+20)^2/(((s+k)+1)*((s+k)+%i)*((s+k)-%i)*((s+k)+2*%i)*((s+k)-2*%i))
G3 = syslin('c', G3);
bode(G3);
xs2pdf(0,'Q2c2');
G3 = (s+20)^3/(((s+k)+1)*((s+k)+%i)*((s+k)-%i)*((s+k)+2*%i)*((s+k)-2*%i))
G3 = syslin('c', G3);
bode(G3);
xs2pdf(0,'Q2c3');
G3 = (s+20)^4/(((s+k)+1)*((s+k)+%i)*((s+k)-%i)*((s+k)+2*%i)*((s+k)-2*%i))
G3 = syslin('c', G3);
bode(G3);
xs2pdf(0,'Q2c4');
G3 = (s+20)^5/(((s+k)+1)*((s+k)+%i)*((s+k)-%i)*((s+k)+2*%i)*((s+k)-2*%i))
G3 = syslin('c', G3);
bode(G3);
xs2pdf(0,'Q2c5');

evans(G3);
xs2pdf(0,'Q2d');
evans(G3, 250);
xs2pdf(0,'Q2de');