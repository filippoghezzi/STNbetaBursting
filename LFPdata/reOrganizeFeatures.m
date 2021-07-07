close all
clear 
clc

load FeaturesForFitting.mat

features=rmfield(features,{'SR','PeakFreq','PSDRawData','PSDFiltData','Envelope','Perc','PSDenvelope','PDFenvelope'}); %Create features struct
for i=1:length(features)
    if features(i).Levodopa=='OFF'
        features(i).Levodopa=1;
    else 
        features(i).Levodopa=2;
    end
    if features(i).Side=='R'
        features(i).Side=1;
    else 
        features(i).Side=2;
    end
end

percentiles=(55:5:90);
defFeat=[];
for i=1:length(features)
    for k=1:length(percentiles)
        newFeat(k,1)=features(i).Subject;
        newFeat(k,2)=features(i).Levodopa;
        newFeat(k,3)=features(i).Side;
        newFeat(k,4)=percentiles(k);
        newFeat(k,5)=features(i).BurstDuration(1,k);
        newFeat(k,6)=features(i).BurstAmplitude(1,k);
    end
%      M=cell2mat(struct2cell(newFeat));
     defFeat=[defFeat;newFeat];
end


% struct2csv(newFeat,'AAron')