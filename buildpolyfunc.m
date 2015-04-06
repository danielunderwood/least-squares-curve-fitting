function polyHandle = ...
    buildpolyfunc(endingorder, startingorder, orderincrement)
%buildpolyfunc Builds polynomial function handle
%   Builds a polynomial of endingorder starting at startingorder
%   and incrementing by orderincrement

% Start function handle
polystr = '@(x)';

for n=startingorder:orderincrement:endingorder
    % Build new term
    term = sprintf('x.^%d', n);
    %TODO: Get rid of beginning '+'
    polystr = strcat(polystr, '+', term);
end

% Convert string to function handle
polyHandle = str2func(polystr);
end