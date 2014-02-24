%Project 7 Section 4d generating a bandpass filter from a low pass filter 
M = 89;
Fc = (2.5 + 1.25)/44.1;

lp = FIR_Filter_By_Window(M, Fc, blackman(M));

%Got the low pass, now convert...
Fcenter = 10/44.1;
bp = transform_lp2bp(lp, Fcenter);

Bk = bp;
Ak = zeros(1,length(M));
Ak(1) = 1;

[poles,zeros,HF,Fd,hn,n] = show_filter_responses(Ak,Bk,44.1E3,500,M,1);

HF_mag = abs(HF);

indecies = find(HF_mag > 0.999);

F_p1 = Fd(indecies(1));
F_p2 = Fd(indecies(length(indecies)));

F_p1
F_p2
pass = (F_p2 - F_p1)
center = pass/2 + F_p1