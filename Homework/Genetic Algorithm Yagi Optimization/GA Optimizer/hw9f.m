% ECE 6370 Homework 9.f
% Caitlyn Caggia

[freq1,Z1,gain_t1,~,~,~,~] = nec_read('Yagi_f1.out');
[freq2,Z2,gain_t2,~,~,~,~] = nec_read('Yagi_f2.out');
[freq3,Z3,gain_t3,~,~,~,~] = nec_read('Yagi_f3.out');

Z0 = 50;
rho1 = (Z1-Z0)./(Z1+Z0);
gain1 = 10*log10(10.^(gain_t1/10).*(1-abs(rho1).^2));
rho2 = (Z2-Z0)./(Z2+Z0);
gain2 = 10*log10(10.^(gain_t2/10).*(1-abs(rho2).^2));
rho3 = (Z3-Z0)./(Z3+Z0);
gain3 = 10*log10(10.^(gain_t3/10).*(1-abs(rho3).^2));

tableInfo = [Z1, gain_t1, gain1; Z2, gain_t2, gain2; Z3, gain_t3, gain3];

tabl = array2table(tableInfo);

writetable(tabl, 'partf table.xls')

