s = %s;
G = 60/(s^3+6*s^2+11*s+6);
G = syslin('c',G);
w = [0.5, 1, 2, 5, 10];
tMax = [50, 20, 20, 10, 10];
phase = [];
phaseTheoretical = [];
gain = [];
gainTheoretical = [];
tStep = 0.01;

function z = plots(w, t, i)
    t = 0:tStep:tMax(i);
    x = sin(w(i)*t);
    y = csim(x,t,G);
    plot(t,cat(1,x,y));
    legend(['Input';'Output']);
    xlabel("t"); ylabel("Response");
    s = "Q3a"+ string(int(i));
    xs2pdf(0,s);
    gain($+1) = max(y(length(t)/2:$)) / max(x(length(t)/2:$));
    phase($+1) = modulo((find(y == max(y(length(t)/2:$))) - find(x == max(x(length(t)/2:$))))*w(i)*180/%pi, 360);

    jw = complex(0,1)*w(i);
    g = 1/((jw)^2+5*jw+6);
    gainTheoretical($+1) = abs(g);
    phaseTheoretical($+1) = modulo(atan(imag(g)/real(g))*180/%pi,360);
endfunction

plots(w, t, 1);
plots(w, t, 2);
plots(w, t, 3);
plots(w, t, 4);
plots(w, t, 5);