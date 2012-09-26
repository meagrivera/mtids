function varargout = editSimParams(varargin)
% EDITSIMPARAMS MATLAB code for editSimParams.fig
%      EDITSIMPARAMS, by itself, creates a new EDITSIMPARAMS or raises the existing
%      singleton*.
%
%      H = EDITSIMPARAMS returns the handle to a new EDITSIMPARAMS or the handle to
%      the existing singleton*.
%
%      EDITSIMPARAMS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EDITSIMPARAMS.M with the given input arguments.
%
%      EDITSIMPARAMS('Property','Value',...) creates a new EDITSIMPARAMS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before editSimParams_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to editSimParams_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help editSimParams

% Last Modified by GUIDE v2.5 26-Sep-2012 14:55:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @editSimParams_OpeningFcn, ...
                   'gui_OutputFcn',  @editSimParams_OutputFcn, ...
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


% --- Executes just before editSimParams is made visible.
function editSimParams_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to editSimParams (see VARARGIN)
% Choose default command line output for editSimParams
handles.output = hObject;

% init of popupmenus as in simulink
contentSolverVar = {'discrete (no continuous states)',...
    'ode45 (Dormand-Prince)','ode23 (Bogacki-Shampine)','ode113 (Adams)',...
    'ode15s (stiff/NDF)','ode23s (stiff/Mod. Rosenbrock)',...
    'ode23t (mod. stiff/Trapezoidal)','ode23tb (stiff/TR-BDF2)'};
set(handles.popup_solver,'String',contentSolverVar);
set(handles.popup_Type,'Value',1.0);
set(handles.popup_solver,'Value',2.0);
popup_Type_Callback(handles.popup_Type, [], handles);

handles.sysname = varargin{1};

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes editSimParams wait for user response (see UIRESUME)
uiwait(handles.figure1);

% --- Executes on selection change in popup_Type.
function popup_Type_Callback(hObject, eventdata, handles)
% hObject    handle to popup_Type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns popup_Type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_Type
contentSolverVar = {'discrete (no continuous states)',...
    'ode45 (Dormand-Prince)','ode23 (Bogacki-Shampine)','ode113 (Adams)',...
    'ode15s (stiff/NDF)','ode23s (stiff/Mod. Rosenbrock)',...
    'ode23t (mod. stiff/Trapezoidal)','ode23tb (stiff/TR-BDF2)'};
contentSolverFix = {'Discrete (no continuous states)',...
    'ode8 (Dormand-Prince)','ode5 (Dormand-Prince)',...
    'ode4 (Runge-Kutta)','ode3 (Bogacki-Shampine)','ode2 (Heun)',...
    'ode1 (Euler)','ode14x (extrapolation)'};

% set elements in panel_solOptions to invisible
resetPanelSolOptions(handles);

contents = cellstr(get(hObject,'String'));
choice = contents{get(hObject,'Value')};
switch choice
    case 'Variable-step';
        set(handles.popup_solver,'String',contentSolverVar);
        set(handles.popup_solver,'Value',2.0);        
    case 'Fixed-step';
        set(handles.popup_solver,'String',contentSolverFix);
        set(handles.popup_solver,'Value',5.0);        
end
popup_solver_Callback(hObject,[],handles);

