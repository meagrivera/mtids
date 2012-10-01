function IDX = getParamIDX( node, data )
%GETPARAMIDX gets index of parameter in cell array
%
% This function gets the index of the parameter value set of a given node,
% which is represented by its number.
%
% INPUT:    node -- Index of node in MTIDS
%           data -- Struct of data, which contains the system informationin
%           MTIDS
%
% OUTPUT:   IDX -- Index of according parameter
%
% Author: Ferdinand Trommsdorff (f.trommsdorff@gmail.com)
% Project: MTIDS (http://code.google.com/p/mtids/)
IDX = data.templates{node,2};