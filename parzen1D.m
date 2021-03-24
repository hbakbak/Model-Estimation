function [density] = parzen1D(data,std_dev)
%This function estimates the density using the Parzen method, assuming we
%have Gaussian windows 
x = 0:0.01:(max(data)+1.5);
density = zeros(size(x)); 
N = length(data)

for i = 1:size(x,2)
    p=0; 
    for j = 1:N 
    p  = p + normpdf(x(i), data(j), std_dev);
    end
    density(i) = p/N;
end
end

