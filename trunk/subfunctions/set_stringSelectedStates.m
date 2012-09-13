function varargout = set_stringSelectedStates( varargin ) %#ok<STOUT>
%SET_STRINGSELECTEDSTATES

% function input
printCell       = varargin{1};
handles         = varargin{2};

data = getappdata(handles.figure1,'appData');
temp = printCell{1,1};
if any(temp(2:length(temp)))
    data.flagCheck2 = 1;
    data.stringSelectedStates = num2str(find(temp(2:length(temp))));
else
    data.flagCheck2 = 0;
    data.stringSelectedStates = '';
end
set(handles.checkbox2,'Value',data.flagCheck2);
set(handles.edit_selectedStates,'String',data.stringSelectedStates);
setappdata(handles.figure1,'appData',data);
% function output
% varargout{1} = stringSelectedStates;
% varargout{2} = flagCheck2;