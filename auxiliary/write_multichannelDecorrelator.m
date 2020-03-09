% select listening test sequences
clear; clc; close all;
fileName = mfilename;

load('sequenceData.mat');
numberConditions = length(conditions);

numberOfSequences = size(dataSet.oVND15.error,2);
numberOfDecorrelators = 32;

for it = [1 2]
    cond = conditions{it};
    switch cond
        case {'oVND30','oVND15'}
            sequenceIndex = 1:numberOfDecorrelators;
        case 'WNS'
%             sequenceIndex = round(linspace(1,numberOfSequences,numberOfDecorrelators));
    end
    decorrelator.(cond) = dataSet.(cond).sequence(:,sequenceIndex);
end

save('./data/decorrelator32.mat','decorrelator');

audiowrite('./data/decorrelator32_oVND30.wav', decorrelator.oVND30, Fs);
audiowrite('./data/decorrelator32_oVND15.wav', decorrelator.oVND15, Fs);

%% write stereo example
[dry, fs] = audioread('NewGo_dry.wav');
stereo(:,1) = conv(dry, decorrelator.oVND30(:,1));
stereo(:,2) = conv(dry, decorrelator.oVND30(:,2));
audiowrite('./data/NewGo_stereo.wav',stereo, fs);
