function [smoothingWindow, logPoints, highFrequencyWindow] = computeSmoothingWindow(numberFrequencyPoints,fs,logPoints)
% Fast version for computing smoothing windows with persistent variables
%
% Author: Sebastian J. Schlecht
% Date: 13/03/2018
persistent smoothingWindowInternal highFrequencyWindowInternal;

if nargin < 3
    numberLogPoints = 100;
    logPoints = logspace( log10(30), log10(5000) ,numberLogPoints);
else
    numberLogPoints = length(logPoints);
end

Noct = 3;
f = linspace(0,fs/2,numberFrequencyPoints);


if isempty(smoothingWindowInternal)
    smoothingWindowInternal = zeros(numberFrequencyPoints,numberLogPoints);
    
    for it = 1:numberLogPoints
        smoothingWindowInternal(:,it) = gauss_f(f, logPoints(it), Noct);
    end
    
    highFrequencyWindowInternal = gauss_f(f, 20000, Noct)';
end

highFrequencyWindow = highFrequencyWindowInternal;
smoothingWindow = smoothingWindowInternal;




function g = gauss_f(f_x,F,Noct)
% G = GAUSS_F(F_X,F,NOCT) calculates a frequency-domain Gaussian function
% for frequencies F_X, with centre frequency F and bandwidth F/NOCT.

sigma = (F/Noct)/pi; % standard deviation
g = exp(-(((f_x-F).^2)./(2.*(sigma^2)))); % Gaussian
g = g./sum(g); % normalise magnitude

