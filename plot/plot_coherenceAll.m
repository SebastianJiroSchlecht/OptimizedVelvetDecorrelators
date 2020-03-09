% plot coherence
clear; clc; close all;
fileName = mfilename;

plotVariables;
load('./data/sequenceData.mat');


s = size(dataSet.WNS.coherence);

%% prepare data
for it = 1:numberConditions
    cond = conditions{it};
    meanCurve.(cond) = mean(mean(abs(dataSet.(cond).coherence),3),2);
end


for it = 1:numberConditions
    cond = conditions{it};
    meanMatrix.(cond) = squeeze(mean(abs(dataSet.(cond).coherence),1));
end


for it = 1:numberConditions
    cond = conditions{it};
    
    [~,I] = min(meanMatrix.(cond)(:));
    [I_row, I_col] = ind2sub(size(meanMatrix.(cond)),I);
    
    bestPair.(cond) = dataSet.(cond).coherence(:,I_row, I_col);
end




%% plot
figure(1); hold on; grid on;

for it = 1:numberConditions
    cond = conditions{it};
    p(it) = plot(coherenceFreq, meanCurve.(cond), 'LineWidth', plotLineWidth, 'Color', conditionColor{it}, 'LineStyle', conditionLineStyle{it});
end

xlabel('Frequency [Hz]')
ylabel('Mean Absolute Coherence [0 - 1]');
axis([30 20000 0 0.4]);
set(gca,'XTick',logXTick,'XTicklabel',logXTickLabel);
set(gca,'XScale','log');
legend(p,legendNames)



figure(2); hold on; grid on;
for it = 1:numberConditions
    cond = conditions{it};
    p(it) = plot(coherenceFreq,bestPair.(cond) + (numberConditions-it) * 0.2, 'LineWidth', plotLineWidth, 'Color', conditionColor{it}, 'LineStyle', conditionLineStyle{it});
end
xlabel('Frequency [Hz]')
ylabel('Best Coherence [-1 - 1]');
axis([30 20000 -0.2 1]);
set(gca,'XTick',logXTick,'XTicklabel',logXTickLabel);
set(gca,'XScale','log');
legend(p,legendNames)


figure(3); hold on; grid on;
for it = 1:numberConditions
    cond = conditions{it};
    
    edges = linspace(0,0.8,100);
    hist = histcounts(meanMatrix.(cond), edges);
    
    p(it) = plot(edges(2:end),hist/2, 'LineWidth', plotLineWidth, 'Color', conditionColor{it},'LineStyle', conditionLineStyle{it});
end
xlabel('Frequency Mean Absolute Coherence [0-1]')
ylabel('Number of Occurences');
legend(p,legendNames)


