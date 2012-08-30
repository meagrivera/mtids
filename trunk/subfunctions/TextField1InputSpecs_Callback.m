function TextField1InputSpecs_Callback( hObject, evtdata, handles )
% This function checks if the prompted string contains names of specified
% variables in the table above

% Read-out string and separate it (empty spaces or comma), using regexp
user_string = get(hObject,'String');
vars =regexp( user_string, ',|\s','split');

% Search for variable names in the table
Data = get(handles.t,'Data');
if ~isempty( vars)
    for ii = 1:size( Data,1 )
        for jj = 2:2:size( Data,2 )
            paramExists = ~isempty( Data{ii,jj} );
            valueExists = ~isempty( Data{ii,jj+1} );
            if paramExists && valueExists
                temp = zeros( length( vars ),1 );
                for kk = 1:length( vars )
                    if isequal( vars(kk), Data(ii,jj) )
                        temp(kk) = 1;
                    end
                end
                vars( logical(temp) ) = [];
            end
            if isempty( vars )
                break
            end
        end
    end
end
if ~isempty( vars)
    errordlg(['Parameter(s) ''' vars{:} ''' not found in table'],'Error on prompted parameter');
end


%%%%%%%%%%%%%%