function plotBaselineCorrection(cw, OptBlRange)
    NROW = 2;
    NCOL = 2; % even number: one col for real, one for imag
    ncw = numel(cw);
    nFig = ncw/NROW;
    if mod(nFig, 1)
        nFig = fix(nFig) + 1;
    end
    for iFig = 1:nFig
        figure();
        tiledlayout(NROW, NCOL, 'TileSpacing', 'compact', 'Padding', 'compact')
        for icw = (iFig-1)*NROW + 1:iFig*NROW
            for iCol = 1:NCOL/2
                nexttile()
                plot(cw(icw).x, real(cw(icw).yRaw), cw(icw).x, real(cw(icw).Bl));
                xlim(setAxLim(cw(icw).x, 0)); ylim(setAxLim(real(cw(icw).yRaw), 0.05));
                xline(OptBlRange(1,2)); xline(OptBlRange(2,1));
                % xline(Opt.Bl.Range(2,2)); xline(Opt.Bl.Range(3,1));
                nexttile()
                plot(cw(icw).x, imag(cw(icw).yRaw), cw(icw).x, imag(cw(icw).Bl)); 
                xlim(setAxLim(cw(icw).x, 0)); ylim(setAxLim(imag(cw(icw).yRaw), 0.05));
                xline(OptBlRange(1,2)); xline(OptBlRange(2,1));
                % xline(Opt.Bl.Range(2,2)); xline(Opt.Bl.Range(3,1));
                title(cw(icw).Title)
            end
        end
    end
end