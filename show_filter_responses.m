function [poles,zeros,HF,Fd,hn,n] = show_filter_responses(Ak, Bk, fsample, num_F_points, num_h_points, figure_num)
%function [poles,zeros,HF,Fd,hn,n] = show_filter_responses(Ak, Bk, fsample, num_F_points, num_h_points, figure_num)
%
%Plots the provided system (Ak and Bk coefficients) with several plots:
%   -zplane
%   -magnitude and phase response in digital frequencies
%   -dB magnitude and phase in analog frequency (given fsample)
%   -unit sample response given num_h_points 
%[poles, zeros, HF, Fd, hn, n] are all of the values calculated in the
%function
%poles and zeros are a vertical vector. 

   poles = roots(Ak);
   zeros = roots(Bk);
   
   figure(figure_num)
   zplane(Bk, Ak)
   xlabel('Real Axis')
   ylabel('j Axis')
   title('Pole Zero Plot on Z Plane')
   grid on
   
   figure_num = figure_num + 1;
   
   %Get the frequency response
   %W is linspace(0, pi, num_F_points)
   [HF, W] = freqz(Bk, Ak, num_F_points);
   %divide out 2?, Fd ranges from 0 to 0.5
      
   Fd = W ./ (2 * pi);
   
   %twosided frequency response hack
   %Fd_rest = linspace(0.5, 1, num_F_points + 1);
   %Fd_rest = Fd_rest(2:length(Fd_rest));
   
   %Fd_rest = Fd_rest .';
   
   %Fd = vertcat(Fd, Fd_rest);
   
   %HF_rest = conj(HF);
   
   %HF_rest = flipud(HF_rest);
   
   %HF = vertcat(HF, HF_rest);
   
   %plot the magnitude response passing along the complex frequency
   %response
   plot_freq_responses(Fd, HF, fsample, figure_num);

   figure_num = figure_num + 2;
   
   [hn, n] = unit_sample_response(Bk, Ak, num_h_points, figure_num);
      
end