function stats=getMeanEnvelopeFeatures_RandL(features)
%Function to calculate the mean and the standard error of the mean of the
%two envelope features (PSD and PDF) and plot them.
%Inputs:
%features -> struct containing envelope features.

tab=struct2table(rmfield(features,{'Subject','SR','PSDFiltData','Envelope','Perc75'}));%Convert struct features into reduced table

stats=grpstats(tab,{'Levodopa','Side'},{'mean','sem'}); %Compute statistics (mean and SEM)

end