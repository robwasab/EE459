function hn_lp = FIR_Filter_By_Window (M, Fc, window)
%function hn_lp = FIR_Filter_By_Window (M, Fc, window)
%M = the filter length (odd)
%Fc = filter cutofff digital frequency (-6dB) cycles/sample
%window = the Matlab window function values to multiply the lowpass impulse
%   response
%hn_lp = windowed impulse response values for the Low-pass FIR filter
if (mod(M,2) == 0)
    fprintf('M is %d Not an ODD Number\n',M);
    fprintf('Adding + 1 to M...\n');
    M = M + 1;
end
fool = (M - 1)/2;

n = -1 * fool : fool; 
hn_lp = 2 * Fc .* sinc(2 .* n .* Fc);
hn_lp = hn_lp .* window.';

end