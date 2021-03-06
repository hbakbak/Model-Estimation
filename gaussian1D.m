function [mean, std_dev] = gaussian1D(x)
%This function will compute the mean and variance using maximum likelihood estimation given an unknown density, x

N = length(x);

mean = sum(x)/N; 

variance = ( sum(( x - mean ).^2 ))/N;

std_dev = sqrt(variance);
end

