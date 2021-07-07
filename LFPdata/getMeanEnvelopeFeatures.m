function stats=getMeanEnvelopeFeatures(features)
%Function to calculate the mean and the standard error of the mean of the
%two envelope features (PSD and PDF); this variation does not distinguish
%between left and right hemisphere. 
%Inputs:
%features -> struct containing envelope features.

tab=struct2table(rmfield(features,{'Subject','Side','SR','PSDRawData','PSDFiltData','Envelope','Perc'}));%Convert struct features into reduced table

stats=grpstats(tab,{'Levodopa'},{'mean','sem'}); %Compute statistics (mean and SEM)


end