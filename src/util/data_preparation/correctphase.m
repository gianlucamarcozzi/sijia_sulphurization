function [y, phase] = correctphase(y, mode)
% correctphase      Phase correction for signals in orthogonal channels.
%
% [y, phase] = correctphase(y)
% [y, phase] = correctphase(y, mode)
%
% Input:
%   y       spectrum, complex vector of length N
%   mode    criterium for phase correction, string or char vector.
%           Minimize the the peak to peak amplituted of (Maximum) or the 
%           area under the (Integral) imaginary part of the spectrum,
%           maximum (default) or integral
%
% Output:
%   y       spectrum phase corrected (real part)
%   phase   corresponding phase

arguments
    y
    mode = 'maximum';
end

% Define fit model.
model = @(p) y*exp(1i*p*pi/180);
switch lower(string(mode))
    case "maximum"
        objective = @(p) imag(max(model(p) - min(model(p))));
    case "integral"
        objective = @(p) imag(cumtrapz(model(p)));
    otherwise
        error("correctphase: unrecognized mode. The possible values " + ...
            "are 'maximum', 'integral'.")
end

p0 = 0;
lb = -90;
ub = 90;
options = optimoptions('lsqnonlin', 'Display', 'off');

% Run fit.
phase = lsqnonlin(@(p) objective(p), p0, lb, ub, options);
y = model(phase);

% Make the signal such that the maximum is on the left of the minimum
[~, minyNo] = min(real(y));
[~, maxyNo] = max(real(y));
if minyNo < maxyNo
    phase = phase + 180;
    y = model(phase);
end


end