function plotMulitpleNoise(dataFeatures,par)
% Function to perform model simulation, calculate R squared according to
% cost between model and data features, and plot model and data features.
% Inputs:
% dataFeatures -> structure with features from data;
% par -> vector, parameter of the cost;
% signal -> filtered data signal.

numSimulation=5;
endt=1000;

perc=(55:5:90);
f=(0:0.01:50);



noise=[par(1)+0.15,par(1)+0.155,par(1)+0.16];

tau=[par(7)-0.0011,par(7)-0.0011,par(7)-0.0013];

figure
for i=1:length(noise) 
    
    par(1)=noise(i);
    par(7)=tau(i);
    [R2,S,modelFeatures]=calculateRsquared(dataFeatures,par,numSimulation,endt);
    
    if i==1
        subplotN=i;
    else 
        subplotN=subplotN+3;
    end
   

    subplot(length(noise),3,subplotN)
    plot((0:10^-3:20),S(1:20/10^-3+1),'b')
    xlabel('Time (s)','FontSize',22); ylim([-5 5]);
    ylabel ('Model simulation','FontSize',22)
    xt = get(gca, 'XTick');
    set(gca, 'FontSize', 18,'Linewidth',1)
    ylim([-5 5])

    subplot(length(noise),3,subplotN+1)
    hold on
    plot(f,dataFeatures.PSDsignalD,'k','LineWidth',1)
    s1=shadedErrorBar(f,modelFeatures.avgPSDdata,modelFeatures.semPSDdata,'lineProps','b');
    s1.mainLine.LineWidth = 1;
    xlabel('Frequency (Hz)','FontSize',22); ylabel('PSD (a.u.)','FontSize',22);
    xlim([10 30]); ylim([0 0.35])
    % title('Power spectrum density'); 
    legend('Data','Model');
    hold off
    xt = get(gca, 'XTick');
    set(gca, 'FontSize', 18,'Linewidth',1)

    subplot(length(noise),3,subplotN+2)
    hold on
    plot(perc,dataFeatures.BurstDurationD,'k','LineWidth',1)
    errorbar(perc,modelFeatures.avgMeanBurstDuration,modelFeatures.semMeanBurstDuration,'b-','LineWidth',1)
    xlabel('Percentile','FontSize',22); ylabel('Burst duration (s)','FontSize',22); 
    xlim([50 95]); ylim([0.15 0.65]);
    legend('Data','Model')
    xt = get(gca, 'XTick');
    set(gca, 'FontSize', 18,'Linewidth',1)
end
h=suptitle(['R^2=',num2str(R2),'; \sigma=',num2str(par(1),4),'; w_{GS}=',num2str(par(2),4),'; w_{SG}=',num2str(par(3),4),'; w_{GG}=',num2str(par(4),4),'; w_{XG}=',num2str(par(5),4),'; w_{CS}=',num2str(par(6),4),'; \tau_S=\tau_G=',num2str(par(7),4)]);
set(h,'FontSize',14,'FontWeight','normal')
end