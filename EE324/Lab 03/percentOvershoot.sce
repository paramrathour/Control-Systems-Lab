function pOS = percentOvershoot(gp)
    finalValue = gp($);
    maxValue = 0;
    for x = 1:length(gp)
        if gp(x) > maxValue
            maxValue = gp(x)
        end
    end
    pOS = (maxValue - finalValue) * 100 / finalValue
endfunction