% --- Executes on selection change in popup_solver.
function popup_solver_Callback(hObject, eventdata, handles)
% hObject    handle to popup_solver (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns popup_solver contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_solver
% set elements in panel_solOptions to invisible
resetPanelSolOptions(handles);
contents = cellstr(get(handles.popup_Type,'String'));
choiceType = contents{get(handles.popup_Type,'Value')};
contentsType = cellstr(get(handles.popup_solver,'String'));
choice = contentsType{get(handles.popup_solver,'Value')};
switch choiceType
    case 'Variable-step';
        switch choice
            case 'discrete (no continuous states)';
                set(handles.text_maxStepSize,'Visible','on');
                set(handles.edit_maxStepSize,'Visible','on');
            case 'ode45 (Dormand-Prince)';
                setPanelODE45(handles);
            case 'ode23 (Bogacki-Shampine)';
                setPanelODE45(handles);
            case 'ode113 (Adams)';
                setPanelODE45(handles);
            case 'ode15s (stiff/NDF)';
                setPanelODE15(handles);
            case 'ode23s (stiff/Mod. Rosenbrock)';
                setPanelODE23s(handles);
            case 'ode23t (mod. stiff/Trapezoidal)';
                setPanelODE23t(handles);
            case 'ode23tb (stiff/TR-BDF2)';
                setPanelODE23t(handles);
        end        
    case 'Fixed-step';
        switch choice
            case 'Discrete (no continuous states)';
                setPanelODE8(handles);
            case 'ode8 (Dormand-Prince)';
                setPanelODE8(handles);
            case 'ode5 (Dormand-Prince)';
                setPanelODE8(handles);
            case 'ode4 (Runge-Kutta)';
                setPanelODE8(handles);
            case 'ode3 (Bogacki-Shampine)';
                setPanelODE8(handles);
            case 'ode2 (Heun)';
                setPanelODE8(handles);
            case 'ode1 (Euler)';
                setPanelODE8(handles);
            case 'ode14x (extrapolation)';
                setPanelODE14(handles);
        end
end

function resetPanelSolOptions(handles)
% sets elements in panel_solOptions to invisible
set(handles.text_maxStepSize,'Visible','off');
set(handles.edit_maxStepSize,'Visible','off');
set(handles.text_minStepSize  ,'Visible','off');
set(handles.edit_minStepSize  ,'Visible','off');
set(handles.text_initialStepSize  ,'Visible','off');
set(handles.edit_initialStepSize  ,'Visible','off');
set(handles.text_relTol  ,'Visible','off');
set(handles.edit_relTol  ,'Visible','off');
set(handles.text_absTol  ,'Visible','off');
set(handles.edit_absTol  ,'Visible','off');
set(handles.text_shapePres  ,'Visible','off');
set(handles.popup_shapePres  ,'Visible','off');
set(handles.text_consecMinSteps  ,'Visible','off');
set(handles.edit_consecMinSteps  ,'Visible','off');
set(handles.text_solReset  ,'Visible','off');
set(handles.popup_solReset  ,'Visible','off');
set(handles.text_maxOrder  ,'Visible','off');
set(handles.popup_maxOrder  ,'Visible','off');
set(handles.text_fixedSize  ,'Visible','off');
set(handles.edit_fixedSize  ,'Visible','off');
set(handles.text_solJacob  ,'Visible','off');
set(handles.popup_solJacob  ,'Visible','off');
set(handles.text_extOrder  ,'Visible','off');
set(handles.popup_extOrder  ,'Visible','off');
set(handles.text_noIter  ,'Visible','off');
set(handles.edit_noIter  ,'Visible','off');
% set(handles.  ,'Visible','off');

function setPanelODE45(handles)
set(handles.text_maxStepSize,'Visible','on');
set(handles.edit_maxStepSize,'Visible','on');
set(handles.text_minStepSize  ,'Visible','on');
set(handles.edit_minStepSize  ,'Visible','on');
set(handles.text_initialStepSize  ,'Visible','on');
set(handles.edit_initialStepSize  ,'Visible','on');
set(handles.text_relTol  ,'Visible','on');
set(handles.edit_relTol  ,'Visible','on');
set(handles.text_absTol  ,'Visible','on');
set(handles.edit_absTol  ,'Visible','on');
set(handles.text_shapePres  ,'Visible','on');
set(handles.popup_shapePres  ,'Visible','on');
set(handles.text_consecMinSteps  ,'Visible','on');
set(handles.edit_consecMinSteps  ,'Visible','on');

function setPanelODE15(handles)
setPanelODE45(handles);
set(handles.text_solReset  ,'Visible','on');
set(handles.popup_solReset  ,'Visible','on');
set(handles.text_maxOrder  ,'Visible','on');
set(handles.popup_maxOrder  ,'Visible','on');
set(handles.text_solJacob  ,'Visible','on');
set(handles.popup_solJacob  ,'Visible','on');

function setPanelODE23s(handles)
setPanelODE45(handles);
set(handles.text_solJacob  ,'Visible','on');
set(handles.popup_solJacob  ,'Visible','on');

function setPanelODE23t(handles)
setPanelODE23s(handles);
set(handles.text_solReset  ,'Visible','on');
set(handles.popup_solReset  ,'Visible','on');

function setPanelODE8(handles)
set(handles.text_fixedSize  ,'Visible','on');
set(handles.edit_fixedSize  ,'Visible','on');

function setPanelODE14(handles)
setPanelODE8(handles)
set(handles.text_solJacob  ,'Visible','on');
set(handles.popup_solJacob  ,'Visible','on');
set(handles.text_extOrder  ,'Visible','on');
set(handles.popup_extOrder  ,'Visible','on');
set(handles.text_noIter  ,'Visible','on');
set(handles.edit_noIter  ,'Visible','on');

function cs = readOutSimPrms(handles)                       %here goes the spelling of the parameter
%load system
load_system(handles.sysname);
cs = getActiveConfigSet(gcs);
%close system
close_system(handles.sysname,0);
StartTime = get(handles.edit_startTime,'String');           %StartTime
StopTime = get(handles.edit_stopTime,'String');             %StopTime
contSolverType = get(handles.popup_Type,'String');
SolverType = contSolverType{get(handles.popup_Type,'Value')};
contSolver = get(handles.popup_solver,'String');
Solver = contSolver{get(handles.popup_solver,'Value')};
Solver = regexp( Solver,'\w*(?=\s)','match');
set_param(cs,'StartTime',StartTime,'StopTime',StopTime,...
    'Solver',Solver{:},'SolverType',SolverType);
if strcmp( get(handles.edit_maxStepSize,'Visible'),'on')
    MaxStep = get(handles.edit_maxStepSize,'String');       %MaxStep
    set_param(cs,'MaxStep',MaxStep);
end
if strcmp( get(handles.edit_minStepSize,'Visible'), 'on')
    MinStep = get(handles.edit_minStepSize  ,'String');     %MinStep
    set_param(cs,'MinStep',MinStep);
end
if strcmp( get(handles.edit_initialStepSize,'Visible'),'on')
    InitialStep = get(handles.edit_initialStepSize  ,'String');%InitialStep
    set_param(cs,'InitialStep',InitialStep);
end
if strcmp( get(handles.edit_relTol,'Visible'),'on')
    RelTol = get(handles.edit_relTol  ,'String');           %RelTol
    set_param(cs,'RelTol',RelTol);
end
if strcmp( get(handles.edit_absTol,'Visible'),'on')
    AbsTol = get(handles.edit_absTol  ,'String');           %AbsTol
    set_param(cs,'AbsTol',AbsTol);
end
if strcmp( get(handles.popup_shapePres,'Visible'),'on')
    contShapePres = get(handles.popup_shapePres,'String');
    tmp = contShapePres{get(handles.popup_shapePres  ,'Value')};%ShapePreserveControl
    tmp = regexp( tmp,'\w*(?=\s)','match');
    ShapePreserveControl = [tmp{:} 'All'];
    set_param(cs,'ShapePreserveControl',ShapePreserveControl);
end
if strcmp( get(handles.edit_consecMinSteps,'Visible'),'on')
    MaxConsecutiveMinStep = get(handles.edit_consecMinSteps  ,'String');%MaxConsecutiveMinStep
    set_param(cs,'MaxConsecutiveMinStep',MaxConsecutiveMinStep);
end
if strcmp( get(handles.popup_solReset,'Visible'),'on')
    contSolReset = get(handles.popup_solReset,'String');
    SolverResetMethod = contSolReset{get(handles.popup_solReset  ,'Value')};%SolverResetMethod
    set_param(cs,'SolverResetMethod',SolverResetMethod);
end
if strcmp( get(handles.popup_maxOrder,'Visible'),'on')
    contMaxOrder = get(handles.popup_maxOrder,'String');
    MaxOrder = contMaxOrder{get(handles.popup_maxOrder  ,'Value')}; %MaxOrder
    set_param(cs,'MaxOrder',MaxOrder);
end
if strcmp( get(handles.edit_fixedSize,'Visible'),'on')
    FixedStep = get(handles.edit_fixedSize  ,'String');         %FixedStep
    set_param(cs,'FixedStep',FixedStep);
end
if strcmp( get(handles.popup_solJacob,'Visible'),'on')
    contSolJacob = get(handles.popup_solJacob,'String');
    SolverJacobianMethodControl = contSolJacob{get(handles.popup_solJacob  ,'Value')}; %SolverJacobianMethodControl
    set_param(cs,'SolverJacobianMethodControl',SolverJacobianMethodControl);
end
if strcmp( get(handles.popup_extOrder,'Visible'),'on')
    contExtOrder = get(handles.popup_extOrder,'String');
    ExtrapolationOrder = contExtOrder{get(handles.popup_extOrder  ,'Value')}; %ExtrapolationOrder
    set_param(cs,'ExtrapolationOrder',ExtrapolationOrder);
end
if strcmp( get(handles.edit_noIter,'Visible'),'on')
    NumberNewtonIterations = get(handles.edit_noIter  ,'String'); %NumberNewtonIterations
    set_param(cs,'NumberNewtonIterations',NumberNewtonIterations);
end

% --- Executes on button press in push_close.
function push_close_Callback(hObject, eventdata, handles) %#ok<*INUSL,*DEFNU>
% hObject    handle to push_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    handles.simPrms = readOutSimPrms(handles);
    uiresume(handles.figure1);
catch %#ok<CTCH>
    disp('Reading of simulation parameter failed - please check prompted value');
end
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = editSimParams_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'simPrms')
    varargout{1} = handles.simPrms;
