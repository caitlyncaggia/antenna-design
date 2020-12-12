%% ECE 6370 Homework 8
% Caitlyn Caggia

clear all; close all;

%% Problem 1
% Admittance Matrix

% Read in currents from NEC output
I1 = dlmread('hw811.txt');
I2 = dlmread('hw812.txt');
I3 = dlmread('hw813.txt');

Y11 = I1(6,1) + j*I1(6,2);
Y12 = I1(6+11,1) + j*I1(6+11,2);
Y13 = I1(6+11*2,1) + j*I1(6+11*2,2);

Y21 = I2(6,1) + j*I2(6,2);
Y22 = I2(6+11,1) + j*I2(6+11,2);
Y23 = I2(6+11*2,1) + j*I2(6+11*2,2);

Y31 = I3(6,1) + j*I3(6,2);
Y32 = I3(6+11,1) + j*I3(6+11,2);
Y33 = I3(6+11*2,1) + j*I3(6+11*2,2);

% Calculate admittance matrix
Y = [Y11 Y12 Y13; 
     Y21 Y22 Y21;
     Y31 Y32 Y33];
 
% Print admittance matrix in magnitude/angle pairs
admit = sprintf([' 1. Admittance matrix Y = \n'...
    '[ %2.5f <%2.5f \t %2.5f <%2.5f \t %2.5f <%2.5f \n' ...
    '  %2.5f <%2.5f \t %2.5f <%2.5f \t %2.5f <%2.5f \n'...
    '  %2.5f <%2.5f \t %2.5f <%2.5f \t %2.5f <%2.5f ]\n\n'],...
    abs(Y11), angle(Y11), abs(Y12), angle(Y12), abs(Y13), angle(Y13), ...
    abs(Y21), angle(Y21), abs(Y22), angle(Y22), abs(Y23), angle(Y23), ...
    abs(Y31), angle(Y31), abs(Y32), angle(Y32), abs(Y33), angle(Y33));
disp(admit)

%% Problem 2
% Impedance Matrix

% Calculate impedance matrix
Z = inv(Y);

% Print impedance matrix in magnitude/angle pairs
imped = sprintf(['2. Impedance matrix Z = \n'...
    '[ %2.5f <%2.5f \t %2.5f <%2.5f \t %2.5f <%2.5f \n' ...
    '  %2.5f <%2.5f \t %2.5f <%2.5f \t %2.5f <%2.5f \n'...
    '  %2.5f <%2.5f \t %2.5f <%2.5f \t %2.5f <%2.5f ]\n\n'],...
    abs(Z(1,1)), angle(Z(1,1)), abs(Z(1,2)), angle(Z(1,2)), abs(Z(1,3)), angle(Z(1,3)), ...
    abs(Z(2,1)), angle(Z(2,1)), abs(Z(2,2)), angle(Z(2,2)), abs(Z(2,3)), angle(Z(2,3)), ...
    abs(Z(3,1)), angle(Z(3,1)), abs(Z(3,2)), angle(Z(3,2)), abs(Z(3,3)), angle(Z(3,3)));
disp(imped);

%% Problem 3
% Ordinary Endfire Array Voltage

% Calculate Vn
I0 = 0.1; % [A]
lambda = 3e8/1.5e9; % [m]
k = (2*pi)/lambda; % [rad/m]
d = 7.5e-2; % [m]

In = zeros(3,1);
for n=1:3
    In(n) = I0 * exp(-j * (n-1) * k * d);
end

Vn = Z*In;

% Print magnitude and angle of Vn
showVn = sprintf(['3. Ordinary Endfire Array Voltage Vn = \n' ...
    '[ %2.5f <%2.5f \n %2.5f <%2.5f \n %2.5f <%2.5f ] \n\n'], ...
    abs(Vn(1)), angle(Vn(1)), abs(Vn(2)), ...
    angle(Vn(2)), abs(Vn(3)), angle(Vn(3)));
disp(showVn)

%% Problem 4
% Driving Point Impedance

% Calculate Zdn
Zdn = Vn/In;

% Print magnitude and angle of Zdn
showZdn = sprintf(['4. Driving Point Impedance Zdn = \n' ...
    '[ %2.5f <%2.5f \n %2.5f <%2.5f \n %2.5f <%2.5f ]\n\n'], ...
    abs(Zdn(1)), angle(Zdn(1)), abs(Zdn(2)), ...
    angle(Zdn(2)), abs(Zdn(3)), angle(Zdn(3)));
disp(showZdn)

%% Problem 5
% 3D Pattern with Vn

% Print real and imaginary parts of Vn
showVn2 = sprintf(['5. Ordinary Endfire Array Voltage Vn = \n' ...
    '[ %2.5f + i%2.5f \n  %2.5f + i%2.5f \n  %2.5f + i%2.5f ] \n\n'], ...
    real(Vn(1)), imag(Vn(1)), real(Vn(2)), imag(Vn(2)), ...
    real(Vn(3)), imag(Vn(3)));
disp(showVn2)

%% Problem 6
% 3D Pattern with ~Vn

Vn16 = Z(1,1)*In(1);
Vn26 = Z(2,2)*In(2);
Vn36 = Z(3,3)*In(3);

Vn6 = [Vn16; Vn26; Vn36];

% Print magnitude and angle of Vapprox
showVn6mag = sprintf(['6.1. Approximated Voltage ~Vn = \n' ...
    '[ %2.5f <%2.5f \n  %2.5f <%2.5f \n  %2.5f <%2.5f ] \n\n'], ...
    abs(Vn16), angle(Vn16), abs(Vn26), ...
    angle(Vn26), abs(Vn36), angle(Vn36));
disp(showVn6mag)

% Print real and imaginary parts of Vapprox
showVn6RI = sprintf(['6.2. Approximated Voltage ~Vn = \n' ...
    '[ %2.5f + i%2.5f \n %2.5f + i%2.5f \n %2.5f + i%2.5f ] \n\n'], ...
    real(Vn6(1)), imag(Vn6(1)), real(Vn6(2)), imag(Vn6(2)), ...
    real(Vn6(3)), imag(Vn6(3)));
disp(showVn6RI)

disp(['Problem 6 shows the approximated Vn gives bigger back and side' ...
    'lobes than Problem 5 plots with actual Vn.'])

%% Problem 7

% Element Pattern
l = 0.05; % [cm]
eta = 377; % [Ohms]
r = 1; % [m] 
theta = linspace(-pi,pi,5000);
elementE = (j*eta*I0*exp(-j*k*r)) / (2*pi*r) * ( cos(k.*l.*cos(theta)) - cos(k.*l) ) ./ sin(theta);
figure;
polarplot(theta, abs(elementE));
title('7. Element Pattern')

% Array Factor
del = k.*d.*cos(theta-pi/2) - k.*d; % subtract pi/2 to flip pattern
N = 3;
arrayFactor = abs(sin(N.*del./2) ./ sin(del./2));
figure;
polarplot(theta, arrayFactor);
title('7. Array Factor')

% Pattern from Theory
arrayTheory = elementE .* arrayFactor;

% Pattern from NEC
necE_theta = dlmread('hw85.out','',[201,8,201+360/2,8]);
necTheta = deg2rad(0:2:360);
figure;
polarplot(theta, abs(arrayTheory), '-', necTheta, abs(necE_theta), '--');
title('7. Theoretical Antenna Pattern vs NEC Pattern');
legend('Theoretical Pattern (solid)', 'NEC Pattern (dashed)')

