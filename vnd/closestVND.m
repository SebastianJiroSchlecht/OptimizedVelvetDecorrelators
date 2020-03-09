function vnd = closestVND( pulseTime, pulseGain, fs )
% compute closest VND with integer pulse times.
%
% Author: Sebastian J. Schlecht
% Date: 13/03/2018

numberOfSequences = size(pulseTime,2);

pulseSample = ms2smp( pulseTime, fs );
len = round(max(pulseSample(:)) + 1000); % make it 1000 samples longer

vnd = zeros(len,numberOfSequences);

for it = 1:numberOfSequences
    vnd( round(pulseSample(:,it))+1, it ) = pulseGain(:, it);
end