else
    varargout{1} = [];
end
varargout{2} = handles.output;
delete(handles.figure1);

function edit_startTime_Callback(hObject, eventdata, handles) %#ok<*INUSD>
% hObject    handle to edit_startTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of edit_startTime as text
%        str2double(get(hObject,'String')) returns contents of edit_startTime as a double

% --- Executes during object creation, after setting all properties.
function edit_startTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_startTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_stopTime_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stopTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of edit_stopTime as text
%        str2double(get(hObject,'String')) returns contents of edit_stopTime as a double

% --- Executes during object creation, after setting all properties.
function edit_stopTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stopTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_fixedSize_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fixedSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of edit_fixedSize as text
%        str2double(get(hObject,'String')) returns contents of edit_fixedSize as a double

% --- Executes during object creation, after setting all properties.
function edit_fixedSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fixedSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_consecMinSteps_Callback(hObject, eventdata, handles)
% hObject    handle to edit_consecMinSteps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of edit_consecMinSteps as text
%        str2double(get(hObject,'String')) returns contents of edit_consecMinSteps as a double

% --- Executes during object creation, after setting all properties.
function edit_consecMinSteps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_consecMinSteps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_maxStepSize_Callback(hObject, eventdata, handles)
% hObject    handle to edit_maxStepSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of edit_maxStepSize as text
%        str2double(get(hObject,'String')) returns contents of edit_maxStepSize as a double

