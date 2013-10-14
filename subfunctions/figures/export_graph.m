function varargout = export_graph(varargin)
% EXPORT_GRAPH MATLAB code for export_graph.fig
%      EXPORT_GRAPH, by itself, creates a new EXPORT_GRAPH or raises the existing
%      singleton*.
%
%      H = EXPORT_GRAPH returns the handle to a new EXPORT_GRAPH or the handle to
%      the existing singleton*.
%
%      EXPORT_GRAPH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXPORT_GRAPH.M with the given input arguments.
%
%      EXPORT_GRAPH('Property','Value',...) creates a new EXPORT_GRAPH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before export_graph_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to export_graph_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help export_graph

% Last Modified by GUIDE v2.5 24-Sep-2013 11:51:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @export_graph_OpeningFcn, ...
                   'gui_OutputFcn',  @export_graph_OutputFcn, ...
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


% --- Executes just before export_graph is made visible.
function export_graph_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to export_graph (see VARARGIN)

% Choose default command line output for export_graph
handles.output = hObject;
handles.file_type = get(handles.file_type_popup,'String');
handles.file_name = [];
set(handles.file_type_popup,'Value',1);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes export_graph wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = export_graph_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_close.
function pushbutton_close_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.figure1);


% --- Executes on button press in pushbutton_export1.
function pushbutton_export1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_export1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global graph_axes

file_name = handles.file_name;
contents = cellstr(get(handles.file_type_popup,'String'));
file_type = contents{get(handles.file_type_popup,'Value')};
full_file = strcat(file_name,file_type);

if isempty(file_name)
    warndlg('Please enter the name of export file.')
    return
end

set(0,'showhiddenhandles','on')
temp_figure = figure('Visible','off','units','normalized','outerposition',[0 0 1 1]);
set(temp_figure,'Color',[1,1,1]);
temp_handle = copyobj(graph_axes,temp_figure);

disp('Exporting...')

if strcmp(file_type,'.tikz')
    matlab2tikz('figurehandle',temp_figure,full_file,'showInfo',false);
else
    export_fig(temp_handle,full_file);
end    
disp('Exporting complete!')


% --- Executes on selection change in file_type_popup.
function file_type_popup_Callback(hObject, eventdata, handles)
% hObject    handle to file_type_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns file_type_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from file_type_popup



% --- Executes during object creation, after setting all properties.
function file_type_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to file_type_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function file_name_Callback(hObject, eventdata, handles)
% hObject    handle to file_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of file_name as text
%        str2double(get(hObject,'String')) returns contents of file_name as a double
handles.file_name = get(hObject,'String');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function file_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to file_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
