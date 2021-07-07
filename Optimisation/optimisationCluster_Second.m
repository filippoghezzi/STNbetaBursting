%Use this script on the cluster. 

close all
clear 
clc

%Create folder for output of optimization
formatOut = 'dd-mmm-yy_HH-MM-ss';
folderName = ['re-optimisation_' datestr(clock,formatOut)];
mkdir(folderName);

%Load optimised and refined parameters
load Subject2-Right-OFF_Top10_Refinement.mat
meanPar=mean(opt.optParam);
stdPar=std(opt.optParam);

%Load data features and select features to fit
load FeaturesForFitting.mat
dataChoice=1+4*(opt.subject-1)+opt.side+opt.levodopa;
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
    sigma=normrnd(meanPar(1),stdPar(1));
    wGS=normrnd(meanPar(2),stdPar(2));
    wSG=normrnd(meanPar(3),stdPar(3));
    wGG=normrnd(meanPar(4),stdPar(4));
    wXG=normrnd(meanPar(5),stdPar(5));
    wCS=normrnd(meanPar(6),stdPar(6));
    tau=normrnd(meanPar(7),stdPar(7));
    par0=[sigma,wGS,wSG,wGG,wXG,wCS,tau];
    
    %Re-sample if one of the parameters is negative. 
    while any(par0(:)<0)
        sigma=normrnd(meanPar(1),stdPar(1));
        wGS=normrnd(meanPar(2),stdPar(2));
        wSG=normrnd(meanPar(3),stdPar(3));
        wGG=normrnd(meanPar(4),stdPar(4));
        wXG=normrnd(meanPar(5),stdPar(5));
        wCS=normrnd(meanPar(6),stdPar(6));
        tau=normrnd(meanPar(7),stdPar(7));
        par0=[sigma,wGS,wSG,wGG,wXG,wCS,tau];
    end
    
    %Create file to save optimisation results. 
    filename=[folderName '/' num2str(i) '.txt'];
    fileID = fopen(filename,'a');
    fprintf(fileID,'%12s %12s %12s %12s %12s %12s %12s %12s \r\n','sigma','wGS','wSG','wGG','wXG','wCS','tau','cost');
    fclose(fileID);


    options=optimset('MaxFunEvals',300);
    fminsearch('CostFunction_First',par0,options,FeaturesToFit,filename);
end

toc
diary off

%Send email when optimisation finished
configure_smtp;
sendmail('filippo.ghezzi@univ.ox.ac.uk','Optimisation has finished');