function [ fitParams, fittedPoints, rmse, pointerrors ] = ...
    linlsqfit(x, y, modelfun)
%linlsqfit Fits data to a model function with linear parameters

% TODO: Check that x and y are column vectors of the same size

% Split modelfun into terms
funcTerms = splitfunction(modelfun);

% Get number of terms and points
numTerms = size(funcTerms, 2);
numPoints = size(x, 1);

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

fittedPoints = A * fitParams;

% Check fitted model to get errors
pointerrors = y - fittedPoints;

rmse = rms(pointerrors);
end

