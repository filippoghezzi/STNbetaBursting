function plotEnvelopeFeatures(features,f,PDFpoints,zscoring)
%Function to plot the envelope features (PDF and PSD) per subject for each
%condition.
%Inputs:
%features -> structure containing envelope features;
%f -> frequency vector for PSD;
%PDFpoints -> points vector for PDF;
%zscoring -> string, indicating the Z-scoring condition.

tabFeatures=struct2table(features); %Convert struct inputs into table
perc=(55:5:90);
for i=1:max(tabFeatures.Subject)
    tab=(tabFeatures(tabFeatures.Subject==i,:)); %Extract one subject from the table
    feat=table2struct(tab); %Convert back to structure
    
    figure % Plot smoothened envelope trace and 75th percentile
    
    a1=subplot(2,2,1); %OFF right
    plot((0:length(feat(1).Envelope)-1)/feat(1).SR,feat(1).Envelope,'b')
    hold on
    plot([0 (length(feat(1).Envelope)-1)/feat(1).SR],[feat(1).Perc(5) feat(1).Perc(5)],'r')
    hold off
    xlabel('Time (s)')
    ylabel('Voltage (\muV)')
    ylim([0 max([feat(1).Envelope,feat(2).Envelope,feat(3).Envelope,feat(4).Envelope])])
    legend('OFF Right','75th pctile')
    a2=subplot(2,2,2); %OFF left
    plot((0:length(feat(2).Envelope)-1)/feat(2).SR,feat(2).Envelope,'b')
    hold on
    plot([0 (length(feat(2).Envelope)-1)/feat(2).SR],[feat(2).Perc(5) feat(2).Perc(5)],'r')
    hold off
    xlabel('Time (s)')
    ylabel('Voltage (\muV)')
    ylim([0 max([feat(1).Envelope,feat(2).Envelope,feat(3).Envelope,feat(4).Envelope])])
    legend('OFF Left','75th pctile')
    linkaxes([a1,a2],'x')
    xlim([0 10])
    a3=subplot(2,2,3); %ON right
    plot((0:length(feat(3).Envelope)-1)/feat(3).SR,feat(3).Envelope,'c')
    hold on
    plot([0 (length(feat(3).Envelope)-1)/feat(3).SR],[feat(3).Perc(5) feat(3).Perc(5)],'r')
    hold off
    xlabel('Time (s)')
    ylabel('Voltage (\muV)')
    ylim([0 max([feat(1).Envelope,feat(2).Envelope,feat(3).Envelope,feat(4).Envelope])])
    legend('ON Right','75th pctile')
    a4=subplot(2,2,4); %ON left
    plot((0:length(feat(4).Envelope)-1)/feat(4).SR,feat(4).Envelope,'c')
    hold on
    plot([0 (length(feat(4).Envelope)-1)/feat(4).SR],[feat(4).Perc(5) feat(4).Perc(5)],'r')
    hold off
    xlabel('Time (s)')
    ylabel('Voltage (\muV)')
    ylim([0 max([feat(1).Envelope,feat(2).Envelope,feat(3).Envelope,feat(4).Envelope])])
    legend('ON Left','75th pctile')
    linkaxes([a3,a4],'x')
    xlim([0 10])
    linkaxes([a1,a2,a3,a4],'y')
    suptitle(strcat('Subject ',num2str(i),' - Smoothened Hilbert envelope',zscoring))
    set(gcf,'PaperUnits','centimeters','PaperPosition',[0 0 20 15])
    print('-r150',strcat('Subject',num2str(i),' - Smoothened Hilbert envelope',zscoring),'-dtiffn')

    
    figure %Plot the power spectrum of smoothened envelope

    subplot(1,2,1) %Right
    plot(f,feat(1).PSDenvelope,'b') %OFF right
    hold on
    plot(f,feat(3).PSDenvelope,'c') %ON right
    hold off
    legend('OFF LD','ON LD')
    xlabel('Frequency (Hz)')
    ylabel('PSD (\muV^{2}/Hz)')
