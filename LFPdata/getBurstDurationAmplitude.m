function [MeanBurstAmplitude,MeanBurstDuration]=getBurstDurationAmplitude(envelope,SR,threshold)    
%Function to calculate mean burst amplitude and duration for the envelope
%signal given as input according to several threhsold values.
%Inputs:
%envelope -> signal to analyze;
%SR -> sampling rate of the signal;
%threshold -> threshold for burst determination
%Output:
%MeanBurstAmplitude
%MeanBurstDuration

count=0;
nBurst=0;
BurstAmp=0;
Amplitude=[];
Duration=[];

for k=1:length(envelope) %K for scanning each envelope time series
    if envelope(k)>=threshold %Comparison of single time point with threshold
        count=count+1; %Index duration in samples
        if count==1 %For first time count increases count nBurst
            nBurst=nBurst+1; %Index burst
        end
        if envelope(k) >= BurstAmp %Udapte BurstAmp as trace of higher point in the burst
            BurstAmp=envelope(k);
        end
    elseif count>0 %If burst just finished
        if count/SR>=0.1 %Take only burst with duration longer than 0.1 s
            Amplitude(nBurst)=BurstAmp;
            Duration(nBurst)=count/SR;
        else 
            nBurst=nBurst-1;
        end
        count=0;
        BurstAmp=0;
    end
end
    
MeanBurstAmplitude=mean(Amplitude);
MeanBurstDuration=mean(Duration);

end
