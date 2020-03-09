function [magnitude,phase,frequency] = individualPulseFrequencyResponseLog( pulseTime, pulseGain, n, fs )
% Compute the frequency response for each pulse
%
% Author: Sebastian J. Schlecht
% Date: 12/03/2018

pulseSample = ms2smp( pulseTime, fs );

frequency = logspace(log10(20),log10(fs/2),n);

offset = (sign(pulseGain') - 1) * (-pi/2);
ff = logspace(log10( pi * 20 / fs*2),log10(pi),n)';
phase = (offset-ff.*(pulseSample') );
magnitude = ones(n,1) .* abs(pulseGain');



