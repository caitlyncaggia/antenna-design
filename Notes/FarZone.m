function [E_theta,E_phi] = FarZone(I,x_strut,y_strut,z_strut, ...
    theta_field,phi_field,lambda)
%This function computes the far-zone efield that is radiated from a wire
%structure defined by the coordinates:
% x_strut -one dimensional array with x-coordinates of the segment ends
% y_strut -one dimensional array with y-coordinates of the segment ends
% z_strut -one dimensional array with z-coordinates of the segment ends
% Note: for a closed a structure make the first and last elements of the
% struct arays the same.
%
% The current:
% I -one dimensional array with the current at the center of each segment
%
% The field is evaluated at the angles
% theta_field -one or two dimensional array of the theta angles
% phi_field -one or two dimensional array of the phi angles
% theta_field and phi_field must have the same dimensions.
%
% The wavelength is is in the variable lambda.
%
% Output variables:
% E_theta -theta component of the radiated field
% E_phi -phi component of the radiated field
% The fields have the exp(-jkr)/r suppressed
%
% Waymond Scott, 2019

mu = pi*4e-7; % H/m
c=299792458;% m/second
epsilon=1/c^2/mu; %F/m
eta=sqrt(mu/epsilon); %ohms
k=2*pi/lambda; %1/m
E_theta=0*theta_field;
E_phi=E_theta;

%compute the x,y,z, length of each segment of the structure
dx_strut = x_strut(2:end) -x_strut(1:end-1);
dy_strut = y_strut(2:end) -y_strut(1:end-1);
dz_strut = z_strut(2:end) -z_strut(1:end-1);
dell_strut = sqrt(dx_strut.^2+dy_strut.^2+dz_strut.^2);

%compute the R' vectors in cartesian components
Rxp=(x_strut(2:end)+x_strut(1:end-1))/2;
Ryp=(y_strut(2:end)+y_strut(1:end-1))/2;
Rzp=(z_strut(2:end)+z_strut(1:end-1))/2;

%compute the hat(r) unit vectors in cartesian components
rx_hat=sin(theta_field).*cos(phi_field);
ry_hat=sin(theta_field).*sin(phi_field);
rz_hat=cos(theta_field);

%compute the hat(theta) unit vectors in cartesian components
theta_x_hat=cos(theta_field).*cos(phi_field);
theta_y_hat=cos(theta_field).*sin(phi_field);
theta_z_hat=-sin(theta_field);

%compute the hat(phi) unit vectors in cartesian components
phi_x_hat=-sin(phi_field);
phi_y_hat= cos(phi_field);
%phi_z_hat=0;

%Compute the N integral in cartesian components
Nx=zeros([size(theta_field)]);
Ny=zeros([size(theta_field)]);
Nz=zeros([size(theta_field)]);
for i = 1:length(dx_strut)
tmp=exp(1j*k*(Rxp(i)*rx_hat+Ryp(i)*ry_hat+Rzp(i)*rz_hat));
Nx=Nx+I(i)*dx_strut(i)*tmp;
Ny=Ny+I(i)*dy_strut(i)*tmp;
Nz=Nz+I(i)*dz_strut(i)*tmp;
end

%convert N into spherical components
Ntheta=Nx.*theta_x_hat+Ny.*theta_y_hat+Nz.*theta_z_hat;
Nphi=Nx.*phi_x_hat+Ny.*phi_y_hat;%+Nz.*phi_z_hat;

%compute E from N note we are suppressing the exp(-jkr)/r term
E_theta=-1j*k*eta/4/pi*Ntheta;
E_phi=-1j*k*eta/4/pi*Nphi;

end

