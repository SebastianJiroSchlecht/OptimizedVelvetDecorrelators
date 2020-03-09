% search for best VND
%
% Author: Sebastian J. Schlecht
% Date: 12/03/2018
clear; clc; close all;

global smoothingWindow;
load('smoothWin.mat');
smoothingWindow = Win;

fs = 48000;
numberFrequencyPoints = 4096;
sequenceLengthMiliseconds = 30;
totalDecayDB = -60;

numberOfPulsesList = [15 30];

numberOfTrails = 50;

for itPulse = 1:2
    numberOfPulses = numberOfPulsesList(itPulse);
    for it = 1:numberOfTrails
        data = [];
        
        %% Improve VND
        [data.improved.pulseTime, data.improved.pulseGain, data.initial.pulseTime, data.initial.pulseGain] = ...
            improveVND( numberOfPulses, sequenceLengthMiliseconds, totalDecayDB, numberFrequencyPoints, fs);
        
        %% disp and save
        disp(it);
        save(['./temporary/' num2str(numberOfPulses) '_' num2str(rand*1000000,'%07.f') '.mat'] ,'data');
    end 
end