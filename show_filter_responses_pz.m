%function [Ak, Bk, HF, Fd, hn, n] = show_filter_responses_pz(poles, zeros, K, fsample, num_F_points, num_h_points, figure_num)
%
%Plots the provided system (poles and zeros and K gain) with several plots:
%   -zplane
%   -magnitude and phase response in digital frequencies
%   -dB magnitude and phase in analog frequency (given fsample)
%   -unit sample response given num_h_points 
%[Ak, Bk, HF, Fd, hn, n] are all of the values calculated in the

function [Ak, Bk, HF, Fd, hn, n] = show_filter_responses_pz(poles, zeros, K, fsample, num_F_points, num_h_points, figure_num)
   Ak = poly(poles);
   Bk = poly(zeros);
   Bk = K .* Bk;

   
   [p,z,HF,Fd,hn,n] = show_filter_responses(Ak, Bk, fsample, num_F_points, num_h_points, figure_num);

   if poles ~= (p.');
       fprintf('ERROR')
       fprintf('orig poles:')
       poles
       fprintf('returned poles:')
       p
   end
   
   fprintf('Difference Equation: \n')
   str = print_difference_equation(Ak, Bk);
end