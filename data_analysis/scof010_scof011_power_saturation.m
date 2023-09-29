clearvars, clc
% Path to the project folder
chdir('D:\Profile\qse\files\projects\sijia_sulphurization');
 
pathFile = {'data/processed/gm002003.mat', 'data/processed/gm002019.mat'};
for jj = 1:numel(pathFile)
    load(pathFile{jj})
    meas{jj} = data;
end

%%

for jj = 1:numel(meas)
    meas{jj}.gAx = planck*meas{jj}.Params.MWFQ/bmagn./meas{jj}.x*1000;
end

clf
load("plotColors.mat")
plot(meas{1}.gAx, meas{1}.y(:, 25), 'Color', plotColors(1))
hold on
plot(meas{1}.gAx, meas{1}.Fit{25}.fit, 'Color', plotColors(2))
plot(meas{1}.gAx, meas{1}.Fit{25}.yFit(1, :), 'Color', plotColors(3))
plot(meas{1}.gAx, meas{1}.Fit{25}.yFit(2, :), 'Color', plotColors(4))
xlim(setaxlim(meas{1}.gAx, -0.3))
ylim(setaxlim(meas{1}.y(:, 25), 0.05))
set(gca, 'Xdir', 'reverse')
labelaxesfig(gca, 'g-value', 'EPR signal / A.U.')
legend('Exp. data', 'Fit', 'Sys 1', 'Sys 2')
savefigas(gcf, 'figures/scof010_scof011_power_saturation_05.svg')

%%

clf
load("plotColors.mat")
plot(meas{2}.gAx, meas{2}.y(:, 25), 'Color', plotColors(1))
hold on
plot(meas{2}.gAx, meas{2}.Fit{25}.fit, 'Color', plotColors(2))
plot(meas{2}.gAx, meas{2}.Fit{25}.yFit(1, :), 'Color', plotColors(3))
plot(meas{2}.gAx, meas{2}.Fit{25}.yFit(2, :), 'Color', plotColors(4))
xlim(setaxlim(meas{1}.gAx, -0.3))
ylim(setaxlim(meas{2}.y(:, 25), 0.05))
set(gca, 'Xdir', 'reverse')
labelaxesfig(gca, 'g-value', 'EPR signal / A.U.')
legend('Exp. data', 'Fit', 'Sys 1', 'Sys 2')
savefigas(gcf, 'figures/scof010_scof011_power_saturation_06.svg')

%%

clf
for ii = 1:numel(meas{1}.Fit)
    g11(ii) = meas{1}.Fit{ii}.pfit(1);
    g12(ii) = meas{1}.Fit{ii}.pfit(3);
end
for ii = 1:numel(meas{2}.Fit)
    g21(ii) = meas{2}.Fit{ii}.pfit(1);
    g22(ii) = meas{2}.Fit{ii}.pfit(3);
end
load("plotColors.mat")
plot(0:60, g11 - 2, 'o-', 'Color', plotColors(1))
hold on
plot(0:60, g12 - 2, 'x-', 'Color', plotColors(1))
plot(0:60, g21 - 2, 'o-', 'Color', plotColors(2))
plot(0:60, g22 - 2, 'x-', 'Color', plotColors(2))
xlim([-1, 61])
ylim([2.0024, 2.0051] - 2)
labelaxesfig(gca, 'Microwave attenuation / dB', 'g-value – 2')
% legend('SCOF010 Sys1', 'SCOF010 Sys2', 'SCOF011 Sys1', 'SCOF011 Sys2', ...
%     'Location', 'northwest')
savefigas(gcf, 'figures/scof010_scof011_power_saturation_01.svg')

%%

for ii = 1:numel(data.Fit)
    DI11spectrum = cumtrapz(cumtrapz(meas{1}.Fit{ii}.yFit(1, :)));
    DI12spectrum = cumtrapz(cumtrapz(meas{1}.Fit{ii}.yFit(2, :)));
    DI11(ii) = DI11spectrum(end);
    DI12(ii) = DI12spectrum(end);
    DI21spectrum = cumtrapz(cumtrapz(meas{2}.Fit{ii}.yFit(1, :)));
    DI22spectrum = cumtrapz(cumtrapz(meas{2}.Fit{ii}.yFit(2, :)));
    DI21(ii) = DI21spectrum(end);
    DI22(ii) = DI22spectrum(end);
end

clf
load("plotColors.mat")
plot(meas{1}.mwpw, DI11, 'o-', 'Color', plotColors(1))
hold on
plot(meas{1}.mwpw, DI12, 'x-', 'Color', plotColors(1))
plot(meas{2}.mwpw, DI21, 'o-', 'Color', plotColors(2))
plot(meas{2}.mwpw, DI22, 'x-', 'Color', plotColors(2))
xlim(setaxlim(0:60, 0.01))
ylim([-0.1, 9]*1e4)
labelaxesfig(gca, 'Microwave power / mW', 'Intensity / A.U.')
legend('SCOF010 Sys1', 'SCOF010 Sys2', 'SCOF011 Sys1', 'SCOF011 Sys2', ...
    'Location', 'northwest')
savefigas(gcf, 'figures/scof010_scof011_power_saturation_02.svg')

%%

clf
for ii = 1:numel(meas{1}.Fit)
    lw11(ii) = meas{1}.Fit{ii}.pfit(2);
    lw12(ii) = meas{1}.Fit{ii}.pfit(4);
end
for ii = 1:numel(meas{2}.Fit)
    lw21(ii) = meas{2}.Fit{ii}.pfit(2);
    lw22(ii) = meas{2}.Fit{ii}.pfit(4);
end
load("plotColors.mat")
plot(0:60, lw11, 'o-', 'Color', plotColors(1))
hold on
plot(0:60, lw12, 'x-', 'Color', plotColors(1))
plot(0:60, lw21, 'o-', 'Color', plotColors(2))
plot(0:60, lw22, 'x-', 'Color', plotColors(2))
xlim(setaxlim(0:60, 0.01))
labelaxesfig(gca, 'Microwave attenuation / dB', 'Linewidth pp / mT')
legend('SCOF010 Sys1', 'SCOF010 Sys2', 'SCOF011 Sys1', 'SCOF011 Sys2')
savefigas(gcf, 'figures/scof010_scof011_power_saturation_03.svg')

%%

for ii = 1:numel(data.Fit)
    w1(ii) = meas{1}.Fit{ii}.pfit(end);
    w2(ii) = meas{2}.Fit{ii}.pfit(end);
end

clf
plot(0:60, w1, 'o-', 'Color', plotColors(1))
hold on
plot(0:60, w2, 'o-', 'Color', plotColors(2))
xlim(setaxlim(0:60, 0.01))
labelaxesfig(gca, 'Microwave attenuation / dB', ...
    'Relative intensity of the two peaks')
legend('SCOF010', 'SCOF011')
savefigas(gcf, 'figures/scof010_scof011_power_saturation_04.svg')