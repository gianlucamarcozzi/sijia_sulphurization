function [] = savefigas(fig, path, overwrite)
% savefigas      Save fig without automatic overwriting.
%
% saveintomat(path, fig, overwrite)
%
% Input:
%   path        path where to save the data
%   fig         figure or axis to save
%   overwrite   boolean, if true and there is a file with the same name
%               in the folder, it overwrites the file in the path (default
%               false)

arguments
    fig
    path
    overwrite = false
end

[fileFolder, fileName, fileExtension] = fileparts(path);
if isempty(fileExtension)
    fileExt = '.svg';
else
    fileExt = fileExtension;
end
pathSave = fullfile(fileFolder, strcat(fileName, fileExt));

if ~overwrite
    while isfile(pathSave)
        dirFolder = dir(fileFolder);
        [~, fileName, ~] = fileparts(pathSave);
        pathSave = fullfile(fileFolder, strcat(fileName, '_new', fileExt));
        warning(strcat("The file was saved with another name because " + ...
            "a file with the same name already exists in the folder:" + ...
            newline, dirFolder(1).folder))
    end
end

saveas(fig, pathSave);
end