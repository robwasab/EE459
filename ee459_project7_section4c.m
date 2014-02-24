%Project 7 Section 4c generating the low pass filter take 2 
Fc = (2500 + 1250)/44100;
window = @blackman;
desired_transition_width = 2500/44100;
attenuation_db = 60;
percent_tolerance = 2;

M  = calculate_M_points_for_window(Fc, window, desired_transition_width, attenuation_db, percent_tolerance);

lp = FIR_Filter_By_Window(M, Fc, blackman(M));

Bk = lp;
Ak = zeros(1,length(M));
Ak(1) = 1;

show_filter_responses(Ak,Bk,44.1E3,500,M,1);

