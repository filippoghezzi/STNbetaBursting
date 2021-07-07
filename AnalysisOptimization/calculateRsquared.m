function [R2,S,modelFeatures]=calculateRsquared(dataFeatures,par,numSimulation,endt)
% Function to perform model simulation and calculate R squared according to
% cost between data and model features. 
% Inputs: 
% dataFeatures -> structure with features from data;
% par -> vector, parameter of the cost;
% Outputs:
% R2 -> R squared value;
% S -> sample of model simulation for plotting;
% modelFeatures -> structure containing model features.

[S,modelFeatures]=getModelFeatures_All(par,dataFeatures.maxPDFpoints,0,numSimulation,endt);

%Calculate adjusted cost associated with this simulation and R^2
cost1=sum((dataFeatures.PSDsignalD-modelFeatures.avgPSDdata).^2)/sum((dataFeatures.PSDsignalD-mean(dataFeatures.PSDsignalD)).^2);
cost5=sum((dataFeatures.BurstDurationD-modelFeatures.avgMeanBurstDuration).^2)/sum((dataFeatures.BurstDurationD-mean(dataFeatures.BurstDurationD)).^2);

cost=cost1/2+cost5/2;
R2=1-cost;

end