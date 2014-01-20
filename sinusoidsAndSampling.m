f = 10; %Hz

t1 = [0 : 1/200 : 0.5];
t2 = [0 : 1/60  : 0.5];

t3 = [0 : 1/20  : 0.5];
t4 = t3;

t5 = [0 : 1/12  : 0.5];

x1 = cos(2 .* pi .* f .* t1 + pi/3);
x2 = cos(2 .* pi .* f .* t2 + pi/3);
x3 = cos(2 .* pi .* f .* t3 + pi/3);
x4 = cos(2 .* pi .* f .* t3 + pi/2);
x5 = cos(2 .* pi .* f .* t5 + pi/3);

plot(t1, x1, 'b', 'LineWidth', 4)
hold on
plot(t2, x2, 'r', 'LineWidth', 3)
hold on
plot(t3, x3, 'g', 'LineWidth', 2)
hold on
plot(t4, x4, 'g--', 'LineWidth', 5)
hold on
plot(t5, x5, 'k', 'LineWidth', 6)

title('Sinusoids And Sampling')
xlabel('Time Seconds')
ylabel('Amplitude')
