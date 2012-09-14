function varargout = set_stringPlotOutputSignals( varargin ) %#ok<STOUT>
%SET_STRINGPLOTOUTPUTSIGNALS

% function input
printCell       = varargin{1};
handles         = varargin{2};

data = getappdata(handles.figure1,'appData');
temp = printCell{1,1};
outDim = data.oldTemplate{1,2}.dimension.outputs;
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