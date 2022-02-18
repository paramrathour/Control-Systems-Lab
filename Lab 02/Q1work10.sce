function y = plots(sys1,sys2,sys3,tau)
	
	t = [0:tau:10];
	y = cat(dims, y, csim('step', t, sys1));

	temp1 = csim('step', t, sys2);
	y = cat(dims, y, csim(temp1, t, sys3));

	temp2 = csim('step', t, sys3);
	y = cat(dims, y, csim(temp2, t, sys2));

	plot(t',y'); xlabel("t"); ylabel("Step Response")
	legend(['a';'b';'c']);
	filename = "Q5" + string(int(10*tau)) 
	xs2pdf(0,filename); 

endfunction