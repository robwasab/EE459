%EE419 HW 5b

function low_pass = design_low_pass(trans_width, Fc, M)
%function low_pass = design_low_pass(trans_width, Fc, M)
%This function returns the Bk samples of an FIR low pass filter using
%freqency sampling. 
%transition_width is the width in cycles per sample
%Fc is the cutoff frequency
%M is the desired filter length

%For now, assume M is odd...
halfway = (M - 1)/2;

k = 0:halfway;
F = k ./ M;

low_pass = ones(1, length(F));

m = -1/trans_width;

start_trans = 0.5/m + Fc;
end_trans = -0.5/m + Fc;

for i = 1:length(F);
   if F(i) < start_trans
       %don't do anything, low_pass is already 1
   elseif start_trans < F(i) && F(i) < end_trans
       %low_pass gets the transition line
       low_pass(i) = m * (F(i) - Fc) + 0.5;
   else
       low_pass(i) = 0;
   end
end

%mirror but leave out the last point
mirror = fliplr(low_pass);
low_pass = horzcat(low_pass, mirror(1:length(low_pass)-1));

k = 0:M-1;
F = k ./ M;
low_pass = low_pass .* exp(-1 .* j .* pi .* k .* (M-1) ./ M);
end