function Struct=organizeData(dat)
% Organize data struct in input to obtain an output structure in tidy format;
% the function also extract the appropriate channel among the three
% recorded channels. 
% Inputs:
% dat -> stuct of data to re-organize.
% Ouputs:
% Struct -> final structure organized in tidy format.

%Extract selected (ChR and ChL) channels from data into new struct mod
for i=1:length(dat)
    mod(i).Subject=i;
    mod(i).RawDataOFF_right=dat(i).RawDataOFF_right(str2double(dat(i).ChR),:);
    mod(i).RawDataON_right=dat(i).RawDataON_right(str2double(dat(i).ChR),:);
    mod(i).RawDataOFF_left=dat(i).RawDataOFF_left(str2double(dat(i).ChL),:);
    mod(i).RawDataON_left=dat(i).RawDataON_left(str2double(dat(i).ChL),:);
    mod(i).SR_OFF=dat(i).SR_OFF;
    mod(i).SR_ON=dat(i).SR_ON;
end

tab=struct2table(mod); %Convert mod to table

%Manual stack of recording side (Left or Right)
tabL=tab;
tabR=tab;
tabL.Side(:)='L';
tabR.Side(:)='R';
tabR(:,[4 5])=[];
tabL(:,[2 3])=[];
tabR.Properties.VariableNames([2 3])={'OFF','ON'};
tabL.Properties.VariableNames([2 3])={'OFF','ON'};
tabtostack=[tabR;tabL];

%Automatic stack of Levodopa condition
Tab=stack(tabtostack,{'OFF','ON'},'NewDataVariableName','RawData','IndexVariableName','Levodopa');

%Obtain appropriate sampling rate per subject per condition
Tab.SR(:)=0;
tabOFF=Tab(Tab.Levodopa=='OFF',:);
tabOFF.SR=tabOFF.SR_OFF;
tabON=Tab(Tab.Levodopa=='ON',:);
tabON.SR=tabON.SR_ON;

%Create final tab
FinalTab=[tabOFF;tabON];
FinalTab(:,[2 3])=[];
FinalTab = sortrows(FinalTab,'Subject','ascend');
FinalTab=FinalTab(:,[1 3 5 2 4]);
FinalTab.Levodopa=char(FinalTab.Levodopa);

%Convert final table into final structure
Struct=table2struct(FinalTab);

end