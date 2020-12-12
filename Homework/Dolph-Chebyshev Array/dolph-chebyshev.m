%% ECE 6370 Homework 7.2
% Caitlyn Caggia

clear all; close all;

%Part A
R = 10^(30/20);
N = 6;

x0 = cosh( acosh(R) / (N-1) )

xi = zeros(1,N-1);
di = zeros(1,N-1);
for i = 1:N-1
    xii = cos( ((i-0.5)*pi) / (N-1));
    dii = 2*acos(xii/x0);
    
    xi(i) = xii;
    di(i) = dii;
end
disp(xi)
disp(di)

% Part B
Ai = real(poly( exp(j*di) ))

% Part C
Acheb = chebwin(6, 30)
Achebnorm = Acheb ./ Acheb(1) % normalize first term to 1

% Part D
dopt = (1/2) * (1 - acos(1/x0)/pi); % times lambda
sprintf('optimum spacing is %f * lambda', dopt)

% Part E
theta = linspace(-pi,pi,500);
kd = 2*pi*dopt; % lambdas cancel
delta = kd*cos(theta) - kd;

fd = 0;
for n = 0:N-1
    fd = fd + Ai(n+1) .* exp(j .* n .* delta);
end

figure;
mmpolar(theta, abs(fd)./max(abs(fd)));