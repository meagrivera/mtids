function computeInputSizes( handles )
%COMPUTEINPUTSIZES Computes signal sizes of nodes inputs
%
% This function computes the number of input signals of each node, which is
% a necessary information for linear systems, due to the input signal size
% must be known to set the node parameters correctly.
%
% INPUT:    (figure) handles
%
% OUTPUT:   none - node input signal size will be written into node i's
%           template, in the field: data.templates{i,2}.nodeInputs
%
% Author: Ferdinand Trommsdorff (f.trommsdorff@gmail.com)
% Project: MTIDS (http://code.google.com/p/mtids/)

data = getappdata(handles.figure1,'appData');
if nv(data.g) == 0
    return
end
for ii = 1:nv(data.g)
    [~, ~, temp] = checkNodeInput(ii,data); % #ok<ASGLU>
    data.templates{ii,2}.nodeInputs = temp;
end
setappdata(handles.figure1,'appData',data);