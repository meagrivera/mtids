function IDX = getTemplateIDX( node, data)
% This funtion gets the index of a node template
IDX = find( ~cellfun( @isempty, regexp( data.template_list(:,1), ...
        data.templates( node ) )));