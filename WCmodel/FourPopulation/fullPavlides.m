%% 4-population WC model
close all
clear
clc
%Model equations (for matcont)
%S'=(1/(1+exp(-beta*((wCS*E-wGS*G)-1)))-S)/tauS     
%G'=(1/(1+exp(-beta*((wSG*S-wGG*G)-Str-1)))-G)/tauG 
%E'=(1/(1+exp(-beta*((-wSC*S-wCC*I)+Ctx-1)))-E)/tauE
%I'=(1/(1+exp(-beta*((wCC*E)-1)))-I)/tauI       

%% Parameter structure declaration
%Constants
param.beta=4;
param.sigma=150;
param.tauS=12.8*10^-3; %s
param.tauG=20*10^-3; %s
%Free parameters
param.tauE=11.59*10^-3; %s:10-20 ms
param.tauI=13.02*10^-3; %s:10-20 ms
param.wSG=4.87; %0-10
param.wGS=1.33; %0-10
param.wCS=9.98; %0-10
param.wSC=8.93; %0-10
param.wGG=0.53; %0-10
param.wCC=6.17; %0-10
param.Ctx=172.18; %0-30
param.Str=8.46; %0-30
%Time delays
param.TSG=6*10^-3; %s
param.TGS=6*10^-3; %s
param.TCS=5.5*10^-3; %s
param.TSC=21.5*10^-3; %s
param.TGG=4*10^-3; %s
param.TCC=4.65*10^-3; % s:1-10 ms 
%Firing features
param.MS=300; %spk/s
param.BS=10; %spk/s
param.MG=400; %spk/s
param.BG=20; %spk/s
param.ME=75.77; %50-80 spk/s
param.BE=17.85; %0-20 spk/s
param.MI=205.72; %200-330 spk/s
param.BI=9.87; %0-20 spk/s
%Time
param.deltat=10^-3; %s
param.endt=50; %s
t=(0:param.deltat:param.endt);

%% Function and plots
%Call DEsolve function to solve differential equation with Euler's method
[S,G,E,I]=DEsolve_fullPavlides(param,t);
%Plots
figure;
%Plot output vs time
plot(t,S,'b-')
hold on
plot(t,G,'g-')
plot(t,E,'r-')
plot(t,I,'c-')
% ylim([0 400])
title('Activity of the populations')
xlabel('Time')
legend('STN','GPe','E','I')
hold off

