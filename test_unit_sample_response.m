%test unit_sample_response
%with y[n] + 0.8y[n-1] = x[n]

%Ak and Bk LENGTHS MUST EQUAL!
Ak = [1, 0.8];
Bk = [1, 0];

number_of_samples = 40;
figure_number = 1;

[hn, n] = unit_sample_response(Bk, Ak, number_of_samples, figure_number);
hn