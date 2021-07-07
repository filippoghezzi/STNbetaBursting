function plotRawFiltPSD(tab)
%Function to plot the PSDs of raw and filtered data per side per condition
%for one single subject. 
%Inputs:
%tab -> table containing all data for one subject in which:
%    Row 1 -> OFF Right
%    Row 2 -> OFF Left
%    Row 3 -> ON Right
%    Row 4 -> ON Left


f=0:0.01:50; %Frequency vector
dat=table2struct(tab); %Convert input table into structure

figure
%Plot Right
a1=subplot(2,2,1); %Raw data
hold on
plot(f,dat(1).PSDRawData,'b') %OFF
plot(f,dat(3).PSDRawData,'c') %ON
plot([dat(1).PeakFreq dat(1).PeakFreq],[0 max([dat(1).PSDRawData dat(3).PSDRawData])*1.5],'--r')
title('Right - Raw')
xlabel('Frequency (Hz)'); xlim([0 40]);
ylabel('PSD (\muV^{2}/Hz)'); ylim([0 max([dat(1).PSDRawData dat(3).PSDRawData])/2000]);
legend('OFF LD','ON LD','Location','best')
hold off
a2=subplot(2,2,3); %Filtered data
hold on
plot(f,dat(1).PSDFiltData,'b') %OFF
plot(f,dat(3).PSDFiltData,'c') %ON
title('Right - Filtered')
xlabel('Frequency (Hz)'); xlim([0 40]);
ylabel('PSD (\muV^{2}/Hz)'); ylim([0 max([dat(1).PSDFiltData dat(3).PSDFiltData])*1.5])
legend('OFF LD','ON LD','Location','best')
hold off

%Plot left
a3=subplot(2,2,2); %Raw data
hold on
plot(f,dat(2).PSDRawData,'b') %OFF
plot(f,dat(4).PSDRawData,'c') %ON
plot([dat(2).PeakFreq dat(2).PeakFreq],[0 max([dat(2).PSDRawData dat(4).PSDRawData])*1.5],'--r')
xlabel('Frequency (Hz)'); xlim([0 40]);
ylabel('PSD (\muV^{2}/Hz)'); ylim([0 max([dat(2).PSDRawData dat(4).PSDRawData])/2000]);
title('Left - Raw')
legend('OFF LD','ON LD','Location','best')
hold off
a4=subplot(2,2,4); %Filtered data
hold on
plot(f,dat(2).PSDFiltData,'b') %OFF
plot(f,dat(4).PSDFiltData,'c') %ON
title('Left - Filtered')
xlabel('Frequency (Hz)'); xlim([0 40]);
ylabel('PSD (\muV^{2}/Hz)'); ylim([0 max([dat(2).PSDFiltData dat(4).PSDFiltData])*1.5]);
legend('OFF LD','ON LD','Location','best')
hold off

end
