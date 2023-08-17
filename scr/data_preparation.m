%% DATA PREPARATION
% Inizialize script
clearvars, close all
cd('D:\Profile\qse\files\projects\sijia_sulphurization')
addpath(genpath('scr'))

%% Import
for jj = 50
    pathLoad = strcat("data/raw/gm-e1-000", string(jj), ".DTA");

    data = eprloadstructure(pathLoad);
    data.DataPrep.Opt.pathLoad = pathLoad;

    nDatas = numel(pathLoad);
    
    %% Add metadata
    data.Metadata = struct( ...
        'sample', ['SCOF mixed with PVDF, super P, LiTF SI. Discharged ' ...
                  'to 2.2 volt.'], ...
        'sample_ID',  , ...
        'sample_provided_by', 'Sijia Cao', ...
        'sample_provided_on', '2023-08-08', ...
        'spectrometer', 'HZB E580', ...
        'resonator', 'Pulse Q-band resonator', ...
        'dimensions', '1 mm tube diameter, 10mm tube height', ...
        'teslameter_status', 'ON');
    
    %% Field calibration and conversion to mT
    % Field offset: X-band SHQ-cavity, TM on, X-band tube (gm-e1-00018).
    xAxisCalibOpt.xOff = 0.044; % mT
    xAxisCalibOpt.gauss2mt = 'true';
    for ii = 1:nDatas
        data(ii).x = calibratexaxis(data(ii).DataPrep.xRaw, xAxisCalibOpt);
        % Store in structure.
        data(ii).DataPrep.Opt.xAxisCalib = xAxisCalibOpt;
    end
    
    %% Subtract baseline
    BaselineCorrectionOpt.order = 1;
    BaselineCorrectionOpt.width = 0.15;

    for ii = 1:nDatas
        [yBaselineCorrected, baseline] = ...
            subtractbaseline(data(ii).x, data(ii).DataPrep.yRaw, ...
            BaselineCorrectionOpt);
    
        data(ii).DataPrep.yBaselineCorrected = yBaselineCorrected;
        data(ii).DataPrep.baseline = baseline;
        data(ii).DataPrep.Opt.BaselineCorrection = BaselineCorrectionOpt;
    end
    plotbaselinecorrection(data, BaselineCorrectionOpt.width);
    
    %% Correct phase
    PhaseCorrectionOpt = 'Maximum';
    for ii = 1:nDatas
        [yBaselinePhaseCorrected, ...
            phase] = correctphase(data(ii).DataPrep.yBaselineCorrected, ...
                        PhaseCorrectionOpt);
    
        data(ii).DataPrep.yBaselinePhaseCorrected = ...
            yBaselinePhaseCorrected;
        data(ii).DataPrep.PhaseCorrection.phase = phase;
        data(ii).DataPrep.Opt.PhaseCorrection = PhaseCorrectionOpt;
    end
    
    %% Assign y value
    % Choose between yRaw, yBaselineCorrected or yBaselinePhaseCorrected.
    % The array y must be non-complex.
    for ii = 1:nDatas
        data(ii).y = real(data(ii).DataPrep.yBaselineCorrected);
    end
    
    %%
    for ii = 1:nDatas
        figure()
        plot(data.x, data.y)
    end
    
    %% Save into mat
    pathSave = fullfile("data/processed", ...
        "gm-e1-000" + string(jj) + ".mat");
    saveintomat(pathSave, data, false)
end