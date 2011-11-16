function [X Y] = calculateEllipse(x, y, a, b, angle, steps)
    %# This functions returns points to draw an ellipse
    %#
    %#  @param x     X coordinate of center
    %#  @param y     Y coordinate of center
    %#  @param a     Semimajor axis; 2*radius of x-axis
    %#  @param b     Semiminor axis; 2*radius of y-axis
    %#  @param angle Angle of the ellipse (in degrees)
    %#

    error(nargchk(5, 6, nargin));
    if nargin<6, steps = 36; end

    beta = -angle * (pi / 180);
    sinbeta = sin(beta);
    cosbeta = cos(beta);

    alpha = linspace(0, 360, steps)' .* (pi / 180);
    sinalpha = sin(alpha);
    cosalpha = cos(alpha);

    X = x + (a * cosalpha * cosbeta - b * sinalpha * sinbeta);
    Y = y + (a * cosalpha * sinbeta + b * sinalpha * cosbeta);

    if nargout==1, X = [X Y]; end
end