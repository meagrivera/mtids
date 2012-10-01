function varargout = get_tableColumnWidth(varargin)
%GET_TABLECOLUMNWIDTH estimates width of table
%
% This function estimates the width of the table, in which the block data
% of the Simulink template will be shown.
%
% INPUT:    (1) -- Handle to invoking function
%           (2) -- List of blocks in template, which obtain numerical
%                   parameters, which may be edited by users
%           (3) -- Data, which will be displayed in the table
%           (4) -- Names of columns for table
%
% OUTPUT:   (1) -- Pixel width of table
%           (2) -- Vector, pixel width of columns
%
% Author: Ferdinand Trommsdorff (f.trommsdorff@gmail.com)
% Project: MTIDS (http://code.google.com/p/mtids/)

if size( varargin,2) < 4
    error('Insufficient number of input arguments');
end

hObject     = varargin{1};
listBlks    = varargin{2};
dat         = varargin{3};
cnames      = varargin{4};

charCounter = 0;
columnwidth = cell( 1 ,size(dat,2) );
for ii = 1: size(dat,2)
    % get max length of a single column in table data
    [val IDX] = max(cellfun(@length,dat(:,ii)));
    % compare max length with column name and take maximum of it
    if cellfun(@length,cnames(ii)) > val
        % column name IS longer
        charCounter = charCounter + cellfun(@length,cnames(ii));
        columnwidth{ii} = 1.4*sizeChar2Pixel(hObject, 'w', cnames{ii} );
    else
        % longest name is within the table data
        charCounter = charCounter + val;
        columnwidth{ii} = 1.2*sizeChar2Pixel(hObject, 'w', dat{IDX,ii} );
    end
end
tableColumnWidth = sizeChar2Pixel(hObject, 'w', max(cellfun(@length,listBlks )) )...
    + sum(cell2mat(columnwidth));
varargout{1} = tableColumnWidth;
varargout{2} = columnwidth;