%function plot_freq_responses(Fd, HF, fsample, figure_num)
%Plots two frequency responses typical magnitude and phase in one figure.
%In another figure, decibel magnitude and phase is plotted vs analog
%frequency.
%Fd is a vector of digital frequencies corresponding to HF complex values.
%HF is a vector of the transfer function's digital frequency response. 
%fsample is the sampling rate.
%figure_num is the number of the figure to start at. 
function plot_freq_responses(Fd, HF, fsample, figure_num)

   frequencies = Fd;
   HF_values   = HF;
   
   mag = abs(HF_values);
   phase = angle(HF_values) ./ pi;

   HF_dB      = 20 .* log10(mag);
   
   figure(figure_num)
   subplot(2,1,1)
   plot(frequencies, mag)
   grid on
   title('Magnitude vs. F')
   xlabel('Digital Frequency')
   ylabel('Magnitude')
   
   subplot(2,1,2)
   plot(frequencies, phase)
   grid on
   title ('Phase vs. F')
   xlabel('Digital Frequency')
   ylabel('Phase / pi')
   
   analogFrequencies = fsample .* frequencies;
   
   figure(figure_num + 1)
   subplot(2,1,1)
   plot(analogFrequencies,  HF_dB)
   grid on
   title('Magnitude vs. F')
   xlabel('Analog Frequency Hz')
   ylabel('Magnitude (dB)')
   
   subplot(2,1,2)
   plot(analogFrequencies, phase)
   grid on
   title ('Phase vs. F')
   xlabel('Analog Frequency Hz')
   ylabel('Phase / pi')
   
   %Determine the max and min HF values simple numerical analysis
   HF_max = max(mag);
   HF_min = min(mag);
   HF_atten_dB = dB(HF_max/HF_min);
   
   fprintf('From plot_freq_responses...\n')
   fprintf('Max at %.3f Min at %.3f, Attenuation: %fdB\n', HF_max, HF_min, HF_atten_dB)
   
   %Determine the type of filter we are dealing with...
   
   %find the max and min HF magnitudes and their respective frequencies
   HF_mag = mag;
   
   [max_val, max_index] = max(HF_mag);
   
   [min_val, min_index] = min(HF_mag);
   
   end_point = length(HF_mag);
   start_point = 1;

   %Band pass
   %this elseif statement goes like this:
   %check to see if the two start and end point magnitude values are
   %smaller than the max value.
   %AND, we must check to see if the max_val's index is inbetween the start
   %and end points.
   if HF_mag(start_point) < max_val && HF_mag(end_point) < max_val && start_point < max_index && max_index < end_point
       fprintf('Band Pass Filter')
       %jade_band_pass(HF_mag, frequencies)
       
   %Notch
   %check to see if the two start and end point magnitudes are greater than
   %the min value. AND check to see if min_val's index is inbetween the
   %start and end points
   elseif HF_mag(start_point) > min_val &&  HF_mag(end_point) > min_val && start_point < min_index && min_index < end_point
       fprintf('Notch Filter')
       %jade_notch(HF_mag, frequencies)

   %Low pass
   elseif HF_mag(start_point) > HF_mag(end_point)
       fprintf('Low Pass Filter')
       %jade_low_pass(HF_mag, frequencies)

   %High pass
   elseif HF_mag(start_point) < HF_mag(end_point)
       fprintf('High Pass Filter')
       %jade_high_pass(HF_mag, frequencies)
              
   else
       fprintf('Couldn''t Determine Type of Filter')
   end
   
end

function ret = dB(val)
   ret = 20 * log(val)
end