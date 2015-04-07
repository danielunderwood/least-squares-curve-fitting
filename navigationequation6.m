function F =navigationequation6(x)
%distanceequation 6-satellite Navigation Equation for GPS Problem

% Hardcode Satellite Values
xi = [ 15600 18760 17610 19170 17800 17500 ];
yi = [ 7540 2750 14630 610 6400 7590 ];
zi = [ 20140 18610 13480 18390 18660 18490 ];
ti = [ 0.07074 0.07220 0.07690 0.07242 0.0732 0.0735 ];
c = 299792.458;

% Distance Equation
F = [ (x(1) - xi(1)).^2 + (x(2) - yi(1)).^2 + (x(3) - zi(1)).^2 - (c*(ti(1) - x(4))).^2;
    (x(1) - xi(2)).^2 + (x(2) - yi(2)).^2 + (x(3) - zi(2)).^2 - (c*(ti(2) - x(4))).^2;
    (x(1) - xi(3)).^2 + (x(2) - yi(3)).^2 + (x(3) - zi(3)).^2 - (c*(ti(3) - x(4))).^2;
    (x(1) - xi(4)).^2 + (x(2) - yi(4)).^2 + (x(3) - zi(4)).^2 - (c*(ti(4) - x(4))).^2 
    (x(1) - xi(5)).^2 + (x(2) - yi(5)).^2 + (x(3) - zi(5)).^2 - (c*(ti(5) - x(4))).^2;
    (x(1) - xi(6)).^2 + (x(2) - yi(6)).^2 + (x(3) - zi(6)).^2 - (c*(ti(6) - x(4))).^2; ];
end



