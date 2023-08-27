function Tp = peakTime(gp, tStep)
    Tp = -1;
    for x = 2:length(gp)-1
        if (gp(x) > gp(x-1)) & (gp(x) > gp(x+1))
            Tp = x;
            break
        end
    end
    Tp = Tp * tStep;
endfunction