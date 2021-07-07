function [S,modelFeatures]=getModelFeatures_All(par,maxPDFpoints,plots,numSimulation,endt)
%This function perform simulations of the WC model according to the
%parameters given in inputs. It also computes the features (data PSD,
%envelope PSD, envelope PDF, average burst duration and average burst amplitude)
%of the model simulation. The simulations are performed 5 times, each of 
%them for a total duration of 30 seconds.
%The average features are given as output. 
%Inputs:
% par -> parameter structure [sigma,wGS,wSG,wGG,wXG,wCS];
%maxPDFpoints -> max value of the data envelope used to find the points of the PDF function.
%Outputs:
%avgPSDdata -> average data PSD;
%avgPSDenvelope -> average envelope PSD;
%avgPDFenvelope -> average envelope PDF;
%avgMeanBurstAmplitude -> average of the mean of burst amplitude per
%simulation;
%avgMeanBurstDuration -> average of the mean of burst duration per
%simulation.

deltat=10^-3;
SR=1/deltat; %Sampling rate of the model
f=0:0.01:50; %Frequency vector for pwelch

for i=1:numSimulation
    [S]=FirstModel_First(par,deltat,endt); 
    S=S(10/deltat+1:end); %Eliminate first 10 seconds to avoid aberrations
    S=zscore(S); %Z-score the simulation
    PSDdata(i,:)=pwelch(S,3*SR,[],f,SR); %Calculate simulation PSD
    [envelope,perc]=getEnvelope(S,SR); %Obtain envelope with Hilbert transform
    [PSDenvelope(i,:),PDFenvelope(i,:),~,modelFeatures.PDFpoints,meanBurstAmplitude(i,:),...
     meanBurstDuration(i,:)]=getEnvelopeFeatures(envelope,SR,maxPDFpoints,perc);
end

%Calculate average features and SEM
modelFeatures.avgPSDdata=mean(PSDdata);
modelFeatures.avgMeanBurstDuration=mean(meanBurstDuration);
modelFeatures.avgPDFenvelope=mean(PDFenvelope);
modelFeatures.avgPSDenvelope=mean(PSDenvelope);

modelFeatures.semPSDdata=std(PSDdata)/size(PSDdata,1);
modelFeatures.semMeanBurstDuration=std(meanBurstDuration)/size(meanBurstDuration,1);
modelFeatures.semPDFenvelope=std(PDFenvelope)/size(PDFenvelope,1);
modelFeatures.semPSDenvelope=std(PSDenvelope)/size(PSDenvelope,1);

if plots
    %Plot average features and SEM: comment while optimizing
    figure
    shadedErrorBar(f,modelFeatures.PSDsignalM,modelFeatures.semPSDdata,'lineProps','b'); title('Average PSD Filt Data')
    figure
    errorbar(perc,modelFeatures.BurstDurationM,modelFeatures.semMeanBurstDuration,'bo-')    
    figure
    plot((0:deltat:endt-10),S)
end

end