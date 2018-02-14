% Lottka - Volterra model with  Runge-Kutta 4 numerical integration
% Using Matlab-procedure 'ode45'
%
% usage: lvODE45(Steps) - Use Steps = 15 or 100
%
% Steps - is the number of evaluation steps
%
% RM-course Advanced Data Analysis
% Module Dynamical and Nonlinear Data analysis and Modeling 
% 
% May 2008
% Fred Hasselman & Ralf Cox

function lvODE45(Steps);
a = 1; b = 2; c = 2; d = 1;

[t,x] = ode45(@lvfun, [0 Steps], [0.1 0.1], [], a,b,c,d);

%Plots
figure; 
subplot(1,2,1);
plot(x(:,1),x(:,2),'-k.'); 
title(['State Space of Predator-Prey dynamics with ode45.']);
XLabel('R'); YLabel('F');

subplot(1,2,2);
plot(x(:,1),'-g.');
hold on;
plot(x(:,2),'-r.');
title(['Time Series of Predator-Prey dynamics with ode45.']);
XLabel('t'); YLabel('Population');

%This is the Lottka-Volterra function
function dx=lvfun(t,x,a,b,c,d);
dx = [(a-b*x(2))*x(1)
      (c*x(1)-d)*x(2)];