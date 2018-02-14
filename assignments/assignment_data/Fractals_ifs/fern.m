% Fractal Fern using Iterated Funtion Systems
%
% RM-course Advanced Data Analysis
% Module Dynamical and Nonlinear Data analysis and Modeling 
% 
% May 2008
% Fred Hasselman & Ralf Cox

x = 0;              %Starting points
y = 0;
figure;
plot(x,y,'.g');
hold on;

for i=1:20000       %This takes some time: 20.000 iterations
    coor=rand;      %coor becomes a random number between 0 and 1

    if coor<=0.01                   %This transformation 1% of the time
        x=0;
        y=0.16*y;
    end
    
    if (coor>0.01 && coor <=0.08)   %This transformation 7% of the time
        x=0.2*x-0.26*y;
        y=0.23*x+0.22*y+1.6;
    end
    
    if (coor>0.08 && coor <=0.15)   %This transformation 7% of the time
        x=-0.15*x+0.28*y;
        y=0.26*x+0.24*y+0.44;
    end
    
    if (coor>0.15 && coor <=1)      %This transformation 85% of the time
        x=-0.85*x+0.04*y;
        y=-0.04*x+0.85*y+1.6;    
    end
    
    plot(x,y,'.g');
    hold on;
end