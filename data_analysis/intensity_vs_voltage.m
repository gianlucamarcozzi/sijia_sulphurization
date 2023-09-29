clearvars, clc
% Path to the project folder
chdir('D:\Profile\qse\files\projects\sijia_sulphurization');

pathFile = {'data/processed/gm-e1-00034.mat', ...
    'data/processed/gm-e1-00035.mat', 'data/processed/gm-e1-00036.mat', ...
    'data/processed/gm-e1-00037.mat'};
nLoad = numel(pathFile);
pathFile1 = {'data/processed/gm002003.mat', 'data/processed/gm002019.mat'};
nLoad1 = numel(pathFile1);
nSample = nLoad + nLoad1;

for jj = 1:nLoad
    tmp = load(pathFile{jj});
    tmp.data.mwpw = tmp.data.Params.MWPW;
    data(jj) = tmp.data;
end

for jj = 1:2
    tmp = load(pathFile1{jj});
    data(nLoad + jj) = tmp.data;
end

voltage = [2.4, 2.2, 2.08, 1.7, 2.4, 2.8];
for jj = 1:nSample
    data(jj).voltage = voltage(jj);
end

tmpT = struct2table(data); % convert the struct array to a table
sortedT = sortrows(tmpT, 'voltage'); % sort the table by 'voltage'
data = table2struct(sortedT);

voltage = sort(voltage);

%%

for ii = 1:nLoad
    DI = cumtrapz(cumtrapz(data(ii).Fit.yFit(1, :)));
    DI1(ii) = DI(end);
    DI = cumtrapz(cumtrapz(data(ii).Fit.yFit(2, :)));
    DI2(ii) = DI(end);
end

for ii = nLoad + 1:nLoad + 2
    DI = cumtrapz(cumtrapz(data(ii).Fit{25}.yFit(1, :)));
    DI1(ii) = DI(end);
    DI = cumtrapz(cumtrapz(data(ii).Fit{25}.yFit(2, :)));
    DI2(ii) = DI(end);
end

mass = [12.7, 9.2, 10, 10, 8.9, 9.5]; % not sure of the third last one
for ii = 1:nLoad
    mwpw(ii) = data(ii).mwpw;
end
for ii = nLoad + 1:nSample
    mwpw(ii) = data(ii).mwpw(25)/1000; % W
end

for ii = 1:nSample
    Qvalue(ii) = data(ii).Params.QValue;
end

Qvalue(end) = 4000;

DI1 = DI1./mass./sqrt(mwpw)./Qvalue;
DI2 = DI2./mass./sqrt(mwpw)./Qvalue;

load("plotColors.mat")
clf
plot(voltage, DI1, 'o-', 'Color', plotColors(1))
hold on
plot(voltage, DI2, 'o-', 'Color', plotColors(2))
xlim(setaxlim(voltage, 0.05))
labelaxesfig(gca, 'Voltage / V', ...
    'Intensity / A.U.')
legend('Sys1', 'Sys2', 'Location', 'northwest')
% savefigas(gcf, 'figures/intensity_vs_voltage_01.svg')