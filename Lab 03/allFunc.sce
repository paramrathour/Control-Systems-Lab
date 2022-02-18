function [pOS, tP, tD, tR, tS] = timeDomainParameters(sys, finalValue, tStep)
    gp = csim('step', t, sys);
    maxValue = 0;
    tP = -1;
    tD = 0;
    tR = 0;
    tS = 0;
    for x = 1:length(gp)
        if gp(x) > maxValue
            maxValue = gp(x);
        end
    end
    for x = 2:length(gp)-1
        if (gp(x) > gp(x-1)) & (gp(x) > gp(x+1))
            tP = x;
            break
        end
    end
    for x = 1:length(gp)
        if (gp(x) > finalValue / 2)
            tD = x;
            break
        end
    end
    for x = 1:length(gp)
        if gp(x) > 0.9*finalValue
            tR = tR + x;
            break
        end
        if gp(x) < 0.1*finalValue
            tR = -x;
        end
    end
    for x = length(gp):-1:1
        if abs(gp(x) - finalValue) > (0.02 * finalValue)
            tS = x;
        break
        end
    end
    pOS = (maxValue - finalValue) * 100 / finalValue
    tP = tP * tStep;
    tD = tD * tStep;
    tR = tR * tStep;
    tS = tS * tStep;
endfunction