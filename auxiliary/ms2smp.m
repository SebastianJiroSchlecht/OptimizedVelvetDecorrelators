function x = ms2smp(x, fs)
% Convert milliseconds to sample
%
% Author:   Sebastian Schlecht
% Date:     Mon Feb 06 2012
% Version:  1.0

x = (x * fs / 1000);