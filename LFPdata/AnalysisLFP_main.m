close all
clear
clc

load OFF_ON_LD_full.mat; %Load data
OrigDat=newData; %Original dataset struct
dat=organizeData(OrigDat); %Re-organize data

%Declare parameters for plotting and Z-scoring
zScoreRawData=0;  %bool, 1 to Z-score raw data
zScoreFiltData=1; %bool, 1 to Z-score filtered data
plotRawFiltPSD=1; %bool, 1 to plot PSDs of raw and filtered data
plotFeatures=1;   %bool, 1 to plot envelope features
meanFeatures=1;   %bool, 1 to compute the mean envelope features


%% Filter data and plot raw and filtered PSD
[dat,zscoring]=getFilteredData(dat,zScoreRawData,zScoreFiltData,plotRawFiltPSD);

%% Get Hilbert envelope and envelope features
maxPDFpoints=0;    %double, initialize to zero

for i=1:length(dat)
    [dat(i).Envelope,dat(i).Perc]=getEnvelope(dat(i).FiltData,dat(i).SR);
    if max(dat(i).Envelope)>maxPDFpoints
        maxPDFpoints=max(dat(i).Envelope)*1.2; %Max value of Hilbert envelope for all subjects
    end
end

features=rmfield(dat,{'RawData','FiltData'}); %Create features struct

%Get envelope features (PSD and PDF)
for i=1:length(dat)
    [features(i).PSDenvelope,features(i).PDFenvelope,f,PDFpoints,features(i).BurstAmplitude,...
     features(i).BurstDuration]=getEnvelopeFeatures(dat(i).Envelope,dat(i).SR,maxPDFpoints,dat(i).Perc);
end

%Plot envelope features
if plotFeatures
    plotEnvelopeFeatures(features,f,PDFpoints,zscoring)
end

save('FeaturesForFitting.mat','features','maxPDFpoints')
save('ProcessedData.mat','dat')

%% Calculate and plot mean envelope features
%Get statistics of envelope features and plot them
if meanFeatures
    %Calculate the mean of the max values of envelope (only for plotting)
    for i=1:length(features)    
        maxEnvelope(i)=max(features(i).Envelope);
    end
    meanMaxEnvelope=mean(maxEnvelope);
    
    meanFeaturesStats=getMeanEnvelopeFeatures(features);
    plotMeanEnvelopeFeatures(meanFeaturesStats,f,PDFpoints,zscoring,meanMaxEnvelope)
    
end