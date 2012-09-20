function varargout = manageParamSets(varargin)
% MANAGEPARAMSETS MATLAB code for manageParamSets.fig
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

% Last Modified by GUIDE v2.5 20-Sep-2012 17:24:08

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
popupmenu_template_Callback(handles.popupmenu_template, eventdata, handles);
setPanelModeActions( handles,hObject );
setObjectPositions( handles );
loadTableFromStruct( handles.popupmenu_valueSet,handles );
handles = handleOpenSystems( handles );
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes manageParamSets wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = manageParamSets_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes when selected object is changed in uipanel_mode.
function uipanel_mode_SelectionChangeFcn(hObject, eventdata, handles) %#ok<*DEFNU>
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
handleOpenSystems( handles );
loadTableFromStruct( hObject,handles );
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
        % position for both dropdown-menues
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
        % position for load-button
        
end
set(handles.uipanel_modeActions,'Title',title);
guidata(hObject, handles);


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
function popupmenu_template_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_template (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_template contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_template
if handles.readTemplateList
    
end
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
handleOpenSystems( handles );
popupmenu_valueSet_Callback(hObject, eventdata, handles);


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
buildTableFromTemplate( handles );
guidata(hObject, handles);

% --- Executes on button press in pushbutton_save2File.
function pushbutton_save2File_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save2File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_addBlock.
function pushbutton_addBlock_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_addBlock (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_removeBlock.
function pushbutton_removeBlock_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_removeBlock (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_addParameter.
function pushbutton_addParameter_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_addParameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_removeParameter.
function pushbutton_removeParameter_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_removeParameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_testValueSet.
function pushbutton_testValueSet_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_testValueSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if regexp( handles.sysname, '_CHECKED')
    handles.pathname = [pwd filesep 'templates' filesep 'import' filesep];
end
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


% --- Executes on selection change in popupmenu_valueSet.
function popupmenu_valueSet_Callback(hObject, eventdata, handles) %#ok<*INUSL>
% hObject    handle to popupmenu_valueSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_valueSet contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_valueSet
if ~handles.noChanges
    choice = questdlg('Discard changes to current parameter set?', ...
        'Switch parameter set', ...
        'Yes','No','No');
    switch choice
        case 'Yes';
            loadTableFromStruct( hObject,handles );
        case 'No';
            return
    end
else
    loadTableFromStruct( hObject,handles );
end


% --- Executes on button press in pushbutton_deleteSet.
function pushbutton_deleteSet_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_deleteSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in togglebutton_setActive.
function togglebutton_setActive_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton_setActive (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of togglebutton_setActive
if get(hObject,'Value')
    set(handles.togglebutton_setActive,'BackgroundColor',[0.702 0.85 0.443]);
else
    set(handles.togglebutton_setActive,'BackgroundColor',[.702 .702 .702]);
end

% --- Executes when selected cell(s) is changed
function table_CellSelectionCallback(src,evt,handles)
handles.selected_cells = evt.Indices;
guidata(src, handles);


function loadTableFromStruct( hObject,handles )
%LOADTABLEFROMSTRUCT
%  This function loads data into a table, which comes from a structure,
%  describing the parameters of a dynamic template
if strcmp( handles.mode,'edit')
idxSelectedTemplate = get(handles.popupmenu_template,'Value');
idxSelectedSet = get(hObject,'Value');
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
guidata(hObject,handles);


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

function buildTableFromTemplate( handles )
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
guidata(hObject,handles);


% --- Executes on button press in pushbutton_debug.
function pushbutton_debug_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_debug (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
assignin('base','h',handles);
