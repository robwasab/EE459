%test y[n] + 0.1 y[n-1] = x[n] + x[n-2]

fsample = 1E3;
Ak = [1, 0.1, 0];
Bk = [1, 0,   1];
num_F_points = 500;
num_h_points = 20;
figure_num = 1;

[poles,zeros,HF,Fd,hn,n] = show_filter_responses(Ak, Bk, fsample, num_F_points, num_h_points, figure_num);

poles
zeros
