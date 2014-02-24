function hp = transform_lp2hp(lp)
%change the sign of all hlp samples
%add +1 to the center sample
hp = lp .* -1;
M = length(hp) - 1;
hp(M/2 + 1) = hp(M/2 + 1) + 1; 
end