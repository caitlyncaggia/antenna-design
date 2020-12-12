% ECE 6370 - Homework 2
% Caitlyn Caggia

clear all; close all;

kr = logspace(-2,2,250);
theta = 45;

RH = abs(1./kr);
REtheta = abs( 1./(j*kr) + 1./(j*kr).^2 );
REr = abs( (2./(j*kr) + 2./(j*kr).^2 ) * (cosd(theta)/sind(theta)) );

loglog(kr, RH, kr, REtheta, kr, REr)
ylabel('Differences')
xlabel('kr')
legend('R_H','R_{E\theta}','R_{Er}')
