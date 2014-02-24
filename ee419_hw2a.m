
%HW 2a 
%y[n] = x[n] + 0.8 y[n-1]

Ak = [1, -0.8];
%Bk isn't symetric
Bk = [0.2, 0];

fsample = 1E3;
num_F_points = 700;
num_h_points = 50;
figure_num = 1;

%[poles,zeros,HF,Fd,hn,n] = show_filter_responses(Ak, Bk, fsample, num_F_points, num_h_points, figure_num);

test_poles = [.71,.71];

mag = 0.8;
F_zero = 0.25;
F_pole = 0;
test_zeros = [mag * exp(j*2*pi*F_zero), mag * exp(-j*2*pi*F_zero)];

F_shift = 0;

F_pole = F_pole + F_shift;
F_zero = F_zero + F_shift;

shifted_poles = [0.71*exp(j*2*pi*F_pole), 0.71*exp(j*2*pi*F_pole)];
shifted_zeros = [mag * exp(j*2*pi*F_zero), mag * exp(-j*2*pi*F_zero)];

K = 1/19.95;
%[Ak, Bk, HF, Fd, hn, n] = show_filter_responses_pz(test_poles, test_zeros, K, fsample, num_F_points, num_h_points, figure_num);
[Ak, Bk, HF, Fd, hn, n] = show_filter_responses_pz(shifted_poles, shifted_zeros, K, fsample, num_F_points, num_h_points, figure_num);

Ak
Bk

%ANSWER
%Difference Equation: 
%0.05y[n] -0.75y[n -1] = x[n]+0.067268x[n -1] -0.045x[n -2]
