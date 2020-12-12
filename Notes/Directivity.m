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
%compute entire pattern on a grid
%choose grid to make integration easy
ntheta=1000;
delta_theta=pi/ntheta;
theta=([1:ntheta]-0.5)*delta_theta;
nphi=2*ntheta;
delta_phi=2*pi/nphi;
phi=([1:nphi]-0.5)*delta_phi;
[theta_field,phi_field]= meshgrid(theta,phi);
%draw Structure
figure
plot3(x_strut,y_strut,z_strut,'.-');
xlabel('x');ylabel('y');zlabel('z');

%compute far-zone field
[E_theta,E_phi] = FarZone(I,x_strut,y_strut,z_strut,theta_field,phi_field,lambda);
%compute radiation intensity
E=sqrt(abs(E_theta).^2+abs(E_phi).^2);
U=E.^2/2/eta;
%compute power radiated by integrating radiation intensity
tmp=sin(theta_field).*U;
power=sum(tmp(:))*delta_theta*delta_phi;
%Compute directivity
D=4*pi*max(U(:))/power
D_db=10*log10(D)