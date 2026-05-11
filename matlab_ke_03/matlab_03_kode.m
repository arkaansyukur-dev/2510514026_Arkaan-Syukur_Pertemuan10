%% LAB 03 - FFT Analisis Frekuensi

clear;
clc;
close all;

%% Parameter Sinyal
fs = 1200;
T  = 2;

t = 0 : 1/fs : T - 1/fs;

N = length(t);

%% Membuat sinyal
x = 0.8*sin(2*pi*60*t) + ...
    0.25*sin(2*pi*145*t) + ...
    0.08*randn(1,N);

%% Windowing
w = hann(N).';

xw = x .* w;

%% FFT
X = fft(xw);

X_mag = abs(X(1:N/2+1))/N;

X_mag(2:end-1) = 2 * X_mag(2:end-1);

f = (0:N/2) * fs / N;

%% Plot Time Domain
figure('Position',[100 100 900 700]);

subplot(2,1,1)

plot(t(1:fs), x(1:fs),'m')

grid on;

title('Sinyal Time Domain')

xlabel('Waktu (s)')
ylabel('Amplitudo')

%% Plot Frequency Domain
subplot(2,1,2)

plot(f, X_mag,'b','LineWidth',1.2)

hold on;

xline(60,'g--','60 Hz');
xline(145,'r--','145 Hz');

grid on;

xlim([0 250]);

title('Spektrum Frekuensi FFT')

xlabel('Frekuensi (Hz)')
ylabel('|X(f)|')

%% Deteksi Peak
[pks, locs] = findpeaks(X_mag, ...
    'MinPeakHeight',0.04, ...
    'MinPeakDistance',5);

fprintf('Frekuensi Terdeteksi:\n');

for i = 1:length(pks)

    fprintf('f = %.2f Hz | Magnitude = %.3f\n', ...
        f(locs(i)), pks(i));

end

%% Simpan figure
saveas(gcf,'lab03_fft.png');
