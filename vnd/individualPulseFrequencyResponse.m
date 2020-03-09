function [magnitude,phase,frequency] = individualPulseFrequencyResponse( pulseTime, pulseGain, n, fs )
% Compute the frequency response for each pulse
%
% Author: Sebastian J. Schlecht
% Date: 12/03/2018

pulseSample = pulseTime * fs / 1000;
frequency = linspace(0,fs/2,n);

offset = (sign(pulseGain') - 1) * (-pi/2);

phaseNew = (offset + linspace(0,-pi,n+1)'.*(pulseSample' - 1) );
phase = phaseNew(1:end-1,:);
magnitude = ones(n,1) .* abs(pulseGain');

