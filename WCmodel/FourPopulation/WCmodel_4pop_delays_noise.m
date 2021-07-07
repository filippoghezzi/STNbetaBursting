%% 4-population WC model with delays and noise
close all
clear
clc
%Model equations (for matcont)
    

%% Parameter structure declaration
%Constants
param.beta=4;
param.sigma=1;
param.tauS=12.8*10^-3; %s
param.tauG=20*10^-3;%s
%Free parameters
param.tauE=11.69*10^-3; %s
param.tauI=10.45*10^-3; %s
param.wSG=4.87;
param.wGS=1.33;
param.wCS=9.98;
param.wSC=8.93;
param.wGG=0.53;
param.wCC=6.17;
param.Ctx=3;
param.Str=2.5;
%Time delays
param.TSG=6*10^-3; %s
param.TGS=6*10^-3; %s
param.TCS=5.5*10^-3; %s
param.TSC=21.5*10^-3; %s
param.TGG=4*10^-3; %s
param.TCC=4.6*10^-3; %s
%Time
param.deltat=10^-4; %s
param.endt=10; %s
t=(0:param.deltat:param.endt);

%% Function and plots
%Call DEsolve function to solve differential equation with Euler's method
[S,G,E,I]=DEsolve_4pop_delays_noise(param,t);
%Plots
figure;
%Plot output vs time
plot(t,S,'b-')
hold on
% plot(t,G,'g-')
% plot(t,E,'r-')
% plot(t,I,'c-')
% ylim([0 1])
title('Activity of the populations')
xlabel('Time')
% legend('STN','GPe','E','I')
hold off

Sfilt = filteringProcess(S,1/param.deltat,0,[],[],0,3,3,1);

