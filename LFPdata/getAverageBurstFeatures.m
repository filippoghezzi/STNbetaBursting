function [pAmp,pDur]=getAverageBurstFeatures(dat,zscoring)
%Perform burst analysis (amplitude and duration) with a threshold-dependent
%method as in Tinkhauser et al., 2017b. 
%Inputs: 
%dat -> data structure contianing envelope time series, sampling rate and
%conditions;
%zscoring -> char array providing indication on Z-scoring applied. 

dat=rmfield(dat,{'RawData','FiltData','PeakFreq','PSDRawData','PSDFiltData'});

for i=1:length(dat) %i for trace (subject, side, condition)
    [dat(i).MeanBurstAmplitude,dat(i).MeanBurstDuration]=getBurstDurationAmplitude...
        (dat(i).Envelope,dat(i).SR,dat(i).Perc(5));
end

tab=struct2table(rmfield(dat,{'Side','Envelope','SR','Subject'}));
stats=grpstats(tab,{'Levodopa'},{'mean','sem'}); %Compute statistics (mean and SEM)


%Compare two groups
[hAmp,pAmp]=ttest(tab(strcmp(tab.Levodopa,'OFF'),:).MeanBurstAmplitude,tab(strcmp(tab.Levodopa,'ON'),:).MeanBurstAmplitude);
[hDur,pDur]=ttest(tab(strcmp(tab.Levodopa,'OFF'),:).MeanBurstDuration,tab(strcmp(tab.Levodopa,'ON'),:).MeanBurstDuration);


x=categorical({'OFF LD','ON LD'});
figure
subplot(1,2,2)
hold on
b1=bar(x,stats.mean_MeanBurstAmplitude);
b1.FaceColor='flat';
b1.CData(1,:)=[0 0 1];
b1.CData(2,:)=[0 1 1];
errorbar(x,stats.mean_MeanBurstAmplitude,stats.sem_MeanBurstAmplitude,'k.')
ylabel('Mean burst amplitude (\muV)')
if pAmp <= 0.001
    text(1.4,max(stats.mean_MeanBurstAmplitude)+max(stats.sem_MeanBurstAmplitude),'***','FontSize',20)
elseif pAmp <=0.01
    text(1.4,mean(stats.mean_MeanBurstAmplitude)+mean(stats.sem_MeanBurstAmplitude),'**','FontSize',20)
elseif pAmp <= 0.05
    text(1.4,mean(stats.mean_MeanBurstAmplitude)+mean(stats.sem_MeanBurstAmplitude),'*','FontSize',20)
end
hold off

subplot(1,2,1)
hold on
b2=bar(x,stats.mean_MeanBurstDuration);
b2.FaceColor='flat';
b2.CData(1,:)=[0 0 1];
b2.CData(2,:)=[0 1 1];
errorbar(x,stats.mean_MeanBurstDuration,stats.sem_MeanBurstDuration,'k.')
ylabel('Mean burst duration (s)')
if pDur <= 0.001
    text(1.35,max(stats.mean_MeanBurstDuration)+max(stats.sem_MeanBurstDuration),'***','FontSize',20)
elseif pDur <=0.01
    text(1.35,max(stats.mean_MeanBurstDuration)+max(stats.sem_MeanBurstDuration),'**','FontSize',20)
elseif pDur <= 0.05
    text(1.35,max(stats.mean_MeanBurstDuration)+max(stats.sem_MeanBurstDuration),'*','FontSize',20)
end
hold off
suptitle(strcat('Burst amplitude and duration',zscoring))
print('-r150',strcat('Burst amplitude and duration',zscoring),'-dtiffn')




end

