function varargout = inputParamsAdaptation(varargin)
%INPUTPARAMSADAPTATION gui to choose how input parameters should corrected
%
% This GUI request how parameters, which depend linearly of the size of the
% input signal, should be corrected automatically. Different modes could be
% chosen for that.
%
% INPUT:    (none)
%
% OUTOUT:   (1) -- Chosen mode (as a char)
%           (2) -- Boolean, '1' if button 'okay' was pressed, '0' if button
%                   'cancel' was pressed
%           (3) -- Scalar; factor for mode "Constant"
%
% Author: Ferdinand Trommsdorff (f.trommsdorff@gmail.com)
% Project: MTIDS (http://code.google.com/p/mtids/)

% Last Modified by GUIDE v2.5 16-Sep-2013 15:05:00

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
varargout{3} = get(handles.edit_factor,'string');
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



function edit_factor_Callback(hObject, eventdata, handles) %#ok<*DEFNU>
% hObject    handle to edit_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of edit_factor as text
%        str2double(get(hObject,'String')) returns contents of edit_factor as a double
if isempty(isnan(str2num(get(hObject,'String')))) %#ok<ST2NM>
    set(hObject,'String',num2str(1));
    error('Prompted input is not a number');
end


% --- Executes during object creation, after setting all properties.
function edit_factor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
