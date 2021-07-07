function plotMeanEnvelopeFeatures(stats,f,points,zscoring,meanMaxEnvelope)
%Function to plot mean envelope features.
%Inputs:
%stats -> table with statistics to plot;
%f -> frequency vector for PSD;
%points -> points vector for PDF;
% zscoring -> string with indication of applied Z-scoring.

figure 

subplot(2,2,2) %Plot mean PDF envelope
hold on
h1=shadedErrorBar(points,stats.mean_PDFenvelope(1,:),stats.sem_PDFenvelope(1,:),'lineProps','b');
h2=shadedErrorBar(points,stats.mean_PDFenvelope(2,:),stats.sem_PDFenvelope(2,:),'lineProps','c');
hold off
xlabel('Envelope Amplitude (\muV)')
xlim([0 meanMaxEnvelope])
ylim([0 max(stats.mean_PDFenvelope(2,:))+max(stats.sem_PDFenvelope(2,:))])
ylabel('Probability Density Function')
% title('Right')
legend([h1.mainLine h2.mainLine],'OFF','ON');
% suptitle(strcat('Mean PDF envelope amplitude',zscoring,' - Mix Sides'))
print('-r150',strcat('Mean PDF envelope amplitude',zscoring,' - Mix Sides'),'-dtiffn')


subplot(2,2,1) %Plot mean PSD envelope
hold on
h3=shadedErrorBar(f,stats.mean_PSDenvelope(1,:),stats.sem_PSDenvelope(1,:),'lineProps','b');
h4=shadedErrorBar(f,stats.mean_PSDenvelope(2,:),stats.sem_PSDenvelope(2,:),'lineProps','c');
hold off
xlabel('Frequency (Hz)')
% xlim([0 5])
ylabel('Power Spectral Density (\muV^2/Hz)')
% ylim([0 max(stats.mean_PSDenvelope(1,:))/20])
% title('Right')
% legend([h3.mainLine h3.patch h4.mainLine h4.patch],'Mean OFF','SEM OFF','Mean ON','SEM ON');
% suptitle(strcat('Mean PSD envelope amplitude',zscoring,' - Mix Sides'))
print('-r150',strcat('Mean PSD envelope amplitude',zscoring,' - Mix Sides'),'-dtiffn')

perc=[55:5:90];

subplot(2,2,3) %Plot mean burst amplitude
hold on
h5=errorbar(perc,stats.mean_BurstAmplitude(1,:),stats.sem_BurstAmplitude(1,:),'b');
h6=errorbar(perc,stats.mean_BurstAmplitude(2,:),stats.sem_BurstAmplitude(2,:),'c');
hold off
xlabel('Percentile'); xlim([50 95]);
% ylim([0 max(stats.mean_PDFenvelope(2,:))+max(stats.sem_PDFenvelope(2,:))])
ylabel('Burst amplitude (\muV)')
legend('OFF','ON');
% suptitle(strcat('Mean burst amplitude',zscoring,' - Mix Sides'))
print('-r150',strcat('Mean burst amplitude',zscoring,' - Mix Sides'),'-dtiffn')

subplot(2,2,4) %Plot mean burst amplitude
hold on
h7=errorbar(perc,stats.mean_BurstDuration(1,:),stats.sem_BurstDuration(1,:),'b');
h8=errorbar(perc,stats.mean_BurstDuration(2,:),stats.sem_BurstDuration(2,:),'c');
hold off
xlabel('Percentile'); xlim([50 95]);
% ylim([0 max(stats.mean_PDFenvelope(2,:))+max(stats.sem_PDFenvelope(2,:))])
ylabel('Burst duration (s)')
legend('OFF','ON');
% suptitle(strcat('Mean burst duration',zscoring,' - Mix Sides'))
print('-r150',strcat('Mean burst duration',zscoring,' - Mix Sides'),'-dtiffn')

end