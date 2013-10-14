function varargout = lti_analysis(varargin)
% LTI_ANALYSIS MATLAB code for lti_analysis.fig
%      LTI_ANALYSIS, by itself, creates a new LTI_ANALYSIS or raises the existing
%      singleton*.
%
%      H = LTI_ANALYSIS returns the handle to a new LTI_ANALYSIS or the handle to
%      the existing singleton*.
%
%      LTI_ANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LTI_ANALYSIS.M with the given input arguments.
%
%      LTI_ANALYSIS('Property','Value',...) creates a new LTI_ANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lti_analysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lti_analysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lti_analysis

% Last Modified by GUIDE v2.5 17-Sep-2013 15:50:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lti_analysis_OpeningFcn, ...
                   'gui_OutputFcn',  @lti_analysis_OutputFcn, ...
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


% --- Executes just before lti_analysis is made visible.
function lti_analysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lti_analysis (see VARARGIN)

% Choose default command line output for lti_analysis
handles.output = hObject;
handles.data = varargin{1};
handles.figure1_handles = varargin{2};

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes lti_analysis wait for user response (see UIRESUME)
uiwait(handles.lti_analysis_figure);


% --- Outputs from this function are returned to the command line.
function varargout = lti_analysis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.data;
if handles.output_mode
    varargout{2} = 1;
else
    varargout{2} = 0;
end
delete(handles.lti_analysis_figure);

% --- Executes on button press in pushbutton_lti_analysis.
function pushbutton_lti_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_lti_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = handles.data;
lti_analysis_test(data, handles.figure1_handles)


% --- Executes on button press in pushbutton_OK.
function pushbutton_OK_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_OK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output_mode = 1;
guidata(hObject, handles);
uiresume(handles.lti_analysis_figure);

% --- Executes on button press in pushbutton_Cancel.
function pushbutton_Cancel_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output_mode = 0;
guidata(hObject, handles);
uiresume(handles.lti_analysis_figure);

% --- Executes on button press in pushbutton_Set.
function pushbutton_Set_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data = handles.data;
new_data = conv2stable(data);
handles.data = new_data;
guidata(hObject, handles);
