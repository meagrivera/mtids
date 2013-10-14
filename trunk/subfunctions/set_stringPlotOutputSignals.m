function varargout = set_stringPlotOutputSignals( varargin ) %#ok<STOUT>
%SET_STRINGPLOTOUTPUTSIGNALS set visualization of which signals are to plot
%
% This function updates the uicontrol elements, which display which 
% output signals of a node should be plotted.
%
% INPUT:    (1) -- Cell array, containing the information about the
%                   plotting parameters
%           (2) -- Struct, handles to elements of parent figure
%
% OUTPUT: (none)
%
% Author: Ferdinand Trommsdorff (f.trommsdorff@gmail.com)
% Project: MTIDS (http://code.google.com/p/mtids/)

% function input
printCell       = varargin{1};
handles         = varargin{2};

data = getappdata(handles.figure1,'appData');
temp = printCell{1,1};

% Tests whether or not the newTemplate Field is within the data structure
% and if so, alters the outDim variable to that templates output size.
% (PDK)

data_struct_string = fieldnames(data);
outDim = data.oldTemplate{1,2}.dimension.template_outputs;

for i = 1 : size(data_struct_string,1)
    if strcmp(data_struct_string(i,1),'newTemplate')
        outDim = data.newTemplate{1,2}.dimension.template_outputs;
        break
    end
end

%--------------

if any(temp(1:outDim))
    data.flagCheck1 = 1;
    data.stringPlotOutputSignals = num2str(find(temp(1:outDim)));
else
    data.flagCheck1 = 0;
    data.stringPlotOutputSignals = '';
end
set(handles.checkbox1,'Value',data.flagCheck1);
set(handles.edit_plotOutputSignals,'String',data.stringPlotOutputSignals);
setappdata(handles.figure1,'appData',data);
% function output
% varargout{1} = stringSelectedStates;
% varargout{2} = flagCheck2;