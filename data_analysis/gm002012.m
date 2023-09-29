clearvars, clc
cd('D:\Profile\qse\files\projects\sijia_sulphurization')

pathLoad = 'data/raw/gm002015.DTA'; % off resonance
[data.DataPrep.OffResonance.x, data.DataPrep.OffResonance.y, ...
    data.data.DataPrep.OffResonance.Params] = eprload(pathLoad);

pathLoad = 'data/raw/gm002012.DTA'; % on resonance
[data.x, data.DataPrep.yRaw, data.Params] = eprload(pathLoad);

data.y = data.DataPrep.yRaw - data.DataPrep.OffResonance.y;

clf
plot(data.x, real(data.DataPrep.yRaw), data.x, imag(data.DataPrep.yRaw))
hold on
plot(data.x, real(data.DataPrep.OffResonance.y), ...
    data.x, imag(data.DataPrep.OffResonance.y))
plot(data.x, real(data.y), data.x, imag(data.y))
legend('raw', 'raw', 'ring', 'ring', 'diff', 'diff')

%% Add metadata
data.Metadata = struct( ...
    'sample', ...
    'SCOF mixed with PVDF, super P, LiTF SI. Discharged to 2.4 volt', ...
    'sample_ID', 'SCOF010', ...
    'sample_provided_by', 'Sijia Cao', ...
    'sample_provided_on', '2023-09-15', ...
    'spectrometer', 'HZB E580', ...
    'resonator', 'MD5 resonator', ...
    'teslameter_status', 'ON');

%%

expoModelGeneral = @(tt, p) p(1)*exp(-tt/p(2)) + p(3);
expoModel = @(p) expoModelGeneral(data.x, p);
p0 = [5e6, 700, 0];
vary = [2e6, 500, 2e6];
FitOpt.x = data.x;

yDatas{1} = real(data.DataPrep.yRaw);
yDatas{2} = imag(data.DataPrep.yRaw);
yDatas{3} = real(data.y);
yDatas{4} = imag(data.y);

yDataDescriptions = {'real(data.DataPrep.yRaw)', ...
    'imag(data.DataPrep.yRaw)', 'real(data.y)', 'imag(data.y)'};
for iFit = 1:numel(yDatas)
    Fit{iFit} = esfit(yDatas{iFit}, expoModel, p0, vary, FitOpt);
    Fit{iFit}.yDataDescription = yDataDescriptions{iFit};
end

data.Fit = Fit;

[~, fileName, fileExt] = fileparts(pathLoad);
pathSave = fullfile("data/processed", strcat(fileName, '.mat'));
saveintomat(pathSave, data, false)
