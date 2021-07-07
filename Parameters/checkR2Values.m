%See Fig. 15A2 and 16A2

clear 
close all
clc

load FeaturesForFitting.mat

load  Subject2-Right-OFF_Top10_Re-Optimisation.mat
parOFF=opt.optParam;

dataChoiceOFF=1+4*(opt.subject-1)+opt.side+opt.levodopa;
FeaturesToFitOFF.PSDsignalD=features(dataChoiceOFF).PSDFiltData;
FeaturesToFitOFF.PSDenvelopeD=features(dataChoiceOFF).PSDenvelope;
FeaturesToFitOFF.PDFenvelopeD=features(dataChoiceOFF).PDFenvelope;
FeaturesToFitOFF.BurstAmplitudeD=features(dataChoiceOFF).BurstAmplitude;
FeaturesToFitOFF.BurstDurationD=features(dataChoiceOFF).BurstDuration;
FeaturesToFitOFF.maxPDFpoints=maxPDFpoints;


load Subject2-Right-ON_Top10_Refinement.mat
parON=opt.optParam;

dataChoiceON=1+4*(opt.subject-1)+opt.side+opt.levodopa;
FeaturesToFitON.PSDsignalD=features(dataChoiceON).PSDFiltData;
FeaturesToFitON.PSDenvelopeD=features(dataChoiceON).PSDenvelope;
FeaturesToFitON.PDFenvelopeD=features(dataChoiceON).PDFenvelope;
FeaturesToFitON.BurstAmplitudeD=features(dataChoiceON).BurstAmplitude;
FeaturesToFitON.BurstDurationD=features(dataChoiceON).BurstDuration;
FeaturesToFitON.maxPDFpoints=maxPDFpoints;

numSimulation=5;
endt=1000;
for i=1:length(parOFF)
    [R2OFF(i),~,~]=calculateRsquared(FeaturesToFitOFF,parOFF(i,:),numSimulation,endt);
    [R2ON(i),~,~]=calculateRsquared(FeaturesToFitON,parON(i,:),numSimulation,endt);
end

scatter(ones(1,length(R2OFF)),R2OFF,'bo','filled')
hold on
scatter(ones(1,length(R2ON))*2,R2ON,'co','filled')
xlim([0 3])
set(gca, 'FontSize', 18,'Linewidth',1)
ylabel('R^2','FontSize',22); 

legend('Model OFF','Model ON')
set(gca,'xtick',[])
set(gca,'xticklabel',[])

    
    
    