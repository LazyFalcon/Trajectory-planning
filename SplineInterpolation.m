function out = SplineInterpolation(points)
    % interpolacja wszystkich punktów kontrolnych krzyw¹, z wykorzytaniem
    % matlabowej interpolacji
    len = length(points(:,1));
    X = 1:1:len;
    t = 1:0.001:length(points(:,1));

    out = Interpolate(interp1(X, points,t,'spline'));
end