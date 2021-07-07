% 2-population WC model with delays and gaussian noise similar to
% Nevado-Holgado et al., 2010. Differences are given by a simplification of
% the activating function (Onslow et al., 2014) and in the scaling cortical
% and striatal inputs to STN and GP. 
close all
clear
clc
%% Parameters
%Constants

tauS=(1:0.5:30)*10^-3; %s 
%% Parameters
%Constants
param.beta=4;
param.TSG=6*10^-3; %s
param.TGS=6*10^-3; %s
param.TGG=4*10^-3; %s
%Free parameters
param.sigma=0.05;
param.wGS=3.5;
param.wSG=4;
param.wGG=0.5;
param.wXG=1;
param.wCS=4.5;
%Time
param.deltat=10^-3; %s
param.endt=30; %s
t=(0:param.deltat:param.endt);

%% Function and plots

for i=1:length(tauS)
    param.tauS=tauS(i);
    param.tauG=tauS(i);%s
    %Call appropriate DEsolve function to solve differential equation with Euler's method
    [S,G]=solveDE_FirstModel_First_Fast(param,t);

    %PSD
    SR=1/param.deltat;
    f=(0:0.01:50);
    PSD=pwelch(zscore(S),3*SR,[],f,SR);
    [~,idx]=max(PSD);
    peakFreq(i)=f(idx);
end

figure
scatter(tauS*10^3,peakFreq,'k','filled');
set(gca,'linewidth',1)
ylabel('Peak Frequency (Hz)','FontSize',18); xlabel('\tau_S = \tau_G (ms)','FontSize',18); 
xt = get(gca, 'XTick');
set(gca, 'FontSize', 14)
