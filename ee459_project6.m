S = 48E3;

F1 = 1000/S;
F2 = 2000/S;

zeros = [exp(j*2*pi*F1), exp(j*2*pi*F2)];
zeros = horzcat(zeros, conj(zeros));

poles = 0.95 .* zeros;

fprintf('Section 1a\n')
fprintf('Poles and Zeros for notch frequencies at 1k and 2kHz:\n');
poles
zeros

K = 1/1.1066;
fsample = S;
num_F_points = 500;
num_h_points = 40;
figure_num = 1;

[Ak, Bk, HF, Fd, hn, n] = show_filter_responses_pz(poles, zeros, K, fsample, num_F_points, num_h_points, figure_num);

fprintf('Section 1b\n')
Ak
Bk
K

original_zeros = zeros;
original_poles = poles;

%Section2
%Quantization
fprintf('***Using 2^8 scale factor****\n')
scale = power(2, 8);

Bk_scaled = Bk .* scale;
Bk_scaled = round(Bk_scaled);
Bk_scaled = Bk_scaled ./ scale;

Ak_scaled = Ak .* scale;
Ak_scaled = round(Ak_scaled);
Ak_scaled = Ak_scaled ./ scale;

%Save the 256 scale factor 
Ak_256 = Ak_scaled;
Bk_256 = Bk_scaled;

[poles, zeros, HF_mag, frequencies, hn,n] = show_filter_responses(Ak_scaled, Bk_scaled, fsample,num_F_points, num_h_points, figure_num);
%print_curr_figures('ee459_project6_section1c');
K
Ak
Bk
Ak_scaled
Bk_scaled
%Percent Error?
percent_error_Ak = percent_error(Ak, Ak_scaled)
percent_error_Bk = percent_error(Bk, Bk_scaled)


%c3) How many bits does it take to represent our integer Ak's and Bk's?
Ak_bits = log2(abs(Ak_scaled) .* scale);
Ak_bits = round(Ak_bits);
Bk_bits = log2(abs(Bk_scaled) .* scale);
Bk_bits = round(Bk_bits);
Ak_bits
Bk_bits

figure_num = figure_num + 4;

%Brute Force finding best scale factor
%if true/false set to false to skip this 
if(true)
   %get find all the angles of the original zeros, this is what we compare to
   angle_orig_zeros = angle(original_zeros);

   %Sort the original angles
   angle_orig_zeros = sort(angle_orig_zeros);

   %try scale powers from 9 -> 20
   for scale_power = 9:20
      scale = power(2, scale_power);
   
      Bk_scaled = Bk .* scale;
      Bk_scaled = round(Bk_scaled);
      Bk_scaled = Bk_scaled ./ scale;

      Ak_scaled = Ak .* scale;
      Ak_scaled = round(Ak_scaled);
      Ak_scaled = Ak_scaled ./ scale;

      %lazy... but I used show_filter_responses to convert the Ak and Bk
      %coefficients to poles and zeros... Definately needs to be changed to
      %use filter()...
      [p, z, HF_mag, frequencies, hn,n] = show_filter_responses(Ak_scaled, Bk_scaled, fsample,num_F_points, num_h_points, figure_num);
      z = z.';
  
      %Organize the zeros so we can compare them to the original
      z = angle(z);
      z = sort(z);
      
      %flag that helps me tell if we've found some zeros whose angles are +/-
      % 5 percent of the original angles. 
      found = false;
      
      %i is a counting index
      i = 1;
   
      for angle_zero = z   
         %percent error calculation that compares the orginal angle zeros
         %to the new quantized ones. 
         res = abs(angle_zero - angle_orig_zeros(i))/abs(angle_orig_zeros(i)) * 100;
         
         %if the result is greater than 5% then get out of the loop, don't
         %try any more
         if (res > 5) 
            break
         %if your counting index is at the end the vectors being tested congrats, 
         %you found a winner. 
         else
            if i == length(angle_orig_zeros)
                found = true;
            end
         end
         i = i + 1;
      end
      
      %if you found one, then don't test any more scale factors
      if found
         break
      end
   end
%print the scale power. 
scale_power
end

%After finding the best scale factor...
%Ak_scaled is now scaled to the best Ak
%so is Bk...

%Percent Error?
Ak_scaled
Bk_scaled
percent_error_Ak = abs(Ak - Ak_scaled) ./ Ak .* 100
percent_error_Bk = abs(Bk - Bk_scaled) ./ Bk .* 100

Ak_bits = log2(abs(Ak_scaled) .* scale);
Ak_bits = round(Ak_bits);
Bk_bits = log2(abs(Bk_scaled) .* scale);
Bk_bits = round(Bk_bits);
Ak_bits
Bk_bits


%Section 3 Scaled Integer Filter Implementation
fprintf('***Section 2e****\n')
[SOS, G] = tf2sos(Bk, Ak)
sys1 = SOS(1,:)
sys2 = SOS(2,:)

%split the two systems into Aks and Bks
Bk_sys1 = sys1(1:length(sys1)/2) .* G;
Ak_sys1 = sys1(length(sys1)/2 + 1: length(sys1));

Bk_sys2 = sys2(1:length(sys2)/2) .* G;
Ak_sys2 = sys2(length(sys2)/2 + 1: length(sys2));

%Bk_sys2 = Bk_sys2 .* 1.1047;

fprintf('**First System***\n')
fprintf('Unscaled:\n')
Ak_sys1
Bk_sys1
fprintf('Scaled:\n')
Ak_sys1 = round(Ak_sys1 .* 256)
Bk_sys1 = round(Bk_sys1 .* 256)

%reset the figure number
figure_num = 1;
%plot
[poles, zeros, HF_1, frequencies, hn,n] = show_filter_responses(Ak_sys1, Bk_sys1, fsample,num_F_points, num_h_points, figure_num);
poles
zeros

%-----------------------------------------

figure_num = 5;
fprintf('***Second System***\n')

fprintf('Unscaled:\n')
Ak_sys1
Bk_sys1

fprintf('Scaled:\n')
Ak_sys2 = round(Ak_sys2 .* 256)

Bk_sys2 = round(Bk_sys2 .* 256)
%plot
[poles, zeros, HF_2, frequencies, hn,n] = show_filter_responses(Ak_sys2, Bk_sys2, fsample,num_F_points, num_h_points, figure_num);

poles
zeros

HF_tot = HF_1 .* HF_2;
HF_tot_max = max(abs(HF_tot));

figure_num = figure_num + 4;
figure(figure_num)
subplot(2,1,1)
plot(frequencies .* S, abs(HF_tot));
grid on
title('Total Frequency Response')
xlabel('frequency Hz')
ylabel('Amplitude')

subplot(2,1,2)
plot(frequencies .* S, angle(HF_tot) ./ pi);
grid on
title('Total Frequency Response Phase')
xlabel('frequency Hz')
ylabel('Phase/pi')

fprintf('Suggested Gain:')
gain = 1/HF_tot_max

%print_curr_figures('ee459_section2e_systems')






