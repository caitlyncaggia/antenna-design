% This program uses a hill climbing algorithm for optimizing a Yagi Antenna. 
% It needs the subroutines mYagi.m, nec_read.m, and nec2dx500.exe.
%Set up parameter space for the Genetic Algorithm.
clear all;close all;
lb=[0.35  0.35  0.35  0.15 0.15];% lower bound on parameters
ub=[0.55  0.55  0.55  0.50 0.50];% upper bound on parameters
%p0=[0.482 0.462 0.442 0.20 0.20];% initial guess for parameters(NBS design)
p0=lb+(ub-lb).*rand(size(lb));% initial guess for parameters
%Run the optimizer.
options = optimset('fmincon');
options = optimset(options, 'DiffMinChange', 1e-3);
[p,m_gain] = fmincon(@mYagi,p0,[],[],[],[],lb,ub,[],options)
Lr=p(1); %length of reflector
Ls=p(2); %length of driven element
Ld=p(3); %length of director
Sr=-p(4); %location of reflector
Sd=p(5);  %location of director
%Display solution
disp('Optimized Solution')
disp(['Lr=',num2str(Lr),'   Ls=',num2str(Ls),'   Ld=',num2str(Ld)])
disp(['Sr=',num2str(Sr),'   Sd=',num2str(Sd)])
