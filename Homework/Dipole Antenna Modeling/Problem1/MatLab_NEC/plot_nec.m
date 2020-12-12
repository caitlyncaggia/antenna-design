clear all;
close all

addpath('..')


f_name='dipoleHW5a.out';
[freq,Z,gain_t,E_theta,E_phi,n_freq_meas,run_time] = nec_read(f_name);


plot(freq,gain_t);
ylabel('Gain (dB) at \phi=0 , \theta=90 degrees');
xlabel('Frequency, MHz');
title('b) Antenna Gain');

figure;hold on;
plot(freq,real(Z));
plot(freq,imag(Z));
ylabel('Impedance, \Omega');
xlabel('Frequency, MHz');
title('a) Antenna Impedance');
legend('Real','Imaginary', 'Location', 'SouthEast')

save NecValues.mat Z gain_t;