function Ts = settlingTime(gp, tStep)
    finalValue = gp($);
    Ts = 0;
    for x = length(gp):-1:1
        if abs(gp(x) - finalValue) > (0.02 * finalValue)
            Ts = x;
        break
        end
    end
    Ts = Ts * tStep;
endfunction