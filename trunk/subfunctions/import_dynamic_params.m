function varargout = import_dynamic_params(varargin)
% IMPORT_DYNAMIC_PARAMS MATLAB code for import_dynamic_params.fig
%      IMPORT_DYNAMIC_PARAMS, by itself, creates a new IMPORT_DYNAMIC_PARAMS or raises the existing
%      singleton*.
%
%      H = IMPORT_DYNAMIC_PARAMS returns the handle to a new IMPORT_DYNAMIC_PARAMS or the handle to
%      the existing singleton*.
%
%      IMPORT_DYNAMIC_PARAMS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMPORT_DYNAMIC_PARAMS.M with the given input arguments.
%
%      IMPORT_DYNAMIC_PARAMS('Property','Value',...) creates a new IMPORT_DYNAMIC_PARAMS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before import_dynamic_params_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to import_dynamic_params_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help import_dynamic_params

% Last Modified by GUIDE v2.5 20-Aug-2012 09:56:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @import_dynamic_params_OpeningFcn, ...
                   'gui_OutputFcn',  @import_dynamic_params_OutputFcn, ...
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


% --- Executes just before import_dynamic_params is made visible.
function import_dynamic_params_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to import_dynamic_params (see VARARGIN)

%% Callback Functions

% Choose default command line output for import_dynamic_params
handles.output = hObject;

listBlks = varargin{1};
listnms = varargin{2};
filename = varargin{3};
m=regexp( filename, '\.', 'split','once');
handles.sysname = m{1};

%% Geometry
screenSize = get( 0, 'ScreenSize' );
topFrame = 30;
bottomFrame = 0.5*topFrame;
sideFrame = 0.5*topFrame;

nrBlks = length(listBlks);

topGap = 1/12*screenSize(4);
left = screenSize(3)*0.1;
% Compute height only depending on the table
height = get_figureHeight( nrBlks );

if screenSize(3)*0.9 > 760
    width = 760;
else
    width = screenSize(3)*0.85;
end

bottom = screenSize(4) - topGap - height;
posVector = [left bottom width height]; %do this dynamically % [left, bottom, width, height]


%% Creating Figure

% creating elements
handles.uipanel1 = uipanel;
handles.t = uitable;
handles.PanelTextInputSpecs = uipanel;
handles.TextField1InputSpecs = uicontrol;
handles.TextField2InputSpecs = uicontrol;
handles.TextField1Descrptn = uicontrol;
handles.TextField2Descrptn = uicontrol;
% handles.textBlockType = uicontrol;

% setting figure parameters manually
defaultBackground = get(0,'defaultUicontrolBackgroundColor');
save('posVecFigure','posVector');
set(hObject,'Position',posVector,'Name','Import Dynamic Wizard','Toolbar','none',...
    'MenuBar','none','Resize','on','ResizeFcn',{@figResize,handles},'Color',...
    defaultBackground,'Units','pixels');%,'CloseRequestFcn',{@figure1_CloseRequestFcn,handles});


%% Filling the data cells
dat = cell(length(listBlks),3);
dat(:,1) = listnms;
for i = 1:length(listBlks)
    % if there are well known block types here, we can provide some
    % initialisation of the table. If not, declare parameters names
    % otherwise
    [ paramname paramvalue ] = get_BlockParams( listBlks{i},handles,listnms{i} );
    % Filling the data cells
    for j = 1:length(paramname)
        dat{i,2*j} = paramname{j};
        dat{i,1+2*j} = paramvalue{j};
    end
end

%% Set Column names and "edit cell" properties
cnames = cell( size(dat,2) , 1 );
cnames{1} = 'Block Name';
columneditable = logical( zeros(1, size(dat,2) ));
for i = 1:floor( size(dat,2) / 2)
    cnames{2*i} = 'Parameter Name';
    cnames{2*i + 1} = 'Value';
    columneditable(2*i) = false;
    columneditable(2*i + 1) = true;
end
columnformat = repmat( {'char'}, 1,size(dat,2) );

%% Column and cell format computations
% width of table should be adapted on content or column cells
% idea: compute number of symbols which are spread horizontally
heightTable = 1.25*sizeChar2Pixel(hObject, 'h', ( nrBlks + 2 ) );
[ widthTable columnwidth] = get_tableColumnWidth(hObject,listBlks,dat,cnames);
widthFigure = widthTable + 140;

