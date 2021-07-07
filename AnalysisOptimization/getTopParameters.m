function optParam=getTopParameters(folderName)
% Function to find the top wanted parameters associated with the best costs by
% reading txt files into a folder.
% Inputs:
% folderName -> folder in which txt files to read are located;
% Outputs:
% optParam -> top wanted parameter matrix (usually 10).


%% Extract cost and parameters from files and sort cost

nLoc=11000;
cost=[];
existingFilesIdx=[];
paramMat=[];

for i=1:nLoc
    filename=[folderName '\' num2str(i) '.txt'];
    if exist(filename, 'file') == 2
        [c, param] = getCostFromFile(filename);
        if ~isempty(c)
            cost=[cost,c];
            paramMat=[paramMat;param];
            existingFilesIdx=[existingFilesIdx,i];
        end
    end
end

[sortedCost,ii]=sort(cost);
idx=existingFilesIdx(ii);

%% Extract top(rankToRead) parameters in optParam
rankToRead=10;
optParam=[];
for rank=1:rankToRead
    optParam=[optParam;paramMat(ii(rank),:)];
end

end