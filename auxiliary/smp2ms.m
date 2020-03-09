function ms = smp2ms(smp, fs)
% Convert sample to milliseconds
%
% Author:   Sebastian Schlecht
% Date:     Mon Feb 06 2012
% Version:  1.0

ms = smp / fs * 1000;