%% Euler's method to solve differential equation
function [S,G,E,I]=DEsolve_fullPavlides(param,t)
%Declare vectors E, I and t as zeros row vector
S=zeros(1,length(t));
G=zeros(1,length(t));
E=zeros(1,length(t));
I=zeros(1,length(t));
%Create anonymous sigmoid functions for each population
FS=@(x) param.MS/(1+(((param.MS+param.BS)/param.BS)*exp((-param.beta*x)/param.MS)));
FG=@(x) param.MG/(1+(((param.MG+param.BG)/param.BG)*exp((-param.beta*x)/param.MG)));
FE=@(x) param.ME/(1+(((param.ME+param.BE)/param.BE)*exp((-param.beta*x)/param.ME)));
FI=@(x) param.MI/(1+(((param.MI+param.BI)/param.BI)*exp((-param.beta*x)/param.MI)));

%For loops to determine values of E and I, solving with Euler's method
for i=int32(param.TSC/param.deltat)+1:length(t)-1
    Sdot=((FS(param.wCS*E(i-int32(param.TCS/param.deltat))-param.wGS*G(i-int32(param.TGS/param.deltat)))-S(i))/param.tauS)+(param.sigma*normrnd(0,1)/sqrt(param.deltat));
    Gdot=((FG(param.wSG*S(i-int32(param.TSG/param.deltat))-param.wGG*G(i-int32(param.TGG/param.deltat))-param.Str)-G(i))/param.tauG)+(param.sigma*normrnd(0,1)/sqrt(param.deltat));
    Edot=((FE(-param.wSC*S(i-int32(param.TSC/param.deltat))-param.wCC*I(i-int32(param.TCC/param.deltat))+param.Ctx)-E(i))/param.tauE)+(param.sigma*normrnd(0,1)/sqrt(param.deltat));
    Idot=((FI(param.wCC*E(i-int32(param.TCC/param.deltat)))-I(i))/param.tauI)+(param.sigma*normrnd(0,1)/sqrt(param.deltat));
    
    S(i+1)=S(i)+Sdot*param.deltat;
    G(i+1)=G(i)+Gdot*param.deltat;
    E(i+1)=E(i)+Edot*param.deltat;
    I(i+1)=I(i)+Idot*param.deltat;
end