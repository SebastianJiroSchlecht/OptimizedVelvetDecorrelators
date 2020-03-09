function [h1] = VND_wndecorr(len, totalDecaydB)
% Generate White Noise Decorrelator
%
% Vesa Valimaki Aug. 22, 2017
% Modified Aug. 22, 2017
% Sebastian Schlecht March 25, 2018

expdecay = db2mag(linspace(0,totalDecaydB,len));
h0 = expdecay .* (2*(rand(1,len)-0.5));

NFFT_bloc = 2*4096;
NFFT = ceil(len / NFFT_bloc) * NFFT_bloc;
H0 = fft(h0,NFFT);  % FFT of decaying random sequence
H1mag = 1.16667*sum(abs(H0))/NFFT .* ones(1,NFFT);  % 2 X Average of magnitude response
H1 = H1mag .* exp(1i*angle(H0));  % Flat magnitude, original phase
h1 = real(ifft(H1));  % Corresponding impulse response
h1 = h1(1:len);  % Truncate

h1 = h1 ./ max(abs(h1));

