function [PSD,PDF,f,PDFpoints,MeanBurstAmplitude,MeanBurstDuration]=getEnvelopeFeatures(envelope,SR,maxPDFpoints,perc)
%Function to compute the Power Spectral Density (PSD), the Probability
%Distribution Function (PDF), mean burst amplitude and duration
%of the envelope given as input according to different threshold values.
%Inputs:
%envelope -> envelope signal
%SR -> sampling rate of the original signal
%maxEnvelope -> max value of all envelopes given in input used to compute
%the bins of the PDF
%perc -> vector with threshold values for burst determination. 
%Outputs:
%PSD -> vector containing the PSD of the envelope
%f -> frequency vector used to compute the envelope PSD
%PDF -> vector containing the envelope amplitude PDF calculated according
%to the vector PDFpoints
%PDFpoints -> vector containing points for the PDF

%Calculate the power spectrum of smoothened envelope
f=(0:0.01:10); %Frequency vector for power spectrum
window=0.6*SR; %Magnitude of the window for pwelch = 0.6 seconds
[PSD,f]=pwelch(envelope,window,[],f,SR);

%Calculate pdf of envelope amplitude
PDFpoints=linspace(0,maxPDFpoints); %Amplitude points for PDF
[PDF,~]=ksdensity(envelope,PDFpoints);

%Calculate burst duration and amplitude according to different thresholds
for i=1:length(perc)%For each different threshold value
    [MeanBurstAmplitude(i),MeanBurstDuration(i)]=getBurstDurationAmplitude(envelope,SR,perc(i));
end

end