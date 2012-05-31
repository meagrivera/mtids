% test script for import_dynamic_params.m

oldFolder = cd(strcat(pwd,'/templates'));

[filename, pathname] = uigetfile( ...
{'*.mdl','Simulink model template(*.mdl)';
   '*.*',  'All Files (*.*)'}, ...
   'Import Simulink model templates', ...
   'MultiSelect', 'on');

% disp(['Filename: ' filename]);
load_system(filename);


% check this file for unset parameter values - this is a prestep to the
% dialog of asking for all needed parameters for this template
% finds all blocks in the simulink model
blks = find_system(gcs, 'Type', 'block');
listblks = get_param(blks, 'BlockType');
listnms = get_param(blks,'Name');

% is is very hard to show the variation of all editable parameters
% thus just show the blocks and let the user type in which values should be
% introduced as parameters for the template OR make a choice of possible
% values, which are very likely

% there are some blocks, which are very likely not to contain parameters,
% which the user should set, e.g.:
% Inport, Outport, Sum, Mux, Math
% sort out these blocks:
listnms( ~cellfun( @isempty, regexp( listblks,...
    'Inport|Outport|Sum|Mux|Math|Scope|ToWorkspace','start')) ) = [];
listblks( ~cellfun( @isempty, regexp( listblks,...
    'Inport|Outport|Sum|Mux|Math|Scope|ToWorkspace','start')) ) = [];


% create new figure and place found blocks in table environment
if ~cellfun( @isempty, listblks )
    argout = import_dynamic_params(listblks,listnms,filename);
else
    % errordlg('No blocks with editable');
end

cd(oldFolder);