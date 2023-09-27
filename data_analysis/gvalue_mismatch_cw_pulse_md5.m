clearvars, clc
% Path to the project folder
chdir('D:\Profile\qse\files\projects\sijia_sulphurization');
 
pathFile = {'data/processed/gm002009.mat', 'data/processed/gm002010.mat'};
for jj = 1:numel(pathFile)
    load(pathFile{jj})
    meas{jj} = data;
end
for jj = 1:numel(pathFile)
    meas{jj}.gAx = planck*meas{jj}.Params.MWFQ/bmagn./meas{jj}.x*1000;
end

for jj = 1:numel(pathFile)
    meas{jj}.Fit.pfit
    meas{jj}.Params.QValue
end

%%
load("plotColors.mat")

clf
tL = tiledlayout(2, 1, "TileSpacing", "none");

nexttile
ySmooth = datasmooth(meas{1}.y, 8, 'savgol');
plot(meas{1}.gAx, ySmooth, 'Color', plotColors(1))
hold on
plot(meas{1}.gAx, meas{1}.Fit.fit, 'Color', plotColors(2))
plot(meas{1}.gAx, meas{1}.Fit.yFit(1, :), 'Color', plotColors(3))
plot(meas{1}.gAx, meas{1}.Fit.yFit(2, :), 'Color', plotColors(4))
xlim([1.99 2.02])
set(gca, 'Xdir', 'reverse')
ylim(setaxlim(ySmooth, 0.05))
xticks([1.995, 2, 2.005, 2.01, 2.015])
yticks(0)

nexttile
yPlot = meas{2}.y/max(meas{2}.y);
plot(meas{2}.gAx, yPlot, 'Color', plotColors(1))
hold on
plot(meas{2}.gAx, meas{2}.Fit.fit, 'Color', plotColors(2))
plot(meas{2}.gAx, meas{2}.Fit.yFit(1, :), 'Color', plotColors(3))
plot(meas{2}.gAx, meas{2}.Fit.yFit(2, :), 'Color', plotColors(4))
xlim([1.99 2.02])
set(gca, 'Xdir', 'reverse')
ylim(setaxlim(yPlot, 0.05))
yticks(0)

xlim([1.99 2.02])
legend({'Data', 'Fit', 'Sys 1', 'Sys2'})
labelaxesfig(tL, 'g-value', 'EPR signal / A.U.')

savefigas(gcf, 'figures/gvalue_mismatch_cw_pulse_md5_01.svg')