%% Prepare table position properties
posVecTable = [1.5*sideFrame 5*bottomFrame widthTable heightTable]; % [left, bottom, width, height]
if widthFigure > screenSize(3)
    widthFigure = screenSize(3);
    posVector(1) = 0;
end

%% Creating Figure Content
posVector(3) = widthFigure;
set(hObject,'Position',posVector);

% parameters for panel, in which all other control elements are positioned
% posVectorPanel = get_panelPosition(widthTable, height);
posVectorPanel = [sideFrame bottomFrame width-2*sideFrame height-topFrame]; % [left, bottom, width, height]

save('posVecPanel','posVectorPanel');
set(handles.uipanel1,'Parent',hObject,'Title',['Collecting parameters for model ''',...
    handles.sysname char(39)],'Units','pixel','Position',posVectorPanel);

set(handles.t,'Units','pixel');
save('posVecTable');
set(handles.t,'RowName',listBlks,'ColumnName',cnames,'Position',posVecTable,...
    'ColumnWidth',columnwidth,'Data',dat, 'ColumnEditable', columneditable,...
    'BackgroundColor',[1 1 1],'ColumnFormat',columnformat,'CellSelectionCallback',...
    {@table_CellSelectionCallback,handles},'CellEditCallback',...
    {@table_CellEditCallbackFcn,handles});

%% parameters for pushbuttons
horPosPushbutton1 = 0.1*widthFigure;
posVectorSubmitButton = [horPosPushbutton1 1.7*bottomFrame 120 35];
set(handles.pushbutton1,'Units','pixels','Position',posVectorSubmitButton,...
    'String','Add Block');

horPosPushbutton2 = 0.4*widthFigure;
posVectorCancelButton = [horPosPushbutton2 1.7*bottomFrame 120 35];
set(handles.pushbutton2,'Units','pixels','String','Remove Block',...
                'Position',posVectorCancelButton);

horPosPushbutton3 = 0.7*widthFigure;
posVectorAddParamButton = [horPosPushbutton3 1.7*bottomFrame 120 35];
set(handles.pushbutton3,'Units','pixels','String','Add Parameter',...
                'Position',posVectorAddParamButton);
            
horPosPushbutton4 = 0.1*widthFigure;
posVectorDebugButton = [horPosPushbutton4 5.0*bottomFrame 120 35];
set(handles.pushbutton4,'Units','pixels','String','Remove Parameter',...
                'Position',posVectorDebugButton);
            
horPosPushbutton5 = 0.4*widthFigure;
posVectorDebugButton1 = [horPosPushbutton5 5.0*bottomFrame 120 35];
set(handles.pushbutton5,'Units','pixels','String','TESTING',...
                'Position',posVectorDebugButton1); 

%% Text fields for input specifications
% Position of design elements
posVecPanelTextInputSpecs = [2*sideFrame 5.5*bottomFrame+35 width-2*sideFrame 50]; % [left, bottom, width, height]
% posVecTextField1InputSpecs ('Style': edit)
posVecTextField1InputSpecs = [170 8 80 22];
% posVecTextField2InputSpecs ('Style': edit)
posVecTextField2InputSpecs = [370 8 80 22];
% posVecTextField1Descrptn ('Style': text )
posVecTextField1Descrptn = [20 3 150 30];
% posVecTextField2Descrptn ('Style': text )
posVecTextField2Descrptn = [270 3 100 30];
            
% Setting design elements
set(handles.PanelTextInputSpecs,'Parent',hObject,'Title','Input Specifications',...
    'Units','pixel','Position',posVecPanelTextInputSpecs);
set(handles.TextField1InputSpecs,'Parent',handles.PanelTextInputSpecs,...
    'Style','edit','Units','pixel','Position',posVecTextField1InputSpecs,...
    'BackgroundColor',[1 1 1],'Callback',{@TextField1InputSpecs_Callback,handles});
TextField1Descrptn_String = 'Parameters depending on number of external inputs';
set(handles.TextField1Descrptn,'Style','text','Parent',handles.PanelTextInputSpecs,...
    'Units','pixel','Position',posVecTextField1Descrptn,'String',TextField1Descrptn_String);
TextField2Descrptn_String = 'Thereof number of internal inputs';
set(handles.TextField2Descrptn,'Style','text','Parent',handles.PanelTextInputSpecs,...
    'Units','pixel','Position',posVecTextField2Descrptn,'String',TextField2Descrptn_String);
