function [freq,Z,gain_t,E_theta,E_phi,count,run_time] = nec_read(fname)
% This function extracts data from a NEC output file
%   count is the number of frequencies read.
%   freq is an array containing the frequencies read.
%   Z is an array containing the input impedence of the antenna.  
%   gain_t is an array containing the total gain of the antenna in dB.
%   E_theta,E_phi are arrays containing the radiated field of the antenna.
%   gain_t,E_theta,E_phi are read from the first line of the pattern table.
%   Author: Waymond Scott, 10-08-2003
%fname='exp.out'
fid=fopen(fname);
count=0;
line=0;
while line~=-1
   line=  fgets(fid);
   if findstr(line,'FREQ')>0   
      count=count+1;
      line;
      for m=1:2
         line=fgets(fid);
      end
      A = sscanf(line(47:58),'%f');
      freq(count)=A(1);
   end
   if findstr(line,'ANTENNA INPUT PARAMETERS')>0   
      line;
      for m=1:4
         line=fgets(fid);
      end
      A = sscanf(line,'%f');
      Z(count)=A(7)+i*A(8);
   end
   if findstr(line,'RADIATION PATTERNS')>0   
      line;
      for m=1:5
         line=fgets(fid);
      end
      A = sscanf(line,'%f');
      gain_t(count)=A(5);
      %  line(73:length(line))
      A = sscanf(line(73:length(line)),'%f');
      E_theta(count)=A(1)*exp(i*A(2)*pi/180);
      E_phi(count)=A(3)*exp(i*A(4)*pi/180);
   end  
   if findstr(line,'RUN TIME')>0   
      line
      run_time = sscanf(line(12:length(line)),'%f')
   end  
end

fclose(fid);
