function varargout = getNumericValue( varargin )
%GETNUMERICVALUE converts a table element from char to double
%
% This function finds the numeric value of a variable, which is specified
% in the table.
%
% INPUT:    (1) -- Char, name of the variable
%           (2) -- Struct of handles of parent figure
%
% OUTPUT:   (1) -- If conversion was successfull, a (NxM) double array will
%                   be passed. If an error occured, the output is empty
%
% Author: Ferdinand Trommsdorff (f.trommsdorff@gmail.com)
% Project: MTIDS (http://code.google.com/p/mtids/)

if size( varargin,2 ) < 2
    error('Insufficient number of input arguments');
end

var         = varargin{1};
handles     = varargin{2};

% Search for variable names in the table
Data = get(handles.t,'Data');
flag = 0;
for ii = 1:size( Data,1 )
    for jj = 2:2:size( Data,2 )
        paramExists = ~isempty( Data{ii,jj} );
        valueExists = ~isempty( Data{ii,jj+1} );
        if paramExists && valueExists
            if isequal( var, Data{ii,jj} )
                varargout{1} = str2num( Data{ii,jj+1} ); %#ok<ST2NM>
                flag = 1;
            end
        end
    end
end
if ~flag
    varargout{1} = [];
end