function argout = initPlotParams( dim )
%INITPLOTPARAMS initially set the parameters needed for plots
%
% This function initializes the plot parameters for a node.
% Output is a (1+n) element struct containing six elements, where
% n is the amount of internal states to plot. At start of mtids, n=1 for
% each node.
%
% INPUT:    dim     -- Internal node states
%
% OUTPUT:   argout  -- Struct with n=dim elements, containing
%                       specifications for plots
%
% Author: Ferdinand Trommsdorff (f.trommsdorff@gmail.com)
% Project: MTIDS (http://code.google.com/p/mtids/)

for kk = 1:dim
    plotParams(kk).lineWidth = '1.0'; %#ok<*AGROW>
    plotParams(kk).lineStyle = '-';
    plotParams(kk).marker = 'none';
    plotParams(kk).lineColor = [0 0 1];
    plotParams(kk).edgeColor = [0 0 1];
    plotParams(kk).faceColor = [0 0 1];
end
argout = plotParams;