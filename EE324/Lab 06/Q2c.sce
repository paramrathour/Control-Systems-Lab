s = %s;
G = 1/((s+3)*(s+4)*(s+12));
zValues = 0:0.01:1;
for i = 1:length(zValues)
    z = zValues(i);
    PI = (s+z)/s;
    TF = G * PI;
    evans(TF);
end
xs2pdf(0,'Q2c1');

s = %s;
G = 1/((s+3)*(s+4)*(s+12));
zValues = 1:1:20;
for i = 1:length(zValues)
    z = zValues(i);
    PI = (s+z)/s;
    TF = G * PI;
    evans(TF);
end
xs2pdf(0,'Q2c2');


s = %s;
G = 1/((s+3)*(s+4)*(s+12));
zValues = 1:0.1:2;
for i = 1:length(zValues)
    z = zValues(i);
    PI = (s+z)/s;
    TF = G * PI;
    evans(TF);
end
xs2pdf(0,'Q2c3');