set(handles.TextField2InputSpecs,'Parent',handles.PanelTextInputSpecs,...
    'Style','edit','Units','pixel','Position',posVecTextField2InputSpecs,...
    'BackgroundColor',[1 1 1],'Callback',{@TextField2InputSpecs_Callback,handles});

% handles.handles.textBlockType = uicontrol('Style','text','FontWeight','demi','FontSize',10,...
%     'Position',[45 height-1.725*topFrame 100 18],... % [left, bottom, width, height]
%     'String','Block Type');
%             
% "Dirty": Prompt Block Type above the row names
% set(handles.textBlockType,'Style','text','FontWeight','demi','FontSize',10,...
%     'Position',[45 height-1.725*topFrame 100 18],... % [left, bottom, width, height]
%     'String','Block Type');
% uistack(handles.textBlockType,'top');

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes import_dynamic_params wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = import_dynamic_params_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = 1; %handles.output;


% --- Executes on button press in pushbutton1. ADD BLOCK
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% determine length of row labeling vector
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
listsize = [1.2*sizeChar2Pixel(hObject,'w', 3+max(cellfun(@length,listOutString))) ...
    1.2*sizeChar2Pixel(hObject,'h',size(listOutString,1)+1 )];
newBlockNameIndex = listdlg('PromptString','Select a Block Name:',...
    'SelectionMode','single','ListSize',listsize,...
    'ListString',listOutString);
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

% Computing new positions
newTablePosition( handles,eventdata, rownames, dataNew );


% --- Executes on button press in pushbutton2. REMOVE BLOCK
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
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
            newTablePosition( handles,eventdata, rownamesNew, data );
        case 'No';
            % do nothing
    end
catch
    errordlg('No row(s) selected');
    return
end

% --- Executes on button press in pushbutton3. ADD PARAMETER
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Case handling: if no cells are selected

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
        listsize = [1.4*sizeChar2Pixel(hObject,'w', 3+max(cellfun(@length,namesAllParams))) ...
            1.3*sizeChar2Pixel(hObject,'h',size(namesAllParams,1)+1 )];
        newParamIndex = listdlg('PromptString','Select a parameter:',...
            'SelectionMode','single','ListSize',listsize,...
            'ListString',namesAllParams);
        if isempty( newParamIndex )
            return;
        end
        answer(1) = namesAllParams( newParamIndex );
%         rowname = get(handles.t,'RowName');
%         prompt = {'Enter parameter value:'};
%         title = ['New Parameter Name in Block ',rowname{rowIDX}];
%         num_lines = 1;
%         def = {'paramvalue'};
%         answer(2) = inputdlg(prompt,title,num_lines,def);
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
        catch
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
    % Computing new positions
    newTablePosition( handles,eventdata, get(handles.t,'RowName'), cellData );
end


% --- Executes on button press in pushbutton4. REMOVE_PARAMETER
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
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
    %     rowname = get(handles.t,'RowName');
    cellData = get(handles.t,'Data');
    % Getting access to a specific block in the model, whose name is contained
    % in handles.sysname; the block name is contained in the first row
%     get_param([handles.sysname '/' cellData{rowIDX,1}],'Dialogparameters');
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
    
catch
   % 
end

% --- Executes on button press in pushbutton5. TESTING
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Checking if there is always a parameter value stored
misses = 0;
notValid = 0;
Data = get(handles.t,'Data');
for ii = 1:size( Data,1 )
    for jj = 2:2:size( Data,2 )
        paramExists = ~isempty( Data{ii,jj} );
        valueExists = ~isempty( Data{ii,jj+1} );
        if paramExists && ~valueExists
            misses = misses + 1;     
        end
        if paramExists && valueExists
            isValid = isValidData( handles, ii, jj+1 );
            if ~isValid
                notValid = notValid + 1;
            end
        end
    end
end
if misses
   errordlg(['At least one parameter values is missing.'...
       'Please add it (them).']);
   return
end
if notValid
   errordlg(['At least one parameter value is not feasible '...
       'for its specific block type. Please correct it (them).']);
   return
end

% Collecting all parameters and writing it into a copy of the Model
save_system( handles.sysname, [pwd filesep handles.sysname '_tempCopy']);
Data = get(handles.t,'Data');
for ii = 1:size( Data,1 )
    for jj = 2:2:size( Data,2 )
        paramExists = ~isempty( Data{ii,jj} );
        valueExists = ~isempty( Data{ii,jj+1} );        
        % store numerical values into temporal copy of model
        if paramExists && valueExists
            set_param([handles.sysname '_tempCopy/' Data{ii,1} ], Data{ii,jj}, Data{ii,jj+1} );
        end      
    end
