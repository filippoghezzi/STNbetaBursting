function cost=CostFunction_First(par,dataFeatures,filename)
%Calculate objective function (cost) comparing data features in input and 
%model simulation according to parameters in input.
%Input:
%par -> parameter vector [sigma,wGS,wSG,wGG,wXG,wCS];
%dataFeatures -> data features structure;
%filename -> name of the file where results are saved.
%Output:
%cost -> result of the objective function

%Perform model simulation and obtain model features
modelFeatures=getModelFeatures_First(par,0);

%Calculate single cost term and final cost
cost1=sum((dataFeatures.PSDsignalD-modelFeatures.PSDsignalM).^2)/sum((dataFeatures.PSDsignalD-mean(dataFeatures.PSDsignalD)).^2);
cost5=sum((dataFeatures.BurstDurationD-modelFeatures.BurstDurationM).^2)/sum((dataFeatures.BurstDurationD-mean(dataFeatures.BurstDurationD)).^2);
cost=cost1/2+cost5/2;

%Save result in filename
fileID = fopen(filename,'a');
fprintf(fileID,'%.10f %.10f %.10f %.10f %.10f %.10f %.10f %.10f \r\n',par(1),par(2),par(3),par(4),par(5),par(6),par(7),cost);
fclose(fileID);

end