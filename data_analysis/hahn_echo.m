clearvars, clc
% Path to the project folder
chdir('D:\Profile\qse\files\projects\sijia_sulphurization');

%%  B0_set = 3476.56, B0_TM = 3479.90

pathLoad = 'data/processed/gm002011.mat';
load(pathLoad)

clf
load("plotColors.mat")
plot(data.x, real(data.DataPrep.yRaw), 'Color', plotColors(1), ...
    'DisplayName', 'Exp. data real')
hold on
plot(data.x, data.Fit{1}.fit, 'Color', plotColors(2), 'HandleVisibility', 'off')
plot(data.x, imag(data.DataPrep.yRaw), 'Color', plotColors(3), ...
    'DisplayName', 'Exp. data imag')
plot(data.x, data.Fit{2}.fit, 'Color', plotColors(2), 'HandleVisibility', 'off')
plot(data.x, real(data.y), 'Color', plotColors(4), ...
    'DisplayName', 'Subtracted real')
plot(data.x, data.Fit{3}.fit, 'Color', plotColors(2), 'HandleVisibility', 'off')
plot(data.x, imag(data.y), 'Color', plotColors(5), ...
    'DisplayName', 'Subtracted imag')
plot(data.x, data.Fit{4}.fit, 'Color', plotColors(2), 'DisplayName', 'Fit')
plot(data.x, real(data.DataPrep.OffResonance.y), 'LineStyle', '-', ...
    'Color', plotColors(end), 'DisplayName', 'Off resonance real')
plot(data.x, imag(data.DataPrep.OffResonance.y), 'LineStyle', '--', ...
    'Color', plotColors(end), 'DisplayName', 'Off resonance imag')

% xlim(setaxlim(meas{1}.gAx, -0.3))
% ylim(setaxlim(meas{1}.y(:, 25), 0.05))
% set(gca, 'Xdir', 'reverse')
labelaxesfig(gca, 'Time / ns', 'Hahn echo intensity / A.U.')
legend()
% savefigas(gcf, 'figures/hahn_echo_01.svg')

%%  B0_set = 3478.02, B0_TM = 3481.40

pathLoad = 'data/processed/gm002012.mat';
load(pathLoad)

clf
load("plotColors.mat")
plot(data.x, real(data.DataPrep.yRaw), 'Color', plotColors(1), ...
    'DisplayName', 'Exp. data real')
hold on
plot(data.x, data.Fit{1}.fit, 'Color', plotColors(2), 'HandleVisibility', 'off')
plot(data.x, imag(data.DataPrep.yRaw), 'Color', plotColors(3), ...
    'DisplayName', 'Exp. data imag')
plot(data.x, data.Fit{2}.fit, 'Color', plotColors(2), 'HandleVisibility', 'off')
plot(data.x, real(data.y), 'Color', plotColors(4), ...
    'DisplayName', 'Subtracted real')
plot(data.x, data.Fit{3}.fit, 'Color', plotColors(2), 'HandleVisibility', 'off')
plot(data.x, imag(data.y), 'Color', plotColors(5), ...
    'DisplayName', 'Subtracted imag')
plot(data.x, data.Fit{4}.fit, 'Color', plotColors(2), 'DisplayName', 'Fit')
plot(data.x, real(data.DataPrep.OffResonance.y), 'LineStyle', '-', ...
    'Color', plotColors(end), 'DisplayName', 'Off resonance real')
plot(data.x, imag(data.DataPrep.OffResonance.y), 'LineStyle', '--', ...
    'Color', plotColors(end), 'DisplayName', 'Off resonance imag')

% xlim(setaxlim(meas{1}.gAx, -0.3))
% ylim(setaxlim(meas{1}.y(:, 25), 0.05))
% set(gca, 'Xdir', 'reverse')
labelaxesfig(gca, 'Time / ns', 'Hahn echo intensity / A.U.')
legend()
% savefigas(gcf, 'figures/hahn_echo_02.svg')

%%  B0_set = 3474.02, B0_TM = 3477.40

pathLoad = 'data/processed/gm002013.mat';
load(pathLoad)

clf
load("plotColors.mat")
plot(data.x, real(data.DataPrep.yRaw), 'Color', plotColors(1), ...
    'DisplayName', 'Exp. data real')
hold on
plot(data.x, data.Fit{1}.fit, 'Color', plotColors(2), 'HandleVisibility', 'off')
plot(data.x, imag(data.DataPrep.yRaw), 'Color', plotColors(3), ...
    'DisplayName', 'Exp. data imag')
plot(data.x, data.Fit{2}.fit, 'Color', plotColors(2), 'HandleVisibility', 'off')
plot(data.x, real(data.y), 'Color', plotColors(4), ...
    'DisplayName', 'Subtracted real')
plot(data.x, data.Fit{3}.fit, 'Color', plotColors(2), 'HandleVisibility', 'off')
plot(data.x, imag(data.y), 'Color', plotColors(5), ...
    'DisplayName', 'Subtracted imag')
plot(data.x, data.Fit{4}.fit, 'Color', plotColors(2), 'DisplayName', 'Fit')
plot(data.x, real(data.DataPrep.OffResonance.y), 'LineStyle', '-', ...
    'Color', plotColors(end), 'DisplayName', 'Off resonance real')
plot(data.x, imag(data.DataPrep.OffResonance.y), 'LineStyle', '--', ...
    'Color', plotColors(end), 'DisplayName', 'Off resonance imag')

% xlim(setaxlim(meas{1}.gAx, -0.3))
% ylim(setaxlim(meas{1}.y(:, 25), 0.05))
% set(gca, 'Xdir', 'reverse')
labelaxesfig(gca, 'Time / ns', 'Hahn echo intensity / A.U.')
legend()
% savefigas(gcf, 'figures/hahn_echo_03.svg')

%%  B0_set = 3470.45, B0_TM = 3473.90

pathLoad = 'data/processed/gm002014.mat';
load(pathLoad)

clf
load("plotColors.mat")
plot(data.x, real(data.DataPrep.yRaw), 'Color', plotColors(1), ...
    'DisplayName', 'Exp. data real')
hold on
plot(data.x, data.Fit{1}.fit, 'Color', plotColors(2), 'HandleVisibility', 'off')
plot(data.x, imag(data.DataPrep.yRaw), 'Color', plotColors(3), ...
    'DisplayName', 'Exp. data imag')
plot(data.x, data.Fit{2}.fit, 'Color', plotColors(2), 'HandleVisibility', 'off')
plot(data.x, real(data.y), 'Color', plotColors(4), ...
    'DisplayName', 'Subtracted real')
plot(data.x, data.Fit{3}.fit, 'Color', plotColors(2), 'HandleVisibility', 'off')
plot(data.x, imag(data.y), 'Color', plotColors(5), ...
    'DisplayName', 'Subtracted imag')
plot(data.x, data.Fit{4}.fit, 'Color', plotColors(2), 'DisplayName', 'Fit')
plot(data.x, real(data.DataPrep.OffResonance.y), 'LineStyle', '-', ...
    'Color', plotColors(end), 'DisplayName', 'Off resonance real')
plot(data.x, imag(data.DataPrep.OffResonance.y), 'LineStyle', '--', ...
    'Color', plotColors(end), 'DisplayName', 'Off resonance imag')

% xlim(setaxlim(meas{1}.gAx, -0.3))
% ylim(setaxlim(meas{1}.y(:, 25), 0.05))
% set(gca, 'Xdir', 'reverse')
labelaxesfig(gca, 'Time / ns', 'Hahn echo intensity / A.U.')
legend()
% savefigas(gcf, 'figures/hahn_echo_04.svg')