clear; clc; close all;
fileName = mfilename;

plotVariables;
load('sequenceData.mat');

%% plot
figure(1); hold on; grid on;

for it = 1:numberConditions
    cond = conditions{it};
    smooth = dataSet.(cond).smooth;
    fm = mean(smooth,1);
    m = mean(smooth,2);
    s = std(smooth-fm,0,2);
         
    downsample = 10;
    p(it) = plot(f(1:downsample:end),s(1:downsample:end), 'LineWidth', plotLineWidth, 'Color', conditionColor{it}, 'LineStyle', conditionLineStyle{it});
end

xlabel('Frequency [Hz]')
ylabel('Std Magnitude [dB]');
axis([20 20000 0 7]);
set(gca,'XTick',logXTick,'XTicklabel',logXTickLabel);
set(gca,'XScale','log');
legend(p,legendNames)


%%
figure(2); hold on; grid on;
for it = 1:numberConditions
    cond = conditions{it};
    seq = dataSet.(cond).sequence(:,1);
    
    range = 70;
    magSeq = mag2db(abs(seq));
    magSeq = magSeq - max(magSeq) + range;
    magSeq( magSeq < 0 ) = 0;
    
    posIndex = nonzeros(find(seq>0));
    negIndex = nonzeros(find(seq<0));
    Index = nonzeros(find(abs(seq)>0));
    
    time = linspace(0, smp2ms(length(seq), Fs), length(seq))';
    
    sparseTime = [-10 -10 -10;time(Index), time(Index), time(Index); 100 100 100]';
    sparseMag = [0 0 0; Index*0, magSeq(Index), Index*0; 0 0 0]';
    
    offSet =  (numberConditions - it)*90;
    
    if it < 4
        p(it) = plot(sparseTime(:), sparseMag(:)+ offSet, 'Color',conditionColor{it}, 'LineWidth', stemLineWidth, 'LineStyle', conditionLineStyle{it});
    else
        p(it) = plot([-5; 0; time], [0; 0; magSeq] + offSet, 'Color',conditionColor{it}, 'LineWidth', stemLineWidth, 'LineStyle', conditionLineStyle{it});    
    end
end

for it = 1:numberConditions
    cond = conditions{it};
    seq = dataSet.(cond).sequence(:,1);
    
    range = 70;
    magSeq = mag2db(abs(seq));
    magSeq = magSeq - max(magSeq) + range;
    magSeq( magSeq < 0 ) = 0;
    
    posIndex = nonzeros(find(seq>0));
    negIndex = nonzeros(find(seq<0));
    
    time = linspace(0, smp2ms(length(seq), Fs), length(seq))';
    
    offSet =  (numberConditions - it)*90;
    
    if it < 4
        pp(it) = scatter( time(posIndex), magSeq(posIndex)+offSet, markerSize*8, conditionColor{it}, 'o', 'MarkerFaceColor', conditionColor{it});         
        pp(it) = scatter( time(negIndex), magSeq(negIndex)+offSet, markerSize*8, conditionColor{it}, 'o', 'MarkerFaceColor', 'w');         
    end  
end
yTickLabel = {'-60','-30','0'};
set(gca,'YTick',(0:11)*30,'YTicklabel',[yTickLabel yTickLabel yTickLabel yTickLabel]);
xlim([-1,max(time)]);
ylim([0 400])
legend(p, legendNames)
ylabel('Magnitude [dB]');
xlabel('Time [ms]');


%%
figure(3); hold on; grid on;
for it = 1:numberConditions
    cond = conditions{it};
    color = conditionColor{it};
    seq = dataSet.(cond).smooth(:,1);
    seq = seq - mean(seq) ; 
    downsample = 10;
    offset = (numberConditions - it)*10;
    plot(f(1:downsample:end), seq(1:downsample:end) + offset,'LineWidth', plotLineWidth,'Color',color, 'LineStyle', conditionLineStyle{it});
end
set(gca,'YTick',(-1:7)*5,'YTicklabel',{'-5','0','5','0','5','0','5','0','5'});
axis([20 20000  -5 45]);
legend(legendNames)
set(gca,'XScale','log');
ylabel('Magnitude Response [dB]');
xlabel('Frequency [Hz]');



