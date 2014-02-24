%test transform_lp2bp
%with filter length of 19
%Fcutoff = 0.05
%use Hamming window
%center the bandpass at Fcenter = 0.3
%
%Provide filter coefficients
%Frequency response plot of the low-pass filter (linear)
%Frequency response plot of the band-pass filter (linear)

M = 19;
Fc = 0.05;

fsample = 48E3;

ak = zeros(1, M);
ak(1) = 1;

num_F_points = 500;
num_h_points = 20;
figure_num = 1;

lp = FIR_Filter_By_Window(M, Fc, hamming(M));

[poles,zero,HF,Fd,hn,n] = show_filter_responses(ak, lp, fsample, num_F_points, num_h_points, figure_num)

pause()

Fcenter = .3;
bp = transform_lp2bp(lp, Fcenter);
[poles,zero,HF,Fd,hn,n] = show_filter_responses(ak, bp, fsample, num_F_points, num_h_points, figure_num)
lp
bp

%lp =
%    0.0009    0.0025    0.0069    0.0156    0.0293    0.0469
%    0.0661    0.0835    0.0956    0.1000    0.0956    0.0835
%    0.0661    0.0469    0.0293    0.0156    0.0069    0.0025
%    0.0009

%bp =
%   0.0017   -0.0016   -0.0112    0.0253    0.0181   -0.0938
%   0.0408    0.1351   -0.1547   -0.0618    0.1913   -0.0516
%  -0.1069    0.0759    0.0181   -0.0313    0.0043    0.0041
%  -0.0014
