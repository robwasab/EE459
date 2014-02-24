function [hn, n] = unit_sample_response(Bk, Ak, number_of_samples, figure_number)
%function [hn, n] = unit_sample_response(Bk, Ak, number_of_samples, figure_number)
%
%Plots the unit sample response h[n] of a difference equation given Bk
%and Ak coefficients. 
%Bk the x[n] coefficients
%Ak the y[n] coefficients
%
%[hn,n] hn is the unit response, n are the corresponding indicies

   [dn,n] = unit_sample(number_of_samples);
   hn = filter(Bk, Ak, dn);
   
   figure(figure_number)
   stem(n, hn, '.')
   title('Impulse Response')
   xlabel('Sample index n')
   ylabel('Response')
  
end