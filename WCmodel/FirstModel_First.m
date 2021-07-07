function [S]=FirstModel_First(par,deltat,endt)
% 2-population WC model with delays and gaussian noise similar to
% Nevado-Holgado et al., 2010. Differences are given by a simplification of
% the activating function (Onslow et al., 2014) and in the scaling cortical
% and striatal inputs to STN and GP. 
% Inputs:
% par -> parameter structure [sigma,wGS,wSG,wGG,wXG,wCS];
% deltat -> time step;
% endt -> total time.
% Output:
% S -> time-series of the subthalamic nucleus trace.

%Constants
param.beta=4;
param.TSG=6*10^-3; %s from Pavlides et al., 2015
param.TGS=6*10^-3; %s
param.TGG=4*10^-3; %s

%Free parameters
param.sigma=par(1);
param.wGS=par(2);
param.wSG=par(3);
param.wGG=par(4);
param.wXG=par(5);
param.wCS=par(6);
param.tauS=par(7);
param.tauG=par(7);

%Time
param.deltat=deltat; %s
param.endt=endt; %s
t=(0:param.deltat:param.endt);

%Call DEsolve function to solve differential equation with Euler's method
[S,~]=solveDE_FirstModel_First_Fast(param,t);

end