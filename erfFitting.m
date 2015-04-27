function erfFitting()
%ERFFITTING Uses linlsqfit to fit error function

% Create test points
t = 0:0.1:1;

% Evaluate error function at points for fitting
yFit = erf(t);

% Evaluate error function more generally for error testing
tErrors = 0:0.001:1;
erfEval = erf(tErrors);

% Generate full polynomials order 1-10
for order=1:10
    fullPoly{order} = buildpolyfunc(order, 0, 1);
end

% Generate odd polynomials order 1-10
for order=1:2:10
    oddPoly{(order + 1) / 2} = buildpolyfunc(order, 1, 2);
end

% Generate exponential model
expModel = @(z) 1 + exp(-(z-1).^2) * 1  + exp(-(z-1).^2) .* z.^2 + ...
    exp(-(z-1).^2) .* z.^2 + exp(-(z-1).^2) .* z.^3;

% --- Full Polynomials --- %

% Create figure and axes
fullFig = figure;
fullAx = axes;
hold(fullAx);
for order=1:10
    polyFit{order} = linlsqfit(t, yFit, fullPoly{order});
    
    % Evaluate at error testing points
    polyTerms = splitfunction(fullPoly{order});
    evaluatedValue = 0;
    for term=1:order+1
        evaluatedValue = evaluatedValue + polyFit{order}(term) * ...
            polyTerms{term}(tErrors);
    end
    
    evaluatedFullPoly{order} = evaluatedValue;
    
    % Get errors
    fullPolyError{order} = evaluatedFullPoly{order}  - erfEval;
    
    % Max and rms error
    fullRMSE{order} = rms(fullPolyError{order});
    fullMaxAbsError{order} = max(abs(fullPolyError{order}));
    
    % Plot log of absolute error
    plot(fullAx, tErrors, log(abs(fullPolyError{order})), ...
        'LineWidth', 4, 'DisplayName', sprintf('P_{%d}', order));
end

fullLegend = legend('-DynamicLegend');
set(fullLegend, 'FontSize', 30);
set(fullLegend, 'Location', 'eastoutside');

fullTitle = title('Full Polynomial Fit Errors');
set(fullTitle, 'FontSize', 36);

fullXLabel = xlabel('t');
fullYLabel = ylabel('log|erf(t) - P_n(t)|');
set(fullXLabel, 'FontSize', 30);
set(fullYLabel, 'FontSize', 30);

% Stop holding axes
hold(fullAx);

% --- Odd Polynomials --- %

% Create figure and axes
oddFig = figure;
oddAx = axes;
hold(oddAx);
for order=1:2:10
    oddFit{(order + 1) / 2} = linlsqfit(t, yFit, oddPoly{(order + 1) / 2});
    
    % Evaluate at error testing points
    oddTerms = splitfunction(oddPoly{(order + 1) / 2});
    evaluatedValue = 0;
    for term=1:((order + 1) / 2)
        evaluatedValue = evaluatedValue + ...
            oddFit{(order + 1) / 2}(term) * oddTerms{term}(tErrors);
    end
    
    evaluatedOddPoly{(order + 1) / 2} = evaluatedValue;
    
    % Get errors
    oddPolyError{(order + 1) / 2} = ...
        evaluatedFullPoly{( order + 1) / 2} - erfEval;
    
    % Max and rms error
    oddRMSE{(order + 1) / 2} = rms(oddPolyError{(order + 1) / 2});
    oddMaxAbsError{(order + 1) / 2} = max(abs(oddPolyError{(order + 1) / 2}));
    
    % Plot log of absolute error
    plot(oddAx, tErrors, log(abs(oddPolyError{(order + 1) / 2})), ...
        'LineWidth', 4, 'DisplayName', sprintf('O_{%d}', order));
end

oddLegend = legend('-DynamicLegend');
set(oddLegend, 'FontSize', 30);
set(oddLegend, 'Location', 'eastoutside');

oddTitle = title('Odd Polynomial Fit Errors');
set(oddTitle, 'FontSize', 36);

oddXLabel = xlabel('t');
oddYLabel = ylabel('log|erf(t) - O_n(t)|');
set(oddXLabel, 'FontSize', 30);
set(oddYLabel, 'FontSize', 30);

% Toggle hold
hold(oddAx);

% --- Exponential Model --- %
expFig = figure;
expAx = axes;
hold(expAx);

expFit = linlsqfit(t, yFit, expModel);

% Evaluate at error testing points
expTerms = splitfunction(expModel);
evaluatedValue = 0;
for term=1:5
    evaluatedValue = evaluatedValue + ...
        expFit(term) * expTerms{term}(tErrors);
end

evaluatedExpModel = evaluatedValue;

% Get error
expError = evaluatedExpModel - erfEval;

expRMSE = rms(expError);
expMaxAbsError = max(abs(expError));

plot(expAx, tErrors, log(abs(expError)), 'LineWidth', 4);

expTitle = title('Exponential Fit Error');
set(expTitle, 'FontSize', 36);

expXLabel = xlabel('t');
expYLabel = ylabel(['log|erf(t) - c_1 + e^{-(z-1)^2} ' ...
    '(c_2 + c_3 z + c_4 z^2 + c_5 z^3)|']);
set(expXLabel, 'FontSize', 30);
set(expYLabel, 'FontSize', 30);

% Toggle hold
hold(expAx);

    
end

