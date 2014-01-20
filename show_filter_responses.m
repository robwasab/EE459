%function [poles,zeros,HF,Fd,hn,n] = show_filter_responses(Ak, Bk, fsample, num_F_points, num_h_points, figure_num)
%
%Plots the provided system (Ak and Bk coefficients) with several plots:
%   -zplane
%   -magnitude and phase response in digital frequencies
%   -dB magnitude and phase in analog frequency (given fsample)
%   -unit sample response given num_h_points 
%[poles, zeros, HF, Fd, hn, n] are all of the values calculated in the
%function
function [poles,zeros,HF,Fd,hn,n] = show_filter_responses(Ak, Bk, fsample, num_F_points, num_h_points, figure_num)
   poles = roots(Ak);
   zeros = roots(Bk);
   
   figure(figure_num)
   zplane(Bk, Ak)
   xlabel('Real Axis')
   ylabel('j Axis')
   title('Pole Zero Plot on Z Plane')

   figure_num = figure_num + 1;
   
   [HF, W] = freqz(Bk, Ak, num_F_points);
   Fd = W ./ (2 * pi);
   
   plot_freq_responses(Fd, HF, fsample, figure_num);

   figure_num = figure_num + 2;
   
   [hn, n] = unit_sample_response(Bk, Ak, num_h_points, figure_num);
   
   poles
   zeros   
end