close all
clear 
clc

%Create folder for output of refinement
formatOut = 'dd-mmm-yy_HH-MM-ss';
folderName = ['refinement_' datestr(clock,formatOut)];
mkdir(folderName);

%Load top parameters from main optimisation
load Subject2-Right-OFF_Top10.mat

%Load data features and select features to fit
load FeaturesForFitting.mat
dataChoice=1+4*(opt.subject-1)+opt.side+opt.levodopa;
FeaturesToFit.PSDsignalD=features(dataChoice).PSDFiltData;
FeaturesToFit.BurstDurationD=features(dataChoice).BurstDuration;
FeaturesToFit.maxPDFpoints=maxPDFpoints;

%Number of parameters to refine equivalent to number of cores used.
nPar=size(opt.optParam,1);

tic
diary on
parpool('local',nPar)
parfor i=1:nPar
    par=opt.optParam(i,:);
    %Parameter to fit
    sigma=par(1);
    wGS=par(2);
    wSG=par(3);
    wGG=par(4);
    wXG=par(5);
    wCS=par(6);
    tau=par(7); 
    par0=[sigma,wGS,wSG,wGG,wXG,wCS,tau];
    
    filename=[folderName '/' num2str(i) '.txt'];
    fileID = fopen(filename,'a');
    fprintf(fileID,'%12s %12s %12s %12s %12s %12s %12s %12s \r\n','sigma','wGS','wSG','wGG','wXG','wCS','tau','cost');
    fclose(fileID);


    options=optimset('MaxFunEvals',10000);
    fminsearch('CostFunction_First',par0,options,FeaturesToFit,filename);
end

toc
diary off