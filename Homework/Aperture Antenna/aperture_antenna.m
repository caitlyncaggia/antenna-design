%% ECE 6370 - Homework 6.2
% Caitlyn Caggia

clear all; close all;

% Constants
a = 0.75; % in terms of lambda
b = linspace(2,20,100);

% Calculations for R_lambda = 10
R = 10;
z = b/sqrt(2 * R);
eff10 = 1./z.^2 .* abs(fresnelc(z) - j*fresnels(z)).^2;
D10 = 4 .* pi .* a .* b .* eff10;

% Calculations for R_lambda = 100
R = 100;
z = b/sqrt(2 * R);
eff100 = 1./z.^2 .* abs(fresnelc(z) - j*fresnels(z)).^2;
D100 = 4 .* pi .* a .* b .* eff100;

% Generate Plots for Directivity
figure
semilogx(b,10*log10(D10));
title('2e) Directivity, R_\lambda = 10')
xlabel('b_\lambda')
ylabel('Directivity [dB]')

figure
semilogx(b,10*log10(D100));
title('2e) Directivity, R_\lambda = 100')
xlabel('b_\lambda')
ylabel('Directivity [dB]')

% Generate Plots for Phase Efficiency
figure
semilogx(b,10*log10(eff10));
title('2f) Phase Efficiency, R_\lambda = 10')
xlabel('b_\lambda')
ylabel('Phase Efficiency [dB]')

figure
semilogx(b,10*log10(eff100));
title('2f) Phase Efficiency, R_\lambda = 100')
xlabel('b_\lambda')
ylabel('Phase Efficiency [dB]')

