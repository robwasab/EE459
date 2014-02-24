function bp = transform_lp2bp(lp, Fcenter)
   n = 0:length(lp)-1
   bp = 2.*cos(2.*pi.* n .* Fcenter) .* lp;
end