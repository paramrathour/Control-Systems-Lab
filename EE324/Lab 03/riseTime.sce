function Tr = riseTime(gp, tStep)
    finalValue = gp($);
    Tr = 0;
    for x = 1:length(gp)
        if gp(x) > 0.9*finalValue
            Tr = Tr + x;
            break
        end
        if gp(x) < 0.1*finalValue
            Tr = -x;
        end
    end
    Tr = Tr * tStep;
endfunction