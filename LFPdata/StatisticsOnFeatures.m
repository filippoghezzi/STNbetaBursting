%Calculate statistical differences between features in OFF and ON
%conditions: see Fig. 8

clear
close all
clc

load FeaturesForFitting.mat
PSDOFFmat=[];
PSDONmat=[];
PDFOFFmat=[];
PDFONmat=[];
BurstDurOFFmat=[];
BurstDurONmat=[];
BurstAmpOFFmat=[];
BurstAmpONmat=[];
for i=1:length(features)
    
    if features(i).Levodopa=='OFF'
        PSDOFFmat=[PSDOFFmat;features(i).PSDenvelope(1,:)];
        PDFOFFmat=[PDFOFFmat;features(i).PDFenvelope(1,:)];
        BurstDurOFFmat=[BurstDurOFFmat;features(i).BurstDuration(1,:)];
        BurstAmpOFFmat=[BurstAmpOFFmat;features(i).BurstAmplitude(1,:)];
    else
        PSDONmat=[PSDONmat;features(i).PSDenvelope(1,:)];
        PDFONmat=[PDFONmat;features(i).PDFenvelope(1,:)];
        BurstDurONmat=[BurstDurONmat;features(i).BurstDuration(1,:)];
        BurstAmpONmat=[BurstAmpONmat;features(i).BurstAmplitude(1,:)];
    end
    
end


%% Perform random-based permutation statistical tests on these four features. 
numPerms=2000;
[clusPos_Z_Stat_PSD, clusPval_Z_Stat_PSD] = permstats(PSDOFFmat(:,1:500),PSDONmat(:,1:500),numPerms);

[clusPos_Z_Stat_PDF, clusPval_Z_Stat_PDF] = permstats(PDFOFFmat(:,1:40),PDFONmat(:,1:40),numPerms);

[clusPos_Z_Stat_Dur, clusPval_Z_Stat_Dur] = permstats(BurstDurOFFmat,BurstDurONmat,numPerms);

[clusPos_Z_Stat_Amp, clusPval_Z_Stat_Amp] = permstats(BurstAmpOFFmat,BurstAmpONmat,numPerms);



load MeanFeatures.mat
plotMeanEnvelopeFeaturesWithStatistics(meanFeaturesStats,f,PDFpoints,zscoring,meanMaxEnvelope,clusPos_Z_Stat_PSD,clusPos_Z_Stat_PDF,clusPos_Z_Stat_Dur,clusPos_Z_Stat_Amp)
