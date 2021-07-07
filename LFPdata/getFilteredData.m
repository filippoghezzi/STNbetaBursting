function [dat,zscoring]=getFilteredData(dat,zScoreRawData,zScoreFiltData,plotPSDs)
%Function to filter the data in input according to filteringProcess.m
%function. It also perform the Z-scoring of either raw or filtered data and
%plots the power spectrum density of raw and filtered data per subject per
%condition. 
%Inputs:
%dat -> structure with data to filter, sampling rates, and conditions;
%zScoreRawData -> bool, 1 to Z-score raw data;
%zScoreFiltData -> bool, 1 to Z-score filtered data;
%plotPSDs -> bool, 1 to plot raw and filtered data PSDs.
%Outputs:
%dat -> input structure containing fields with filtered data and PSDs of raw and filtered data;
%zscoring -> string containing indication on the Z-scoring applied. 

zscoring=' '; %Void for no Z-scoring

for i=1:length(dat)
    %Z-score raw data
    if zScoreRawData
        dat(i).RawData=zscore(dat(i).RawData);
        zscoring=' - Z-scoring raw data';
    end
    
    %Set parameters for filteringProcess according to Levodopa condition
    if strcmp(dat(i).Levodopa,'OFF')
        bandSpecified=0;
        fminus=[];
        fplus=[];
        aroundMean=0;
        dfminus=3;
        dfplus=3;
    elseif strcmp(dat(i).Levodopa,'ON ')
        bandSpecified=1;
        fminus=dat(i-2).PeakFreq-3;
        fplus=dat(i-2).PeakFreq+3;
        aroundMean=[];
        dfminus=[];
        dfplus=[];
    end
    
    [dat(i).FiltData,dat(i).PeakFreq,dat(i).PSDRawData,~]=filteringProcess_pwelch(dat(i).RawData,dat(i).SR,bandSpecified,fminus,fplus,aroundMean,dfminus,dfplus);
    
    %Z-score filtered data
    if zScoreFiltData
        dat(i).FiltData=zscore(dat(i).FiltData);
        zscoring=' - Z-scoring filtered data';
    end
    
    dat(i).PSDFiltData=pwelch(dat(i).FiltData,dat(i).SR*3,[],(0:0.01:50),dat(i).SR);
    
end

%Plot the PSD of raw data and filtered data
if plotPSDs
    tab=struct2table(dat); %Convert struct to table
    
    for i=1:max(tab.Subject)
        plotRawFiltPSD(tab(tab.Subject==i,:)) %Extract one subject each loop from table
        
        suptitle(strcat('Subject',num2str(i),zscoring))
        set(gcf,'PaperUnits','centimeters','PaperPosition',[0 0 20 15])
        print('-r300',strcat('Subject',num2str(i),' - PSD Raw and Filt Data',zscoring),'-dtiffn')
    end
end

end