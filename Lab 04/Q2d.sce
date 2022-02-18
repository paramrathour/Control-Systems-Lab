s = %s;
G = 10/(s*(s+2)*(s+4));
K = 4.8;
TF = CLTFPositiveUnity(G,K);
[r, num] = routh_t(TF.den)

K = 4.79;
TF = CLTFPositiveUnity(G,K);
[r, num] = routh_t(TF.den)