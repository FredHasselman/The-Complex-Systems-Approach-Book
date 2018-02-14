% Spectral Slope using pwelch
%
% Usage: sps(Data, Fr)
% 
% - Data - A data set censored, normalized and of 2^n samples
% - Fr   - Number of frequencies to be estimated
%
% RM-course Advanced Data Analysis
% Module Dynamics of Complex Systems
% 
% May 2011
% Fred Hasselman & Ralf Cox

function [slope] = sps(Data,Fr)

%Use pwelch function to get Frequency and Power in the signal
[Power Freq] = pwelch(Data,[],[],Fr);


%The frequency 0Hz is just a theoretical value, here we delete it
Power(1) = []; 
Freq(1) = [];	

%Plot the frequency and power in log-log coordinates.
figure
plot(log10(Freq), log10(Power),'.k');
xlabel('log10 Frequency');ylabel('log10 Power');
hold on;

%Calculate where the 25% lowest frequencies are (Freq is orderded from low
%to high frequencies)
quartile = round((length(Freq)/100)*25);

%Perform a linear regression on 25% (in Log10 coordinates) by using polyfit. The first
%number in linreg, linreg(1) is the slope, the second, linreg(2) is the
%intercept. Check the slope value!
linreg = polyfit(log10(Freq(1:quartile)),log10(Power(1:quartile)),1);
slope = linreg(1);

%Let's plot this line by calculating the values of the line for each
%frequency: intercept + slope * frequency
spec_slope = linreg(2) + linreg(1).*log10(Freq(1:quartile));
plot(log10(Freq(1:quartile)), spec_slope,'-r','LineWidth',2);
title(['Spectral slope of 25% lowest frequencies: ',num2str(linreg(1))]);

%Note:
%- Using 25% lowest frequencies is a rule of thumb
%- Sample rate may influence slope estimate due to over estimating high frequencies of low power




