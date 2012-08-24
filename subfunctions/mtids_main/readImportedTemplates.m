function template_list = readImportedTemplates( varargin )
%READIMPORTEDTEMPLATES
% This function checks the import/template folder, if there are any
% templates, which were formerly imported (with paramValue sets)
% This function is at least invoked by the initialization of MTIDS
% template_list = [Type color1 color2 param_values active]

if size( varargin,2) == 1
    template_list_old = varargin{1};
end

% get Filelist of folder
path1 = [pwd filesep 'templates' filesep 'import' ];
filelist = dir( path1 );

% examine each .mdl-File if it contains 'CHECKED' in its name
templateNames = cell( length(filelist),1 );
for ii = 1:length(filelist)
    % only checked mdl's are interesting at the moment
    idxTemp = regexp( filelist(ii).name,'_CHECKED.mdl');
    if ~isempty( idxTemp )      
        nameTemp = filelist(ii).name;        
        templateNames{ii} = nameTemp(1:idxTemp-1);
    end    
end
templateNames = templateNames( ~cellfun(@isempty,templateNames) );

% for found checked templates, look for the paramValue sets
% paramValueSets = cell( length(templateNames),1 );
for ii = 1:length( templateNames )
    if exist( [ path1 filesep templateNames{ii} '_paramValues.mat'],'file')
        load([path1 filesep templateNames{ii} '_paramValues']);
        cmd1 = ['paramValueSets(' num2str(ii) ...
            ').sets = ' templateNames{ii} '_paramValues;'];
        eval( cmd1 );
        cmd2 = ['paramValueSets(' num2str(ii) ...
            ').name = ''' templateNames{ii} ''';'];
        eval( cmd2 );
    else
%         disp(['Template "' templateNames{ii}...
%             '" found, but no appendant parameter value file.'...
%             ' Template will be ignored.']);
    end   
end

isEmptyVec = zeros( length(paramValueSets),1 );
for ii = 1:length(paramValueSets)
    isEmptyVec(ii) = isempty(paramValueSets(ii).name);
end
paramValueSets = paramValueSets( ~isEmptyVec );

% prepare template-list in MTIDS-GUI
template_list = cell( size( paramValueSets,2 ),5);
for ii = 1:size( paramValueSets,2 )
    template_list{ii,1} = paramValueSets(ii).name;
    % Check if template still existed before, because then we must use the
    % stored color(s)
    idxTemplExists = ~cellfun( @isempty, ...
        regexp( template_list_old(:,1), template_list{ii,1} ) );
    if any( idxTemplExists )
        template_list{ii,2} = template_list_old{idxTemplExists,2};
        template_list{ii,3} = template_list_old{idxTemplExists,3};
    else
        template_list{ii,2} = [245 245 245]/255;
        template_list{ii,3} = [0 0 0];
    end
    template_list{ii,4} = paramValueSets(ii).sets;
    template_list{ii,5} = 1;
end




%%%%%%%%%%%%%%