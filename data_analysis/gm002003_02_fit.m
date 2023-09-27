clearvars, clc
% Path to the project folder
chdir('D:\Profile\qse\files\projects\sijia_sulphurization');
 
pathFile = 'data/processed/gm002003.mat';
load(pathFile);

%%

% Fit 
Sys0 = struct('g', 2.0026, ...
    'lwpp', [0. 0.3]);
Sys1 = struct('g', 2.0043, ...
    'lwpp', [0. 0.5], ...
    'weight', 0.5);
Sys2 = struct('g', 2.0066, ...
    'lwpp', [1 0.1], ...
    'weight', 0.9);
Sys3 = struct('g', 2.0135, ...
    'lwpp', [0.4 0.03], ...
    'weight', 0.015);

Vary0 = struct('g', .005, ...
    'lwpp', 0.97*Sys0.lwpp);
Vary1 = struct('g', .005, ...
    'lwpp', 0.97*Sys1.lwpp, ...
    'weight', 1);
Vary2 = struct('g', .005, ...
    'lwpp', [0.9 0.08], ...
    'weight', 1);
Vary3 = struct('g', .005, ...
    'lwpp', [0.38 0.01], ...
    'weight', 1);

% Define x and y
Exp.Range = [min(data.x) max(data.x)];
Exp.mwFreq = data.Params.MWFQ*1e-9;
Exp.nPoints = numel(data.x);

% Disregard low field peak g ~ 2.0065
% FitOpt.mask = (1:numel(x) < 195) | (1:numel(x) > 378);
FitOpt.BaseLine = [];

% Sys = {Sys0, Sys1, Sys2};
% SysVary = {Vary0, Vary1, Vary2};
% Sys = {Sys0, Sys1, Sys2, Sys3};
% SysVary = {Vary0, Vary1, Vary2, Vary3};
Sys = {Sys0, Sys1};
SysVary = {Vary0, Vary1};
% Sys = {Sys0};
% SysVary = {Vary0};

% Fit = esfit(yy, @pepper, {{Sys1, Sys2, Sys3}, Exp}, {{Vary1, Vary2, Vary3}}, FitOpt)
% for jj = 1:numel(data.y(1, :))
for jj = 1:14
    yData = data.y(:, jj);
    Fit{jj} = esfit(yData, @pepper, {Sys, Exp}, {SysVary}, FitOpt);
    [Fit{jj}.yFit, Fit{jj}.SysBest] = simulatecomponentsfit(Fit{jj});
    figure(jj)
    clf
    plot(data.x, yData, data.x, Fit{jj}.fit, data.x, ...
        Fit{jj}.yFit(1, :), data.x, Fit{jj}.yFit(2, :))
    fitResults = sprintf("%f\n%f\n%f\n%f\n%f\n%f\n%f", ...
        Fit{jj}.pfit(1), Fit{jj}.pfit(2), Fit{jj}.pfit(3), ...
        Fit{jj}.pfit(4), Fit{jj}.pfit(5));
    % fitResults = sprintf("%f\n%f", Fit{jj}.pfit(2), ...
    %     Fit{jj}.pfit(4));
    annotation("textbox", [0.2 0.25 0.5 0.5], "FitBoxToText", "on", ...
        "Units","normalized", "String", fitResults)
end
data.Fit = Fit;
saveintomat(pathFile, data, false)