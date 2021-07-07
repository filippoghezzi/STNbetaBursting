% Compare mean parameters in OFF and ON; similar to Fig. 15 and 16, B and D

clear
close all
clc


load Subject2-Right-OFF_Top10_Re-Optimisation.mat
OFF=opt.optParam;
load Subject2-Right-ON_Top10_Refinement.mat
ON=opt.optParam;
mat=[];
positions=[];

for i=1:size(OFF,2)
    mat=[mat,OFF(:,i),ON(:,i)];
    positions=[positions,i,i+0.25];
end

Xs={'sigmaOFF','sigmaON','wGSOFF','wGSON','wSGOFF','wSGON','wGGOFF','wGGON','wXGOFF','wXGON','wCSOFF','wCSON','tauOFF','tauON'};
    

boxplot(mat,Xs,'Positions',positions)



%Ratio weights
RatioOFF=[OFF(:,2)./OFF(:,3),OFF(:,2)./OFF(:,4),OFF(:,3)./OFF(:,4)];
RatioON=[ON(:,2)./ON(:,3),ON(:,2)./ON(:,4),ON(:,3)./ON(:,4)];

ratioNames={'w_{GS}/w_{SG}-OFF','w_{GS}/w_{SG}-ON','w_{GS}/w_{GG}-OFF','w_{GS}/w_{GG}-ON','w_{SG}/w_{GG}-OFF','w_{SG}/w_{GG}-ON'};
mat2=[];
positions2=[];
for k=1:size(RatioOFF,2)
    mat2=[mat2,RatioOFF(:,k),RatioON(:,k)];
    positions2=[positions2,k,k+0.25];
end
figure
boxplot(mat2,ratioNames,'Positions',positions2)


