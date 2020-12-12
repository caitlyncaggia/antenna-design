% ECE 6370 Homework 9
% Caitlyn Caggia

% This program uses a Genetic Algorithm for optimizing a Yagi Antenna. 
% It needs the subroutines ga.m, mYagi.m, nec_read.m, and nec2dx500.exe.

clear all; close all;

% Set up parameter space for the Genetic Algorithm
f = 2.442e9; % center frequency [Hz]
lambda = 3e8/f; % wavelength [m]
Prange = [0.3*lambda, 2*lambda]; % Perimiter
Arange = [0.3, 3]; % Aspect ratio
Srange = [0.2*lambda, 0.7*lambda]; % Spacing
drange = [0.001*lambda, 0.025*lambda]; % Diameter

lb = [Prange(1)*ones(1,10) Arange(1)*ones(1,10) Srange(1)*ones(1,10) ...
    drange(1)*ones(1,10)]; % lower bound on parameters
ub = [Prange(2)*ones(1,10) Arange(2)*ones(1,10) Srange(2)*ones(1,10) ...
    drange(2)*ones(1,10)]; % upper bound on parameters
p0 = lb+(ub-lb).*rand(size(lb)); % initial guess for parameters

options = gaoptimset('CrossoverFrac', 0.1, ...
    'PopulationSize', 75, 'StallGen', 125, 'Generations', 12, ...
    'PlotFcns', {@gaplotbestf, @gaplotscorediversity});

% Run the Genetic Algorithm
[p,fval] = ga(@mYagi,length(lb),[],[],[],[],lb,ub, [], [], options)
P = p(1:10);  % Perimeter
A = p(11:20); % Aspect ratio
S = p(21:30); % Element spacing
d = p(31:40); % Diameter

% Produce NEC Input File for Optimized Antenna
optGain = Yagi(p)
