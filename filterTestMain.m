load project2_variables
%project2_variables are
%AkHP = [1,0.9];
%BkHP = [1, 0];
%AKLP = [1,0];
%BKLP = [0.5,0.5];
%AKNCH = [1,0,0];
%BKNCH = [0.5,0,0.5];
%p = [0.7*j - 0.7*j];
%z = [-1, 1];
%k = 1
pause on

fs = 1E3; %Hz
F_samples = 500;
h_samples = 50;

%test High Pass Filter
show_filter_responses(AkHP, BkHP, fs, F_samples, h_samples, 1)
fprintf('press the return key in cmd line to continue tests\n')
pause()

%test Low Pass Filter
show_filter_responses(AkLP, BkLP, fs, F_samples, h_samples, 1)
fprintf('press the return key in cmd line to continue tests\n')
pause()

%test NOTCH
show_filter_responses(AkNCH, BkNCH, fs, F_samples, h_samples, 1)
fprintf('press the return key in cmd line to continue tests\n')
pause()

%test Band Pass
show_filter_responses_pz(p, z, k,  fs, F_samples, h_samples, 1)
