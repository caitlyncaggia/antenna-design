%% ECE 6370 - Homework 3
% Caitlyn Caggia

theta = linspace(-pi,pi,300);
figure

%% Traveling Wave (Problem 2)
% total length 0.5*lambda --> L = 0.5*lambda
kL = pi;
E = abs(sin(theta).*(exp(-j*kL*(1-cos(theta)))-1)./-(1-cos(theta)));
subplot(3,2,1)
mmpolar(theta,E./max(E));
title('Traveling Wave, L = 0.5\lambda')

% total length 2.5*lambda --> L = 2.5*lambda
kL = 5*pi;
subplot(3,2,2)
E = abs(sin(theta).*(exp(-j*kL*(1-cos(theta)))-1)./-(1-cos(theta)));
mmpolar(theta,E./max(E));
title('Traveling Wave, L = 2.5\lambda')

%% Uniform Current (Problem 1)
% total length 0.5*lambda --> L = 0.5/2 * lambda
kL = 0.5*pi;
E = abs(sin(theta).*sin(kL.*cos(theta))./(cos(theta)));
subplot(3,2,3)
mmpolar(theta,E./max(E));
title('Uniform Current, L = 0.25\lambda')

% total length 2.5*lambda --> L = 2.5/2 * lambda
kL = 2.5*pi;
subplot(3,2,4)
E = abs(sin(theta).*sin(kL.*cos(theta))./(cos(theta)));
mmpolar(theta,E./max(E));
title('Uniform Current, L = 1.25\lambda')

%% Standing Wave
% total length 0.5*lambda --> L = 0.5*lambda
kL = 0.5*pi;
E = abs((cos(kL.*cos(theta))-cos(kL))./sin(theta));
subplot(3,2,5)
mmpolar(theta,E./max(E));
title('Standing Wave, L = 0.25\lambda')

% total length 2.5*lambda --> L = 2.5*lambda
kL = 2.5*pi;
subplot(3,2,6)
E = abs((cos(kL.*cos(theta))-cos(kL))./sin(theta));
mmpolar(theta,E./max(E));
title('Standing Wave, L = 1.25\lambda')