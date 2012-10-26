function TextField1InputSpecs_Callback( hObject, evtdata, handles ) %#ok<INUSL>
%TEXTFIELD1INPUTSPECS_CALLBACK consistency check for user edit field
%
% This function checks if the prompted string contains names of specified
% variables in the table above.
%
% INPUT:    hObject -- Handle to invoking function
%           evtdata -- (unused, set empty ([]) for manual use of function)
%           handles -- Struct with handles of parent figure
%
% OUTPUT:   (none)  -- Direct warning message will show up
%
% Author: Ferdinand Trommsdorff (f.trommsdorff@gmail.com)
% Project: MTIDS (http://code.google.com/p/mtids/)

% Read-out string and separate it (empty spaces or comma), using regexp
user_string = get(hObject,'String');
vars =regexp( user_string, ',|\s','split');
vars = vars(~cellfun(@isempty,vars));
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
                    comparestring=strcat(Data{ii,1},'/',Data{ii,jj});
%                     if isequal( vars(kk), Data(ii,jj) )
                    if strcmp( vars(kk), comparestring )
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
%for all found variables
% for kk = 1:length( vars )
%     %find block name for variable kk in first col of 'Data'
%     rowIDX = strcmp(Data{:,1},regexp(vars{kk},'[\w-_]*(?=/)','match'));
%     regexp(vars{kk},'\/','split')
%     %compare if there is any parameter with 'Name'
% %     if regexp(vars{kk},'[\w-_]*(?=/)','match')
% %         
% %     end
% 
% end
if ~isempty( vars)
    errordlg(['Parameter(s) ''' vars{:} ''' not found in table'],'Error on prompted parameter');
end


%%%%%%%%%%%%%%