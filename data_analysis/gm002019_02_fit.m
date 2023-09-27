clearvars, clc
% Path to the project folder
chdir('D:\Profile\qse\files\projects\sijia_sulphurization');
 
pathFile = 'data/processed/gm002019.mat';
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
for jj = 1:61
    yData = data.y(:, jj);
    Fit{jj} = esfit(yData, @pepper, {Sys, Exp}, {SysVary}, FitOpt);
    [Fit{jj}.yFit, Fit{jj}.SysBest] = simulatecomponentsfit(Fit{jj});
    figure(jj)
    plot(data.x, yData, data.x, Fit{jj}.fit, data.x, ...
        Fit{jj}.yFit(1, :), data.x, Fit{jj}.yFit(2, :))
end
data.Fit = Fit;
saveintomat(pathFile, data, false)

%%

for ii = 1:numel(data.Fit)
    g1(ii) = data.Fit{ii}.pfit(1);
    g2(ii) = data.Fit{ii}.pfit(4);
end
plot(1:61, g1, 'o-', 1:61, g2, 'o-')

%%
for ii = 1:numel(data.Fit)
    weightto(ii) = data.Fit{ii}.pfit(end);
end
plot(1:61, weightto)

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