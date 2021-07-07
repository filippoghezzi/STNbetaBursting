% 2-population WC model with delays and gaussian noise similar to
% Nevado-Holgado et al., 2010 using simplification of
% the activating function (Onslow et al., 2014). 
close all
clear
clc
%% Parameters
%Constants
param.beta=4;
param.tauS=13.45*10^-3; %s 
param.tauG=13.45*10^-3;%s
param.TSG=6*10^-3; %s
param.TGS=6*10^-3; %s
param.TGG=4*10^-3; %s
%Free parameters
param.sigma=0.0646;
param.wGS=3.533;
param.wSG=3.866;
param.wGG=0.7578;
param.wXG=0.6165;
param.wCS=4.546;
%Time
param.deltat=10^-3; %s
param.endt=40; %s
t=(0:param.deltat:param.endt);

%% Function and plots
%Call appropriate DEsolve function to solve differential equation with Euler's method
[S,G]=solveDE_FirstModel(param,t);
%Plots
figure
hold on
plot(t,S,'b-')
plot(t,G,'g-')
% ylim([0 1])
title('Activity of the populations')
xlabel('Time (s)')
legend('STN','GPe')
hold off