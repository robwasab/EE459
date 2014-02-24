function M_ret = calculate_M_points_for_window(Fc, window, desired_transition_width, attenuation_db, percent_tolerance)
%function calculate_M_points_for_window(Fc, window, desired_transition_width, attenuation_db, percent_tolerance)
%   Fc is the digital 0.5 cutoff frequency for a low pass filter
%
%   desired_transition_width is the transition width in cycles/sample
%   (digital frequency)
%
%   attenuation_db is the desired attenuation in the stop band in dB,
%   (specifiy a positive attenuation)
%   The program uses attenuation to calculate the passband and stopband
%   frequencies. Then it finds the transition bandwidth and compares it to
%   the desired_transition_width. The program stops if the values are
%   within the specified tolerance. 
%
%   percent tolerance is the allowed range of deviation that this program
%   will conform to. I.E. deviation from Fc and transition width. 
%   This function can use the following window function handles:
%   -@blackman
%   -@hamming
%   -@hanning

   %find the highest possible M for a given window
   highest_M = calculate_M_points_for_various_windows(desired_transition_width, window);

   if highest_M == 0
       return
   end 
   
   ds = 10 .^ (-1 * attenuation_db / 20);
   %assuming dp = ds 
   dp = ds;
   num_F_points = 2000;
   
   for M = highest_M: -2: 1
      %Make the filter
      lp = FIR_Filter_By_Window(M, Fc, window(M));
      Bk = lp;
      Ak = zeros(1,length(M));
      Ak(1) = 1;
      
      [HF, W] = freqz(Bk, Ak, num_F_points);      
      Fd = W ./ (2 * pi);

      %find the transition width based on dp ds (dell s dell p)
      HF_mag = abs(HF);
      
      indecies = find(HF_mag < ds);  
      
      Fs   = Fd(indecies(1));
      HF_Fs = HF_mag(indecies(1));
      
      %assuming pass band = 1
      indecies = find(HF_mag < (1 - dp));
      
      Fp = Fd(indecies(1));
            
      transition_width = Fs - Fp;
      %test the calculated transition_width vs. the
      %desired_transition_width
      error = percent_error(desired_transition_width, transition_width);
      if (error <= percent_tolerance)
         fprintf('   M = %d Error: %.3d\n', M, error)
         fprintf('   Fp: %.3d\n   Fs: %.3d\n   Transition Width: %.3d\n', Fp, Fs, transition_width)
         fprintf('   Attenuation at Fs: %.3d\n', 20 * log10(HF_Fs))
         M_ret = M;
         return;
      end
   end   
   fprintf('Couldnt find an M to satisfy specifications\n')
   M_ret = 0;
end

function M = calculate_M_points_for_various_windows(trans_width, window_func)
   rectangularM = 0.92 / trans_width;
   hanningM = 3.21 / trans_width;
   hammingM = 3.47 / trans_width;
   blackManM = 5.71 / trans_width;
   
   name = func2str(window_func);
   if strcmp(name,'rectwin')
      M = rectangularM;
   elseif strcmp(name,'blackman')
      M = blackManM;
   elseif strcmp(name,'hanning')
      M = hanningM;
   elseif strcmp(name,'hamming')
      M = hammingM;
   else 
      fprintf('unknown window... M = 0\n')
   end
   M = round(M);
   if mod(M,2) == 0
      M = M + 1; 
   end
end

