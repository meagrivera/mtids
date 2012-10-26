function varargout = manageParamSets(varargin)
%MANAGEPARAMSETS gui for managing templates and its numerical parameter sets
%
% This GUI enables the import of new dynamic templates to MTIDS and the
% management of its numerical parameter sets. Principally, the relation of
% a template to its num. values sets is a 1N relation, which means, one
% template may obtain N param sets. Furthermore, theses sets can be
% deactivated for their use in MTIDS.
%
% INPUT:    (1) -- Cell array, containing a list of templates (see overview
%                   of applied data structures in MTIDS, folder
%                   'resources')
%
% OUTPUT:   (1) -- Template list, similar to input
%
% Author: Ferdinand Trommsdorff (f.trommsdorff@gmail.com)
% Project: MTIDS (http://code.google.com/p/mtids/)

%      MANAGEPARAMSETS, by itself, creates a new MANAGEPARAMSETS or raises the existing
%      singleton*.
%
%      H = MANAGEPARAMSETS returns the handle to a new MANAGEPARAMSETS or the handle to
%      the existing singleton*.
%
%      MANAGEPARAMSETS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MANAGEPARAMSETS.M with the given input arguments.
%
%      MANAGEPARAMSETS('Property','Value',...) creates a new MANAGEPARAMSETS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before manageParamSets_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to manageParamSets_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help manageParamSets

% Last Modified by GUIDE v2.5 26-Sep-2012 08:51:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @manageParamSets_OpeningFcn, ...
                   'gui_OutputFcn',  @manageParamSets_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before manageParamSets is made visible.
function manageParamSets_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to manageParamSets (see VARARGIN)

% Choose default command line output for manageParamSets
handles.output = hObject;
handles.mode = 'edit';
template_list = varargin{1};
handles.readTemplateList = 0;
handles.templateNames = template_list(:,1);
handles.templateSets = template_list(:,4);
handles.flagNewTemplate = 0;
handles.sys2Import = cell(0,2);
handles.noChanges = 1;
handles.newImportStarted = 0;
handles.succTest = 0;
% initialize dropdown menues
initDropdownMenuTemplates( handles );
handles = popupmenu_template_Callback(handles.popupmenu_template, eventdata, handles);
setPanelModeActions( handles,hObject );
setObjectPositions( handles );
handles = loadTableFromStruct( handles.popupmenu_valueSet,handles );
handles = handleOpenSystems( handles );
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes manageParamSets wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = manageParamSets_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
delete(hObject);


% --- Executes when selected object is changed in uipanel_mode.
function handles = uipanel_mode_SelectionChangeFcn(hObject, eventdata, handles) %#ok<*DEFNU>
% hObject    handle to the selected object in uipanel_mode 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
switch get(eventdata.NewValue,'Tag')
    case 'radiobutton_editParamSets';
        if handles.newImportStarted
            choice = questdlg('Discard current template import?', ...
                'Switch mode', ...
                'Yes','No','No');
            switch choice
                case 'Yes';
                    handles.mode = 'edit';
                case 'No';
                    set(handles.radiobutton_editParamSets,'Value',0.0);
                    set(handles.radiobutton_newImport,'Value',1.0);
                    return
            end
        else
            handles.mode = 'edit';
        end
    case 'radiobutton_newImport';
        if ~handles.noChanges
            choice = questdlg('Discard changes to current parameter set?', ...
                'Switch mode', ...
                'Yes','No','No');
            switch choice
                case 'Yes';
                    handles.mode = 'import';
%                     handles.noChanges = 1;
                case 'No';
                    set(handles.radiobutton_editParamSets,'Value',1.0);
                    set(handles.radiobutton_newImport,'Value',0.0);                    
                    return
            end
        else
            handles.mode = 'import';
        end
end
setPanelModeActions( handles,hObject );
handles = handleOpenSystems( handles );
handles = loadTableFromStruct( hObject,handles );
guidata(hObject, handles);


function setPanelModeActions( varargin )
%SETPANELMODEACTIONS
% This functions resets the layout of the panel "uipanel_modeActions",
% depending on which mode was chosen
handles     = varargin{1};
hObject     = varargin{2};
switch handles.mode
    case 'edit';
        title = 'Choose parameter set';
        set(handles.pushbutton_loadTemplate,'Visible','off');
        set(handles.popupmenu_template,'Visible','on');
        set(handles.popupmenu_valueSet,'Visible','on');
        set(handles.pushbutton_deleteSet,'Visible','on');
        set(handles.togglebutton_setActive,'Visible','on');
        set(handles.pushbutton_addBlock,'Visible','off');
        set(handles.pushbutton_removeBlock,'Visible','off');
        set(handles.pushbutton_addParameter,'Visible','off');
        set(handles.pushbutton_removeParameter,'Visible','off');
        set(handles.pushbutton_finishImport,'Visible','off');
        set(handles.pushbutton_save2File,'Visible','on');
    case 'import';
        title = 'Load template from file';
        set(handles.pushbutton_loadTemplate,'Visible','on');
        set(handles.popupmenu_template,'Visible','off');
        set(handles.popupmenu_valueSet,'Visible','off');
        set(handles.pushbutton_deleteSet,'Visible','off');
        set(handles.togglebutton_setActive,'Visible','off');        
        set(handles.pushbutton_addBlock,'Visible','on');
        set(handles.pushbutton_removeBlock,'Visible','on');
        set(handles.pushbutton_addParameter,'Visible','on');
        set(handles.pushbutton_removeParameter,'Visible','on');
        set(handles.pushbutton_finishImport,'Visible','on');
        set(handles.pushbutton_save2File,'Visible','off');
end
set(handles.uipanel_modeActions,'Title',title);


function initDropdownMenuTemplates( handles )
%INITDROPDOWNMENUES
%  This function initializes the dropdown menues in the panel "Mode
%  depending actions" with the loaded templates in "data.template_list" and
%  the given parameter value sets.
if ~handles.flagNewTemplate
    set(handles.popupmenu_template, 'String', handles.templateNames);
else
    % do something
end


% --- Executes on selection change in popupmenu_template.
function handles = popupmenu_template_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_template (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_template contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_template
idxDynSelector = get(hObject,'Value');
if ~handles.flagNewTemplate
    nrOfParamSets = length(handles.templateSets{idxDynSelector});
%     length( handles.templateNames{get(hObject,'Value'),4} );
else
    % do something
end
drop_string = cell( nrOfParamSets,1 );
for i=1:nrOfParamSets
    % Check if template contains a name for a set
    if isfield(handles.templateSets{idxDynSelector}(i),'setName') &&...
            ~isempty(handles.templateSets{idxDynSelector}(i).setName)
        drop_string{i} = handles.templateSets{idxDynSelector}(i).setName;
    else
        drop_string{i} = '<no name set>';
    end
end
set(handles.popupmenu_valueSet, 'String', drop_string,'Value',1);
handles = handleOpenSystems( handles );
handles = popupmenu_valueSet_Callback(hObject, eventdata, handles);
guidata(handles.figure1, handles);


% --- Executes during object creation, after setting all properties.
function popupmenu_template_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_template (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function popupmenu_valueSet_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_valueSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function setObjectPositions( handles )
%SETOBJECTPOSITIONS
% This function set some parameters of the uicontrol elements in the panel
% "mode depending actions"
temp = get(handles.pushbutton_loadTemplate,'Position');
posPopupmenu_template = get(handles.popupmenu_template,'Position');
posPopupmenu_template(1) = temp(1);
posPopupmenu_valueSet = get(handles.popupmenu_valueSet,'Position');
posPopupmenu_valueSet(1) = temp(1);
set(handles.popupmenu_template,'Position',posPopupmenu_template);
set(handles.popupmenu_valueSet,'Position',posPopupmenu_valueSet);
temp1 = get(handles.pushbutton_finishImport,'Position');
set(handles.pushbutton_deleteSet,'Position',temp1);



% --- Executes during object creation, after setting all properties.
function edit_save2File_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_save2File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function TextField1InputSpecs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TextField1InputSpecs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles1 not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function TextField2InputSpecs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TextField2InputSpecs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_loadTemplate.
function pushbutton_loadTemplate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_loadTemplate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile( ...
{'*.mdl','Simulink model template(*.mdl)';
   '*.*',  'All Files (*.*)'}, ...
   'Import Simulink model templates', ...
   'MultiSelect', 'on');
if any(~filename) || any(~pathname)
    return
elseif any(strcmp( handles.templateNames, regexp(filename,'\w*(?=.mdl)','match') ))
    errordlg({'A template with this name still exists.',...
        'Please check if the new template is not identical to the existing one.',...
        'If so, use "Edit parameter set" to create new value sets.',...
        'If not, rename new template.'});
    return
end
if isfield(handles,'sys2Import')
    howManySys = length(handles.sys2Import(:,1));
else
    howManySys = 0;
end
handles.sys2Import{howManySys+1,1} = filename;
handles.sys2Import{howManySys+1,2} = pathname;
handleOpenSystems( handles );
m=regexp( filename, '\.', 'split','once');
handles.sysname = m{1};
handles = buildTableFromTemplate( handles );
guidata(hObject, handles);

% --- Executes on button press in pushbutton_save2File.
function pushbutton_save2File_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save2File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('Saving parameter set to file...');
if handles.succTest && isfield( handles, 'dimension')
    choice = 'yes';
    dimension = handles.dimension;
else
    handles.pathname = [pwd filesep 'templates' filesep 'import' filesep];
    [dimension choice ] = testingValueSet( handles,0 );
end
if strcmp( choice,'yes')
    handles.succTest = 1;
    templName = handles.templateNames{get(handles.popupmenu_template,'Value')};
    Data = get(handles.t,'Data');
    [success errMessage ] = saveParamSet2File(handles.TextField1InputSpecs,...
        handles.TextField2InputSpecs, templName, handles.edit_save2File,...
        Data, dimension, handles.pathname,handles.togglebutton_setActive,1);
    if ~success
        disp('Parameter set not saved due to following reason:');
        if ~isempty(errMessage)
            disp(errMessage);
        end
    else
        % read in updated param sets
        paramValueSetsNew = readImportedTemplates;
        for kk = 1:length( paramValueSetsNew )
            handles.templateNames{kk} = paramValueSetsNew(kk).name;
            handles.templateSets{kk} =  paramValueSetsNew(kk).sets;
        end
        % choose entries in popupmenus to recent saved set
        setName = get(handles.edit_save2File,'String');
        handles.noChanges = 1;
        handles = popupmenu_template_Callback( handles.popupmenu_template,[],handles );
        idxTemp = find( strcmp( get(handles.popupmenu_template,'String'),templName));
        idxSet = find( strcmp( get(handles.popupmenu_valueSet,'String'),setName ));
        set(handles.popupmenu_template,'Value',idxTemp);
        set(handles.popupmenu_valueSet,'Value',idxSet);
        handles = popupmenu_valueSet_Callback(handles.popupmenu_valueSet, [], handles);
        guidata(hObject,handles);
    end
else
    disp('Testing of parameter set failed.');
end

% --- Executes on button press in pushbutton_addBlock.
function pushbutton_addBlock_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_addBlock (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
nrOfRows = length( get(handles.t,'RowName') );
% ask for new row (=block) name
newRowName = inputdlg({'New Block Type: '},'Add Block',1);
if isempty( newRowName )
    return;
end
% check if block type exists before adding the row to the table
if isempty( find_system(handles.sysname,'BlockType',newRowName{1}) )
    errordlg(['No Block of Type ',newRowName,' found!']);
    return;
end
% Data processing to row names and table data
rownames = cell(nrOfRows+1,1);
rownames(1:nrOfRows) = get(handles.t,'RowName');
rownames(end) = newRowName;
testCell=find_system(handles.sysname,'BlockType',newRowName{1});
s=regexp(testCell,'/','split');
listOutString = cell(size(s,1),1);
for i = 1:size(s,1)
    listOutString{i} = s{i}{2};
end
newBlockNameIndex = listdlg('PromptString','Select a Block Name:',...
    'SelectionMode','single','ListString',listOutString);
dataOld=get(handles.t,'Data');
dataNew = cell( size(dataOld,1)+1, size(dataOld,2) );
dataNew(1:end-1,:) = dataOld;
newBlockName = listOutString(newBlockNameIndex);
[ paramname paramvalue ] = get_BlockParams( newRowName{:},handles,newBlockName{:} );
dataNew(end,1) = listOutString(newBlockNameIndex);
for j = 1:length(paramname)
    dataNew{end,2*j} = paramname{j};
    dataNew{end,1+2*j} = paramvalue{j};
end
set(handles.t,'RowName',rownames,'Data',dataNew);

% --- Executes on button press in pushbutton_removeBlock.
function pushbutton_removeBlock_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_removeBlock (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Case handling: if no cells are selected
try
    if isempty(handles.selected_cells)
        errordlg('No row(s) selected');
        return
    end
    IDX = handles.selected_cells; % Contains indices of the selected cells
    rowIDX = IDX(:,1);
    % colIDX = IDX(:,2);
    rownames = get(handles.t,'RowName');
    % Perform request if cells should really be deleted
    title = 'Sure? Delete block(s)?';
    qstring = {'Should the following blocks be deleted?',...
        rownames{rowIDX} };
    choice = questdlg(qstring,title,'Yes','No','No');
    switch choice
        case 'Yes';
            % adapt rownames
            rownamesIDX = 1:1:length(rownames);
            % delete rowname indices according to selected cells
            for ii = 1:length(rowIDX)
                rownamesIDX = rownamesIDX(rownamesIDX ~= rowIDX(ii));
            end
            rownamesNew = rownames( rownamesIDX );
            % adapt table data
            data=get(handles.t,'Data');
            data = data( rownamesIDX,: );
            % set new table
            set(handles.t,'RowName',rownamesNew,'Data',data);
        case 'No';
            % do nothing
    end
catch
    errordlg('No row(s) selected');
    return
end

% --- Executes on button press in pushbutton_addParameter.
function pushbutton_addParameter_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_addParameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'selected_cells') || isempty(handles.selected_cells)
    errordlg('No row(s) selected');
    return
end
IDX = handles.selected_cells; % Contains indices of the selected cells
rowIDX = IDX(:,1);
% colIDX = IDX(:,2);
if size( rowIDX,1 ) > 1
    errordlg('Please choose only one block for adding a new parameter');
    return
end
% Dialog if parameter out of list should be chosen or via free hand input
% Construct a questdlg with three options
choice = questdlg('How should the parameter be chosen?', ...
 'Add Parameter Menu', ...
 'Out of list','Free input','Cancel','Cancel');
% Handle response
cellData = get(handles.t,'Data');
switch choice
    case 'Out of list'
        % Show list with available parameters        
        allParams = get_param([handles.sysname '/' cellData{rowIDX,1}],'Dialogparameters');
        namesAllParams = fieldnames( allParams );
        newParamIndex = listdlg('PromptString','Select a parameter:',...
            'SelectionMode','single','ListString',namesAllParams);
        if isempty( newParamIndex )
            return;
        end
        answer(1) = namesAllParams( newParamIndex );
        paramvalue = get_param([handles.sysname,'/',cellData{ rowIDX,1 } ],answer{1});
    case 'Free input'
        rowname = get(handles.t,'RowName');
        % Perform request if parameter should be added
        prompt = {'Enter parameter name:'};
        title = ['Add new Parameter to Block ',rowname{rowIDX}];
        num_lines = 1;
        def = {'paramname'};
        answer = inputdlg(prompt,title,num_lines,def);
        % Check if parameter name really exists; if not, throw error
        try
            paramvalue = get_param([handles.sysname,'/',cellData{ rowIDX,1 } ],answer{1});
        catch %#ok<CTCH>
            errordlg(['Parameter ',answer{1},' not found for block ',cellData{ rowIDX,1 },'!']);
            return
        end
    case 'Cancel'
        return;
end
if ~isempty( answer{1} ) && ~isempty( paramvalue )
    cellData = get(handles.t,'Data');
    % Determine next free position in cell data
    % Check for length AND last empty cell
    posLast = length( cellData( rowIDX,:));
    while isempty( cellData{ rowIDX,posLast } )
        posLast = posLast - 1;
    end
    posNew = posLast + 1;
    cellData{ rowIDX, posNew } = answer{1};
    cellData{ rowIDX, posNew+1 } = paramvalue;
    % Adapt column names if necessary
    cnames = get(handles.t,'ColumnName');
    columneditable = get(handles.t,'ColumnEditable');
    if length( cnames ) < posNew+1
        %do something
        cnames{posNew} = 'Parameter Name';
        cnames{posNew + 1} = 'Value';
        columneditable(posNew) = false;
        columneditable(posNew + 1) = true;
        set(handles.t,'ColumnName',cnames);
        set(handles.t,'ColumnEditable',columneditable);
    end
    set(handles.t,'Data',cellData);
end

% --- Executes on button press in pushbutton_removeParameter.
function pushbutton_removeParameter_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_removeParameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    if ~isfield(handles,'selected_cells') || isempty(handles.selected_cells)
        errordlg('No row(s) selected');
        return
    end
    IDX = handles.selected_cells; % Contains indices of the selected cells
    if size( IDX,1 ) > 1
       errordlg('Please select only one cell to delete parameter values');
       return
    end
    rowIDX = IDX(1);
    colIDX = IDX(2);
    cellData = get(handles.t,'Data');
    if colIDX == 1
        pushbutton2_Callback(hObject, eventdata, handles);
    end
    % determine colIDXs to delete entries    
    if rem( colIDX,2 ) == 0
        colIDX = [colIDX colIDX+1];
    else
        colIDX = [colIDX-1 colIDX];
    end
    if or( isempty( cellData{rowIDX,colIDX(1)} ),...
            isempty( cellData{rowIDX,colIDX(2)} ))
        errordlg('No parameter contained in selected cell(s)');
        return
    else
        cellData{rowIDX,colIDX(1)} = [];
        cellData{rowIDX,colIDX(2)} = [];
        % Check if table contains empty cols; if yes, remove them
        if all( all( cellfun(@isempty, cellData(:,colIDX(1:2)) ) ) )
            if size( cellData,2 ) > colIDX(2)
                % shift all cols on the RHS to the left by 2
                cellData(:,colIDX(1):end-2) = cellData(:,colIDX(2)+1:end);
                cellData = cellData(:,1:end-2);
            else
                % simply remove these two cols
                cellData = cellData(:,1:colIDX(1)-1);               
            end
        end
        colNames = get(handles.t,'ColumnName');
        dimCellCols = size( cellData,2 );
        colNames = colNames(1:dimCellCols);
        set(handles.t,'Data',cellData,'ColumnName',colNames);
    end   
catch %#ok<CTCH>
   % 
end

% --- Executes on button press in pushbutton_testValueSet.
function pushbutton_testValueSet_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_testValueSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(regexp( handles.sysname, '_CHECKED', 'once'))
    handles.pathname = [pwd filesep 'templates' filesep 'import' filesep];
else
    handles.pathname = handles.sys2Import{end,2};
end
disp('Testing parameter set...');
[dimension choice ME1 ME2] = testingValueSet( handles,0 );
if strcmp( choice, 'yes' )
    handles.succTest = 1;
    handles.dimension = dimension;
    guidata(hObject, handles);
    disp('Parameter tested successfully');
else
    disp('Testing failed. Maybe the following message will help you to find the error:');
    if ~isempty(ME1)
        disp(ME1.message);
    end
    if ~isempty(ME2)
        disp(ME2.message);
    end
end

% --- Executes on button press in pushbutton_finishImport.
function pushbutton_finishImport_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_finishImport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.succTest
    choice = 'yes';
    dimension = handles.dimension;
else
    handles.pathname = handles.sys2Import{end,2};
    [dimension choice ] = testingValueSet( handles,0 );
end
% In case of being successful, store parameters
if strcmp(choice,'yes')
    Data = get(handles.t,'Data');
    answer(1) = regexp( handles.sys2Import{1}, '\w*(?=.mdl)','match' );
    pathname = [handles.pathname 'import' filesep];
    % copy also data=>use existing table
    [success errMessage ] = saveParamSet2File(handles.TextField1InputSpecs,...
        handles.TextField2InputSpecs, answer{1}, handles.edit_save2File,...
        Data, dimension, pathname);
    % close figure
    if success
        if ~exist( [answer{1} '_CHECKED.mdl'],'file')
            save_system( handles.sysname, [pathname answer{1} '_CHECKED.mdl']);
        else
            errordlg({'A template with this name still exists.',...
                'Please check if the new template is not identical to the existing one.',...
                'If so, use "Edit parameter set" to create new value sets.',...
                'If not, rename new template.'});
            return
        end
        bdclose;
        % read new template_list
        paramValueSets = readImportedTemplates;
        for kk = 1:length( paramValueSets )
            handles.templateNames{kk} = paramValueSets(kk).name;
            handles.templateSets{kk} = paramValueSets(kk).sets;
        end
        initDropdownMenuTemplates( handles );    
        % clean up table
        set(handles.edit_save2File,'String','');
        choice = questdlg('Import is finished. What do you like to do?', ...
            'Import successful', ...
            'Edit params sets','New import','Exit','New import');
        switch choice
            case 'Edit params sets';
                % switch mode
                evtdat.EventName = 'SelectionChanged';
                evtdat.OldValue = handles.radiobutton_newImport;
                evtdat.NewValue = handles.radiobutton_editParamSets;
                set(handles.radiobutton_editParamSets,'Value',1.0);
                set(handles.radiobutton_newImport,'Value',0.0);
                % make new templates available internally before invoking
                % "selectionChangeFcn"
                handles = uipanel_mode_SelectionChangeFcn(handles.uipanel_mode, evtdat, handles);
                % select new imported set
                idxNewTempl = find( strcmp( get(handles.popupmenu_template,'String'), answer{1} ));
                idxNewSet = 1;
                set(handles.popupmenu_template,'Value',idxNewTempl);
                handles = popupmenu_template_Callback(handles.popupmenu_template, [], handles);
            case 'New import';
                % do nothing
            case 'Exit';
                % leave 'manageParamSets'
                figure1_CloseRequestFcn(handles.figure1, [], handles);
                return
        end        
        
        % saving new handles
        guidata(handles.figure1, handles);

    else
        disp('Could not save parameter set due to following reason:');
        if ~isempty(errMessage)
           disp(errMessage); 
        end
    end
else
    disp('Testing of parameter set failed.');
end

% --- Executes on selection change in popupmenu_valueSet.
function handles = popupmenu_valueSet_Callback(hObject, eventdata, handles) %#ok<*INUSL>
% hObject    handle to popupmenu_valueSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_valueSet contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_valueSet
if ~handles.noChanges && strcmp(handles.mode,'edit')
    choice = questdlg('Discard changes to current parameter set?', ...
        'Switch parameter set', ...
        'Yes','No','No');
    switch choice
        case 'Yes';
            handles = loadTableFromStruct( hObject,handles );
        case 'No';
            return
    end
else
    handles = loadTableFromStruct( hObject,handles );
end
idxSet = get(handles.popupmenu_valueSet,'Value');
idxTempl = get(handles.popupmenu_template,'Value');
isActive = handles.templateSets{idxTempl}(idxSet).isActive;
set(handles.togglebutton_setActive,'Value',isActive);
if isActive
    set(handles.togglebutton_setActive,'BackgroundColor',[0.702 0.85 0.443]);
else
    set(handles.togglebutton_setActive,'BackgroundColor',[.702 .702 .702]);
end
guidata(hObject,handles);


% --- Executes on button press in pushbutton_deleteSet.
function pushbutton_deleteSet_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_deleteSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
answer = questdlg(['Delete current parameter set "' get(handles.edit_save2File,'String') '"?' ],...
    'Delete parameter set');
if strcmp( answer,'Yes')
    flagDelete = 0;
    setName = get(handles.edit_save2File,'String');
    templName = handles.templateNames{ get(handles.popupmenu_template,'Value') };
    pathname = [pwd filesep 'templates' filesep 'import' filesep];
    load([pathname templName '_paramValues.mat']);
    varName = [templName '_paramValues'];
    eval(['len = length(' varName ');']);
    if len > 1
        for kk = 1:len
            eval(['match = strcmp(' varName '(kk).setName, setName );']);
            if match
                eval([varName '(kk) = [];']);
                mess = ['Parameter set "' setName '" deleted'];
                flagDelete = 1;
                break
            end
        end
        if ~flagDelete
            mess = ['Parameter set "' setName '" not found'];
        end
    else
        mess = 'At least one parameter set must remain';
    end
    if flagDelete
        % store set struct
        save([pathname varName],varName);
        % read in updated param sets
        paramValueSetsNew = readImportedTemplates;
        for kk = 1:length( paramValueSetsNew )
            handles.templateNames{kk} = paramValueSetsNew(kk).name;
            handles.templateSets{kk} =  paramValueSetsNew(kk).sets;
        end
        handles.noChanges = 1;
        handles = popupmenu_template_Callback( handles.popupmenu_template,[],handles );
        idxTemp = find( strcmp( get(handles.popupmenu_template,'String'),templName));
        set(handles.popupmenu_template,'Value',idxTemp);
        handles = popupmenu_valueSet_Callback(handles.popupmenu_valueSet, [], handles);
        guidata(hObject,handles);
    end
    disp(mess);
end

% --- Executes on button press in togglebutton_setActive.
function handles = togglebutton_setActive_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton_setActive (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of togglebutton_setActive
if get(hObject,'Value')
    set(handles.togglebutton_setActive,'BackgroundColor',[0.702 0.85 0.443]);
else
    set(handles.togglebutton_setActive,'BackgroundColor',[.702 .702 .702]);
end
handles.noChanges = 0;
guidata(hObject, handles);

% --- Executes when selected cell(s) is changed
function table_CellSelectionCallback(src,evt,handles)
handles.selected_cells = evt.Indices;
guidata(src, handles);


function handles = loadTableFromStruct( hObject,handles )
%LOADTABLEFROMSTRUCT
%  This function loads data into a table, which comes from a structure,
%  describing the parameters of a dynamic template
if strcmp( handles.mode,'edit')
    idxSelectedTemplate = get(handles.popupmenu_template,'Value');
    idxSelectedSet = get(handles.popupmenu_valueSet,'Value');
    set(handles.TextField2InputSpecs,'String', ...
        num2str( handles.templateSets{idxSelectedTemplate}(idxSelectedSet).inputSpec.noOfIntInputs ) );
    inputStrg = [];
    for kk = 1:length( handles.templateSets{idxSelectedTemplate}(idxSelectedSet).inputSpec.Vars )
        inputStrg = [inputStrg ', ' handles.templateSets{idxSelectedTemplate}(idxSelectedSet).inputSpec.Vars{kk}]; %#ok<AGROW>
    end
    set(handles.TextField1InputSpecs,'String', inputStrg(3:end) );
    tableRowNames = handles.templateSets{idxSelectedTemplate}(idxSelectedSet).set(:,1);
    tableData = handles.templateSets{idxSelectedTemplate}(idxSelectedSet).set;
    cnames = cell( size(tableData,2) , 1 );
    cnames{1} = 'Block Name';
    columneditable = logical( zeros(1, size(tableData,2) )); %#ok<LOGL>
    for i = 1:floor( size(tableData,2) / 2)
        cnames{2*i} = 'Parameter Name';
        cnames{2*i + 1} = 'Value';
        columneditable(2*i) = false;
        columneditable(2*i + 1) = true;
    end
    columnformat = repmat( {'char'}, 1,size(tableData,2) );
    set(handles.t,'CellSelectionCallback',...
        {@table_CellSelectionCallback,handles},'CellEditCallback',...
        {@table_CellEditCallbackFcn,handles},'RowName',tableRowNames,...
        'Data',tableData,'ColumnName',cnames,...
        'ColumnEditable', columneditable,'ColumnFormat',columnformat);
    set(handles.edit_save2File,'String',handles.templateSets{idxSelectedTemplate}(idxSelectedSet).setName);
else
    % clear table and according text fields
    set(handles.TextField2InputSpecs,'String', num2str(0) );
    set(handles.TextField1InputSpecs,'String', '' );
    set(handles.t,'CellSelectionCallback',...
        {@table_CellSelectionCallback,handles},'CellEditCallback',...
        {@table_CellEditCallbackFcn,handles},'RowName',{'1','2'},...
        'Data',{'','';'',''},'ColumnName',{'a','b'});
    set(handles.edit_save2File,'String','');
end
handles.noChanges = 1;
handles.succTest = 1;


% --- Executes when cell(s) is (are) edited
function table_CellEditCallbackFcn(src,evt,handles) %#ok<INUSL>
% success = 0;
% Get indices of edited cell
IDX = evt.Indices;
rowIDX = IDX(1);
colIDX = IDX(2);
cellData = get(handles.t,'Data');
handles.sysname = gcs;
success = isValidData( handles, rowIDX, colIDX );
if ~success
    errordlg('Parameter value not possible');
    % Restore old data
    cellData{ rowIDX,colIDX } = evt.PreviousData;
    set(handles.t,'Data',cellData);
else
    handles.noChanges = 0;
    handles.succTest = 0;
end
guidata(src,handles);

function handles = handleOpenSystems( handles )
%HANDLEOPENSYSTEMS
% This function handles the opened simulink systems, which are necessary
% due to various checks, if parameter sets are feasible or not.
% close gcs if it belongs to our current database
currSys = gcs;
currSys = currSys( 1:regexp( currSys, '_CHECKED' )-1);
if any(~cellfun(@isempty,regexp( handles.templateNames, currSys )))
    close_system(gcs,0);
else
    currSys = gcs;
    if any(~cellfun(@isempty,regexp( handles.sys2Import(:,1), currSys )))
        close_system(gcs,0);
    end
end
% if mode==edit, load sys which is selected in popupmenu_template
switch handles.mode
    case 'edit';
        idxSelSys = get(handles.popupmenu_template,'Value');
        allNames = get(handles.popupmenu_template,'String');
        selSys = allNames{idxSelSys};
        handles.sysname = [selSys '_CHECKED'];
        load_system(handles.sysname);
% if mode==import, close all systems and start import routine, which
%       necessarily opens the new template                
    case 'import';
        if isempty(handles.sys2Import)
            % could not load model => exit fcn
            return
        else
            nameSys2Import = handles.sys2Import{end,1};
            pathSys2Import = handles.sys2Import{end,2};
            currPath = pwd;
            cd(pathSys2Import);
            load_system(nameSys2Import);
            cd(currPath);
        end
end

function handles = buildTableFromTemplate( handles )
%BUILDTABLEFROMTEMPLATE
% This function creates a new table from a dynamic template
blks = find_system(gcs, 'Type', 'block');
listblks = get_param(blks, 'BlockType');
listnms = get_param(blks,'Name');
listnms( ~cellfun( @isempty, regexp( listblks,...
    'Inport|Outport|Sum|Mux|Math|Scope|ToWorkspace','start')) ) = [];
listblks( ~cellfun( @isempty, regexp( listblks,...
    'Inport|Outport|Sum|Mux|Math|Scope|ToWorkspace','start')) ) = [];
% Filling the data cells
dat = cell(length(listblks),3);
dat(:,1) = listnms;
for i = 1:length(listblks)
    [ paramname paramvalue ] = get_BlockParams( listblks{i},handles,listnms{i} );
    for j = 1:length(paramname)
        dat{i,2*j} = paramname{j};
        dat{i,1+2*j} = paramvalue{j};
    end
end
cnames = cell( size(dat,2) , 1 );
cnames{1} = 'Block Name';
columneditable = logical( zeros(1, size(dat,2) )); %#ok<LOGL>
for i = 1:floor( size(dat,2) / 2)
    cnames{2*i} = 'Parameter Name';
    cnames{2*i + 1} = 'Value';
    columneditable(2*i) = false;
    columneditable(2*i + 1) = true;
end
columnformat = repmat( {'char'}, 1,size(dat,2) );
set(handles.t,'RowName',listblks,'ColumnName',cnames,...
    'Data',dat, 'ColumnEditable', columneditable,...
    'BackgroundColor',[1 1 1],'ColumnFormat',columnformat,'CellSelectionCallback',...
    {@table_CellSelectionCallback,handles},'CellEditCallback',...
    {@table_CellEditCallbackFcn,handles});
handles.noChanges = 1;
handles.succTest = 0;


% --- Executes on button press in pushbutton_debug.=>CLOSE-Button
function pushbutton_debug_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_debug (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% assignin('base','h',handles);
% disp(['handles.noChanges : ' num2str( handles.noChanges ) ]);
% disp(['handles.succTest : ' num2str( handles.succTest ) ]);
figure1_CloseRequestFcn(hObject, eventdata, handles);

function edit_save2File_Callback(hObject, eventdata, handles) %#ok<INUSD>
% hObject    handle to edit_save2File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of edit_save2File as text
%        str2double(get(hObject,'String')) returns contents of edit_save2File as a double

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: delete(hObject) closes the figure
uiresume(handles.figure1);

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over togglebutton_setActive.
function togglebutton_setActive_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to togglebutton_setActive (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% function TextField1InputSpecs_Callback(hObject, eventdata, handles)
% % hObject    handle to TextField1InputSpecs (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% % Hints: get(hObject,'String') returns contents of TextField1InputSpecs as text
% %        str2double(get(hObject,'String')) returns contents of TextField1InputSpecs as a double
% handles.noChanges = 0;
% guidata(hObject,handles);

function TextField2InputSpecs_Callback(hObject, eventdata, handles)
% hObject    handle to TextField2InputSpecs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of TextField2InputSpecs as text
%        str2double(get(hObject,'String')) returns contents of TextField2InputSpecs as a double
handles.noChanges = 0;
guidata(hObject,handles);
