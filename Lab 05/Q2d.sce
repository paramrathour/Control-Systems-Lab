s = %s;
G =  1 / ((s^2 - 1) * (s^2 - 9))
evans(G, 10000);
xs2pdf(0,'Q2d1');

s = %s;
G =  1 / ((-s^2 - 1) * (-s^2 - 9))
evans(G, 10000);
xs2pdf(0,'Q2d2');

s = %s;
G =  1 / ((-(s-2)^2 - 1) * (-(s-2)^2 - 9))
evans(G, 10000);
xs2pdf(0,'Q2d3');