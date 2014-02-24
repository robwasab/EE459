fsample = 50E3;
num_F_points = 500;
num_h_points = 50;
figure_num = 1;

%[poles,zeros,HF,Fd,hn,n] = show_filter_responses(Ak, Bk, fsample, num_F_points, num_h_points, figure_num);

r_pole = 0.843;
center_F = 5/50;
bandwidth = 0.05;

test_poles = [r_pole * exp(j*2*pi*center_F), r_pole * exp(-j*2*pi*center_F)];

test_zeros = [1, -1];

K = 1/6.912;
[Ak, Bk, HF, Fd, hn, n] = show_filter_responses_pz(test_poles, test_zeros, K, fsample, num_F_points, num_h_points, figure_num);

Ak
Bk