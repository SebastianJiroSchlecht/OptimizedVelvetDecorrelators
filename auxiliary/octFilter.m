function [sig_bands, fc] = octFilter(sig, octDiv, f_lims, fs)
% Divide signal into octave band signals

% FIR filter order
ordFilt = 100;
fbDelay = round(ordFilt/2);

[filters, fc] = octFilterbank(octDiv, f_lims, fs, ordFilt);

lSig = size(sig,1);
nChannels = size(sig,2);
nBands = size(filters,2);

sig_bands = zeros(lSig, nBands, nChannels);

for nc=1:nChannels
    sig_band_nc = fftfilt(filters, [sig(:,nc); zeros(ordFilt,1)]);
    sig_bands(:,:,nc) = sig_band_nc(fbDelay + (1:lSig), :);
end
