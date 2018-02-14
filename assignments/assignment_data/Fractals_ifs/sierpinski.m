% Sierpinski Gasket using Iterated Function Systems
%
% RM-course Advanced Data Analysis
% Module Dynamical and Nonlinear Data analysis and Modeling 
% 
% May 2008
% Fred Hasselman & Ralf Cox

x = 0;                  %Starting points
y = 0;
figure;

for i=1:20000           %This takes some time: 20.000 iterations
    coor=rand;          %coor becomes a random number between 0 and 1

    if coor<=0.33       %Equal chances (33%) to perform one of these 3 transformations of x and y
        x=0.5*x;
        y=0.5*y;
        plot(x,y,'.g'); %plot these points in green
    end

    if (coor>0.33 && coor <=0.66)
        x=0.5*x+0.5;
        y=0.5*y+0.5;
        plot(x,y,'.b'); %plot these points in blue
    end

    if (coor>0.66 && coor <=1)
        x=0.5*x+1;
        y=0.5*y;
        plot(x,y,'.r'); %plot these points in red
    end

    hold on;
end
