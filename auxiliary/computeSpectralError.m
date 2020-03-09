function [VNDerror, logSpectrum, logPoints] = computeSpectralError(pulseTime, pulseGain, numberFrequencyPoints, fs)
% Compute the spectral mean squared error against the mean value of the high frequencies
%
% Author: Sebastian J. Schlecht
% Date: 12/03/2018
global smoothingWindow

[magnitude, phase, frequency] = individualPulseFrequencyResponseLog(pulseTime, pulseGain, numberFrequencyPoints, fs);
h = sum(magnitude .* exp(1i*phase), 2);

logSpectrum = smoothingWindow*mag2db(abs(h));
m = mean(logSpectrum);
logSpectrum = logSpectrum - m;

VNDerror = sqrt(sum((logSpectrum ).^2));

logPoints = frequency;
