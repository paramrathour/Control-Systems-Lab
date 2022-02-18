function Tr = riseTime(gp, step, tmax)
    finalValue = gp($);
    for x = 1:tmax/step
        if gp(x) > 0.9*finalValue
            Tr = Tr + x;
            break
        end
        if gp(x) < 0.1*finalValue
            Tr = -x;
        end
    end
    Tr = Tr * step
endfunction