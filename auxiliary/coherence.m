function [fc, coherenceMatrix] = coherence(signal, Fs)
% Compute signal coherence matrix based on octave filtering

[signalBands, fc] = octFilter(signal, 3, [20 16000], Fs);

fc = [0; fc; Fs/2];

numberOfBands = size(signalBands,2);
numberOfSignals = size(signal,2);
coherenceMatrix = zeros(numberOfBands,numberOfSignals,numberOfSignals);
for it1 = 1:numberOfSignals
    for it2 = 1:numberOfSignals
    a_bands = signalBands(:,:,it1);
    b_bands = signalBands(:,:,it2);
    
    ab_coh = sum(a_bands.*b_bands, 1);
    
    E_a = sum(a_bands.^2, 1);
    E_b = sum(b_bands.^2, 1);
    coh_norm = sqrt(E_a.*E_b);
    
    coherenceMatrix(:,it1,it2) = ab_coh./coh_norm;
    end
end


