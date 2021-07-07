clear
close all
clc


load Subject2-Right-OFF_Top10_Refinement.mat

load FeaturesForFitting.mat
load ProcessedData.mat
dataChoice=1+4*(opt.subject-1)+opt.side+opt.levodopa; %Automatically select dataChoice with information contained in the loaded file
FilteredSig=dat(dataChoice).FiltData;
FeaturesToFit.PSDsignalD=features(dataChoice).PSDFiltData;
FeaturesToFit.PSDenvelopeD=features(dataChoice).PSDenvelope;
FeaturesToFit.PDFenvelopeD=features(dataChoice).PDFenvelope;
FeaturesToFit.BurstAmplitudeD=features(dataChoice).BurstAmplitude;
FeaturesToFit.BurstDurationD=features(dataChoice).BurstDuration;
FeaturesToFit.maxPDFpoints=maxPDFpoints;

numSimulation=5;
endt=(40:40:200); 
rank=1;
n=10;

for i=1:length(endt) %Test features stability with varying endt values
    for j=1:n
        [R2(j),~,~]=calculateRsquared(FeaturesToFit,opt.optParam(rank,:),numSimulation,endt(i));
    end
    avgR2(i)=mean(R2);
    semR2(i)=std(R2)/sqrt(n);
end

%Plot R2 versus endt
errorbar(endt,avgR2,semR2,'-o')
xlabel('Time of simulation (s)')
ylabel('R^2')
xlim([30 210])
title ('Subject 2 OFF Right')
