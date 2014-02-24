function ret = percent_error(old, new)
   ret = abs(old - new) ./ abs(old) .* 100;
end