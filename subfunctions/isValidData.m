function varargout = isValidData( varargin )
% ISVALIDDATA
%  Checks if data stored in table fits to the block in simulink models and
%  if this data is feasible

handles     = varargin{1};
rowIDX      = varargin{2};
colIDX      = varargin{3};

success = 0;

cellData = get(handles.t,'Data');
paramCellArray = get_param([handles.sysname,'/',cellData{ rowIDX,1 } ], 'DialogParameters');
paramName = cellData{ rowIDX,colIDX-1 };
paramField = getfield( paramCellArray, paramName );

switch paramField.Type
    case 'boolean';
        % Value can be on / off
        if ~any( strcmp( cellData{ rowIDX,colIDX }, {'on','off'} ))
            success = 0;
        else
            success = 1;
        end
    case 'enum';
        idxValue = find( strcmp( cellData{ rowIDX,colIDX }, paramField.Enum ));
        if isempty( idxValue )
            success = 0;
        else
            success = 1;
        end
    case 'string';
        if isempty( str2num( cellData{ rowIDX,colIDX } ) )  || ...
                isempty( cellData{ rowIDX,colIDX } )
            success = 0;
        else
            success = 1;
        end        
    otherwise;        
end

varargout{1} = success;