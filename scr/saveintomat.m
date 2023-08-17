function [] = saveintomat(path, data, overwrite)
% saveintomat      Save into .mat file.
%
% saveintomat(path, data, overwrite)
%
% Input:
%   path        path where to save the data
%   data        structure with data
%   overwrite   boolean, if true and there is a file with the same name
%               in the folder, it overwrites the file in the path (default
%               false)

arguments
    path
    data
    overwrite = false
end

[fileFolder, fileName, ~] = fileparts(path);
pathSave = fullfile(fileFolder, strcat(fileName, '.mat'));

if ~overwrite
    while isfile(pathSave)
        dirFolder = dir(fileFolder);
        [~, fileName, ~] = fileparts(pathSave);
        pathSave = fullfile(fileFolder, strcat(fileName, '_new.mat'));
        warning(strcat("The .mat file was saved with another name because " + ...
            "a file with the same name already exists in the folder:" + ...
            newline, dirFolder(1).folder))
    end
end

save(pathSave, 'data', '-mat');
end