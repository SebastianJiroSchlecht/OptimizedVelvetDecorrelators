function freq = freqAxis(f_start,f_end,N)
% Creates vector of logarithmically separated frequencies with
% user defined start and stop frequencies and number of points.
% f_start = starting frequency
% f_end = ending frequency
% N = number of points

freq = logspace(log10(f_start),log10(f_end),N)';