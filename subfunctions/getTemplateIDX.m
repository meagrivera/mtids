function IDX = getTemplateIDX( node, data)
%GETPARAMIDX gets index of node template in cell array
%
% This funtion gets the index of a node template.
%
% INPUT:    node -- Index of node in MTIDS
%           data -- Struct of data, which contains the system informationin
%           MTIDS
%
% OUTPUT:   IDX -- Index of according parameter
%
% Author: Ferdinand Trommsdorff (f.trommsdorff@gmail.com)
% Project: MTIDS (http://code.google.com/p/mtids/)
IDX = find( ~cellfun( @isempty, regexp( data.template_list(:,1), ...
        data.templates( node ) )));