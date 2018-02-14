% Draws the Cusp surface (I.e., the real solutions to the equilibrium equation for the
% Cusp potential function.)
%
% RM-course Advanced Data Analysis
% Module Dynamical and Nonlinear Data analysis and Modeling 
% 
% June 2008
% Ralf Cox & Fred Hasselman
% 
clear all;

for alfa = -5:.1:5,
    for beta = -5:.1:5,
        C = [1 0 -beta -alfa];
        a = roots(C);

        % plot cusp plane
        for i=1:3,
            if isreal(a(i)) plot3(beta,alfa,a(i)); end;
            hold on;
        end;

    end;
end;
