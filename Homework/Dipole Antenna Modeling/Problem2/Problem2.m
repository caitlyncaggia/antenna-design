%% ECE 6370 - Homework 5.2
% Caitlyn Caggia

clear all; close all;
addpath('../Problem1/Matlab_NEC')

d = dipole('Length',30/100,'Width',2*0.2/1000);

% Part A: Impedance
freq = 10e6:10e6:2e9;

figure;
Zmat = impedance(d,freq);

% Part B: Impedance Comparison
load NecValues.mat Z gain_t
R = abs((Z-Zmat) ./ (Z+Zmat));

figure;
semilogy(freq, R);
title('b) Impedance Comparison');
xlabel('Frequency, Hz');
ylabel('Relative Difference');

% Part C: Gain
Gmat = zeros(1,length(freq));
for i = 1:length(freq)
    [Gmat(i),~,~] = pattern(d,freq(i),0,0);
end

figure;
plot(freq,Gmat);
title('c) Gain Calculation');
xlabel('Frequency, Hz');
ylabel('Gain, dB');

% Part D: Gain Comparison
deltaG = gain_t - Gmat;

figure;
plot(freq,deltaG);
title('d) Gain Comparison');
xlabel('Frequency, Hz');
ylabel('Gain Difference, dB');