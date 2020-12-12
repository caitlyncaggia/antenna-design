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

f = 0.5e9; c = 3e8;
L = abs(Z1) + abs(Z2);
Itheory = sin(2*pi*f/c .* (L/2 - pos));
Itheoryn = Itheory ./ max(Itheory);

figure; hold on;
plot(pos, Imagnorm, pos, Irenorm, pos, Iimnorm, pos, Itheoryn, '-o');
ylabel('Normalized Current');
xlabel('Frequency, MHz');
title('d) Current for 0.5 GHz');
legend('Magnitude', 'Real','Imaginary', 'Theory', 'Location', 'SouthEast')

%% 1.0 GHz

fname='dipoleHW5d1000.out';
[~,Z1,Z2,nseg,Ire,Iim,Imag] = nec_read_d(fname);

Imagnorm = Imag ./ max(abs(Imag));
Irenorm = Ire ./ max(abs(Ire));
Iimnorm = Iim ./ max(abs(Iim));

pos = linspace(Z1, Z2, nseg);

f = 1e9; c = 3e8;
L = abs(Z1) + abs(Z2);
Itheory = sin(2*pi*f/c .* (L/2 - pos));
Itheoryn = Itheory ./ max(Itheory);

figure; hold on;
plot(pos, Imagnorm, pos, Irenorm, pos, Iimnorm, pos, Itheoryn, '-o');
ylabel('Normalized Current');
xlabel('Frequency, MHz');
title('d) Current for 1.0 GHz');
legend('Magnitude', 'Real','Imaginary', 'Theory', 'Location', 'SouthEast')

%% 1.5 GHz

fname='dipoleHW5d1500.out';
[freq,Z1,Z2,nseg,Ire,Iim,Imag] = nec_read_d(fname);

Imagnorm = Imag ./ max(abs(Imag));
Irenorm = Ire ./ max(abs(Ire));
Iimnorm = Iim ./ max(abs(Iim));

pos = linspace(Z1, Z2, nseg);

f = 1.5e9; c = 3e8;
L = abs(Z1) + abs(Z2);
Itheory = sin(2*pi*f/c .* (L/2 - pos));
Itheoryn = Itheory ./ max(Itheory);

figure; hold on;
plot(pos, Imagnorm, pos, Irenorm, pos, Iimnorm, pos, Itheoryn, '-o');
ylabel('Normalized Current');
xlabel('Frequency, MHz');
title('d) Current for 1.5 GHz');
legend('Magnitude', 'Real','Imaginary', 'Theory', 'Location', 'SouthEast')
