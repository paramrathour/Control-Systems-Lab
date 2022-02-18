function Td = delayTime(gp, tStep)
    finalValue = gp($);
    Td = 0
    for x = 1:length(gp)
        if (gp(x) > finalValue / 2)
            Td = x;
            break
        end
    end
    Td = Td * tStep;
endfunction