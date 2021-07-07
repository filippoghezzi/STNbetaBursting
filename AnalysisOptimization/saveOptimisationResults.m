clear
close all
clc

%% Select subject, side and condition
opt.subject=5;
opt.levodopa=0; % 0 for OFF, 2 for ON
opt.side=0; %0 for R, 1 for L
analysisType='Re-Optimisation';   %or 'Optimisation'

%% Extract top parameters from folder
optimFolder='re-optimisation_03-Apr-18_22-04-02';
folderName=['OptimisationResults\OFF\' optimFolder];

opt.optParam=getTopParameters(folderName);

%% Save top(rankToRead) parameters
if opt.side==0
    if opt.levodopa==0
        paramFileName=strcat('Subject',int2str(opt.subject),'-Right-OFF_Top10_',analysisType);
    elseif opt.levodopa==2
        paramFileName=strcat('Subject',int2str(opt.subject),'-Right-ON_Top10_',analysisType);
    end
elseif opt.side==1
    if opt.levodopa==0
        paramFileName=strcat('Subject',int2str(opt.subject),'-Left-OFF_Top10_',analysisType);
    elseif opt.levodopa==2
        paramFileName=strcat('Subject',int2str(opt.subject),'-Left-ON_Top10_',analysisType);
    end
end

save(paramFileName,'opt')