%% Fit
clearvars; close all
% Path to the project folder
chdir('D:\Profile\qse\files\projects\sijia_sulphurization');
% Add source file directory
addpath(genpath('scr'));

for jj = 49:50
    pathFile = strcat("data/processed/gm-e1-000", string(jj), ".mat");
    load(pathFile);
    
    % Fit 2 spin systems
    Sys0 = struct('g', 2.0034, ...
        'lwpp', [1 0.2]);
    Sys1 = struct('g', 2.0052, ...
        'lwpp', [1 0.5], ...
        'weight', 1.2);
    Sys2 = struct('g', 2.008, ...
        'lwpp', [0.6 0.6], ...
        'weight', 0.7);
    
    
    Vary0 = struct('g', .005, ...
        'lwpp', Sys0.lwpp);
    Vary1 = struct('g', .005, ...
        'lwpp', Sys1.lwpp, ...
        'weight', 1);
    Vary2 = struct('g', .005, ...
        'lwpp', Sys2.lwpp, ...
        'weight', 1);
    
    % Define x and y
    Exp.Range = [min(data.x) max(data.x)];
    Exp.mwFreq = data.Params.MWFQ*1e-9;
    Exp.nPoints = numel(data.x);
    Exp.Harmonic = 0;

    % Disregard low field peak g ~ 2.0065
    % FitOpt.mask = (1:numel(x) < 195) | (1:numel(x) > 378);
    FitOpt.BaseLine = [];
    
    Sys = {Sys0, Sys1, Sys2};
    SysVary = {Vary0, Vary1, Vary2};
    % Sys = {Sys0, Sys1};
    % SysVary = {Vary0, Vary1};
    % Sys = {Sys0};
    % SysVary = {Vary0};
    
    % Fit = esfit(yy, @pepper, {{Sys1, Sys2, Sys3}, Exp}, {{Vary1, Vary2, Vary3}}, FitOpt)
    % data.Fit = esfit(data.y, @pepper, {Sys, Exp}, {SysVary}, FitOpt);
        
    [data.Fit.yFit, data.Fit.SysBest] = simulatecomponentsfit(data.Fit);

    figure()
    plot(data.x, data.y)
    hold on
    plot(data.x, data.Fit.fit)
    for isys = 1:numel(data.Fit.yFit(:, 1))
        yFit_ = data.Fit.yFit(isys, :);
        plot(data.x, yFit_)
    end

    saveintomat(pathFile, data, true)
    % fprintf('%f +- %e\n', data.Fit.pfit(1), data.Fit.pstd(1))
end

%% Calculate weights
%{
From the weights parameters of esfit, calculate the weigths u1 and u2 that summed are equal to 1.
format long
w1 = 1; % dw1 = 0
w2 = Fit.pfit(5); % Check if pfit(5) is a weight
dw2 = Fit.pstd(5);
u1 = w1/(w1 + w2)
du1 = w1/((w1 + w2)^2) * dw2
u2 = w2/(w1 + w2)
du2 = (w1 + 2*w2)/((w1 + w2)^2) * dw2
The value obtained from u2 is extremely small!
Follows the same calculation but from the double integral:
DI1 = cumtrapz(cumtrapz(yFit(1, :)));
DI2 = cumtrapz(cumtrapz(yFit(2, :)));
w1 = DI1(end);
w2 = DI2(end);
u1DI = w1/(w1 + w2)
u2DI = w2/(w1 + w2)
These make more sense, but how to extract uncertainty?
fprintf(['g1 = %.5f +- %.5f\n', ...
    'lwpp1 = %.2f +- %.2f\n', ...
    'weight1 = %f +- ?\n' ...
    'g2 = %.5f +- %.5f\n' ...
    'lwpp2 = %.2f +- %.2f\n', ...
    'weight2 = %f +- ?'], ...
    [Fit.pfit(1), Fit.pstd(1), ...
     Fit.pfit(2), Fit.pstd(2), ...
     u1DI, ...
     Fit.pfit(3), Fit.pstd(3), ...
     Fit.pfit(4), Fit.pstd(4), ...
     u2DI])

Fit 3 spin systems
ICW = 5;
Sys0 = struct('g', 2.0046, ...
    'lwpp', [0. 1.1239]);
Sys1 = struct('g', 2.003, ...
    'lwpp', [0.8397 0.], ...
    'weight', 2.6355e-5);
Sys2 =  struct('g', 2.0065, ...
    'lwpp', [0.8397 0.5], ...
    'weight', 0.0005);

Vary0 = struct('g', .005, ...
    'lwpp', Sys0.lwpp);
Vary1 = struct('g', .005, ...
    'lwpp', Sys1.lwpp, ...
    'weight', 1);
Vary2 = struct('g', .005, ...
    'lwpp', Sys2.lwpp, ...
    'weight', 1);

Exp.Range = [min(cw(ICW).x) max(cw(ICW).x)];
Exp.mwFreq = cw(ICW).Params.MWFQ*1e-9;
Exp.nPoints = numel(cw(ICW).x);

MaskL = 1:numel(cw(ICW).x) < 195;
MaskR = 1:numel(cw(ICW).x) > 378;
Mask = logical(MaskL + MaskR);
FitOpt.mask = Mask;

Sys = {Sys0, Sys1, Sys2};
SysVary = {Vary0, Vary1, Vary2};

% Fit = esfit(yy, @pepper, {{Sys1, Sys2, Sys3}, Exp}, {{Vary1, Vary2, Vary3}}, FitOpt)
esfit(-real(cw(ICW).y2), @pepper, {Sys, Exp}, {SysVary}, FitOpt);
%}