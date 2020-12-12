clear all;close all
lambda=1;
mu = pi*4e-7; % H/m
c=299792458;% m/second
epsilon=1/c^2/mu; %F/m
eta=sqrt(mu/epsilon); %ohms
k=2*pi/lambda; %1/m
h=0.5; %total length of dipole

%Make structure arrays for the antenna
%Make current at center of each segment
ni=101;
for i=1:ni;
x_strut(i)=0;
y_strut(i)=0;
z_strut(i)=-h/2+h*(i-1)/(ni-1);
if i<ni
z=z_strut(i)+h/(ni-1)/2;%z at center of segment
I(i)=sin(k*(h/2-abs(z)));
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
title('Half-Wave Dipole')

%Compute theoretical pattern
E_theta_theory=1j*eta/2/pi*( cos(k*h/2*cos(theta_field))-cos(k*h/2) )./sin(theta_field);
E_phi_theory=0*E_theta_theory;
figure;
subplot(1,2,1)

%Draw theta pattern cut; Mirror cut to get cut at phi=pi.
mmpolar(theta_field,abs(E_theta_theory),'r',theta_field,abs(E_theta),'b','Style','compass')
hold on
mmpolar(-theta_field,abs(E_theta_theory),'r',-theta_field,abs(E_theta),'b','Style','compass')
legend('E_{\theta,theory}','E_\theta')
%Draw phi pattern cut; Mirror cut to get cut at phi=pi
subplot(1,2,2)
mmpolar(theta_field,abs(E_phi_theory),'r',theta_field,abs(E_phi),'b','Style','compass')
hold on
mmpolar(-theta_field,abs(E_phi_theory),'r',-theta_field,abs(E_phi),'b','Style','compass')
legend('E_{\phi,theory}','E_\phi')

figure;
plot(theta_field(2:end-1),abs((E_theta_theory(2:end-1)-E_theta(2:end-1))./E_theta_theory(2:end-1)),'k');
xlabel('\theta');
ylabel('|E_{\theta, theory}-E_\theta|/|E_{\theta, theory}|');