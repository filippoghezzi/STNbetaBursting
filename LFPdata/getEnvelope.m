function [envelope,perc]=getEnvelope(Signal,SR)
% Function to perform the Hilbert transform on a filtered signal, compute
% its absolute value to find the Hilbert envelope of the original signal, 
% smooth the envelope and find out the nth percentile of the signal. 
%Inputs:
%filteredSignal -> a given signal properly filtered around a frequency
%band;
%SR -> sampling rate of the filtered signal.
%Outputs:
%envelope -> vector containing the time-series of the original signal;
%perc -> scalar value of the nth percentile.

smoothSpan=SR*0.2; %Window span (0.2 s) of the smoothing function
percentile=(55:5:90); %nth percentile

hilbFilteredSignal=abs(hilbert(Signal)); %Calculate the Hilber transform of the filtered signal
envelope=smooth(hilbFilteredSignal,smoothSpan)'; %Smooth the Hilbert envelope with smoothspan
perc=prctile(envelope,percentile); %Calculate nth percentile of smoothened Hilbert transform
end