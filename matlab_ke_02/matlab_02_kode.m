%% LAB 02 - Konvergensi dan Error Fourier

clear;
clc;
close all;

%% Parameter
A  = 1;
T  = 2*pi;
fs = 1800;

t = linspace(0, T, fs);

%% Sinyal target
target = A * sign(sin(2*pi*t/T));

%% Variasi harmonika
N_max  = 81;
N_list = 1:2:N_max;

mse_list = zeros(size(N_list));

%% Perhitungan Fourier dan MSE
for k = 1:length(N_list)

    N = N_list(k);

    f_recon = zeros(size(t));

    for n = 1:2:N

        f_recon = f_recon + ...
            (4*A/(n*pi)) * sin(2*pi*n*t/T);

    end

    % Hitung error MSE
    mse_list(k) = mean((target - f_recon).^2);

end

%% Plot Linear
figure('Position',[100 100 900 700]);

subplot(2,1,1)

plot(N_list, mse_list,'m-o', ...
    'LineWidth',1.5, ...
    'MarkerSize',4)

grid on;

title('Konvergensi Fourier (Linear Scale)')

xlabel('Jumlah Harmonik')
ylabel('MSE')

%% Plot Log-Log
subplot(2,1,2)

loglog(N_list, mse_list,'b-s', ...
    'LineWidth',1.5, ...
    'MarkerSize',4)

grid on;

title('Konvergensi Fourier (Log-Log)')

xlabel('log(N)')
ylabel('log(MSE)')

%% Estimasi slope
p = polyfit(log(N_list), log(mse_list),1);

fprintf('=================================\n');
fprintf('Slope log-log : %.3f\n', p(1));
fprintf('MSE ~ N^(%.3f)\n', p(1));
fprintf('=================================\n');

%% Simpan figure
saveas(gcf,'lab02_konvergensi.png');