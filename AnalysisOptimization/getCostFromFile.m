function [cost, optParams] = getCostFromFile(filename)
% Function to read a single txt file from optimisation process, 
% find minimum cost value and return associated parameters.
% Inputs:
% filename -> name of the file to scan;
% Outputs:
% cost -> minimum cost value;
% optParams -> vector with associated best parameters.

    % open file and get values
    fileID = fopen(filename);
    head = textscan(fileID,'%12s %12s %12s %12s %12s %12s %12s %12s',1);
    values = textscan(fileID,'%.10f %.10f %.10f %.10f %.13f %.10f %.10f %.10f');
    fclose(fileID);
    paramMat=[];
    for i=1:size(values,2)
        paramMat = [paramMat,values{i}];
    end

    %min cost and optimal params
    [~,idx]=min(paramMat(:,end));
    optParams=paramMat(idx,1:end-1);
    cost=paramMat(idx,end);

end