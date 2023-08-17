%% DATA PREPARATION
% Inizialize script
clearvars, close all
cd('D:\Profile\qse\files\projects\sijia_sulphurization')
addpath(genpath('scr'))

%% 3 Spin systems
for jj = 49:49
    format long
    pathLoad = strcat("data/processed/gm-e1-000", string(jj), ".mat");
    load(pathLoad);

    pp = data.Fit.pfit;
    dpp = data.Fit.pstd;
    pnames = data.Fit.pnames;

    fileID = fopen(strcat('temp/temp_gm-e1-000', string(jj), '.txt'), 'w');

    fprintf(fileID, '\t & %12s & %12s & %12s \\\\ \n\n', ...
        'Low field syst.', 'Medium field syst.', 'High field syst.');
    
    containsParam = contains(pnames, '.g');
    param = pp(containsParam);
    dparam = dpp(containsParam);
    fprintf(fileID, '%6s & %.5f & %.5f & %.5f \\\\ \n', ...
        'g', param);
    fprintf(fileID, '%6s & %.5f & %.5f & %.5f \\\\ \n', ...
        'dg', dparam);

    containsParam = contains(pnames, '.lwpp');
    param = pp(containsParam);
    dparam = dpp(containsParam);
    fprintf(fileID, '%6s & %.5f %.2f & %.3f & %.1f %.2f\\\\ \n', ...
        'lwpp', param);
    fprintf(fileID, '%6s & %.5f %.2f & %.3f & %.1f %.2f\\\\ \n', ...
        'dlwpp', dparam);

    % fprintf(fileID,'%6.2f %12.8f\n',A);
    fclose(fileID);
end
%%
for jj = 1:numel(temp)
    disp('\n')
    disp(temp(jj).data.filename)
    disp(temp(jj).data.Metadata)
    disp('\n')
end

%{
temp(9).data.Metadata.sample = temp(2).data.Metadata.sample;
temp(9).data.Metadata.sample_ID = temp(2).data.Metadata.sample_ID;
temp(10).data.Metadata.sample = temp(3).data.Metadata.sample;
temp(10).data.Metadata.sample_ID = temp(3).data.Metadata.sample_ID;
temp(11).data.Metadata.sample = temp(4).data.Metadata.sample;
temp(11).data.Metadata.sample_ID = temp(4).data.Metadata.sample_ID;
temp(10).data.Metadata = temp(9).data.Metadata;
temp(11).data.Metadata.sample = temp(3).data.Metadata.sample;
temp(11).data.Metadata.sample_ID = temp(3).data.Metadata.sample_ID;
temp(12).data.Metadata = temp(11).data.Metadata;
temp(13).data.Metadata.sample_ID = temp(4).data.Metadata.sample_ID;
temp(13).data.Metadata.sample = temp(4).data.Metadata.sample;
temp(14).data.Metadata = temp(13).data.Metadata;
temp(15).data.Metadata = temp(8).data.Metadata;
%}