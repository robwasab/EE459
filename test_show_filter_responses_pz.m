%test with y[n] = x[n] + x[n-2]
poles = [0,0];
zeros = [j, -j];
K = 1;
fsample = 1E3;
num_F_points = 500;
num_h_points = 50;
figure_num = 1;

[Ak, Bk, HF, Fd, hn, n] = show_filter_responses_pz(poles, zeros, K, fsample, num_F_points, num_h_points, figure_num);

Ak
Bk
