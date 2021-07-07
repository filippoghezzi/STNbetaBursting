function normalizeEnvelopePSD(features,f,zscoring)

features=rmfield(features,{'SR','PSDRawData','PSDFiltData','Envelope','PDFenvelope'});

for i=1:length(features)
    features(i).PSDenvelope(1:20)=NaN;
    features(i).normPSDenvelope=features(i).PSDenvelope/sum(features(i).PSDenvelope,'omitnan');
end

tab=struct2table(rmfield(features,{'Subject','Side','PSDenvelope'}));%Convert struct features into reduced table

stats=grpstats(tab,{'Levodopa'},{'mean','sem'}); %Compute statistics (mean and SEM)

f(1:20)=NaN;
figure %Plot mean PSD envelope
hold on
h3=shadedErrorBar(f,stats.mean_normPSDenvelope(1,:),stats.sem_normPSDenvelope(1,:),'lineProps','b');
h4=shadedErrorBar(f,stats.mean_normPSDenvelope(2,:),stats.sem_normPSDenvelope(2,:),'lineProps','c');
hold off
xlabel('Frequency (Hz)')
xlim([0 5])
ylabel('Power Spectral Density (\muV^2/Hz)')
% ylim([0 max(stats.mean_normPSDenvelope(1,:))])
title('Right')
legend([h3.mainLine h3.patch h4.mainLine h4.patch],'Mean OFF','SEM OFF','Mean ON','SEM ON');
suptitle(strcat('Mean normalized PSD envelope amplitude',zscoring,' - Mix Sides'))
print('-r150',strcat('Mean normalized PSD envelope amplitude',zscoring,' - Mix Sides'),'-dtiffn')


end