%     xlim([0 5])
%     ylim([0 max(feat(1).PSDenvelope)/20])
    title('Right')
    subplot(1,2,2) %Left
    plot(f,feat(2).PSDenvelope,'b')%OFF left
    hold on
    plot(f,feat(4).PSDenvelope,'c')%ON left
    hold off
    legend('OFF LD','ON LD')
    xlabel('Frequency (Hz)')
    ylabel('PSD (\muV^{2}/Hz)')
%     xlim([0 5])
%     ylim([0 max(feat(2).PSDenvelope)/20])
    title('Left')
    
    suptitle(strcat('Subject ',num2str(i),' - PSD envelope amplitude',zscoring))
    print('-r150',strcat('Subject',num2str(i),' - PSD envelope',zscoring),'-dtiffn')

    
    figure %Plot the probability density function of smoothened envelope 

    subplot(1,2,1) %Right
    plot(PDFpoints,feat(1).PDFenvelope,'b') %OFF right
    hold on
    plot(PDFpoints,feat(3).PDFenvelope,'c') %ON right
    hold off
    legend('OFF LD','ON LD')
    xlabel('Envelope amplitude (\muV)')
    ylabel('Probability Density Function')
    xlim([0 max([feat(1).Envelope,feat(2).Envelope,feat(3).Envelope,feat(4).Envelope])])
    title('Right')
    subplot(1,2,2) %Left
    plot(PDFpoints,feat(2).PDFenvelope,'b')
    hold on
    plot(PDFpoints,feat(4).PDFenvelope,'c')
    hold off
    legend('OFF LD','ON LD')
    xlabel('Envelope amplitude (\muV)')
    ylabel('Probability Density Function')
    xlim([0 max([feat(1).Envelope,feat(2).Envelope,feat(3).Envelope,feat(4).Envelope])])
    title('Left')
    
    suptitle(strcat('Subject ',num2str(i),' - PDF envelope amplitude',zscoring))
    print('-r150',strcat('Subject',num2str(i),' - PDF envelope amplitude',zscoring),'-dtiffn')
    
    
    figure %Plot the burst amplitude 

    subplot(1,2,1) %Right
    plot(perc,feat(1).BurstAmplitude,'bo-') %OFF right
    hold on
    plot(perc,feat(3).BurstAmplitude,'co-') %ON right
    hold off
    legend('OFF LD','ON LD')
    xlabel('Percentile')
    ylabel('Burst amplitude (\muV)')
    xlim([50 95])
    title('Right')
    subplot(1,2,2) %Left
    plot(perc,feat(2).BurstAmplitude,'bo-')
    hold on
    plot(perc,feat(4).BurstAmplitude,'co-')
    hold off
    legend('OFF LD','ON LD')
    xlabel('Percentile')
    ylabel('Burst amplitude (\muV)')
    xlim([50 95])
    title('Left')
    
    suptitle(strcat('Subject ',num2str(i),' - Burst amplitude',zscoring))
    print('-r150',strcat('Subject',num2str(i),' - Burst amplitude',zscoring),'-dtiffn')
    

    figure %Plot the burst duration

    subplot(1,2,1) %Right
    plot(perc,feat(1).BurstDuration,'bo-') %OFF right
    hold on
    plot(perc,feat(3).BurstDuration,'co-') %ON right
    hold off
    legend('OFF LD','ON LD')
    xlabel('Percentile')
    ylabel('Burst amplitude (\muV)')
    xlim([50 95])
    title('Right')
    subplot(1,2,2) %Left
    plot(perc,feat(2).BurstDuration,'bo-')
    hold on
    plot(perc,feat(4).BurstDuration,'co-')
    hold off
    legend('OFF LD','ON LD')
    xlabel('Percentile')
    ylabel('Burst duration (s)')
    xlim([50 95])
    title('Left')
    
    suptitle(strcat('Subject ',num2str(i),' - Burst duration',zscoring))
    print('-r150',strcat('Subject',num2str(i),' - Burst duration',zscoring),'-dtiffn')
end

end
