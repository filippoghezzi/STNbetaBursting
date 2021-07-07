function [dat,maxPDFpoints]=waveletAnalysis(dat)
%The function perform the wavelet decomposition of the time series in dat,
%using the function cwt of the Matlab Wavelet Toolbox. It obtains the
%envelope of the time series in the beta peak +- 0.5 Hz by taking the
%absolute value of the cwt output
%Input:
%dat -> struct containing time series and sampling rate
%Output:
%dat -> modified structure adding the result of the decomposition and
%envelope

percentile=[55:5:90]; %nth percentile
maxPDFpoints=0;

for i=1:length(dat)
    
    %Perform wavelet decomposition with Morlet wavelet
    [wt,f]=cwt(dat(i).RawData,'amor',dat(i).SR,'VoicesPerOctave',12);
    
    ModWT=abs(wt);
    
    %Find max value in the beta range and peak frequency
    meanWT=mean(ModWT,2);
    [~,stop]=min(abs(f-13));
    [~,start]=min(abs(f-35));
    [~,idxMax]=max(meanWT(start:stop));
    dat(i).PeakFreq=f(idxMax+start-1);

    %Invert the wavelet transform in the max peak frequency +- 0.5 Hz
    dat(i).Envelope=ModWT(idxMax+start-1,:);
    
    %Manual Z-scoring of the envelope
    dat(i).FiltData=icwt(wt,f,[dat(i).PeakFreq-0.5,dat(i).PeakFreq+0.5]);
    STDFiltData=std(dat(i).FiltData);   
    dat(i).Envelope=dat(i).Envelope/STDFiltData;
   
    dat(i).PSDRawData=[];
    dat(i).PSDFiltData=[];
    
    %Get nth percentile
    for k=1:length(percentile)
        dat(i).Perc(k)=prctile(dat(i).Envelope,percentile(k));
    end
    
    %Get max values of all envelopes for PDF points
    if max(dat(i).Envelope)>maxPDFpoints
        maxPDFpoints=max(dat(i).Envelope)*1.2; %Max value of Hilbert envelope for all subjects
    end
    
    
end

end
