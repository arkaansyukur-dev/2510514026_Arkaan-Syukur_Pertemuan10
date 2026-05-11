%% LAB 04 - Aproksimasi Taylor dan Maclaurin

clear;
clc;
close all;

%% Variabel x
x = linspace(-pi, pi, 400);

% Variasi orde
orde_list = [1 3 5 7 9];

%% Fungsi Maclaurin

% e^x
maclaurin_exp = @(x,N) arrayfun(@(xi) ...
    sum(arrayfun(@(n) ...
    xi^n/factorial(n),0:N)), x);

% sin(x)
maclaurin_sin = @(x,N) arrayfun(@(xi) ...
    sum(arrayfun(@(n) ...
    (-1)^((n-1)/2)*xi^n/factorial(n), ...
    intersect(0:N,1:2:N))), x);

% cos(x)
maclaurin_cos = @(x,N) arrayfun(@(xi) ...
    sum(arrayfun(@(n) ...
    (-1)^(n/2)*xi^n/factorial(n), ...
    intersect(0:N,0:2:N))), x);

%% Figure
figure('Position',[100 100 1100 800]);

%% Plot e^x
subplot(3,1,1)

plot(x, exp(x),'k','LineWidth',2);
hold on;

labels = {'true'};

for k = 1:length(orde_list)

    N = orde_list(k);

    plot(x, maclaurin_exp(x,N), ...
        'LineWidth',1.2)

    labels{end+1} = ...
        ['orde ', num2str(N)];

end

grid on;

title('Maclaurin e^x')

xlabel('x')
ylabel('f(x)')

legend(labels)

%% Plot sin(x)
subplot(3,1,2)

plot(x, sin(x),'k','LineWidth',2);
hold on;

labels = {'true'};

for k = 1:length(orde_list)

    N = orde_list(k);

    plot(x, maclaurin_sin(x,N), ...
        'LineWidth',1.2)

    labels{end+1} = ...
        ['orde ', num2str(N)];

end

grid on;

title('Maclaurin sin(x)')

xlabel('x')
ylabel('f(x)')

legend(labels)

%% Plot cos(x)
subplot(3,1,3)

plot(x, cos(x),'k','LineWidth',2);
hold on;

labels = {'true'};

for k = 1:length(orde_list)

    N = orde_list(k);

    plot(x, maclaurin_cos(x,N), ...
        'LineWidth',1.2)

    labels{end+1} = ...
        ['orde ', num2str(N)];

end

grid on;

title('Maclaurin cos(x)')

xlabel('x')
ylabel('f(x)')

legend(labels)

%% Judul utama
sgtitle('Aproksimasi Taylor dan Maclaurin')

%% Error pada x = pi
fprintf('Error pada x = pi\n');

for N = 1:10

    e_err = abs(exp(pi) - maclaurin_exp(pi,N));
    s_err = abs(sin(pi) - maclaurin_sin(pi,N));
    c_err = abs(cos(pi) - maclaurin_cos(pi,N));

    fprintf('Orde %d -> exp: %.6f | sin: %.6f | cos: %.6f\n', ...
        N, e_err, s_err, c_err);

end

%% Simpan figure
saveas(gcf,'lab04_maclaurin.png');