function TF = CLTFPositiveUnity(G,K)
	TF = K*G/(1+K*G);
endfunction
s = %s;
G = 10/(s*(s+2)*(s+4));
K = 4.2;
TF = CLTFPositiveUnity(G,K)