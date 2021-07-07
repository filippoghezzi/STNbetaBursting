%Plot parameters correlation matrices: see Fig. 15 and 16, A and C
clear 
close all
clc

% Raw parameters
load Subject2-Right-OFF_Top10_Re-Optimisation.mat
OFF=opt.optParam(1:5,:);
load Subject2-Right-ON_Top10_Refinement.mat
ON=opt.optParam(1:8,:);
clear opt

VarName={'\sigma','w_{GS}','w_{SG}','w_{GG}','\theta_{XG}','\theta_{CS}','\tau_S = \tau_G'};
caption='Subject 2';


fcnCorrMatrixPlot_Modified(OFF, ON, VarName, caption);


% Ratio parameters weights
RatioOFF=[OFF(:,2)./OFF(:,3),OFF(:,2)./OFF(:,4),OFF(:,3)./OFF(:,4)];
RatioON=[ON(:,2)./ON(:,3),ON(:,2)./ON(:,4),ON(:,3)./ON(:,4)];

ratioNames={'w_{GS}/w_{SG}','w_{GS}/w_{GG}','w_{SG}/w_{GG}'};

fcnCorrMatrixPlot_Ratio(RatioOFF, RatioON, ratioNames, caption);
