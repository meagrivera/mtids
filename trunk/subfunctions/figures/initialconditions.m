function varargout = initialconditions(varargin)
% INITIALCONDITIONS MATLAB code for initialconditions.fig
%      INITIALCONDITIONS, by itself, creates a new INITIALCONDITIONS or raises the existing
%      singleton*.
%
%      H = INITIALCONDITIONS returns the handle to a new INITIALCONDITIONS or the handle to
%      the existing singleton*.
%
%      INITIALCONDITIONS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INITIALCONDITIONS.M with the given input arguments.
%
%      INITIALCONDITIONS('Property','Value',...) creates a new INITIALCONDITIONS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before initialconditions_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to initialconditions_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help initialconditions

% Last Modified by GUIDE v2.5 16-Sep-2013 15:46:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @initialconditions_OpeningFcn, ...
                   'gui_OutputFcn',  @initialconditions_OutputFcn, ...
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


% --- Executes just before initialconditions is made visible.
function initialconditions_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to initialconditions (see VARARGIN)

% Choose default command line output for initialconditions
handles.integral_mode = 'ones';
% handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

handles.main_figInitialConditions = handles.integral_condition_figure;

% UIWAIT makes initialconditions wait for user response (see UIRESUME)
uiwait(handles.integral_condition_figure);


% --- Outputs from this function are returned to the command line.
function varargout = initialconditions_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.integral_mode;
if handles.output_mode
    varargout{2} = 1;
else
    varargout{2} = 0;
end
varargout{3} = get(handles.edit_integral_factor,'string');
delete(handles.integral_condition_figure);



function edit_integral_factor_Callback(hObject, eventdata, handles)
% hObject    handle to edit_integral_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_integral_factor as text
%        str2double(get(hObject,'String')) returns contents of edit_integral_factor as a double

if isempty(isnan(str2num(get(hObject,'String')))) %#ok<ST2NM>
    set(hObject,'String',num2str(1));
    error('Prompted input is not a number');
end


% --- Executes during object creation, after setting all properties.
function edit_integral_factor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_integral_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in uipanel_integral_initial_condition.
function uipanel_integral_initial_condition_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel_integral_initial_condition 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

% Obtains the type of initial condition for the integral chosen by the
% user. (PDK)

switch get(eventdata.NewValue,'Tag')
    case 'radiobutton_intconstant';
        handles.integral_mode = 'ones';
    case 'radiobutton_intmeannodes';
        handles.integral_mode = 'meanNodes';
    case 'radiobutton_intaverage';
        handles.integral_mode = 'meanValues';
    case 'radiobutton_intrandom';
        handles.integral_mode = 'random';
    case 'radiobutton_intpreserve';
        handles.integral_mode = 'preserve';
end
guidata(hObject, handles);


% --- Executes on button press in pushbutton_okay.
function pushbutton_okay_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_okay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.output_mode = 1;
guidata(hObject, handles);
uiresume(handles.integral_condition_figure);


% --- Executes on button press in pushbutton_cancel.
function pushbutton_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.output_mode = 0;
guidata(hObject, handles);
uiresume(handles.integral_condition_figure);
