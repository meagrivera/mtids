


function varargout = secondgui(varargin)
% SECONDGUI M-file for secondgui.fig
%      SECONDGUI, by itself, creates a new SECONDGUI or raises the existing
%      singleton*.
%
%      H = SECONDGUI returns the handle to a new SECONDGUI or the handle to
%      the existing singleton*.
%
%      SECONDGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SECONDGUI.M with the given input arguments.
%
%      SECONDGUI('Property','Value',...) creates a new SECONDGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before secondgui_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to secondgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help secondgui

% Last Modified by GUIDE v2.5 25-May-2011 15:48:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @secondgui_OpeningFcn, ...
                   'gui_OutputFcn',  @secondgui_OutputFcn, ...
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


% --- Executes just before secondgui is made visible.
function secondgui_OpeningFcn(hObject, eventdata, handles, varargin)

addpath(strcat(pwd,'/matgraph'));
graph_init;
global g;
global gui_handle;


g = graph; %% Creating a graph
resize(g,0);
grid on;
zoom on;
set(handles.numberview,'Check','on');
refresh_graph(0, eventdata, handles);

% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to secondgui (see VARARGIN)

% Choose default command line output for secondgui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes secondgui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = secondgui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in updategraph.
function updategraph_Callback(hObject, eventdata, handles)
% hObject    handle to updategraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;


refresh_graph(1, eventdata, handles);

guidata(hObject, handles);

function newnodelabel_Callback(hObject, eventdata, handles)
% hObject    handle to newnodelabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of newnodelabel as text
%        str2double(get(hObject,'String')) returns contents of newnodelabel as a double


% --- Executes during object creation, after setting all properties.
function newnodelabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to newnodelabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in newnode.
function newnode_Callback(hObject, eventdata, handles)
% hObject    handle to newnode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;
new_vertex = nv(g) + 1;
resize(g, new_vertex);
label(g,new_vertex, get(handles.newnodelabel,'String')); 

refresh_graph(0, eventdata, handles)

guidata(hObject, handles);



% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
global g;
free(g)
% graph_destroy();
delete(hObject);




% --- Executes on button press in addconnection.
function addconnection_Callback(hObject, eventdata, handles)
% hObject    handle to addconnection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;
from_node = str2num(get(handles.fromnode,'String'));
to_node = str2num(get(handles.tonode,'String'));
add(g,from_node, to_node);

refresh_graph(0, eventdata, handles)

guidata(hObject, handles);



function fromnode_Callback(hObject, eventdata, handles)
% hObject    handle to fromnode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fromnode as text
%        str2double(get(hObject,'String')) returns contents of fromnode as a double


% --- Executes during object creation, after setting all properties.
function fromnode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fromnode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function tonode_Callback(hObject, eventdata, handles)
% hObject    handle to tonode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tonode as text
%        str2double(get(hObject,'String')) returns contents of tonode as a double


% --- Executes during object creation, after setting all properties.
function tonode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tonode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end




% --- Executes on button press in randomconnection.
function randomconnection_Callback(hObject, eventdata, handles)
% hObject    handle to randomconnection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;

a = ceil(nv(g)*rand());
b = floor(nv(g)*rand());

add(g,a,b);

refresh_graph(0, eventdata, handles)

guidata(hObject, handles);

% --- Executes on button press in removeconnection.
function removeconnection_Callback(hObject, eventdata, handles)
% hObject    handle to removeconnection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;
from_node = str2num(get(handles.fromnode,'String'));
to_node = str2num(get(handles.tonode,'String'));
delete(g,from_node, to_node);

refresh_graph(0, eventdata, handles)

guidata(hObject, handles);




function remnode_Callback(hObject, eventdata, handles)
% hObject    handle to remnode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of remnode as text
%        str2double(get(hObject,'String')) returns contents of remnode as a double


% --- Executes during object creation, after setting all properties.
function remnode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to remnode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in removenode.
function removenode_Callback(hObject, eventdata, handles)
% hObject    handle to removenode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;

a = str2num(get(handles.remnode,'String'));

delete(g,a);

refresh_graph(0, eventdata, handles)

guidata(hObject, handles);



% --- Executes on button press in trimgraph.
function trimgraph_Callback(hObject, eventdata, handles)
% hObject    handle to trimgraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;
trim(g);

refresh_graph(0, eventdata, handles)

guidata(hObject, handles);


