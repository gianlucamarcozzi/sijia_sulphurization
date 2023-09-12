%% DATA PREPARATION
% Inizialize script
clearvars, close all
cd('D:\Profile\qse\files\projects\sijia_sulphurization')
addpath(genpath('scr'))

%% Import
for jj = 
    pathLoad = strcat("data/processed/gm-e1-000", string(jj), ".mat");

    temp(jj - 33) = load(pathLoad);
end
%%
for jj = 1:numel(temp)
    disp('\n')
    disp(temp(jj).data.filename)
    disp(temp(jj).data.Metadata)
    disp('\n')
end

%% Save into mat
for jj = 48
    pathSave = strcat("data/processed/gm-e1-000", string(jj), ".mat");
    data = temp(jj - 33).data;
    saveintomat(pathSave, data, false)
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