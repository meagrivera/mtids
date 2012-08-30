function varargout = getNumericValue( varargin )
% This function finds the numeric value of a variable, which is specified
% in the table

var         = varargin{1};
handles     = varargin{2};

% Search for variable names in the table
Data = get(handles.t,'Data');

for ii = 1:size( Data,1 )
    for jj = 2:2:size( Data,2 )
        paramExists = ~isempty( Data{ii,jj} );
        valueExists = ~isempty( Data{ii,jj+1} );
        if paramExists && valueExists
            if isequal( var, Data{ii,jj} )
                varargout{1} = str2num( Data{ii,jj+1} );
            end
        end
    end
end
