deff('u=timefun(t)','u=temp1(t/tau)');
ax = gca();
ax.data_bounds=[0 0;15 1.5];

function Tr = customInput1(t)
    return temp1(t/tau)
endfunction
