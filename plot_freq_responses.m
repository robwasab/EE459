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
   
   HF_mag = abs(HF_values);
   phase = angle(HF_values) ./ pi;

   HF_dB = 20 .* log10(HF_mag);
   
   figure(figure_num)
   subplot(2,1,1)
   plot(frequencies, HF_mag)
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
   
 %Determine the type of filter we are dealing with...
   
   %find the max and min HF magnitudes and their respective frequencies
   
   [max_val, max_index] = max(HF_mag);
   [min_val, min_index] = min(HF_mag);
   end_point = length(HF_mag);
   start_point = 1;
   maxfreq = frequencies(max_index);
   minfreq = frequencies(min_index);
   fprintf('Max Magnitude: %.3f\n', max_val)
   fprintf('   Corresponding Frequency: %.3f\n', maxfreq)
   fprintf('                            %.3f\n', maxfreq * fsample)
   fprintf('Min Magnitude: %.3f\n', min_val)
   fprintf('   Corresponding Frequency: %.3f\n', minfreq)
   fprintf('                            %.3f\n', minfreq * fsample)

   cuttoff_mag = max_val / sqrt(2);
   above = find(frequencies > 0.2);
   freqtwo = HF_mag(above(1));
   atten2 = 20*log10(max_val/freqtwo);
   
   fprintf('Attenuation B/W MAX and 3dB is: %.3f dB\n', atten2)
    
   %Band pass
   %this elseif statement goes like this:
   %check to see if the two start and end point magnitude values are
   %smaller than the max value.
   %AND, we must check to see if the max_val's index is inbetween the start
   %and end points.
   if HF_mag(start_point) < max_val && HF_mag(end_point) < max_val && start_point < max_index && max_index < end_point
       fprintf('Band Pass Filter\n')
       bandpass(HF_mag, frequencies, cuttoff_mag, fsample)
       
   %Notch
   %check to see if the two start and end point magnitudes are greater than
   %the min value. AND check to see if min_val's index is inbetween the
   %start and end points
   elseif HF_mag(start_point) > min_val &&  HF_mag(end_point) > min_val && start_point < min_index && min_index < end_point
       fprintf('Notch Filter\n')
       notch(HF_mag, frequencies, cuttoff_mag, fsample)

   %Low pass
   elseif HF_mag(start_point) > HF_mag(end_point)
       fprintf('Low Pass Filter\n')
       lowpass(HF_mag, frequencies, cuttoff_mag)

   %High pass
   elseif HF_mag(start_point) < HF_mag(end_point)
       fprintf('High Pass Filter\n')
       highpass(HF_mag, frequencies, cuttoff_mag)
              
   else
       fprintf('Couldn''t Determine Type of Filter\n')
   end
end

function ret = dB(val)
   ret = 20 * log(val)
end

function bandpass(HF_mag, frequencies, cuttoff_mag, fsample) 
cutoff_mag_vals = find(HF_mag > cuttoff_mag);
cutoff_freq_vals = frequencies(cutoff_mag_vals);
First_DB_val = frequencies(cutoff_mag_vals(1));
Last_DB_val = frequencies(cutoff_mag_vals(length(cutoff_mag_vals)));
fprintf('   The magnitude at the cutoff frequency is: %.3f\n', cuttoff_mag)
fprintf('   The 3DB cutoff frequencies are: %.3f, %.3f\n', First_DB_val, Last_DB_val)
fprintf('       3Db cutoff in Hertz        %.3fHz %.3f\n', First_DB_val * fsample, Last_DB_val * fsample) 
bandwidth = Last_DB_val - First_DB_val;
fprintf('   The Bandwidth of the filter is: %.3f or %.3fHz\n', bandwidth, bandwidth * fsample)
end

function notch(HF_mag, frequencies, cuttoff_mag, fsample) 
cutoff_mag_vals = find(HF_mag < cuttoff_mag);
cutoff_freq_vals = frequencies(cutoff_mag_vals);
First_DB_val = frequencies(cutoff_mag_vals(1));
Last_DB_val = frequencies(cutoff_mag_vals(length(cutoff_mag_vals)));
bandwidth = Last_DB_val - First_DB_val;
fprintf('   The magnitude at the cutoff frequency is: %.3f\n', cuttoff_mag)
fprintf('   The 3DB cutoff frequencies are: %.3f, %.3f\n', First_DB_val, Last_DB_val)
fprintf('       3Db cutoff in Hertz        %.3fHz %.3f\n', First_DB_val * fsample, Last_DB_val * fsample) 
fprintf('   The Bandwidth of the filter is: %.3f\n', bandwidth)
fprintf('   The Bandwidth of the filter is: %.3f or %.3fHz\n', bandwidth, bandwidth * fsample)
end

function highpass(HF_mag, frequencies, cuttoff_mag) 
cutoff_mag_vals = find(HF_mag > cuttoff_mag);
cutoff_freq_vals = frequencies(cutoff_mag_vals);
First_DB_val = frequencies(cutoff_mag_vals(1));
Last_DB_val = frequencies(length(frequencies));
bandwidth = Last_DB_val - First_DB_val;
fprintf('The magnitude at the cutoff frequency is: %.3f\n', cuttoff_mag)
fprintf('The 3DB cutoff frequency is: %.3f\n', First_DB_val)
fprintf('The Bandwidth of the filter is: %.3f\n', bandwidth)
end

function lowpass(HF_mag, frequencies, cuttoff_mag) 
cutoff_mag_vals = find(HF_mag > cuttoff_mag);
cutoff_freq_vals = frequencies(cutoff_mag_vals);
Last_DB_val = frequencies(length(cutoff_mag_vals));
First_DB_val = 0;
bandwidth = Last_DB_val - First_DB_val;
fprintf('The magnitude at the cutoff frequency is: %.3f\n', cuttoff_mag)
fprintf('The 3DB cutoff frequency is: %.3f\n', Last_DB_val)
fprintf('The Bandwidth of the filter is: %.3f\n', bandwidth)
end