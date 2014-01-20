function [dn,n] = unit_sample(sampls)

dn = zeros(1, sampls);
dn(1) = 1;
n  = 0 : sampls-1;

end