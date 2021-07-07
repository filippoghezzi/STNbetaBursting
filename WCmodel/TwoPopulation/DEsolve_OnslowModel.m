%% Euler's method to solve differential equation
function [E,I]=DEsolve_OnslowModel(param,t)
%Declare vectors E, I and t as zeros row vector
E=zeros(1,length(t));
I=zeros(1,length(t));
%Create anonymous function sigmoid equivalent to f(x)
sigmoid=@(x) 1/(1+exp(-param.beta*(x-1)));
%For loops to determine values of E and I, solving with Euler's method
for i=1:length(t)-1
    Edot=(-E(i)+sigmoid(param.thetaE+param.wEE*E(i)-param.wIE*I(i)))/param.tau;
    Idot=(-I(i)+sigmoid(param.thetaI(i)+param.wEI*E(i)))/param.tau;
    E(i+1)=E(i)+param.deltat*Edot;
    I(i+1)=I(i)+param.deltat*Idot;
end