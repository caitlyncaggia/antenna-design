% This program uses a Genetic Algorithm for optimizing a Yagi Antenna. It
% needs the subroutines ga_Gordy.m, Yagi.m, nec_read.m, and nec2dx500.exe.

clear all; close all;

%% PARAMETERS
f = 2.442e9; % center frequency [Hz]
c = 3e8;
lambda = c/f; % wavelength [m]

% Perimeter
Pmin = .3*lambda;
Pmax = 2*lambda;
Pmid = (0.3 + (2-0.3)/2)*lambda;

% Aspect Ratio
Amin = .3;
Amax = 3;
Amid = (0.3 + (3-0.3)/2);

% Spacing
Smin = .2*lambda;
Smax = .7*lambda;
Smid = (0.2 + (0.7-0.2)/2)*lambda;

% Diameter
dmin = .001*lambda;
dmax = .025*lambda;
dmid = (0.001 + (0.025-0.001)/2)*lambda;

%Upper and lower bound limit vectors
Plb = Pmin*ones(1,10); % lower
Pub = Pmax*ones(1,10); % upper
Pmid = Pmid*ones(1,10); % middle

Alb = Amin*ones(1,10); % lower
Aub = Amax*ones(1,10); % upper
Amid = Amid*ones(1,10); % middle

Slb = Smin*ones(1,10); % lower
Sub = Smax*ones(1,10); % upper
Smid = Smid*ones(1,10); % middle

dlb = dmid*ones(1,10); % lower
dub = dmid*ones(1,10); % upper
dmid = dmid*ones(1,10); % middle

lb = [Plb Amid Smid dmid];
ub = [Pub Amid Smid dmid];
p0 = [Pmid.*ones(1,10) Amid.*ones(1,10) Smid.*ones(1,10) dmid.*ones(1,10)];

parspace = [lb;ub;p0];

%% Run the Genetic Algorithm.

p = ga_Gordy('Yagi',parspace);

% Display solution
%disp('Optimized Solution')
%disp(['Lr=',num2str(Lr),'   Ls=',num2str(Ls),'   Ld=',num2str(Ld)])
%disp(['Sr=',num2str(Sr),'   Sd=',num2str(Sd)])
