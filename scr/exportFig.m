function [] = exportFig(fig, SFolder, SName, extension, varargin)
% ADD DOCUMENTATION
if isempty(extension)
    extension = '.png';
elseif ~contains(extension, '.')
    extension = ['.', char(extension)];
end

if isempty(varargin)
    exportStr = input(...
        sprintf("Export graph in %s? Type 'y' to export\n", ...
        extension), ...
        's');
else
    exportStr = input(...
        sprintf("Export %s graph in %s? Type 'y' to export\n", ...
        varargin{:}, extension), ...
        's');
end

if strcmp(exportStr, 'y')
    FilePath = [char(SFolder), '\', char(SName), char(extension)];
    if isfile(FilePath)
        exportStr = input(...
            sprintf(...
            "There is already an existing file named %s\n" + ...
            "in folder %s.\nExport anyway? Type 'y' to export\n", ...
            [char(SName), char(extension)], strrep(SFolder, '\', '\\') ...
            ), ...
            's');
        if ~strcmp(exportStr, 'y')
            disp('Graphics not exported')
            return
        end
    end
    saveas(fig, FilePath);
else
    disp('Graphics not exported')
end
end

