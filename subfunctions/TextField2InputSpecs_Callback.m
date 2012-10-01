function TextField2InputSpecs_Callback( hObject, evtdata,handles ) %#ok<INUSD>
%TEXTFIELD2INPUTSPECS consistency check for prompted user data
%
% Checks prompted user date, if the string can be converted into a numeric
% value.
%
% INPUT:    hObject -- Handle to invoking function
%           evtdata -- (unused, set empty ([]) for manual use of function)
%           handles -- Struct with handles of parent figure
%
% OUTPUT:   (none)  -- Direct warning message will show up
%
% Author: Ferdinand Trommsdorff (f.trommsdorff@gmail.com)
% Project: MTIDS (http://code.google.com/p/mtids/)

user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
  errordlg('You must enter a numeric value','Bad Input','modal')
end


%%%%%%%%%%%%%%