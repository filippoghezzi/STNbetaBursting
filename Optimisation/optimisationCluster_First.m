%Use this script on the cluster. 

close all
clear 
clc

%Create folder for output of optimization
formatOut = 'dd-mmm-yy_HH-MM-ss';
folderName = ['optimisation_' datestr(clock,formatOut)];
mkdir(folderName);

%Load data features and select features to fit
load FeaturesForFitting.mat
dataChoice=22;
FeaturesToFit.PSDsignalD=features(dataChoice).PSDFiltData;
FeaturesToFit.BurstDurationD=features(dataChoice).BurstDuration;
FeaturesToFit.maxPDFpoints=maxPDFpoints;

%Select number of local optimizations
nOptim=10000;

rng('shuffle');
tic
diary on
parpool('local',32)

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
    
    %Create file to save optimisation results
    filename=[folderName '/' num2str(i) '.txt'];
    fileID = fopen(filename,'a');
    fprintf(fileID,'%12s %12s %12s %12s %12s %12s %12s %12s \r\n','sigma','wGS','wSG','wGG','wXG','wCS','tau','cost');
    fclose(fileID);


    options=optimset('MaxFunEvals',300);
    fminsearch('CostFunction_First',par0,options,FeaturesToFit,filename);
end

toc
diary off