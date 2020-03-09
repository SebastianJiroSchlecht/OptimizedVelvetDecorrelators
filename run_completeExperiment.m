% run complete experiment
%
% Sebastian J. Schlecht, Thursday, 20 February 2020
clear; clc; close all;

startup;

%% optimization of velvet noise and collect data
search_bestVND;
collectData;

%% create data set for EVN, OVN30, OVN15, WN (sequence, smooth, error, coherence)
createSequenceData;

%% Select best sequences
write_multichannelDecorrelator

%% create plots
plot_coherenceAll
plot_exponentialDecayCurve
plot_integerSPSerror
plot_meanMagnitudeAll

