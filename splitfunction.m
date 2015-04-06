function funcArray = splitfunction(funcHandle)
%splitfunction Splits function into cell array
%   Splits function into cell array based on terms. 
%   i.e., 1 + x + x^2 -> {1, x, x^2}

F = functions(funcHandle);

% Get string from function handle
str = F.function;

% pref is the '@(...)' part. Split by regex
[pref, body] = regexp(str, '@\(.+?\)', 'match', 'split');

% body is the main part
body = body{2};

% Indices for splitting
ind = cumsum((body=='(')-(body==')'))==0 & body=='+';

% '?' will be used as split marker
body(ind) = '?';

% split, and then add prefix
funcStrArray = strcat(pref, strsplit(body, '?'));

% Convert strings to functions
funcArray = cellfun(@str2func, funcStrArray, 'uniformoutput', 0);

end

