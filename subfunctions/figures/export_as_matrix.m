function varargout = export_as_matrix(varargin)
%EXPORT_AS_MATRIX gui to export a graph in mtids as a matrix
%
% Graphical user interface, which enables to save the MTIDS graph using an
% array representation. Possible variants are: a Laplacian
% matrix, an Adjacency matrix or a (N x 2) list of edges.
%
% INPUT:    (1)    -- Adjacency matrix of graph g
%           (2)    -- Graph as matgraph-object
%           (3)    -- string, 'directed' or 'undirected'
%
% OUTPUT:   (none) -- Data will be saved
%
% Authors: Francisco Llobet, Jose Rivera
% Editor: Ferdinand Trommsdorff (f.trommsdorff@gmail.com)
% Project: MTIDS (http://code.google.com/p/mtids/)
%

%      EXPORT_AS_MATRIX, by itself, creates a new EXPORT_AS_MATRIX or raises the existing
%      singleton*.
%
%      H = EXPORT_AS_MATRIX returns the handle to a new EXPORT_AS_MATRIX or the handle to
%      the existing singleton*.
%
%      EXPORT_AS_MATRIX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXPORT_AS_MATRIX.M with the given input arguments.
%
%      EXPORT_AS_MATRIX('Property','Value',...) creates a new EXPORT_AS_MATRIX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before export_as_matrix_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to export_as_matrix_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Last Modified by GUIDE v2.5 22-Nov-2011 20:06:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       'export_as_matrix', ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @export_as_matrix_OpeningFcn, ...
                   'gui_OutputFcn',  @export_as_matrix_OutputFcn, ...
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


% --- Executes just before export_as_matrix is made visible.
function export_as_matrix_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to export_as_matrix (see VARARGIN)
% Choose default command line output for export_as_matrix
handles.output = hObject;

global matrix;
global g;
global modus;
global kindOfDegree;

matrix = varargin{1};
g = varargin{2};
modus = varargin{3};
kindOfDegree = 'isIndegree';

% default values at start of the figure
set(handles.export_as_laplacian,'Value', 1);
set(handles.export_as_adjacency,'Value', 0);
set(handles.export_as_edge_list,'Value', 0);
set(handles.indegree,'Value',1);
switch modus
    case 'undirected';
        set(handles.choiceDegree,'Visible','off');
    case 'directed';
        set(handles.choiceDegree,'Visible','on');
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes export_as_matrix wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = export_as_matrix_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;
uiresume(handles.output);


% --- Executes on button press in export_to_workplace.
function export_to_workplace_Callback(hObject, eventdata, handles) %#ok<*INUSL,*DEFNU>
% hObject    handle to export_to_workplace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%varargin
global matrix;
global modus;
global g;
global kindOfDegree;

workspace  = get(handles.edit_workplace,'String');
varname    = get(handles.edit_matrix,'String');

if (get(handles.export_as_laplacian,'Value') == get(handles.export_as_laplacian,'Max'))
    switch modus
        case 'undirected';
            matrix = laplacian(g);
        case 'directed';
            [InDeg OutDeg] = getDegree(matrixOfGraph(g));
            switch kindOfDegree
                case 'isIndegree';
                    matrix = diag(InDeg) - double(matrixOfGraph(g));
                case 'isOutdegree';
                    matrix = diag(OutDeg) - double(matrixOfGraph(g));
            end
    end
elseif (get(handles.export_as_adjacency,'Value') == get(handles.export_as_adjacency,'Max'))
    % No distinction of cases necessary
    matrix = matrixOfGraph(g);
elseif (get(handles.export_as_edge_list,'Value') == get(handles.export_as_edge_list,'Max'))
    switch modus
        case 'undirected'
            addpath(strcat(pwd,'/interface2Simulink'));
            degree = diag(diag(matrix));
            adjacency = degree - matrix;
            matrix = adj_to_elist(adjacency);
        case 'directed'
            matrix = sortrows(edges(g,1),1);
    end
end
assignin(workspace, varname, matrix);

%    close(handles.export_as_matrix)
uiresume(handles.output);
close(handles.output);

% --- Executes during object creation, after setting all properties.
function edit_workplace_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_workplace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit_matrix_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_matrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in export_as_laplacian.
function export_as_laplacian_Callback(hObject, eventdata, handles)
% hObject    handle to export_as_laplacian (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of export_as_laplacian
set(handles.export_as_laplacian,'Value', 1);
set(handles.export_as_adjacency,'Value', 0);
set(handles.export_as_edge_list,'Value', 0);

% --- Executes on button press in export_as_adjacency.
function export_as_adjacency_Callback(hObject, eventdata, handles)
% hObject    handle to export_as_adjacency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of export_as_adjacency
set(handles.export_as_laplacian,'Value', 0);
set(handles.export_as_adjacency,'Value', 1);
set(handles.export_as_edge_list,'Value', 0);

% --- Executes on button press in export_as_edge_list.
function export_as_edge_list_Callback(hObject, eventdata, handles)
% hObject    handle to export_as_edge_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of export_as_edge_list
set(handles.export_as_laplacian,'Value', 0);
set(handles.export_as_adjacency,'Value', 0);
set(handles.export_as_edge_list,'Value', 1);

% --- Executes when selected object is changed in choiceDegree.
function choiceDegree_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in choiceDegree 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
global kindOfDegree;
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object
    case 'indegree';
        kindOfDegree = 'isIndegree';       
    case 'outdegree';
        kindOfDegree = 'isOutdegree';      
end

%--------------------------------------------------------------------------
%-------UNUSED FUNCTION CALLBACKS - AUTOMATICALLY GENERATED BY GUIDE-------
%--------------------------------------------------------------------------

% --- Executes when selected object is changed in uipanel2.
function uipanel2_SelectionChangeFcn(hObject, eventdata, handles)

function edit_matrix_Callback(hObject, eventdata, handles)

function edit_workplace_Callback(hObject, eventdata, handles) %#ok<*INUSD>
