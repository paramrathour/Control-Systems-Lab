s = %s;
Pvalues = -10:0.5:10;
for i = 1:length(Pvalues)
    p = Pvalues(i);
    G =  (s + p) / (s*(s+1)*(s+2));
	evans(G);
end
xs2pdf(0,'Q1d');