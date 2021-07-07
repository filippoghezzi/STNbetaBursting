clear 

load parSubject6_L_OFF.mat
numSimulation=5;
deltat=10^-3;
endt=200;
SR=1/deltat; %Sampling rate of the model
f=0:0.01:50; %Frequency vector for pwelch
plots=1;

for k=1:10
    for i=1:numSimulation
        [S]=FirstModel_First(par,deltat,endt); %Simulate 40 seconds
        S=S(10/deltat+1:end); %Take only last 30 seconds
        S=zscore(S); %Z-score the simulation
        PSDdata(i,:)=pwelch(S,3*SR,[],f,SR); %Calculate simulation PSD
        [envelope,perc]=getEnvelope(S,SR); %Obtain envelope with Hilbert transform
        for k=1:length(perc)
            [~,meanBurstDuration(i,k)]=getBurstDurationAmplitude(envelope,SR,perc(k));
        end
    end

    %Calculate average features and SEM
    modelFeatures.PSDsignalM=mean(PSDdata);
    modelFeatures.BurstDurationM=mean(meanBurstDuration);
    modelFeatures.semPSDdata=std(PSDdata)/size(PSDdata,1);
    modelFeatures.semMeanBurstDuration=std(meanBurstDuration)/size(meanBurstDuration,1);

    errorbar(perc,modelFeatures.BurstDurationM,modelFeatures.semMeanBurstDuration,'bo-')
    ylim([0.15 0.65])
    hold on
end
hold off

