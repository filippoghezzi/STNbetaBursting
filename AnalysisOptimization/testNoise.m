%Test effect of noise as in Fig. 17 of my dissertation.

clear
close all
clc


load Subject2-Right-OFF_Top10_Re-Optimisation.mat

load FeaturesForFitting.mat
load ProcessedData.mat
dataChoice=1+4*(opt.subject-1)+opt.side+opt.levodopa;
FilteredSig=dat(dataChoice).FiltData;
FeaturesToFit.PSDsignalD=features(dataChoice).PSDFiltData;
FeaturesToFit.PSDenvelopeD=features(dataChoice).PSDenvelope;
FeaturesToFit.PDFenvelopeD=features(dataChoice).PDFenvelope;
FeaturesToFit.BurstAmplitudeD=features(dataChoice).BurstAmplitude;
FeaturesToFit.BurstDurationD=features(dataChoice).BurstDuration;
FeaturesToFit.maxPDFpoints=maxPDFpoints;


%% Plot model features from top parameters
rankToPlot=1;
for rank=1:rankToPlot
    plotMulitpleNoise(FeaturesToFit,opt.optParam(rank,:));
end