% --- Executes during object creation, after setting all properties.
function edit_maxStepSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_maxStepSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_minStepSize_Callback(hObject, eventdata, handles)
% hObject    handle to edit_minStepSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of edit_minStepSize as text
%        str2double(get(hObject,'String')) returns contents of edit_minStepSize as a double

% --- Executes during object creation, after setting all properties.
function edit_minStepSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_minStepSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_initialStepSize_Callback(hObject, eventdata, handles)
% hObject    handle to edit_initialStepSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of edit_initialStepSize as text
%        str2double(get(hObject,'String')) returns contents of edit_initialStepSize as a double

% --- Executes during object creation, after setting all properties.
function edit_initialStepSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_initialStepSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_relTol_Callback(hObject, eventdata, handles)
% hObject    handle to edit_relTol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of edit_relTol as text
%        str2double(get(hObject,'String')) returns contents of edit_relTol as a double

% --- Executes during object creation, after setting all properties.
function edit_relTol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_relTol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_absTol_Callback(hObject, eventdata, handles)
% hObject    handle to edit_absTol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of edit_absTol as text
%        str2double(get(hObject,'String')) returns contents of edit_absTol as a double

% --- Executes during object creation, after setting all properties.
function edit_absTol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_absTol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function popup_Type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_Type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function popup_solver_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_solver (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in popup_shapePres.
function popup_shapePres_Callback(hObject, eventdata, handles)
% hObject    handle to popup_shapePres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns popup_shapePres contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_shapePres

% --- Executes during object creation, after setting all properties.
function popup_shapePres_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_shapePres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in popup_solJacob.
function popup_solJacob_Callback(hObject, eventdata, handles)
% hObject    handle to popup_solJacob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns popup_solJacob contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_solJacob

% --- Executes during object creation, after setting all properties.
function popup_solJacob_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_solJacob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in popup_solReset.
function popup_solReset_Callback(hObject, eventdata, handles)
% hObject    handle to popup_solReset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns popup_solReset contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_solReset

% --- Executes during object creation, after setting all properties.
function popup_solReset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_solReset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in popup_maxOrder.
function popup_maxOrder_Callback(hObject, eventdata, handles)
% hObject    handle to popup_maxOrder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns popup_maxOrder contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_maxOrder

% --- Executes during object creation, after setting all properties.
function popup_maxOrder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_maxOrder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in popup_extOrder.
function popup_extOrder_Callback(hObject, eventdata, handles)
% hObject    handle to popup_extOrder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns popup_extOrder contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_extOrder

% --- Executes during object creation, after setting all properties.
function popup_extOrder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_extOrder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_noIter_Callback(hObject, eventdata, handles)
% hObject    handle to edit_noIter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of edit_noIter as text
%        str2double(get(hObject,'String')) returns contents of edit_noIter as a double

% --- Executes during object creation, after setting all properties.
function edit_noIter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_noIter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

