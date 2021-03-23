function [lambda] = exponential1D(x)
%Given an unknown exponential density, this function calculates the value of lambda for
%using maximum likelihood estimation 
%   We know that mean = 1/lambda, so we can use the mean formula to
%   calulate lambda 
N = length(x);
mean = 0;

for i = 1:N 
    mean = mean + x(i);
end
mean = mean/N; 
lambda = 1/mean; 
end

