function [sig_filtered,peakFreq,pwelch_raw,f]=filteringProcess_pwelch(sig,fs,bandSpecified,fminus,fplus,aroundMean,dfminus,dfplus)
% Wrapper for doFiltering: compute the power spectrum of the raw data, find
% the boundary for the bandpass filter in doFiltering according to inputs
% and compute the power spectrum of the filtered data. 
% Inputs:
% sig -> signal to be filtered;
% fs -> sampling frequency;
% bandSpecified -> bool, set to 1 to specify directly the frequency bounds
% of the bandpass filter (in fplus and fminus);
% aroundMean -> if bounds not directly specify, set to 1 to center the 
% bandpass filter around the mean frequency (energy), or to 0 to center 
% the bandpass on the peak frequency. The filtering window will be 
% [center-dfminus,center+dfplus].
% Outputs:
% sig_filtered -> filtered signal;
% peakFreq -> peak frequency within the Beta band (13-35 Hz);
% pwelch_raw -> PSD of raw data;
% pwelch_filtered -> PSD of filtered data.

f=0:0.01:50; %Frequency vector
wind=3*fs; %Magnitude of the pwelch window = 3 seconds

[pwelch_raw,~]=pwelch(sig,wind,[],f,fs); %Compute PSD of raw data

%Params for doFiltering
params.dt = 1/fs;
params.filterOrder = 2;

if bandSpecified
    params.fcutlow=fminus;
    params.fcuthigh=fplus;
    peakFreq=fminus+3; %Peak frequency for ON data (equal to correspondent OFF data)
else
    if ~aroundMean
        %mode between 13 and 35 Hz (Beta band)
        [~,start]=min(abs(f-13));
        [~,stop]=min(abs(f-35));
        [~,idx]=max(pwelch_raw(start:stop));
        peakFreq = f(idx+start-1);
    else
        %weighted average between 13 and 35 Hz
        [~,start]=min(abs(f-13)); 
        [~,stop]=min(abs(f-35)); 
        peakFreq=sum(f(start:stop).*pwelch_raw(start:stop))/sum(pwelch_raw(start:stop));
    end
    params.fcutlow  = peakFreq-dfminus;
    params.fcuthigh = peakFreq+dfplus; 
end

sig_filtered = doFiltering(params,sig);

end

