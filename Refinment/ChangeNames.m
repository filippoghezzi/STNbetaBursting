%Simple script useful to change optimisation result file names; used when
%optimisation crashed to have only one folder per subject per condition.

clear
close all

% Get all text files in the current folder
files = dir('*.txt');
% Loop through each file
firstFile=7272;
for id = 1:length(files)
    % Get the file name 
    [~, f,ext] = fileparts(files(id).name);
    rename = strcat(int2str(firstFile+id),ext) ; 
    movefile(files(id).name, rename); 
end

