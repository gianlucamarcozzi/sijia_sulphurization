clearvars, clc
cd('D:\Profile\qse\files\projects\sijia_sulphurization')

%% SHQ N@C60

data = eprloadstructure("data/raw/gm002002.DTA");
xx = data.DataPrep.xRaw/10; % mT
yy = real(data.DataPrep.yRaw);

plot(xx, yy)

%%

Sys.g = 2.0021;
Sys.lwpp = [0.00, 0.005]; % mT
Sys.Nucs = 'N';
Sys.A = unitconvert(0.568, 'mT->MHz'); 

SysVary.lwpp = [0, 0.01];

Exp.mwFreq = data.Params.MWFQ * 1e-9; % GHz
Exp.CenterSweep = [mean(xx), max(xx) - min(xx)];
Exp.nPoints = numel(xx);

ExpVary.CenterSweep = [0.1, 0];

FitOpt.mask = xx < 352.1 | xx > 352.8;

Fit = esfit(yy, @pepper, {Sys, Exp}, {SysVary, ExpVary}, FitOpt);

%%

plot(xx, yy, xx, Fit.fit)
shqNC60DeltaB = Fit.pfit(2) - Exp.CenterSweep(1) 

%% SHQ BDPA

clearvars, clc

data = eprloadstructure("data/raw/gm002020.DTA");
xx = data.DataPrep.xRaw/10; % mT
yy = real(data.DataPrep.yRaw);

plot(xx, yy)

%%

Sys.g = 2.0026; % https://doi.org/10.1007/s00723-014-0579-6
Sys.lwpp = [0.0, 0.07]; % mT

SysVary.lwpp = [0., 0.038];

Exp.mwFreq = data.Params.MWFQ * 1e-9; % GHz
Exp.CenterSweep = [mean(xx), max(xx) - min(xx)];
Exp.nPoints = numel(xx);
 
ExpVary.CenterSweep = [0.1, 0];

Fit = esfit(yy, @pepper, {Sys, Exp}, {SysVary, ExpVary});

%%

plot(xx, yy, xx, Fit.fit)
shqBdapaDeltaB = Fit.pfit(2) - Exp.CenterSweep(1) % 0.0164

%% MD5 BDPA

clearvars, clc, clf

data = eprloadstructure("data/raw/gm002008.DTA");
xx = data.DataPrep.xRaw/10; % mT
yy = real(data.DataPrep.yRaw);

plot(xx, yy)

%%

Sys.g = 2.0026; % https://doi.org/10.1007/s00723-014-0579-6
Sys.lwpp = [0.0, 0.07]; % mT

SysVary.lwpp = [0., 0.038];

Exp.mwFreq = data.Params.MWFQ * 1e-9; % GHz
Exp.CenterSweep = [mean(xx), max(xx) - min(xx)];
Exp.nPoints = numel(xx);
 
ExpVary.CenterSweep = [0.1, 0];

Fit = esfit(yy, @pepper, {Sys, Exp}, {SysVary, ExpVary});

%%

plot(xx, yy, xx, Fit.fit)
md5DeltaB = Fit.pfit(2) - Exp.CenterSweep(1) 

