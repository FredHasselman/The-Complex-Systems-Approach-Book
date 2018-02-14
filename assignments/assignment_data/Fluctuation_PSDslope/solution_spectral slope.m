%Load
clear all;
load('ts1.txt');
load('ts2.txt');
load('ts3.txt');

%Check 2^n
n1 = log2(length(ts1));
n2 = log2(length(ts2));
n3 = log2(length(ts3));

if mod(n1,1)~=0 %Integer test, make sure no decimal remainder after dividing by 1     
    error('Series must be an integer power of 2 in length.')
end
if mod(n2,1)~=0 
    error('Series must be an integer power of 2 in length.')
end
if mod(n3,1)~=0 
    error('Series must be an integer power of 2 in length.')
end

%Plot
figure;
subplot(3,3,1);
plot(ts1);
title('ts1 original');
subplot(3,3,2);
plot(ts2);
title('ts2 original');
subplot(3,3,3)
plot(ts3);
title('ts3 original');
hold on;

%Normalize
ts1n = (ts1-mean(ts1))/std(ts1);
ts2n = (ts2-mean(ts2))/std(ts2);
ts3n = (ts3-mean(ts3))/std(ts3);

subplot(3,3,4);
plot(ts1n);
title('ts1 normalized');
subplot(3,3,5);
plot(ts2n);
title('ts2 normalized');
subplot(3,3,6);
plot(ts3n);
title('ts3 normalized');

%Detrend
ts1nd = detrend(ts1n);
ts2nd = detrend(ts2n);
ts3nd = detrend(ts3n);

subplot(3,3,7);
plot(ts1nd);
title('ts1 normalized - detrended');
subplot(3,3,8);
plot(ts2nd);
title('ts2 normalized - detrended');
subplot(3,3,9);
plot(ts3nd);
title('ts3 normalized - detrended');

%Spectral slopes
s_ts1nd = sps(ts1nd,512);

s_ts2nd = sps(ts2nd,512);

s_ts3nd = sps(ts3nd,512);