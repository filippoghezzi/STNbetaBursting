function [S,G]=solveDE_FirstModel(param,t)
%Differential equation numerical solver (Euler's method) for 2 populations 
%WC model with delays and noise.
%Inputs: 
%param -> parameter structure containing deltat;
%t -> time vector.
%Outputs:
%S,G -> time-series of solved differential equation.

%Declare vectors E, I and t as zeros row vector
S=zeros(1,length(t));
G=zeros(1,length(t));
random=normrnd(0,1,2,length(t)-1);
%Create anonymous function sigmoid equivalent to f(x)
sigmoid=@(x) 1/(1+exp(-param.beta*(x-1)));
%For loops to determine values of E and I, solving with Euler's method
for i=int32(param.TSG/param.deltat)+1:length(t)-1
    randS=random(1,i);
    randG=random(2,i);
    
    Sdot=((sigmoid(-param.wGS*G(i-int32(param.TGS/param.deltat))+param.wCS)-S(i))/param.tauS)+(param.sigma*randS/sqrt(param.deltat));
    Gdot=((sigmoid(param.wSG*S(i-int32(param.TSG/param.deltat))-param.wGG*G(i-int32(param.TGG/param.deltat))-param.wXG)-G(i))/param.tauG)+(param.sigma*randG/sqrt(param.deltat));
    
    S(i+1)=S(i)+param.deltat*Sdot;
    G(i+1)=G(i)+param.deltat*Gdot;
end


end