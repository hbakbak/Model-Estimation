function [a,b] = uniform1D(x)
%Given an unknown uniform density, this function uses maximum likelihood to find a and b
a = min(x);
b = max(x); 
end

