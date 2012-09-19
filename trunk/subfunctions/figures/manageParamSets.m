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

% Last Modified by GUIDE v2.5 19-Sep-2012 12:44:12

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
        handles.mode = 'edit';
    case 'radiobutton_newImport';
        handles.mode = 'import';
end
setPanelModeActions( handles );


function setPanelModeActions( varargin )
%SETPANELMODEACTIONS
% This functions resets the layout of the panel "uipanel_modeActions",
% depending on which mode was chosen
handles     = varargin{1};
parent = handles.uipanel_modeActions;
switch handles.mode
    case 'edit';
        title = 'Choose parameter set';
%         handles.loadTemplateButton = uicontrol;
%         posLoadTemplateButton = [5 10 100 30]; % [left, bottom, width, height]
    case 'import';
        title = 'Load template from file';
end
set(handles.uipanel_modeActions,'Title',title);
guidata(hObject, handles);


% --- Executes on button press in pushbutton_loadTemplate.
function pushbutton_loadTemplate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_loadTemplate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
