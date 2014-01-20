function plot_freq_response(frequencies, HF_values)
   mag = abs(HF_values);
   phase = angle(HF_values);
   
   figure(1)
   subplot(2,1,1)
   plot(frequencies, mag)
   grid on
   title('Magnitude vs. F')
   xlabel('Digital Frequency')
   ylabel('Magnitude')
   
   subplot(2,1,2)
   plot(frequencies, phase ./ pi)
   grid on
   title ('Phase vs. F')
   xlabel('Digital Frequency')
   ylabel('Phase / pi')
   
   figure(2)
   subplot(2,1,1)
   stem(frequencies, mag, '.')
   grid on
   title('Magnitude vs. F')
   xlabel('Digital Frequency')
   ylabel('Magnitude')
   
   subplot(2,1,2)
   stem(frequencies, phase ./ pi, '.')
   grid on
   title ('Phase vs. F')
   xlabel('Digital Frequency')
   ylabel('Phase / pi')
end