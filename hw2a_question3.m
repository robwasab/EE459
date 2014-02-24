fsample = 1E3;
num_F_points = 500;
num_h_points = 50;
figure_num = 1;

r_pole = 0.9;
r_zero = 1;

F = 0.35;

test_poles = [r_pole * exp(j*2*pi*F), r_pole * exp(-j*2*pi*F)];

test_zeros = [r_zero * exp(j*2*pi*F), r_zero * exp(-j*2*pi*F)];

K = 1/6.912;
[Ak, Bk, HF, Fd, hn, n] = show_filter_responses_pz(test_poles, test_zeros, K, fsample, num_F_points, num_h_points, figure_num);
