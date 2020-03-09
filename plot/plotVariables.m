%% plot variables

conditionColor = {[73 148 206]/256*0.9; [127 194 65]/256*1.1; [182 182 182]/256; 0*[118 118 118]/256};
conditionLineStyle = {'-'; '-'; '--'; '--'};
legendNames = {'OVN$_{30}$','OVN$_{15}$','EVN$_{30}$','WN'};
numberConditions = length(legendNames);

plotLineWidth = 1.75;
plotBoldLineWidth = 1.75;
markerSize = 6;
stemLineWidth = 1.0;
f = freqAxis(20,22050,4096);

logXTick = [20 50 100 300 500 1000 2000 5000 10000 20000];
logXTickLabel = {'20' '50' '100' '300' '500' '1k' '2k' '5k' '10k' '20k'};