end

% Perform simulation with model
choice = 'No';
try
    % Adapt "/Mux" according to specified inputs
    
    simout = sim( [handles.sysname '_tempCopy'],'StopTime','0.1',...
        'SaveState','on','StateSaveName','xoutNew','SaveOutput','on',...
        'OutputSaveName','youtNew');
    dimension.states = size( simout.get('xoutNew'),2 );
    dimension.outputs = size( simout.get('youtNew'),2 );
    if ~isempty( simout )
        title = 'Testing suceeded';
        qstring = {'Variable check and explicit model simulation test suceeded.',...
            'Should the template import to MTIDS be finished?' };
        choice = questdlg(qstring,title,'Yes','No','No');
    end
catch ME_testSimulation
    errordlg(['The explicit test simulation of the simulink model failed. '...
        'Maybe this message will help you finding the error: '...
        ME_testSimulation.message ]);
end
bdclose;
delete([pwd filesep handles.sysname '_tempCopy.mdl']);
load_system( [pwd filesep handles.sysname] );
if strcmp(choice,'Yes')
    % copy model to \import
    % ask for new filename
    prompt = {'Enter name of imported template:'};
    dlg_title = 'Name of imported template';
    num_lines = 1;
    def = {handles.sysname};
    answer = inputdlg(prompt,dlg_title,num_lines,def);
    pathname = [pwd filesep 'import' filesep];
    save_system( handles.sysname, [pathname answer{1} '_CHECKED']);    
    % copy also date=>use existing table
    flagEqual = 0;
    if exist([pathname answer{1} '_paramValues.mat'],'file')
        load([pathname answer{1} '_paramValues']);
        % check if the paramSet still exists        
        eval(['idx = length( ' answer{1} '_paramValues);']);
        for ii = 1:idx
            cmd2 = ['flagEqual = isequal(Data,' answer{1} ...
                '_paramValues(' num2str(ii) ').set);'];
            eval( cmd2 );
            if flagEqual == 1
%                msgbox('Parameter set still exists');
               break 
            end
        end
        if flagEqual == 0
            cmd1 = [answer{1} '_paramValues(' num2str(idx+1) ').set = '...
                'Data;'];
            eval( cmd1 );
        end
    else
        eval([answer{1} '_paramValues.set = Data;']);       
    end
    if flagEqual == 0
        save([pathname answer{1} '_paramValues'],[answer{1} '_paramValues'],...
            dimension);
    end
    % close figure
    bdclose;
    figure1_CloseRequestFcn(handles.figure1, eventdata, handles);
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: delete(hObject) closes the figure
handles.OutputFlag = 1;
guidata(hObject, handles);
%     uiresume(handles.figure1);
delete(hObject);
     

function height = get_figureHeight( nrBlks )
% Set the height of the figure
fixedHeight = 170 + 60; % + 60 due to new elements
rowHeight = 25;
height = fixedHeight + nrBlks*rowHeight;

% --- Executes when selected cell(s) is changed
function table_CellSelectionCallback(src,evt,handles)
handles.selected_cells = evt.Indices;
guidata(src, handles);

% --- Executes when cell(s) is (are) edited
function table_CellEditCallbackFcn(src,evt,handles)
% success = 0;
% Get indices of edited cell
IDX = evt.Indices;
rowIDX = IDX(1);
colIDX = IDX(2);
cellData = get(handles.t,'Data');
success = isValidData( handles, rowIDX, colIDX );
if ~success
    errordlg('Parameter value not possible');
    % Restore old data
    cellData{ rowIDX,colIDX } = evt.PreviousData;
    set(handles.t,'Data',cellData);
end


function geo_params = get_initialGeometry
screenSize = get( 0, 'ScreenSize' );
geo_params.topFrame = 30;
geo_params.bottomFrame = 0.5*geo_params.topFrame;
geo_params.sideFrame = 0.5*geo_params.topFrame;
if screenSize(3)*0.9 > 760
    geo_params.width = 760;
else
    geo_params.width = screenSize(3)*0.85;
end




%%%%%ENDOFSCRIPT%%%%%%%%%%%
