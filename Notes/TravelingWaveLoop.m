clear all;close all
lambda=1;
mu = pi*4e-7; % H/m
c=299792458;% m/second
epsilon=1/c^2/mu; %F/m
eta=sqrt(mu/epsilon); %ohms
k=2*pi/lambda; %1/m
a=1/k;% set radius of loop to make ka=1;

%Make structure arrays for the antenna
%Make current at center of each segment
ni=1001;
for i=1:ni;
phi=(i-1)*2*pi/(ni-1);
x_strut(i)=a*cos(phi);
y_strut(i)=a*sin(phi);
z_strut(i)=0;
if i<ni
p=phi+2*pi/(ni-1)/2;%phi at center of segment
I(i)=exp(-1j*p);
end
end

%Make angles to compute field in far zone.
%Single cut at phi=0
theta_field=[0:0.1:180]*pi/180;
phi_field=0*theta_field;

%compute far-zone field
[E_theta,E_phi] = FarZone(I,x_strut,y_strut,z_strut,theta_field,phi_field,lambda);

%draw Structure
figure
plot3(x_strut,y_strut,z_strut,'.-');
xlabel('x');ylabel('y');zlabel('z');
title('Traveling-Wave Loop')

%Compute theoretical pattern
E_theta_theory=k*eta*a/2*exp(-1j*phi_field).*cos(theta_field).*besselj(1,k*a*sin(theta_field))./k./a./sin(theta_field);
E_phi_theory=-1j*k*eta*a/2*exp(-1j*phi_field).*( (besselj(1,k*a*sin(theta_field)) -k.*a.*sin(theta_field).*besselj(2,k*a*sin(theta_field)) )./k./a./sin(theta_field) );
figure;
subplot(1,2,1)

%Draw theta pattern cut; Mirror cut to get cut at phi=pi.
mmpolar(theta_field,abs(E_theta_theory),'r',theta_field,abs(E_theta),'b','Style','compass','RLimit',[0 inf])
hold on
mmpolar(-theta_field,abs(E_theta_theory),'r',-theta_field,abs(E_theta),'b','Style','compass','RLimit',[0 inf])
legend('E_{\theta,theory}','E_\theta')

%Draw phi pattern cut; Mirror cut to get cut at phi=pi
subplot(1,2,2)
mmpolar(theta_field,abs(E_phi_theory),'r',theta_field,abs(E_phi),'b','Style','compass','RLimit',[0 inf])
hold on
mmpolar(-theta_field,abs(E_phi_theory),'r',-theta_field,abs(E_phi),'b','Style','compass','RLimit',[0 inf])
legend('E_{\phi,theory}','E_\phi')

figure;
plot(theta_field(2:end-1),abs((E_phi_theory(2:end-1)-E_phi(2:end-1))./E_phi_theory(2:end-1)),'b');
hold on
plot(theta_field(2:end-1),abs((E_theta_theory(2:end-1)-E_theta(2:end-1))./E_theta_theory(2:end-1)),'r');
xlabel('\theta');
ylabel('Error');
legend('E_{\phi}','E_\theta')