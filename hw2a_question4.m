fsample = 360;
num_F_points = 999;
num_h_points = 50;
figure_num = 1;

jw = 2 * pi * j;

F60 = 60/360;
harmonic_60 = [exp(jw*F60), exp(-jw*F60)];

F120 = 120/360;
harmonic_120 = [exp(jw*F120), exp(-jw*F120)];

F180 = 180/360;
harmonic_180 = [exp(jw*F180)];

suggested_radius = 1 - pi * 6/360;

R60 = suggested_radius;
pole_60 = [R60 * exp(jw*F60), R60 * exp(-jw*F60)];

R120 = suggested_radius;
pole_120 = [R120 * exp(jw*F120), R120 * exp(-jw*F120)];

R180 = suggested_radius;
pole_180 = [R180 * exp(jw*F180)];

poles = horzcat(pole_60, pole_120, pole_180);

zeros = horzcat(harmonic_60, harmonic_120, harmonic_180);

K = 1/1.13;
[Ak, Bk, HF, Fd, hn, n] = show_filter_responses_pz(poles, zeros, K, fsample, num_F_points, num_h_points, figure_num);

Ak
Bk

z = poles(1);
A_num = (z - zeros(1))*(z - zeros(2))*(z - zeros(3))*(z - zeros(4))*(z - zeros(5))/z;
A_den =                (z - poles(2))*(z - poles(3))*(z - poles(4))*(z - poles(5));

A = A_num/A_den;
A
abs(A)
angle(A)/pi

z = poles(3);
B_num = (z - zeros(1))*(z - zeros(2))*(z - zeros(3))*(z - zeros(4))*(z - zeros(5))/z;
B_den = (z - poles(1))*(z - poles(2))               *(z - poles(4))*(z - poles(5));
B = B_num/B_den;
B
abs(B)
angle(B)/pi

z = poles(5);
C_num = (z - zeros(1))*(z - zeros(2))*(z - zeros(3))*(z - zeros(4))*(z - zeros(5))/z;
C_den = (z - poles(1))*(z - poles(2))*(z - poles(3))*(z - poles(4))               ;
C = C_num/C_den;
C
abs(C)
angle(C)/pi

poles

mag_poles = abs(poles)
angle_poles = angle(poles)./pi

n = 0:50;
a = 2 .* 0.0617 .* power(0.9476, n) .* cos(n .* pi/3 + pi);
b = 2 .* 0.0617 .* power(0.9476, n) .* cos(n .* 2 * pi/3 + pi);
c = -0.0618 .* power(-0.9476, n);

h = a + b + c;
figure(5)
stem (n, h, '.')


