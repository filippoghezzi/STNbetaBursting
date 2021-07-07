function plotModelBurstDuration(dataFeatures,parOFF,parON)
% Function to perform model simulation in OFF and ON conditions and plot
% burst duration comparing the conditions. 
% Inputs:
% dataFeatures -> structure with features from data;
% parOFF -> vector, parameter OFF condition;
% parON -> vector, parameter OFF condition;


numSimulation=5;
endt=1000;

[~,modelFeaturesOFF]=getModelFeatures(parOFF,dataFeatures.maxPDFpoints,0,numSimulation,endt);
[~,modelFeaturesON]=getModelFeatures(parON,dataFeatures.maxPDFpoints,0,numSimulation,endt);

perc=(55:5:90);

errorbar(perc,modelFeaturesOFF.avgMeanBurstDuration,modelFeaturesOFF.semMeanBurstDuration,'b-','LineWidth',1)
hold on
errorbar(perc,modelFeaturesON.avgMeanBurstDuration,modelFeaturesON.semMeanBurstDuration,'c-','LineWidth',1)
hold off
xlabel('Percentile','FontSize',22); ylabel('Burst duration (s)','FontSize',22); 
xlim([50 95]); ylim([0.15 0.65]);
legend('Model OFF','Model ON')
xt = get(gca, 'XTick');
set(gca, 'FontSize', 18,'Linewidth',1)


end