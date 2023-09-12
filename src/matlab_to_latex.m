%% DATA PREPARATION
% Inizialize script
clearvars, close all
cd('D:\Profile\qse\files\projects\sijia_sulphurization')
addpath(genpath('scr'))
%%
for jj = 42
    pathLoad = strcat("data/processed/gm-e1-000", string(jj), ".mat");
    load(pathLoad);
    
    filePath = strcat('temp/temp_gm-e1-000', string(jj), '.txt');   
    printFieldArray = ["g", "lwpp", "lwpp", "weight", "weightDI"];
    printFieldArrayAs = ["g", "lwppG", "lwppL", "weight", "weightDI"];
    matlab2latextablefit(filePath, data.Fit, ...
        printFieldArray, printFieldArrayAs);
end
%%
dirPath = dir("temp");
for ii = 3:numel(dirPath)
    textContent{ii - 2} = ...
    fileread(fullfile(dirPath(ii).folder, dirPath(ii).name));
end
fileID = fopen('temp/total.txt', 'w');
for ii = 1:numel(textContent)
    fprintf(fileID, "%d \n \\begin{table} [H] \n \\centering \n \\small" + ...
        "\\begin{tabular}{cccc} \n \\toprule\n", ii+33);
    fprintf(fileID, "%s \n\n", textContent{ii});
    fprintf(fileID,"\\bottomrule \\end{tabular} \\end{table} \n\n\n");
end