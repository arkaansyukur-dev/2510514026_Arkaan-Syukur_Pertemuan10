%% LAB 05 - Analisis Sinyal Motor

clear;
clc;
close all;

%% Parameter
fs = 2200;
T  = 5;

t = 0 : 1/fs : T - 1/fs;

N = length(t);

%% Skenario
scenarios = {'normal','fault'};

features = struct();

%% Loop Skenario
for s = 1:2

    %% Membuat sinyal

    rotor = 1.0 * sin(2*pi*55*t);

    harm2 = 0.35 * sin(2*pi*110*t);

    harm3 = 0.18 * sin(2*pi*165*t);

    noise = 0.12 * randn(1,N);

    if s == 1

        bearing = 0;

    else

        bearing = 0.30 * sin(2*pi*142*t);

    end

    x = rotor + harm2 + harm3 + bearing + noise;

    %% Window dan FFT

    w = hann(N).';

    xw = x .* w;

    X = fft(xw);

    X_mag = abs(X(1:N/2+1))/N;

    X_mag(2:end-1) = 2 * X_mag(2:end-1);

    f = (0:N/2) * fs / N;

    %% Feature Extraction

    [~, idx_max] = max(X_mag);

    f_dominant = f(idx_max);

    spectral_centroid = ...
        sum(f .* X_mag) / sum(X_mag);

    energy_total = sum(X_mag.^2);

    band_idx = (f >= 135) & (f <= 150);

    energy_fault_band = ...
        sum(X_mag(band_idx).^2);

    %% Simpan fitur

    features(s).scenario = scenarios{s};

    features(s).f_dominant = f_dominant;

    features(s).spectral_centroid = ...
        spectral_centroid;

    features(s).energy_total = ...
        energy_total;

    features(s).energy_fault_band = ...
        energy_fault_band;

    %% Output Command Window

    fprintf('\n=== Skenario %s ===\n', ...
        scenarios{s});

    fprintf('Frekuensi Dominan : %.2f Hz\n', ...
        f_dominant);

    fprintf('Spectral Centroid : %.2f\n', ...
        spectral_centroid);

    fprintf('Total Energy      : %.4f\n', ...
        energy_total);

    fprintf('Fault Band Energy : %.4f\n', ...
        energy_fault_band);

    %% Plot

    figure('Name',scenarios{s}, ...
        'Position',[100 100 900 600]);

    % Time domain
    subplot(2,1,1)

    plot(t(1:fs), x(1:fs),'m');

    grid on;

    title(['Sinyal Getaran - ', ...
        scenarios{s}]);

    xlabel('Waktu (s)')
    ylabel('Amplitudo')

    % Frequency domain
    subplot(2,1,2)

    plot(f, X_mag,'b','LineWidth',1.2)

    hold on;

    xline(55,'g--','55 Hz');
    xline(110,'g--','110 Hz');
    xline(165,'g--','165 Hz');

    if s == 2

        xline(142,'r-','142 Hz Fault');

    end

    grid on;

    xlim([0 250]);

    title('Spektrum Frekuensi')

    xlabel('Frekuensi (Hz)')
    ylabel('|X(f)|')

    %% Simpan Figure

    saveas(gcf, ...
        ['lab05_', scenarios{s}, '.png']);

end

%% Export CSV

T_out = struct2table(features);

writetable(T_out,'lab05_features.csv');

disp('File CSV berhasil disimpan');

disp(T_out);