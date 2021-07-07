function [S,G]=solveDE_FirstModel_First_Fast(param,t)
%Differential equation numerical solver (Euler's method) for 2 populations 
%WC model with delays and noise; uses C language for improved speed.
%Inputs: 
%param -> parameter structure containing deltat;
%t -> time vector.
%Outputs:
%S,G -> time-series of solved differential equation.

%Random numbers
random=normrnd(0,1,2,length(t)-1);
randS=random(1,:);
randG=random(2,:);
%For loops to determine values of E and I, solving with Euler's method
[S,G]=doEulerNoise_First_Fast(param.sigma,param.wGS,param.wSG,param.wGG,param.wXG,param.wCS,...
    param.tauS,param.tauG,param.deltat,param.beta,param.TSG,param.TGS,param.TGG,param.endt,randS,randG);


end