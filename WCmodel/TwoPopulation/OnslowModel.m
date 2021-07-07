%% 2-population WC model
close all
clear
clc
%Model equations
%E'=(-E+1/(1+exp(-beta*(thetaE+(wEE*E)-(wIE*I)-1))))/tau
%I'=(-I+1/(1+exp(-beta*(thetaI+(wEI*E)-1))))/tau
%% Parameter structure declaration
%Constants
param.wEE=2.4;
param.wEI=2;
param.wIE=2;
param.tau=0.0032;
param.beta=4;
%Time
param.deltat=10^-3;
param.endt=1;
t=[0:param.deltat:param.endt];

%% Inputs
%Constant values
param.thetaE=1.3;
%param.thetaI=0.6;

%Theta (4 Hz) frequency 
% param.thetaE=[((sin(2*pi*4*t))+1)/2.5];
param.thetaI=[((sin(2*pi*4*t))+1)/1.43]+0.1;

%% Function and plots
%Call DEsolve function to solve differential equation with Euler's method
[E,I]=DEsolve_OnslowModel(param,t);
%Plots
figure;
%Plot inputs vs time
subplot(2,1,1)
plot([0 1],[param.thetaE param.thetaE],'g-')
hold on
plot(t,param.thetaI,'r-')
ylim([0 1.5])
title('Inputs to the populations')
xlabel('Time')
hold off
%Plot output vs time
subplot(2,1,2)
plot(t,E,'g-')
hold on
plot(t,I,'r-')
ylim([0 1])
title('Activity of the populations')
xlabel('Time')
legend('E','I')
hold off

%% Continuation analysis (Matcont)
%thetaE continuation
%Equilibrium (thetaE=0, thetaI=0)
%E=0.01813
%I=0.02073
%thetaE_CR1=0.39998575
%thetaE_CR2=1.2000143

%thetaI continuation
%Equilibrium (thetaE=1.3, thetaI=0)
%E=0.88730
%I=0.95683
%thetaI_CR1=0.10580056
%thetaI_CR2=0.52368435


%ADD RANDOM NOISE
%normrnd(0,1)
%sigma is a parameter

%sigma*normrnd()/sqrt(dt)
%Wiener process to add at Edot not E