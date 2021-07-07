%See Fig. 14

clear
close all
clc

load Subject5-Right-OFF_Top10_Re-Optimisation.mat
parOFF=opt.optParam(2,:);
load Subject5-Right-ON_Top10_Refinement.mat
parON=opt.optParam(1,:);

load FeaturesForFitting.mat
dataChoice=1+4*(opt.subject-1)+opt.side+opt.levodopa;
FeaturesToFit.PSDsignalD=features(dataChoice).PSDFiltData;
FeaturesToFit.PSDenvelopeD=features(dataChoice).PSDenvelope;
FeaturesToFit.PDFenvelopeD=features(dataChoice).PDFenvelope;
FeaturesToFit.BurstAmplitudeD=features(dataChoice).BurstAmplitude;
FeaturesToFit.BurstDurationD=features(dataChoice).BurstDuration;
FeaturesToFit.maxPDFpoints=maxPDFpoints;


plotModelBurstDuration(FeaturesToFit,parOFF,parON)
