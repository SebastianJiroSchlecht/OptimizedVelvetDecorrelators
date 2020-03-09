% plot exponentialDecay curve
clear; clc; close all;
fileName = mfilename;

fs = 48000;
timeInMs = 30;
numberTimePoints = 200;

totalDecayDB = -30;
deviationDB = 6;

time = linspace(0,timeInMs,numberTimePoints)';
fadeGain = interp1([0,1,40],[0,1,1]*deviationDB,time);

expGain = db2mag( linspace(0,totalDecayDB,numberTimePoints) )';
expGainUpper = db2mag( linspace(0,totalDecayDB,numberTimePoints)' + fadeGain);
expGainLower = db2mag( linspace(0,totalDecayDB,numberTimePoints)' - fadeGain);


%% plot
figure(1); hold on; grid on;

ttt = [time; flipud(time)];
ccc = [expGainUpper; flipud(expGainLower)];

plot(time, expGain, 'b')
plot(time, -expGain, 'b')
fill(ttt,ccc ,'b','FaceAlpha',0.3);
fill(ttt,-ccc ,'b','FaceAlpha',0.3);

xlabel('Time [ms]');
ylabel('Amplitude [lin]')



