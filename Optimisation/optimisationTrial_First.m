%Use this script to test whether optimisation is working on your machine.

close all
clear 
clc

%Save results of optimisation
folderName='C:\Users\Filippo\Documents\MATLAB\STNbetaBursting\Optimisation\OptimResults';

%Load data features and select features to fit
load FeaturesForFitting.mat
dataChoice=24;
FeaturesToFit.PSDsignalD=features(dataChoice).PSDFiltData;
FeaturesToFit.BurstDurationD=features(dataChoice).BurstDuration;
FeaturesToFit.maxPDFpoints=maxPDFpoints;

nOptim=1000;
parpool('local',2)
parfor i=1:nOptim 
    
    %Parameter to fit
    sigma=0.2*rand;
    wGS=10*rand+0;
    wSG=10*rand+0;
    wGG=10*rand+0;
    wXG=30*rand+0;
    wCS=30*rand+0;
    tau=11.5*10^-3; %see plot and set initial tau to obtain appropriate oscillation frequency. 
    par0=[sigma,wGS,wSG,wGG,wXG,wCS,tau];
    
    filename=[folderName '\' num2str(i) '.txt'];
    fileID = fopen(filename,'a');
    fprintf(fileID,'%12s %12s %12s %12s %12s %12s %12s %12s \r\n','sigma','wGS','wSG','wGG','wXG','wCS','tau','cost');
    fclose(fileID);


    options=optimset('MaxFunEvals',2);
    fminsearch('CostFunction_First',par0,options,FeaturesToFit,filename);
end