function [mean, variance] = gaussian1D(x)
%This function will compute the mean and variance using maximum likelihood estimation given an unknown density, x
N = length(x);
mean = 0;
variance = 0;
for i=1:N
    mean = mean + x(i);
end
mean = mean/N; 

for i=1:N
    variance = mean + ( ( x(i) - mean )^2 );
end

variance = variance/N;
end

