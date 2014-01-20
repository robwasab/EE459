% EE419_HF_exp1_proto
% COMPUTE AND PLOT THE FREQUENCY RESPONSE OF AN IIR FILTER

% Make a digital frequency variable with 1001 points 
% for Principle Range F =-1/2 to +1/2, with spacing .001 cycles/sample

%freq=[-0.5 -0.499 -0.498 ......... 0.499  0.5];  % 1001 values?! YIKES!!

%freq=linspace(first_val, last_val, Num_of_points); 
% For LINSPACE: Increment =(last_val - first_val) / (Num_of_points-1) 
%freq=linspace(-.5, .5, 1001); % 1001 points, from -1/2 to +1/2, Incr=.001

%freq=[first_val : increment : last_val]; 
freq = [-0.5 : 0.001 : 0.5];        

% NOTE: # of Points =[(last_val-first_val) / increment]+1 
                    % 1001 points, from -1/2 to +1/2, increment=.001


% Compute the values of the COMPLEX DTFT frequency response at these frequencies

HF = exp(j .* 2 .* pi .* freq) ./ (exp(j .* 2 .* pi .* freq) - 0.9);


% LINEAR FREQUENCY RESPONSE PLOT
% Plot the magnitude and phase responses on a linear freq scale
figure(1)
% Magnitude Response
subplot(2,1,1) % Display plots in 2 rows / 1 column; This is the 1st plot.
                                % Plot the magnitude on a linear scale

plot(freq, abs(HF))
grid on

xlabel('Digital Frequency  F (cycles/sample)')
ylabel('Magnitude Response')
title('Frequency Response of Filter')
% Phase Response
subplot(2,1,2) % Display plots in 2 rows / 1 column; This is the 2nd plot.
                                % Normalize angle values by pi radians

%angle(HF)/pi normalizes the angles 
plot(freq, angle(HF) ./ pi)

grid on
xlabel('Digital Frequency  F (cycles/sample)')
ylabel('Phase Response /pi')


% LOG SCALE FREQUENCY RESPONSE PLOT
% Make a logarithmic frequency variable with 100 points for F =.001-0.5
% (Positive part of Principle Range, up to Nyquist Rate)
log_freq=logspace(log10(.001), log10(.5), 100); % 100 logarithmic points between .001 (10e-3) and 0.5x10e+0

% Compute the values of the COMPLEX freq response at these log frequencies
HlogF=exp(j.*2.*pi.*log_freq)./(exp(j.*2.*pi.*log_freq)- 0.9);

figure(2)
% Magnitude Response
subplot(2,1,1)
                                 % plot linear magnitude vs. freq on log scale
semilogx(log_freq, 20 .* log( abs(HlogF)))

grid on
xlabel('Digital Frequency  F (cycles/sample)')
ylabel('Magnitude Response dB')
title('Frequency Response of Filter')
% Phase Response
subplot(2,1,2)

semilogx(log_freq, angle(HlogF) ./ pi)

grid on
xlabel('Digital Frequency  F')
ylabel('Phase Response /pi')


% PLOT MAGNITUDE IN dB (like Bode Plot)

% Compute the values of the COMPLEX frequency response in dB


% copy, paste, modify plot commands




% Find the peak response and peak response frequency
% WHICH RESPONSE AND FREQUENCY VARIABLES TO USE??   WHY??
% CONSIDER: Do you need to see the entire range of frequencies??
[peak_response, peak_response_index]=max(abs(HF))
% No ';' at end so answers print to screen
peak_response_freq=freq(peak_response_index)

% Find the minimum magnitude response and min response frequency
[min_response, min_response_index]=min(abs(HF))
% No ';' so answers print to screen
min_response_freq=freq(min_response_index)

% notes: COPY FIGURES TO A WORD DOCUMENT WHEN DONE
%      HOW COULD WE HAVE MADE HF INTO A FUNCTION SO NOT REPEATING EQUATION?