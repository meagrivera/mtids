function TextField2InputSpecs_Callback( hObject, evtdata,handles )
user_entry = str2double(get(hObject,'string'));
if isnan(user_entry)
  errordlg('You must enter a numeric value','Bad Input','modal')
end




%%%%%%%%%%%%%%