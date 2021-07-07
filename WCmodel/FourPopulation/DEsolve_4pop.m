%% Euler's method to solve differential equation
function [S,G,E,I]=DEsolve_4pop(param,t)
%Declare vectors E, I and t as zeros row vector
S=zeros(1,length(t));
G=zeros(1,length(t));
E=zeros(1,length(t));
I=zeros(1,length(t));
%Create anonymous function sigmoid equivalent to f(x)
sigmoid=@(x) 1/(1+exp(-param.beta*(x-1)));
%For loops to determine values of E and I, solving with Euler's method
for i=1:length(t)-1
    Sdot=(sigmoid(param.wCS*E(i)-param.wGS*G(i))-S(i))/param.tauS;
    Gdot=(sigmoid(param.wSG*S(i)-param.wGG*G(i)-param.Str)-G(i))/param.tauG;
    Edot=(sigmoid(-param.wSC*S(i)-param.wCC*I(i)+param.Ctx)-E(i))/param.tauE;
    Idot=(sigmoid(param.wCC*E(i))-I(i))/param.tauI;
    
    S(i+1)=S(i)+param.deltat*Sdot;
    G(i+1)=G(i)+param.deltat*Gdot;
    E(i+1)=E(i)+param.deltat*Edot;
    I(i+1)=I(i)+param.deltat*Idot;
end