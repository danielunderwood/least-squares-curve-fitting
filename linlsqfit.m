function [ fitParams ] = linlsqfit(x, y, modelfun)
%linlsqfit Fits data to a model function with linear parameters

% Make x and y column vectors
x = x(:);
y = y(:);

% Split modelfun into terms
funcTerms = splitfunction(modelfun);

% Get number of terms and points
numTerms = numel(funcTerms);
numPoints = numel(x);

% Preallocate A
A = zeros(numPoints, numTerms);

% Generate matrix A
for m=1:numPoints
    for n=1:numTerms
        A(m,n) = funcTerms{n}(x(m));
    end
end

% Solve for fit parameters
fitParams = A \ y;
end

