function [density] = parzen1D(data,std_dev)
%This function estimates the density using the Parzen method, assuming we
%have Gaussian windows 
x = linspace(min(data), max(data), length(data)); 
density = zeros(size(x)); 
N = length(data)
p=0; 
for i = 1:size(x,2)
    for j = 1:N 
    p  = p + normpdf(x(i), data(j), std_dev);
    end
    density(i) = p/N;
end


end

