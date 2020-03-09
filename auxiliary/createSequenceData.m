% create complete sequence data set for analysis
clc; clear; close all;

load('collectData.mat');

Fs = 48000;
len = 0.03 * Fs;
numberOfSequences = size(data.improved30.pulseGain,2);
totalDecaydB = -60;

conditions = {'oVND30','oVND15','eVND','WNS'};
dataFields = {'improved30','improved15','initial30','none'};

numberConditions = length(conditions);

for it = 1:numberConditions
    cond = conditions{it};
    disp(cond)
    
    switch cond
        case {'oVND30','oVND15','eVND'}
            field = dataFields{it};
            pulseGain = data.(field).pulseGain;
            pulseTime = data.(field).pulseTime;
            
            sequence = closestVND(pulseTime,pulseGain, Fs);
            sequence = sequence(1:len,:);
        case 'WNS'
            sequence = zeros(len,numberOfSequences);
            for itSeq = 1:numberOfSequences
                sequence(:,itSeq) = VND_wndecorr(len,totalDecaydB);
            end
    end
    
    sequence = sequence ./ sqrt(sum(sequence.^2,1));
    
    numberFrequencyPoints = 4096;
    [smooth,~] = thirdOctaveSmooth(sequence,numberFrequencyPoints,Fs);
    
    m = mean(smooth,1);
    error = sqrt(mean((smooth - m ).^2,1));
    
    [e, index] = sort(error,'ascend');
    
    switch cond
        case 'oVND30'
            indexOVN30 = index;
        case 'eVND'
            index = indexOVN30;
    end
            
    local.(cond).sequence = sequence(:,index);
    local.(cond).smooth = smooth(:,index);
    local.(cond).error = error(:,index);
    
    [coherenceFreq, local.(cond).coherence] = coherence(local.(cond).sequence, Fs);
     
end

dataSet = local;
save('./data/sequenceData.mat','dataSet','conditions','Fs','coherenceFreq');






