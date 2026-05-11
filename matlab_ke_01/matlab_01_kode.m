%% LAB 01 - Deret Fourier Gelombang Persegi

clear;
clc;
close all;

%% Parameter
A  = 1;
T  = 2*pi;
fs = 1200;

% Vektor waktu
t = linspace(0, 2*T, 2*fs);

%% Gelombang target
target = A * sign(sin(2*pi*t/T));

%% Variasi harmonika
N_values = [1 5 9 25 45];

%% Figure
figure('Name','Fourier Square Wave',...
    'Position',[100 100 1200 800]);

%% Rekonstruksi Fourier
for k = 1:length(N_values)

    N = N_values(k);

    f_recon = zeros(size(t));

    % Harmonik ganjil
    for n = 1:2:N

        f_recon = f_recon + ...
            (4*A/(n*pi)) * sin(2*pi*n*t/T);

    end

    %% Plot
    subplot(length(N_values),1,k)

    plot(t, target,'b--','LineWidth',1);
    hold on;

    plot(t, f_recon,'m','LineWidth',1.5);

    grid on;

    ylim([-1.5 1.5]);

    title(['Rekonstruksi Fourier N = ', ...
        num2str(N)])

    xlabel('Waktu')
    ylabel('Amplitudo')

    legend('Target','Fourier',...
        'Location','southeast')

end

%% Judul utama
sgtitle('Rekonstruksi Gelombang Persegi dengan Deret Fourier')

%% Simpan figure
saveas(gcf,'lab01_fourier.png');