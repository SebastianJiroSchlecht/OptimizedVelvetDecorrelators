function [Px_oct,freqFFT] = thirdOctaveSmooth(sig, numberFrequencyPoints, fs)
% copmute third octave smoothed magnitude response of signal

numberOfSignals = size(sig,2);

%% Frequency Domain
freqFFT = freqAxis(20,22050,numberFrequencyPoints)';
Px = zeros(numberFrequencyPoints,numberOfSignals);
for it = 1:numberOfSignals
    Px(:,it)   = mag2db(abs(freqz(sig(:,it),1,freqFFT,fs))).';
end

%% Smoothing Window
fup = zeros(numberFrequencyPoints,1); flo = zeros(numberFrequencyPoints,1);
fc   = freqFFT;
for k = 1:length(fc)
    fup(k,:) = fc(k) * 2^(1/6);
    flo(k,:) = fc(k) / 2^(1/6);
end

Win = zeros(numberFrequencyPoints,numberFrequencyPoints);
for k = 1:numberFrequencyPoints
    ix_lo   = find(freqFFT >= flo(k),1,'first');
    ix_up   = find(freqFFT <= fup(k),1,'last');
    Win(k,ix_lo:ix_up) = 1 / (ix_up - ix_lo + 1);
end

%% Smooth
Px_oct = Win * Px ;

