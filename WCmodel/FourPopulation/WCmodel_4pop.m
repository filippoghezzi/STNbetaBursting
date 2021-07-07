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
param.tauS=12.8*10^-3; %s
param.tauG=20*10^-3; %s
%Free parameters
param.tauE=11.59*10^-3; %s
param.tauI=13.02*10^-3; %s
param.wSG=4.87;
param.wGS=1.33;
param.wCS=9.98;
param.wSC=8.93;
param.wGG=0.53;
param.wCC=6.17;
param.Ctx=5;
param.Str=2.5;
%Time
param.deltat=10^-5;
param.endt=1;
t=(0:param.deltat:param.endt);

%% Function and plots
%Call DEsolve function to solve differential equation with Euler's method
[S,G,E,I]=DEsolve_4pop(param,t);
%Plots
figure;
%Plot output vs time
plot(t,S,'b-')
hold on
plot(t,G,'g-')
plot(t,E,'r-')
plot(t,I,'c-')
ylim([0 1])
title('Activity of the populations')
xlabel('Time')
legend('STN','GPe','E','I')
hold off

