% Lottka - Volterra model integrated using the classical method by Runge
% and Kutta: 4th order Runge-Kutta methode explicitly written out
%
% usage: lvRK4(Steps) - Use Steps = 1000 or 5000
%
% Steps - is the number of evaluation steps
%
% RM-course Advanced Data Analysis
% Module Dynamical and Nonlinear Data analysis and Modeling 
% 
% May 2008
% Ralf Cox & Fred Hasselman

function lvRK4(Steps);

R=zeros(1,Steps); F=zeros(1,Steps);

% Parameters and Initial conditions
a=1; b=2; c=2; d=1;
R(1)=0.1; F(1)=0.1;
h=0.01; % time step

for i = 1:Steps-1

    % The 4 RK formula's for each variable
    k1_R=(a - b * F(i)) * R(i);                       k1_F=(c * R(i) - d) * F(i);
    k2_R=(a - b * (F(i)+h*k1_F/2)) * (R(i)+h*k1_R/2); k2_F=(c * (R(i)+h*k1_R/2) - d) * (F(i)+h*k1_F/2);
    k3_R=(a - b * (F(i)+h*k2_F/2)) * (R(i)+h*k2_R/2); k3_F=(c * (R(i)+h*k2_R/2) - d) * (F(i)+h*k2_F/2);
    k4_R=(a - b * (F(i)+h*k3_F)) * (R(i)+h*k3_R);     k4_F=(c * (R(i)+h*k3_R) - d) * (F(i)+h*k3_F);

    % The iterative process
    R(i+1) = R(i) + (1/6)*h*(k1_R+2*k2_R+2*k3_R+k4_R);
    F(i+1) = F(i) + (1/6)*h*(k1_F+2*k2_F+2*k3_F+k4_F);

end

%Plots
figure; 
subplot(1,2,1);
plot(R,F,'-k.');
title(['State Space of Predator-Prey dynamics with RK4 integration.']);
XLabel('R'); YLabel('F');

subplot(1,2,2);
plot(R,'-g.');
hold on;
plot(F,'-r.');
title(['Time Series of Predator-Prey dynamics with RK4 integration.']);
XLabel('t'); YLabel('Population');
