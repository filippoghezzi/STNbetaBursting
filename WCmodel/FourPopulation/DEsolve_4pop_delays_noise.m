%% Euler's method to solve differential equation
function [S,G,E,I]=DEsolve_4pop_delays_noise(param,t)
%Declare vectors E, I and t as zeros row vector
S=zeros(1,length(t));
G=zeros(1,length(t));
E=zeros(1,length(t));
I=zeros(1,length(t));
%Create anonymous function sigmoid equivalent to f(x)
sigmoid=@(x) 1/(1+exp(-param.beta*(x-1)));
%For loops to determine values of E and I, solving with Euler's method
for i=int32(param.TSC/param.deltat)+1:length(t)-1
    Sdot=((sigmoid(param.wCS*E(i-int32(param.TCS/param.deltat))-param.wGS*G(i-int32(param.TGS/param.deltat)))-S(i))/param.tauS)+(param.sigma*normrnd(0,1)/sqrt(param.deltat));
    Gdot=((sigmoid(param.wSG*S(i-int32(param.TSG/param.deltat))-param.wGG*G(i-int32(param.TGG/param.deltat))-param.Str)-G(i))/param.tauG)+(param.sigma*normrnd(0,1)/sqrt(param.deltat));
    Edot=((sigmoid(-param.wSC*S(i-int32(param.TSC/param.deltat))-param.wCC*I(i-int32(param.TCC/param.deltat))+param.Ctx)-E(i))/param.tauE)+(param.sigma*normrnd(0,1)/sqrt(param.deltat));
    Idot=((sigmoid(param.wCC*E(i-int32(param.TCC/param.deltat)))-I(i))/param.tauI)+(param.sigma*normrnd(0,1)/sqrt(param.deltat));
    
    S(i+1)=S(i)+param.deltat*Sdot;
    G(i+1)=G(i)+param.deltat*Gdot;
    E(i+1)=E(i)+param.deltat*Edot;
    I(i+1)=I(i)+param.deltat*Idot;
end