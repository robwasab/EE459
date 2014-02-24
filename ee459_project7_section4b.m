%Project 7 Section 4b generating the low pass filter 

M = 101;
Fc = (2.5 + 1.25)/44.1;

lp = FIR_Filter_By_Window(M, Fc, blackman(M));

Bk = lp;
Ak = zeros(1,length(M));
Ak(1) = 1;

show_filter_responses(Ak,Bk,44.1E3,500,M,1);

