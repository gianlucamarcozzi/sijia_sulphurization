clearvars, clc
cd('D:\Profile\qse\files\projects\sijia_sulphurization')

pathLoad = 'data/raw/gm002018.DTA';

data = eprloadstructure(pathLoad);
data.DataPrep.Opt.pathLoad = pathLoad;
[~, nSpectrum] = size(data.DataPrep.yRaw);

tmp = load("data\processed\gm002019.mat");

plot(data.DataPrep.xRaw, data.DataPrep.yRaw, ...
    tmp.data.DataPrep.xRaw{1, 1}, tmp.data.DataPrep.yRaw(:, 25))
yyaxis right
plot(data.DataPrep.xRaw, cumtrapz(cumtrapz(data.DataPrep.yRaw)), ...
    tmp.data.DataPrep.xRaw{1, 1}, 4100/3900*cumtrapz(cumtrapz(tmp.data.DataPrep.yRaw(:, 25))))

figure(2)
plot(data.DataPrep.xRaw, imag(data.DataPrep.yRaw), ...
    tmp.data.DataPrep.xRaw{1, 1}, imag(tmp.data.DataPrep.yRaw(:, 25)))
yyaxis right
plot(data.DataPrep.xRaw, imag(cumtrapz(cumtrapz(data.DataPrep.yRaw))), ...
    tmp.data.DataPrep.xRaw{1, 1}, imag(cumtrapz(cumtrapz(tmp.data.DataPrep.yRaw(:, 25)))))
% Qvalue of 