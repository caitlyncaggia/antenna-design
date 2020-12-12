clear all;
close all

addpath('..')

%% 0.5 GHz

fname='dipoleHW5d500.out';
[~,Z1,Z2,nseg,Ire,Iim,Imag] = nec_read_d(fname);

Imagnorm = Imag ./ max(abs(Imag));
Irenorm = Ire ./ max(abs(Ire));
Iimnorm = Iim ./ max(abs(Iim));

pos = linspace(Z1, Z2, nseg);

figure; hold on;
plot(pos, Imagnorm, pos, Irenorm, pos, Iimnorm);
ylabel('Normalized Current');
xlabel('Frequency, MHz');
title('d) Current for 0.5 GHz');
legend('Magnitude', 'Real','Imaginary', 'Location', 'SouthEast')

%% 1.0 GHz

fname='dipoleHW5d1000.out';
[~,Z1,Z2,nseg,Ire,Iim,Imag] = nec_read_d(fname);

Imagnorm = Imag ./ max(abs(Imag));
Irenorm = Ire ./ max(abs(Ire));
Iimnorm = Iim ./ max(abs(Iim));

pos = linspace(Z1, Z2, nseg);

figure; hold on;
plot(pos, Imagnorm, pos, Irenorm, pos, Iimnorm);
ylabel('Normalized Current');
xlabel('Frequency, MHz');
title('d) Current for 1.0 GHz');
legend('Magnitude', 'Real','Imaginary', 'Location', 'SouthEast')

%% 1.5 GHz

fname='dipoleHW5d1500.out';
[freq,Z1,Z2,nseg,Ire,Iim,Imag] = nec_read_d(fname);

Imagnorm = Imag ./ max(abs(Imag));
Irenorm = Ire ./ max(abs(Ire));
Iimnorm = Iim ./ max(abs(Iim));

pos = linspace(Z1, Z2, nseg);

figure; hold on;
plot(pos, Imagnorm, pos, Irenorm, pos, Iimnorm);
ylabel('Normalized Current');
xlabel('Frequency, MHz');
title('d) Current for 1.5 GHz');
legend('Magnitude', 'Real','Imaginary', 'Location', 'SouthEast')
