% 2-population WC model with delays and gaussian noise similar to
% Nevado-Holgado et al., 2010. Differences are given by a simplification of
% the activating function (Onslow et al., 2014) and in the scaling cortical
% and striatal inputs to STN and GP. 
close all
clear
clc

load('Subject5-Right-OFF_Top10.mat')
 
%% Parameters
%Constants
param.beta=4;
param.TSG=6*10^-3; %s
param.TGS=6*10^-3; %s
param.TGG=4*10^-3; %s
%Time
param.deltat=10^-3; %s
param.endt=50; %s
t=(0:param.deltat:param.endt);

tauS=(1:0.5:30)*10^-3; %s 
    
for k=1:length(optParam)
    
    %Free parameters
    param.sigma=optParam(k,1);
    param.wGS=optParam(k,2);
    param.wSG=optParam(k,3);
    param.wGG=optParam(k,4);
    param.wXG=optParam(k,5);
    param.wCS=optParam(k,6);
 


    %% Function and plots
    figure
    for i=1:length(tauS)
        param.tauS=tauS(i);
        param.tauG=tauS(i);%s
        %Call appropriate DEsolve function to solve differential equation with Euler's method
        [S,G]=DEsolve_2pop_delays_noise_forC(param,t);

        %PSD
        SR=1/param.deltat;
        f=(0:0.01:50);
        PSD=pwelch(zscore(S),3*SR,[],f,SR);
        [~,idx]=max(PSD);
        peakFreq(i)=f(idx);

        %Plots
        plot(f,PSD)
        hold on

    end
    hold off

    figure
    scatter(tauS*10^3,peakFreq,'k','filled');
    ylabel('Peak Frequency (Hz)'); xlabel('\tau_S = \tau_G (ms)'); 
    title(int2str(k))
end