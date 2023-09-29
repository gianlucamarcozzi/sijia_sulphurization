clearvars, close all
cd('D:\Profile\qse\files\projects\sijia_sulphurization')

fileNo = ["09", "10"];
for jjNo = 1:2 %numel(fileNo)
    jj = fileNo(jjNo);
    pathLoad = strcat("data/processed/gm0020", string(jj), ".mat");
    load(pathLoad);
    
    filePath = strcat('temp/temp_gm0020', string(jj), '.txt');   
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