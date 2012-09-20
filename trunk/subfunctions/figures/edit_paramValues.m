function varargout = edit_paramValues(varargin)
% EDIT_PARAMVALUES MATLAB code for edit_paramValues.fig
%      EDIT_PARAMVALUES, by itself, creates a new EDIT_PARAMVALUES or raises the existing
%      singleton*.
%
%      H = EDIT_PARAMVALUES returns the handle to a new EDIT_PARAMVALUES or the handle to
%      the existing singleton*.
%
%      EDIT_PARAMVALUES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EDIT_PARAMVALUES.M with the given input arguments.
%
%      EDIT_PARAMVALUES('Property','Value',...) creates a new EDIT_PARAMVALUES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before edit_paramValues_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to edit_paramValues_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help edit_paramValues

% Last Modified by GUIDE v2.5 20-Sep-2012 09:28:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @edit_paramValues_OpeningFcn, ...
                   'gui_OutputFcn',  @edit_paramValues_OutputFcn, ...
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


% --- Executes just before edit_paramValues is made visible.
function edit_paramValues_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to edit_paramValues (see VARARGIN)
data.template = varargin{1};
data.templateSaved = 0;
handles.sysname = [data.template{1,1} '_CHECKED'];
handles.pathname = [pwd filesep 'templates' filesep 'import' filesep];
load_system( [handles.pathname handles.sysname] );
% Standard: output will not be saved
handles.flagOutput = 0;
% Initialise ui elements
set(handles.TextField2InputSpecs,'String', ...
    num2str( data.template{1,2}.inputSpec.noOfIntInputs ) );
inputStrg = [];
for kk = 1:length( data.template{1,2}.inputSpec.Vars )
    inputStrg = [inputStrg ', ' data.template{1,2}.inputSpec.Vars{kk}]; %#ok<AGROW>
end
set(handles.TextField1InputSpecs,'String', inputStrg(3:end) );
tableRowNames = data.template{1,2}.set(:,1);
tableData = data.template{1,2}.set;
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
set(handles.edit_setName,'String',data.template{1,2}.setName);
% Choose default command line output for edit_paramValues
handles.output = hObject;
% Update handles structure
setappdata(handles.main_editParamValues,'appData',data);
guidata(hObject, handles);
% UIWAIT makes edit_paramValues wait for user response (see UIRESUME)
uiwait(handles.main_editParamValues);


% --- Outputs from this function are returned to the command line.
function varargout = edit_paramValues_OutputFcn(hObject, eventdata, handles)  %#ok<*INUSL>
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = getappdata(handles.main_editParamValues,'appData');
if handles.flagOutput == 1
    varargout{1} = data.new_template;
else
    varargout{1} = data.template;
end
varargout{2} = data.templateSaved;
delete(handles.main_editParamValues);


function TextField1InputSpecs_Callback(hObject, eventdata, handles)
% hObject    handle to TextField1InputSpecs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TextField1InputSpecs as text
%        str2double(get(hObject,'String')) returns contents of TextField1InputSpecs as a double


% --- Executes during object creation, after setting all properties.
function TextField1InputSpecs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TextField1InputSpecs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function TextField2InputSpecs_Callback(hObject, eventdata, handles)
% hObject    handle to TextField2InputSpecs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TextField2InputSpecs as text
%        str2double(get(hObject,'String')) returns contents of TextField2InputSpecs as a double


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

% --- Executes when selected cell(s) is changed
function table_CellSelectionCallback(src,evt,handles)
handles.selected_cells = evt.Indices;
guidata(src, handles);

% --- Executes during object deletion, before destroying properties.
function main_editParamValues_DeleteFcn(hObject, eventdata, handles) %#ok<INUSL>
% hObject    handle to main_editParamValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'sysname')
    close_system(handles.sysname,0);
end


% --- Executes on button press in pushbutton_save2Template.
function pushbutton_save2Template_Callback(hObject, eventdata, handles) %#ok<*DEFNU,*INUSD>
% hObject    handle to pushbutton_save2Template (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = getappdata(handles.main_editParamValues,'appData');
% If succ == 'yes', test simulation with param value set was successfull
[dimension succ ME_testSimulation ME_paramsFeasible] = testingValueSet( handles,0 );
if strcmp( succ, 'yes' )
    inputSpec.Vars = regexp( get(handles.TextField1InputSpecs,'String'), '[a-zA-Z0-9]','match');
    inputSpec.noOfIntInputs = str2double(get(handles.TextField2InputSpecs,'string'));
    data.new_template{1,1} = data.template{1,1};
    data.new_template{1,2}.set = get(handles.t,'Data');
    data.new_template{1,2}.dimension = dimension;
    data.new_template{1,2}.inputSpec = inputSpec;
    data.new_template{1,2}.setName = get(handles.edit_setName,'String');
    handles.flagOutput = 1;
    setappdata(handles.main_editParamValues,'appData',data);
    guidata(hObject, handles);
    uiresume(handles.main_editParamValues);
else
    error = {};
    if ~isempty( ME_testSimulation )
        error = {error, ME_testSimulation.message };
    end
    if ~isempty( ME_paramsFeasible )
        error = {error, ME_paramsFeasible.message };
    end
    error = error(~cellfun(@isempty,error));
    errordlg({'The test using the new system parameters failed. ',...
        'Maybe the following messages will help you to find the error: ',...
        error{:} }); %#ok<*CCAT>
end


% --- Executes on button press in pushbutton_cancel.
function pushbutton_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume(handles.main_editParamValues);

% --- Executes when user attempts to close main_editParamValues.
function main_editParamValues_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to main_editParamValues (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
uiresume(handles.main_editParamValues);



function edit_setName_Callback(hObject, eventdata, handles)
% hObject    handle to edit_setName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_setName as text
%        str2double(get(hObject,'String')) returns contents of edit_setName as a double

% --- Executes during object creation, after setting all properties.
function edit_setName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_setName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save2File.
function pushbutton_save2File_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save2File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = getappdata(handles.main_editParamValues,'appData');
templName = handles.sysname(1:regexp(handles.sysname,'(_CHECKED)')-1);
[dimension testSucc ME1 ME2] = testingValueSet( handles,0 );
pathname = [pwd filesep 'templates' filesep 'import' filesep];
if strcmp(testSucc,'yes')
    [succ errMess ] = saveParamSet2File(handles.TextField1InputSpecs,...
        handles.TextField2InputSpecs,templName, handles.edit_setName,...
        get(handles.t,'Data'), dimension, pathname);
else
    disp('Testing the parameter set failed.');
    disp('Maybe the following message will help you to find the error:');
    if ~isempty(ME1)
        disp(ME1.message);
    end
    if ~isempty(ME2)
        disp(ME2.message);
    end
end
if ~succ
    disp('Could not save parameter set due to following reason:');
    if ~isempty(errMess)
        disp(errMess);
    end
else
    data.templateSaved = 1;
end
setappdata(handles.main_editParamValues,'appData',data);
