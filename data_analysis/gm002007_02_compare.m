clearvars, clc, clf
cd('D:\Profile\qse\files\projects\sijia_sulphurization')

p1 = load('data/processed/gm002007.mat');

p2 = load("data\processed\gm002010.mat");

y1 = p1.data.y/max(p1.data.y);
y2 = p2.data.y/max(p2.data.y);

clf
plot(p1.data.x, y1, p2.data.x, y2)