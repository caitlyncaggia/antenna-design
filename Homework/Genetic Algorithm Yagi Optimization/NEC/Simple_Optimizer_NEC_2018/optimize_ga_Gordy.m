% This program uses a Genetic Algorithm for optimizing a Yagi Antenna. 
% It needs the subroutines ga.m, Yagi.m, nec_read.m, and nec2dx500.exe.
%Set up parameter space for the Genetic Algorithm.
clear all;close all;
%[length of reflector, length of driven element, length of director,location of reflector,  location of director]
lb=[0.35  0.35  0.35  0.15 0.15];% lower bound on parameters
ub=[0.55  0.55  0.55  0.50 0.50];% upper bound on parameters
p0=[0.482 0.462 0.442 0.20 0.20];% initial guess for parameters(NBS design)
%p0=lb+(ub-lb).*rand(size(lb));% initial guess for parameters
parspace=[lb; ub; p0]; %combine lb, ub, p0 for the ga_Gordy.m
%Run the Genetic Algorithm.
p=ga_Gordy('Yagi',parspace)
Lr=p(1); %length of reflector
Ls=p(2); %length of driven element
Ld=p(3); %length of director
Sr=-p(4); %location of reflector
Sd=p(5);  %location of director
%Display solution
disp('Optimized Solution')
disp(['Lr=',num2str(Lr),'   Ls=',num2str(Ls),'   Ld=',num2str(Ld)])
disp(['Sr=',num2str(Sr),'   Sd=',num2str(Sd)])
