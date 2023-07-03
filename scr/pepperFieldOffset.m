function y = pepperFieldOffset(Sys, Exp, Opt)

if nargin < 3 || isempty(Opt)
    Opt = struct;
end

persistent fieldOffset
if isempty(fieldOffset)
    fieldOffset = 0;
end

if isa(Sys, "struct")
    fieldOffset = Sys.FieldOffset;
else
    fieldOffset = Sys{1}.FieldOffset;
end

% Handle the field offset.
Exp_ = Exp;
Exp_.Range = Exp_.Range - fieldOffset;

y = pepper(Sys, Exp_, Opt);

% Handle scaling.
if isfield(Sys, 'Scaling')
    y = y * Sys.Scaling;
end
if isa(Sys, "struct")
    % Handle scaling.
    if isfield(Sys, 'Scaling')
        y = y * Sys.Scaling;
    end
else
    % Handle scaling.
    if isfield(Sys{1}, 'Scaling')
        y = y * Sys{1}.Scaling;
    end
end

end