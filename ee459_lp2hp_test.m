%test case for transform_lp2hp(lp)
load project7

lp = FIR_Filter_By_Window(9, 0.2, hanning(9));
lp
ak
[poles,zeros,HF,Fd,hn,n] = show_filter_responses(ak, lp, fsample, num_F_points, num_h_points, figure_num);

hp
hp = transform_lp2hp(lp);
[poles,zeros,HF,Fd,hn,n] = show_filter_responses(ak, hp, fsample, num_F_points, num_h_points, figure_num);

%Filter Coefficients
%hp = 0.0072    0.0215   -0.0612   -0.2738    0.6000   -0.2738 -0.0612    0.0215    0.0072
%lp =-0.0072   -0.0215    0.0612    0.2738    0.4000    0.2738  0.0612   -0.0215   -0.0072
%