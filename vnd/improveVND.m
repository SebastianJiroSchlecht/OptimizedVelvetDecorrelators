function [pulseTime, pulseGain, pulseTimeInitial, pulseGainInitial] = improveVND( numberOfPulses, sequenceLengthMs, totalDecayDB, numberFrequencyPoints, fs )
% Run the optimization algorithm
%
% Author: Sebastian J. Schlecht
% Date: 13/03/2018

%% Pulse Time
MsPerPulse = 1 / numberOfPulses * sequenceLengthMs;

pulseTimeLowerBound = ( (1:numberOfPulses)' - 2 + 0.1 )  * MsPerPulse ;
pulseTimeUpperBound = pulseTimeLowerBound + 0.95;

pulseTimeLowerBound(1) = 0;
pulseTimeUpperBound(1) = 0;

pulseTimeInitial = pulseTimeLowerBound + rand(numberOfPulses, 1)*0.95;

%% Pulse Gain
deviationDB = 6;

fadeGain = interp1([0,1,sequenceLengthMs + 100],[0,deviationDB,deviationDB],pulseTimeInitial);
expGain = interp1([0,sequenceLengthMs,sequenceLengthMs + 100],[0, totalDecayDB, totalDecayDB],pulseTimeInitial);

midGain = db2mag( expGain );
upperGain = db2mag( expGain + fadeGain);
lowerGain = db2mag( expGain - fadeGain);

negativeUpperGain = -lowerGain;
negativeLowerGain = -upperGain;

signPulse = sign(randn(numberOfPulses, 1));
isPositivePulse = signPulse > 0;

pulseGainInitial = signPulse .* midGain;

%% normalization of first pulse
pulseTimeInitial(1) = 0; 
pulseGainInitial(1) = 1;

%% setup optimization
x0 = [pulseTimeInitial, pulseGainInitial ];

A = [];
b = [];
Aeq = [];
beq = [];

lb = x0;
ub = x0;

lb(:,1) = pulseTimeLowerBound;
ub(:,1) = pulseTimeUpperBound;

lb(:,2) = isPositivePulse .* lowerGain + (1-isPositivePulse) .*  negativeLowerGain;
ub(:,2) = isPositivePulse .* upperGain + (1-isPositivePulse) .*  negativeUpperGain;

lb(1,2) = 1;
ub(1,2) = 1;

%% Cost Function 
costFunction = @(pulses) computeSpectralError(pulses(:,1), pulses(:,2), numberFrequencyPoints, fs);

%% run optimization
options = optimoptions('fmincon','Display','iter');
tic
x = fmincon(costFunction,x0,A,b,Aeq,beq,lb,ub,[],options);
toc
pulseTime = x(:,1);
pulseGain = x(:,2);


