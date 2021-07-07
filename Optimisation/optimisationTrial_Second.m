%Use this script to test whether optimisation is working on your machine.

close all
clear 
clc

folderName='C:\Users\Filippo\Documents\MATLAB\STNbetaBursting\Optimisation\OptimResults';

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
nOptim=10;

rng('shuffle');
parpool('local',2)

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
    
    while any(par0(:)<0)
        sigma=normrnd(meanPar(1),stdPar(1));
        wGS=normrnd(meanPar(2),stdPar(2));
        wSG=normrnd(meanPar(3),stdPar(3));
        wGG=normrnd(meanPar(4),stdPar(4));
        wXG=normrnd(meanPar(5),stdPar(5));
        wCS=normrnd(meanPar(6),stdPar(6));
        tau=normrnd(meanPar(7),stdPar(7));
        par0=[sigma,wGS,wSG,wGG,wXG,wCS,tau];
        c=c+1;
    end
    
    filename=[folderName '/' num2str(i) '.txt'];
    fileID = fopen(filename,'a');
    fprintf(fileID,'%12s %12s %12s %12s %12s %12s %12s %12s \r\n','sigma','wGS','wSG','wGG','wXG','wCS','tau','cost');
    fclose(fileID);


    options=optimset('MaxFunEvals',2);
    fminsearch('CostFunction_First',par0,options,FeaturesToFit,filename);
end

configure_smtp;
sendmail('filippo.ghezzi@univ.ox.ac.uk','Optimisation has finished');