% --- Executes on button press in clearconnections.
function clearconnections_Callback(hObject, eventdata, handles)
% hObject    handle to clearconnections (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;
clear_edges(g);

refresh_graph(0, eventdata, handles)

guidata(hObject, handles);




% --- Executes on button press in completegraph.
function completegraph_Callback(hObject, eventdata, handles)
% hObject    handle to completegraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;
complete(g);

refresh_graph(0, eventdata, handles)

guidata(hObject, handles);

% --- Executes on button press in randomgraph.
function randomgraph_Callback(hObject, eventdata, handles)
% hObject    handle to randomgraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;
random(g);

refresh_graph(0, eventdata, handles)

guidata(hObject, handles);


% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --------------------------------------------------------------------
function Newgraph_Callback(hObject, eventdata, handles)
% hObject    handle to Newgraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;

resize(g,0);
refresh_graph(0, eventdata, handles);

% --------------------------------------------------------------------
function loadgraph_Callback(hObject, eventdata, handles)
% hObject    handle to loadgraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;

[filename, pathname] = uigetfile( ...
{'*.mat;*.gr;','Graph/Network Files';
   '*.mat','MAT-files (*.mat)'; ...
   '*.gr','Matgraph file'; ...
   '*.*',  'All Files (*.*)'}, ...
   'Open');

 file = strcat(pathname, filename);
 load(g, file);
 
refresh_graph(0, eventdata, handles);

% --------------------------------------------------------------------
function Savegraph_Callback(hObject, eventdata, handles)
% hObject    handle to Savegraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function savegraphas_Callback(hObject, eventdata, handles)
% hObject    handle to savegraphas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;

[filename, pathname] = uiputfile( ...
{'*.mat;*.gr;','Graph/Network Files';
   '*.mat','MAT-files (*.mat)'; ...
   '*.gr','Matgraph file (*.gr)'; ...
   '*.*',  'All Files (*.*)'}, ...
   'Save');

 file = strcat(pathname, filename);
 save(g, file);
 
refresh_graph(0, eventdata, handles);

% --------------------------------------------------------------------
function Untitled_10_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function file_Callback(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_9_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_11_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function generatesimulinkmdl_Callback(hObject, eventdata, handles)
% hObject    handle to generatesimulinkmdl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_12_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function aboutmtids_Callback(hObject, eventdata, handles)
% hObject    handle to aboutmtids (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function about_Callback(hObject, eventdata, handles)
% hObject    handle to about (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function adddynamics_Callback(hObject, eventdata, handles)
% hObject    handle to adddynamics (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function dynamicsimporter_Callback(hObject, eventdata, handles)
% hObject    handle to dynamicsimporter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function labelview_Callback(hObject, eventdata, handles)
% hObject    handle to labelview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;
checkstatus = get(hObject,'Check');

if strcmp(checkstatus, 'on')
    set(hObject,'Check','off');
elseif strcmp(checkstatus, 'off')
    set(handles.colorview,'Check','off');
    set(handles.labelview,'Check','on');
    set(handles.numberview,'Check','off');
        set(handles.blankview,'Check','off');
    refresh_graph(0, eventdata, handles)
end

guidata(hObject, handles);

% --------------------------------------------------------------------
function colorview_Callback(hObject, eventdata, handles)
% hObject    handle to colorview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;
checkstatus = get(hObject,'Check');

if strcmp(checkstatus, 'on')
    set(hObject,'Check','off');
elseif strcmp(checkstatus, 'off')
    set(handles.colorview,'Check','on');
    set(handles.labelview,'Check','off');
    set(handles.numberview,'Check','off');
        set(handles.blankview,'Check','off');
    refresh_graph(0, eventdata, handles)
end

guidata(hObject, handles);

% --------------------------------------------------------------------
function numberview_Callback(hObject, eventdata, handles)
% hObject    handle to numberview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;
checkstatus = get(hObject,'Check');

if strcmp(checkstatus, 'on')
    set(hObject,'Check','off');
elseif strcmp(checkstatus, 'off')
    set(handles.colorview,'Check','off');
    set(handles.labelview,'Check','off');
    set(handles.numberview,'Check','on');
        set(handles.blankview,'Check','off');
    refresh_graph(0, eventdata, handles)
end

guidata(hObject, handles);


% --------------------------------------------------------------------
function blankview_Callback(hObject, eventdata, handles)
% hObject    handle to blankview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;
checkstatus = get(hObject,'Check');

if strcmp(checkstatus, 'on')
    set(hObject,'Check','off');
elseif strcmp(checkstatus, 'off')
    set(handles.colorview,'Check','off');
    set(handles.labelview,'Check','off');
    set(handles.numberview,'Check','off');
    set(handles.blankview,'Check','on');
    refresh_graph(0, eventdata, handles)
end

guidata(hObject, handles);



% --------------------------------------------------------------------
function Untitled_16_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_17_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function viewmenu_Callback(hObject, eventdata, handles)
% hObject    handle to viewmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function editnode_Callback(hObject, eventdata, handles)
% hObject    handle to editnode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function refresh_graph(reset, eventdata, handles)
% This function refreshes the graph window
global g;

 checklabel = get(handles.labelview,'Check');
checknumber = get(handles.numberview,'Check');
 checkcolor = get(handles.colorview,'Check');
 checkblank = get(handles.blankview,'Check');
 
rmxy(g);
cla;

if (reset >= 0.99) && (ne(g) > 0)
    distxy(g);
end

if(ne(g)>0)
    basic_stats(eventdata, handles);
end


if strcmp(checklabel, 'on')
    ldraw(g);
elseif strcmp(checkcolor, 'on')
    cdraw(g);
elseif strcmp(checknumber, 'on')
    ndraw(g);
else
    draw(g);
end

set(handles.nedges,'String', num2str(ne(g)));
set(handles.nvertices,'String',num2str(nv(g)));


% --------------------------------------------------------------------
function click_add_node_long_Callback(hObject, eventdata, handles)
% hObject    handle to click_add_node_long (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)







% --- Executes on button press in laplacianvisualize.
function basic_stats(eventdata, handles)
% hObject    handle to laplacianvisualize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global g;

L = laplacian(g);

 rank_L = rank(L);       % Matrix rank
  dim_L  = mean(size(L)); % Matrix dimension
 
 null_L = dim_L - rank(L); %Rank of the null-space (from rank-nullity theorem)
                            %Gives us number of connected (sub) graphs
degree_vector = diag(L);

D = diag(diag(L));
A = D - L; % Adjacency matrix

 rank_A = rank(A);       % Matrix rank
  dim_A  = mean(size(A)); % Matrix dimension
 
 null_A = dim_A - rank(A); %Rank of the null-space (from rank-nullity theorem)
                            %Gives us number of connected (sub) graphs
set(handles.connected_graphs,'String', num2str(null_L));
graph_density = mean(degree_vector)/(dim_L-1); %(1)
set(handles.graph_density,'String', num2str(graph_density));
graph_average_degree = mean(degree_vector);
set(handles.average_degree,'String', num2str(graph_average_degree));
graph_median_degree = median(degree_vector);
set(handles.median_degree,'String', num2str(graph_median_degree));
graph_min_degree = min(degree_vector);
set(handles.minimum_degree,'String', num2str(graph_min_degree));
graph_max_degree = max(degree_vector);
set(handles.maximum_degree,'String', num2str(graph_max_degree));
%graph_density = 2*NEdges/(NVertex*(NVertex-1)); % Segun Wikipedia
graph_heterogenity = sqrt(var(degree_vector))/mean(degree_vector);
set(handles.graph_heterogenity,'String', num2str(graph_heterogenity));
[Eigen_Matrix_L, Eigen_Values_L] = eig(L);
[Eigen_Matrix_A, Eigen_Values_A] = eig(A);

% Sorting Eigenvalues
 Eigen_Values_L = diag(Eigen_Values_L);
[Eigen_Values_L, ndx] = sort(Eigen_Values_L, 'ascend');
 Eigen_Matrix_L=Eigen_Matrix_L(:,ndx); 
 
  Eigen_Values_A = diag(Eigen_Values_A);
[Eigen_Values_A, ndx] = sort(Eigen_Values_A, 'ascend');
 Eigen_Matrix_A=Eigen_Matrix_A(:,ndx); 
 
 graph_connectivityA = Eigen_Values_A(null_L+1);
 graph_connectivity = Eigen_Values_L(null_L+1);
 set(handles.algebraic_connectivity,'String', num2str(graph_connectivity));
 fiedler_vector   = Eigen_Matrix_L(:,null_L+1);
  
 estrada_connectivity = diag(exp(A));
  
 estrada_graph_index  = trace(exp(A));







function dynamic_label_Callback(hObject, eventdata, handles)
% hObject    handle to dynamic_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dynamic_label as text
%        str2double(get(hObject,'String')) returns contents of dynamic_label as a double


% --- Executes during object creation, after setting all properties.
function dynamic_label_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dynamic_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --------------------------------------------------------------------
function import_from_simulink_Callback(hObject, eventdata, handles)
% hObject    handle to import_from_simulink (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function export_to_simulink_Callback(hObject, eventdata, handles)
% hObject    handle to export_to_simulink (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;
addpath(strcat(pwd,'/interface2Simulink'));
A  = double(matrix(g));
xy = getxy(g);
labs = get_label(g);
name =	'untitled';
template =	'LTI'; 
exportSimulink(name,template,A, xy, labs);



% --- Executes on button press in add_multiple_nodes.
function add_multiple_nodes_Callback(hObject, eventdata, handles)
% hObject    handle to add_multiple_nodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)







% --------------------------------------------------------------------
function exit_to_matlab_Callback(hObject, eventdata, handles)
% hObject    handle to exit_to_matlab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;

