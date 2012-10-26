function varargout = isValidData( varargin )
%ISVALIDDATA Test prompted user data for feasiblity
%
% Checks, if data stored in table, which represents the numerical parameter 
% set of a template, fits to the block in simulink models and checks
% if this data is feasible.
%
% INPUT:    (1) -- Handle to main figure (usually MTIDS itself)
%           (2) -- Row index
%           (3) -- Column index
%
% OUTPUT:   (1) -- Boolean, '1' for 'no problem occured during the check'
%
% Author: Ferdinand Trommsdorff (f.trommsdorff@gmail.com)
% Project: MTIDS (http://code.google.com/p/mtids/)

if size( varargin,2 ) < 3
    error('Insufficient number of input arguments');
end

handles     = varargin{1};
rowIDX      = varargin{2};
colIDX      = varargin{3};

success = 0;

cellData = get(handles.t,'Data');
    paramCellArray = get_param([handles.sysname,'/',cellData{ rowIDX,1 } ], 'DialogParameters');
paramName = cellData{ rowIDX,colIDX-1 };
paramField = getfield( paramCellArray, paramName ); %#ok<*GFLD>

switch paramField.Type
    case 'boolean';
        % Value can be on / off
        if ~any( strcmp( cellData{ rowIDX,colIDX }, {'on','off'} ))
            success = 0;
        else
            success = 1;
        end
    case 'enum';
        idxValue = find( strcmp( cellData{ rowIDX,colIDX }, paramField.Enum )); %#ok<EFIND>
        if isempty( idxValue )
            success = 0;
        else
            success = 1;
        end
    case 'string';
        if isempty( str2num( cellData{ rowIDX,colIDX } ) )  || ...
                isempty( cellData{ rowIDX,colIDX } ) %#ok<ST2NM>
            success = 0;
        else
            success = 1;
        end        
    otherwise;        
end

varargout{1} = success;