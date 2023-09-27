clearvars, clc
cd('D:\Profile\qse\files\projects\sijia_sulphurization')

pathLoad = 'data/raw/gm002009.DTA';

data = eprloadstructure(pathLoad);
data.DataPrep.Opt.pathLoad = pathLoad;

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

%% Field calibration and conversion to mT
% Field offset from calibration_resonator.m.
xAxisCalibOpt.xOff = -0.0534; % mT
xAxisCalibOpt.gauss2mt = 'true';

data.x = calibratexaxis(data.DataPrep.xRaw, xAxisCalibOpt);
% Store in structure.
data.DataPrep.Opt.xAxisCalib = xAxisCalibOpt;

%% Subtract baseline
BaselineCorrectionOpt.order = 1;
BaselineCorrectionOpt.width = 0.15;

[yBaselineCorrected, baseline] = ...
    subtractbaseline(data.x, data.DataPrep.yRaw, ...
    BaselineCorrectionOpt);

data.DataPrep.yBaselineCorrected = yBaselineCorrected;
data.DataPrep.baseline = baseline;
data.DataPrep.Opt.BaselineCorrection = BaselineCorrectionOpt;

plot(data.x, real(data.DataPrep.yBaselineCorrected))%, ...
    %data.x, imag(data.DataPrep.yBaselineCorrected))

%% Correct phase
PhaseCorrectionOpt = 'Integral';

[yBaselinePhaseCorrected, ...
    phase] = correctphase(data.DataPrep.yBaselineCorrected, ...
                PhaseCorrectionOpt);

data.DataPrep.yBaselinePhaseCorrected = ...
    yBaselinePhaseCorrected;
data.DataPrep.PhaseCorrection.phase = phase;
data.DataPrep.Opt.PhaseCorrection = PhaseCorrectionOpt;

plot(data.x, real(data.DataPrep.yBaselinePhaseCorrected), ...
    data.x, imag(data.DataPrep.yBaselinePhaseCorrected))

%% Assign y value
% Choose between yRaw, yBaselineCorrected or yBaselinePhaseCorrected.
% The array y must be non-complex.
data.y = real(data.DataPrep.yBaselinePhaseCorrected);

%% Save into mat
[~, fileName, fileExt] = fileparts(pathLoad);
pathSave = fullfile("data/processed", strcat(fileName, '.mat'));
saveintomat(pathSave, data, false)