% plot integer SPS error
clear; clc; close all;
fileName = mfilename;
plotVariables;

global smoothingWindow
load('smoothWin.mat');
smoothingWindow = Win;

fs = 48000;
timeInMs = 30;
numberTimePoints = 50;
n = 2^9;
numberFrequencyPoints = 4096;


load('collectData.mat');

index = 2;

pulseTime = data.improved30.pulseTime(:,index);
pulseTimeInteger = smp2ms(round(ms2smp(pulseTime,fs)),fs);
pulseGain = data.improved30.pulseGain(:,index);



[magnitude,phase,~] = individualPulseFrequencyResponse( pulseTime, pulseGain, n, fs );
h = sum(magnitude .* exp(1i*phase), 2);

[magnitudeInteger,phaseInteger,frequency] = individualPulseFrequencyResponse( pulseTimeInteger, pulseGain, n, fs );
hInteger = sum(magnitudeInteger .* exp(1i*phaseInteger), 2);

[~, logSpectrum, ~] = computeSpectralError(pulseTime, pulseGain, numberFrequencyPoints, fs);
[~, logSpectrumInteger, logPoints] = computeSpectralError(pulseTimeInteger, pulseGain, numberFrequencyPoints, fs);
        


%% plot
close all
figure(1); hold on; grid on;
offset = 8;
plot(frequency, mag2db(abs(h)) - offset );
plot(frequency, mag2db(abs(hInteger)) - offset );
xlim([50 20000]);
ylim([-13 13]);
set(gca,'XScale','log')
xlabel('Frequency [Hz]');
ylabel('Magnitude [dB]');
legend('Continuous VND$_{30}$', 'Integer VND$_{30}$')





figure(2); hold on; grid on;
plot(frequency, mag2db(abs(h)) - mag2db(abs(hInteger)),'k') ;
xlim([50 20000]);
set(gca,'XScale','log')
xlabel('Frequency [Hz]');
ylabel('Magnitude [dB]');
% legend('Continuous to Integer Difference ')




figure(3); hold on; grid on;
offset = logSpectrumInteger(1) - logSpectrum(1);
downsample = 10;
plot(logPoints(1:downsample:end), logSpectrum(1:downsample:end) + offset );
plot(logPoints(1:downsample:end), logSpectrumInteger(1:downsample:end));
xlim([30 20000]);
ylim([-3 3]);
set(gca,'XScale','log')
xlabel('Frequency [Hz]');
ylabel('Magnitude [dB]');
legend('Continuous VND$_{30}$', 'Integer VND$_{30}$')





figure(4); hold on; grid on;
offset = logSpectrumInteger(1) - logSpectrum(1);
downsample = 10;
plot(logPoints(1:downsample:end), logSpectrum(1:downsample:end) + offset - logSpectrumInteger(1:downsample:end),'k') ;
xlim([50 20000]);
set(gca,'XScale','log')
xlabel('Frequency [Hz]');
ylabel('Magnitude [dB]');
% legend('Continuous to Integer Difference ')

