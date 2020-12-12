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
%compute 3/4 of patttern from phi=90 to 360
[theta_field,phi_field]= meshgrid([0:2:180]*pi/180,[90:5:360]*pi/180);

%draw Structure
figure
plot3(x_strut,y_strut,z_strut,'.-');
xlabel('x');ylabel('y');zlabel('z');

%compute far-zone field
[E_theta,E_phi] = FarZone(I,x_strut,y_strut,z_strut,theta_field,phi_field,lambda);

%compute total field amplitude
E=sqrt(abs(E_theta).^2+abs(E_phi).^2);
E_max=max(E(:));
%compute the hat(r) unit vectors in cartesian components
rx_hat=sin(theta_field).*cos(phi_field);
ry_hat=sin(theta_field).*sin(phi_field);
rz_hat=cos(theta_field);
%compute polar pattern in cartesion coordinates
X=abs(E_theta/E_max).*rx_hat;
Y=abs(E_theta/E_max).*ry_hat;
Z=abs(E_theta/E_max).*rz_hat;

%draw 3d pattern
figure
surf(X,Y,Z,ones([size(X) 3]))
hold on
% cover ends of pattern
patch(X(1,:),Y(1,:),Z(1,:),'white')
patch(X(end,:),Y(end,:),Z(end,:),'white')
axis equal
view(115,25)
axis off
xlabel('x');ylabel('y');zlabel('z');
mArrow3([0 0 0],[1.5 0 0],'color',0.7*[1,1,1],'stemWidth',0.01);
text(1.6,0,0,'x','color',0.7*[1,1,1],'FontSize',16);
mArrow3([0 0 0],[0 1.5 0],'color',0.7*[1,1,1],'stemWidth',0.01);
text(0,1.6,0,'y','color',0.7*[1,1,1],'FontSize',16);
mArrow3([0 0 0],[0 0 1.5 ],'color',0.7*[1,1,1],'stemWidth',0.01);
text(0,0,1.6,'z','color',0.7*[1,1,1],'FontSize',16);