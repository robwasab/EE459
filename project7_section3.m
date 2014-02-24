M = 29;
Fc = 0.20;
fsample = 48E3;

lp = FIR_Filter_By_Window(M, Fc, hamming(M));

hamming(M)

lp = lp .* 2.^15;
lp
lp = round(lp);
lp = lp ./ 2.^15;

Ak = zeros(1, M);
Ak(1) = 1;
Bk = lp;
show_filter_responses(Ak,Bk,fsample,1000,M,1);