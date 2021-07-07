%%Script to plot the PSDs of each channel per hemisphere per subject per 
%%condition to find the higher beta peak.

clear 
close all
clc

load OFF_ON_LD_full.mat
dat=newData;

f=0:0.01:50; %Frequency vector
windowTime=3; %s
condition={'OFF_right','OFF_left','ON_right','ON_left'};
condition1={'OFF Right','OFF Left','ON Right','ON Left'};
Zscoring=0; %bool, set to 1 to perform Zscoring

for i=5:5
    figure
    for j=1:length(condition)
        subplot(2,2,j)
        for k=1:3
            sig=dat(i).(strcat('RawData',condition{j}))(k,:);
            if strcmp(condition{j},'OFF_right') || strcmp(condition{j},'OFF_left')
                fs=dat(i).SR_OFF;
            elseif strcmp(condition{j},'ON_right') || strcmp(condition{j},'ON_left')
                fs=dat(i).SR_ON;
            end
            [PSD(i).(strcat('RawData',condition{j}))(k,:),~]=pwelch(sig,fs*windowTime,[],f,fs);
            s1=plot(f,PSD(i).(strcat('RawData',condition{j}))(k,:),'LineWidth',1);
            hold on
        end
        set(gca,'linewidth',1)
        title(condition1{j},'FontSize',20)
        xlabel('Frequency (Hz)','FontSize',18)
        ylabel('PSD (\muV^2/Hz)','FontSize',18)
        xlim([8 35])
        xt = get(gca, 'XTick');
        set(gca, 'FontSize', 14)

        hold off
    end
    legend('Channel 1','Channel 2','Channel 3','Location','eastoutside')
    suptitle(strcat('Subject ',num2str(i)))
    set(gcf,'PaperUnits','centimeters','PaperPosition',[0 0 36 27])
    print('-r150',strcat('Subject',num2str(i),' - PSD Raw Data - All channels'),'-dtiffn')
end