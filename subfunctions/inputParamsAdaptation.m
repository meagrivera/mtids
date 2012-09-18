function varargout = inputParamsAdaptation(varargin)
% INPUTPARAMSADAPTATION MATLAB code for inputParamsAdaptation.fig
%      INPUTPARAMSADAPTATION, by itself, creates a new INPUTPARAMSADAPTATION or raises the existing
%      singleton*.
%
%      H = INPUTPARAMSADAPTATION returns the handle to a new INPUTPARAMSADAPTATION or the handle to
%      the existing singleton*.
%
%      INPUTPARAMSADAPTATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INPUTPARAMSADAPTATION.M with the given input arguments.
%
%      INPUTPARAMSADAPTATION('Property','Value',...) creates a new INPUTPARAMSADAPTATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before inputParamsAdaptation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to inputParamsAdaptation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help inputParamsAdaptation

% Last Modified by GUIDE v2.5 17-Sep-2012 10:18:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @inputParamsAdaptation_OpeningFcn, ...
                   'gui_OutputFcn',  @inputParamsAdaptation_OutputFcn, ...
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


% --- Executes just before inputParamsAdaptation is made visible.
function inputParamsAdaptation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to inputParamsAdaptation (see VARARGIN)

% Choose default command line output for inputParamsAdaptation
handles.mode = 'ones';
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes inputParamsAdaptation wait for user response (see UIRESUME)
uiwait(handles.main_figInputParamAdaptation);


% --- Outputs from this function are returned to the command line.
function varargout = inputParamsAdaptation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.mode;
if handles.output_mode
    varargout{2} = 1;
else
    varargout{2} = 0;
end
delete(handles.main_figInputParamAdaptation);

% --- Executes on button press in pushbutton_okay.
function pushbutton_okay_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_okay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output_mode = 1;
guidata(hObject, handles);
uiresume(handles.main_figInputParamAdaptation);

% --- Executes on button press in pushbutton_cancel.
function pushbutton_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output_mode = 0;
guidata(hObject, handles);
uiresume(handles.main_figInputParamAdaptation);

% --- Executes when selected object is changed in panel_setMode.
function panel_setMode_SelectionChangeFcn(hObject, eventdata, handles) %#ok<DEFNU>
% hObject    handle to the selected object in panel_setMode 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
switch get(eventdata.NewValue,'Tag')
    case 'radiobutton_ones';
        handles.mode = 'ones';
    case 'radiobutton_meanNodes';
        handles.mode = 'meanNodes';
    case 'radiobutton_meanValues';
        handles.mode = 'meanValues';
    case 'radiobutton_random';
        handles.mode = 'random';
    case 'radiobutton_preserve';
        handles.mode = 'preserve';
end
guidata(hObject, handles);
