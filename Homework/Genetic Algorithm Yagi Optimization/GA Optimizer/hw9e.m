% ECE 6370 Homework 9.e
% Caitlyn Caggia

[freq,Z,gain_t,~,~,~,~] = nec_read('Yagi_e.out');

figure
plot(freq,real(Z),'k--',freq,imag(Z),'k')
title('Impedance vs Frequency');
xlabel('Frequency');
ylabel('Impedance');

figure
plot(freq,gain_t)
title('Gain vs Frequency');
xlabel('Frequency');
ylabel('Gain in dB');

Z0 = 50;
rho = (Z-Z0)./(Z+Z0);
gain = 10*log10(10.^(gain_t/10).*(1-abs(rho).^2));

figure
plot(freq,gain);
title('Realized Gain vs Frequency')
xlabel('Frequency');
ylabel('Realized Gain in dB');