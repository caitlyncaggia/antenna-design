function [gain_t]=Yagi(p)
% This program is used with a getic optimization code.
% It creates an NEC input file given the parameters for a 3 element YAGI
% antenna.  Then, it runs NEC and reads in the parameters(Gain, Impedance, etc) generated by NEC.
%=========Create NEC input file========================================
Fname_nec='Yagi.nec';
FID_nec=fopen(Fname_nec,'wt');
D=0.0085; % diamter of elements in wavelengths
R=D/2;
Lr=p(1); %length of reflector
Ls=p(2); %length of driven element
Ld=p(3); %length of director
Sr=-p(4); %location of reflector
Sd=p(5);  %location of director
%    Geometry input for NEC
fprintf(FID_nec,strcat('CM EXAMPLE','\n'));
fprintf(FID_nec,strcat('CM UDA-YAGI ANTENNA','\n'));
fprintf(FID_nec,strcat('CE FIle Generated by MatLab','\n'));
fprintf(FID_nec,'GW %3i %3i %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f\n',1,7,Sr,0,-Lr/2,Sr,0,Lr/2,R); %Reflector
fprintf(FID_nec,'GW %3i %3i %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f\n',2,7,0 ,0,-Ls/2, 0,0,Ls/2,R); %Driven Element
fprintf(FID_nec,'GW %3i %3i %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f %8.4f\n',3,7,Sd,0,-Ld/2,Sd,0,Ld/2,R); %Director
%    Program Control Commands for NEC
fprintf(FID_nec,strcat('GE','\n'));
fprintf(FID_nec,'EX %3i %3i %3i %3i %8.4f %8.4f\n',0,2,4,0,1,0);%Exitation Command wire 2 segment 4
fprintf(FID_nec,'FR %3i %3i %3i %3i %8.4f %8.4f\n',0,1,0,0,299.8,0);%set freq to 299.8 MHz so wavelength will be 1m
fprintf(FID_nec,'RP %3i %3i %3i %3i %8.4f %8.4f %8.4f %8.4f\n',0,1,1,1000,90,0,0,0);%calculate gain at boresite
fprintf(FID_nec,strcat('EN','\n'));
fclose(FID_nec);
%=======Create file to pipe to NEC ===================================
FID_input=fopen('input_CMD','wt');
fprintf(FID_input,strcat(Fname_nec,'\n'));
fprintf(FID_input,strcat('NEC.out','\n'));
fclose(FID_input);
%=======Run NEC======================================================
!NEC2Dx500 < input_CMD >tmp;
%=======Read Data form NEC output file===============================
[freq,Z,gain_t,E_theta,E_phi,n_freq_meas,run_time] = nec_read('NEC.out');


%====================================================================
%Graph the current Yagi along with the history of the gain.
%You will want to comment out this sesction for long runs
%otherwise it will slow down your code
figure(1);
subplot(1,2,1)
plot([Sr Sr],[-Lr/2 Lr/2]);%plot reflector 
xlabel('x/\lambda')
ylabel('z/\lambda')
axis equal
hold on
plot([0 0],[-Ls/2 Ls/2]);%plot driven 
plot([Sd Sd],[-Ld/2 Ld/2]);%plot director 
hold off
axis([-.6 .6 -.4 .4])
subplot(1,2,2)
global Gain_old 
Gain_old=[Gain_old gain_t];
semilogx(Gain_old)
axis([0 100*ceil(length(Gain_old)/100) 7 10.5])
xlabel('iteration')
ylabel('Gain, dB')
drawnow
