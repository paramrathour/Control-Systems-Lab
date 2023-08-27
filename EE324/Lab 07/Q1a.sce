s = %s;
kMax = 100;
kStep = 0.01;
kValues = kStep:kStep:100;
TF = 1/(s*(s^2+4*s+8));
TF = syslin('c', TF);
gainMargin = [];
phaseMargin = [];
for i = 1:length(kValues)
	k = kValues(i);
	G = k * TF;
	G = syslin('c', G);
	gainMargin($+1) = g_margin(G);
	phaseMargin($+1) = p_margin(G);
	if (abs(gainMargin($)) < 1e-6) and (abs(phaseMargin($)) < 1e-6)
		disp(k);
		// show_margins(32 * TF);
		// xs2pdf(0,'Q1a');
	end
end
plot(kValues', gainMargin, 'b'); xlabel("k"); ylabel("Margin");
plot(kValues', phaseMargin, 'g'); xlabel("k"); ylabel("Margin");
// plot(kValues, cat(1, gainMargin, phaseMargin)); xlabel("k"); ylabel("Margin");
legend(['Gain Margin (dB)';'Phase Margin (degree)']);
ax = gca();
ax.data_bounds=[0 -40;100 100];
xs2pdf(0,'Q1ae');

--> ans = 32