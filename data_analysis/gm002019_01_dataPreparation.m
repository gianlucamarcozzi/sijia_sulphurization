clearvars, clc
cd('D:\Profile\qse\files\projects\sijia_sulphurization')

%% Import
pathLoad = 'data/raw/gm002019.DTA';

data = eprloadstructure(pathLoad);
data.DataPrep.Opt.pathLoad = pathLoad;
data.mwpw = data.DataPrep.xRaw{1, 2};
[~, nSpectrum] = size(data.DataPrep.yRaw);

%% Add metadata
data.Metadata = struct( ...
    'sample', ...
    'SCOF mixed with PVDF, super P, LiTF SI. Discharged to 2.8 volt', ...
    'sample_ID', 'SCOF011', ...
    'sample_provided_by', 'Sijia Cao', ...
    'sample_provided_on', '2023-09-15', ...
    'spectrometer', 'HZB E580', ...
    'resonator', 'SHQ X-band resonator', ...
    'teslameter_status', 'ON');

%% Field calibration and conversion to mT
% Field offset from calibration_resonator.m.
xAxisCalibOpt.xOff = 0.0164; % mT
xAxisCalibOpt.gauss2mt = 'true';

data.x = calibratexaxis(data.DataPrep.xRaw{1, 1}, xAxisCalibOpt);
% Store in structure.
data.DataPrep.Opt.xAxisCalib = xAxisCalibOpt;

%% Subtract baseline
BaselineCorrectionOpt.order = 1;
BaselineCorrectionOpt.width = 0.15;

for ii = 1:nSpectrum
    [yBaselineCorrected, baseline] = ...
        subtractbaseline(data.x', data.DataPrep.yRaw(:, ii), ...
        BaselineCorrectionOpt);

    data.DataPrep.yBaselineCorrected(:, ii) = yBaselineCorrected;
    data.DataPrep.baseline(:, ii) = baseline;
    data.DataPrep.Opt.BaselineCorrection = BaselineCorrectionOpt;
end
for ii = 1:nSpectrum
    plot(data.x, data.DataPrep.yBaselineCorrected(:, ii))
    hold on
end

%% Correct phase
PhaseCorrectionOpt = 'Maximum';
for ii = 1:nSpectrum
    [yBaselinePhaseCorrected, ...
        phase] = correctphase(data.DataPrep.yBaselineCorrected(:, ii), ...
                    PhaseCorrectionOpt);

    data.DataPrep.yBaselinePhaseCorrected(:, ii) = ...
        yBaselinePhaseCorrected;
    data.DataPrep.PhaseCorrection.phase(ii) = phase;
    data.DataPrep.Opt.PhaseCorrection = PhaseCorrectionOpt;
end

%% Assign y value
% Choose between yRaw, yBaselineCorrected or yBaselinePhaseCorrected.
% The array y must be non-complex.
data.y = real(data.DataPrep.yBaselineCorrected);

%%
h = ScrollableAxes();
slider = 1:numel(data.mwpw);
plot(h, data.x, data.mwpw, data.y')

%% Save into mat
pathSave = 'data/processed/gm002019.mat';
saveintomat(pathSave, data, false)