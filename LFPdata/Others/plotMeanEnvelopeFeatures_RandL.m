function plotMeanEnvelopeFeatures_RandL(stats,f,points,zscoring,meanMaxEnvelope)
%Function to plot mean envelope features.
%Inputs:
%stats -> table with statistics to plot;
%f -> frequency vector for PSD;
%points -> points vector for PDF;
% zscoring -> string with indication of applied Z-scoring.

figure %Plot mean PDF envelope
subplot(1,2,1) %Right
hold on
h1=shadedErrorBar(points,stats.mean_PDFenvelope(1,:),stats.sem_PDFenvelope(1,:),'lineProps','b');
h2=shadedErrorBar(points,stats.mean_PDFenvelope(3,:),stats.sem_PDFenvelope(3,:),'lineProps','c');
hold off
xlabel('Envelope Amplitude (\muV)')
xlim([0 meanMaxEnvelope])
ylim([0 max(stats.mean_PDFenvelope(3,:))+max(stats.sem_PDFenvelope(3,:))])
ylabel('Probability Density Function')
title('Right')
legend([h1.mainLine h1.patch h2.mainLine h2.patch],'Mean OFF','SEM OFF','Mean ON','SEM ON');
subplot(1,2,2) %Left
hold on
h3=shadedErrorBar(points,stats.mean_PDFenvelope(2,:),stats.sem_PDFenvelope(2,:),'lineProps','b');
h4=shadedErrorBar(points,stats.mean_PDFenvelope(4,:),stats.sem_PDFenvelope(4,:),'lineProps','c');
hold off
xlabel('Envelope Amplitude (\muV)')
xlim([0 meanMaxEnvelope])
ylabel('Probability Density Function')
ylim([0 max(stats.mean_PDFenvelope(4,:))+max(stats.sem_PDFenvelope(4,:))])
title('Left')
legend([h3.mainLine h3.patch h4.mainLine h4.patch],'Mean OFF','SEM OFF','Mean ON','SEM ON');
suptitle(strcat('Mean PDF envelope amplitude',zscoring))
print('-r150',strcat('Mean PDF envelope amplitude',zscoring),'-dtiffn')

figure %Plot mean PSD envelope
subplot(1,2,1) %Right
hold on
h5=shadedErrorBar(f,stats.mean_PSDenvelope(1,:),stats.sem_PSDenvelope(1,:),'lineProps','b');
h6=shadedErrorBar(f,stats.mean_PSDenvelope(3,:),stats.sem_PSDenvelope(3,:),'lineProps','c');
hold off
xlabel('Frequency (Hz)')
xlim([0 5])
ylabel('Power Spectral Density (\muV^2/Hz)')
% ylim([0 max(stats.mean_PSDenvelope(1,:))/20])
title('Right')
legend([h5.mainLine h5.patch h6.mainLine h6.patch],'Mean OFF','SEM OFF','Mean ON','SEM ON');
subplot(1,2,2) %Left
hold on
h7=shadedErrorBar(f,stats.mean_PSDenvelope(2,:),stats.sem_PSDenvelope(2,:),'lineProps','b');
h8=shadedErrorBar(f,stats.mean_PSDenvelope(4,:),stats.sem_PSDenvelope(4,:),'lineProps','c');
hold off
xlabel('Frequency (Hz)')
xlim([0 5])
ylabel('Power Spectral Density (\muV^2/Hz)')
% ylim([0 max(stats.mean_PSDenvelope(2,:))/20])
title('Left')
legend([h7.mainLine h7.patch h8.mainLine h8.patch],'Mean OFF','SEM OFF','Mean ON','SEM ON');
suptitle(strcat('Mean PSD envelope amplitude',zscoring))
print('-r150',strcat('Mean PSD envelope amplitude',zscoring),'-dtiffn')

end