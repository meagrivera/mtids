function varargout = graph_analysis(varargin)
% GRAPH_ANALYSIS MATLAB code for graph_analysis.fig
%      GRAPH_ANALYSIS, by itself, creates a new GRAPH_ANALYSIS or raises the existing
%      singleton*.
%
% varagin{1} = data
% varagin{2} = modus
% varagin{3} = iscyclic
%
%
%
%
%      H = GRAPH_ANALYSIS returns the handle to a new GRAPH_ANALYSIS or the handle to
%      the existing singleton*.
%
%      GRAPH_ANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GRAPH_ANALYSIS.M with the given input arguments.
%
%      GRAPH_ANALYSIS('Property','Value',...) creates a new GRAPH_ANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before graph_analysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to graph_analysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help graph_analysis

% Last Modified by GUIDE v2.5 26-Sep-2013 10:11:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @graph_analysis_OpeningFcn, ...
                   'gui_OutputFcn',  @graph_analysis_OutputFcn, ...
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


% --- Executes just before graph_analysis is made visible.
function graph_analysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to graph_analysis (see VARARGIN)

% Choose default command line output for graph_analysis
data = varargin{1};
handles.output = hObject;
handles.data = varargin{1};
handles.modus = varargin{2};
handles.iscyclic = varargin{3};
handles.graph_vector = graph_vectors(matrix(data.g));

iscyclic = varargin{3};
modus = handles.modus;

switch modus
    case 'directed'
        [graph_vector, spanning, arborescence, root] = graph_analysis_comp(data);
        set(handles.analyis_type_panel,'Title','Directed Analysis')
        set(handles.path_text,'String','Shortest Path between Vertices')
        set(handles.spanning_text,'String',spanning);
        
        if size(root,1) == 1
            set(handles.root_text,'String','Yes')
        else
            set(handles.root_text,'String','None')
        end
        
        if strcmp(iscyclic, 'No') & size(root,1) == 1
            set(handles.tree_text,'String','Yes')
        else
            set(handles.tree_text,'String','No')
            set(handles.root_text,'String','None')
        end
        
    case 'undirected'
        set(handles.analyis_type_panel,'Title','Undirected Analysis')
        set(handles.path_text,'String','Distance Between Vertices')
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes graph_analysis wait for user response (see UIRESUME)
% uiwait(handles.graph_analysis_figure);


% --- Outputs from this function are returned to the command line.
function varargout = graph_analysis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in close_pushbutton.
function close_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to close_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.graph_analysis_figure);



% --- Executes on button press in solve_pushbutton.
function solve_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to solve_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
modus = handles.modus;
E = handles.graph_vector;

switch modus
    case 'directed'
        shortest_path = grShortPath(E);
        disp(shortest_path)
    case 'undirected'
        distances = grDistances(E);
        disp(distances)
end
