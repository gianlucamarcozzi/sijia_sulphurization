clearvars, clc
% Path to the project folder
chdir('D:\Profile\qse\files\projects\sijia_sulphurization');
 
pathFile = {'data/processed/gm-e1-00034.mat', ...
    'data/processed/gm-e1-00038.mat', ... 
    'data/processed/gm002001.mat', 'data/processed/gm002017.mat'};
for jj = 1:numel(pathFile)
    load(pathFile{jj})
    meas(jj) = data;
end
for jj = 1:numel(pathFile)
    meas(jj).gAx = planck*meas(jj).Params.MWFQ/bmagn./meas(jj).x*1000;
    % meas(jj).gAx = flip(meas(jj).gAx);
end

for jj = 1:numel(pathFile)
    meas(jj).Fit.pfit
    meas(jj).Params.QValue
end

%%
load("plotColors.mat")
clf
plot(meas(1).gAx, meas(1).y, 'Color', plotColors(1))
hold on
plot(meas(2).gAx, meas(2).y, 'Color', plotColors(2))
plot(meas(3).gAx, meas(3).y, 'Color', plotColors(3))
plot(meas(4).gAx, meas(4).y, 'Color', plotColors(4))
hold off

xlim([1.99 2.02])
ylim(setaxlim(meas(3).y, 0.05))
set(gca, 'Xdir', 'reverse')
labelaxesfig(gca, 'g-value', 'EPR signal / A.U.')
legend('Aug. 8th', 'Aug. 9th', 'Sept. 20th', 'Sept. 21st')
annotation("arrow", [0.41, 0.41], [0.8, 0.65], 'Color', 'k')
annotation("arrow", [0.59, 0.59], [0.8, 0.7], 'Color', 'r')
annotation("arrow", [0.6, 0.6], [0.7, 0.87], 'Color', 'r')
annotation("arrow", [0.28, 0.28], [0.6, 0.7], 'Color', '#77AC30')
savefigas(gcf, 'figures/scof005_stability_over_time_01.svg')