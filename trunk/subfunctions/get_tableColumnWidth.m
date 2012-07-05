function [ tableColumnWidth columnwidth ] = get_tableColumnWidth(hObject,listBlks,dat,cnames)
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