

function varargout = secondgui_export(varargin)
% SECONDGUI_EXPORT M-file for secondgui_export.fig
%      SECONDGUI_EXPORT, by itself, creates a new SECONDGUI_EXPORT or raises the existing
%      singleton*.
%
%      H = SECONDGUI_EXPORT returns the handle to a new SECONDGUI_EXPORT or the handle to
%      the existing singleton*.
%
%      SECONDGUI_EXPORT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SECONDGUI_EXPORT.M with the given input arguments.
%
%      SECONDGUI_EXPORT('Property','Value',...) creates a new SECONDGUI_EXPORT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before secondgui_export_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to secondgui_export_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help secondgui_export

% Last Modified by GUIDE v2.5 20-May-2011 19:34:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @secondgui_export_OpeningFcn, ...
                   'gui_OutputFcn',  @secondgui_export_OutputFcn, ...
                   'gui_LayoutFcn',  @secondgui_export_LayoutFcn, ...
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


% --- Executes just before secondgui_export is made visible.
function secondgui_export_OpeningFcn(hObject, eventdata, handles, varargin)

addpath(strcat(pwd,'/matgraph'));
graph_init;
global g;

g = graph; %% Creating a graph
resize(g,0);
refresh_graph(0, eventdata, handles);

% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to secondgui_export (see VARARGIN)

% Choose default command line output for secondgui_export
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes secondgui_export wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = secondgui_export_OutputFcn(hObject, eventdata, handles) 
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


refresh_graph(1, eventdata, handles)

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

rmxy(g);
cla;

if (reset >= 0.99) && (ne(g) > 0)
    distxy(g);
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







% --- Creates and returns a handle to the GUI figure. 
function h1 = secondgui_export_LayoutFcn(policy)
% policy - create a new figure or use a singleton. 'new' or 'reuse'.

persistent hsingleton;
if strcmpi(policy, 'reuse') & ishandle(hsingleton)
    h1 = hsingleton;
    return;
end

appdata = [];
appdata.GUIDEOptions = struct(...
    'active_h', [], ...
    'taginfo', struct(...
    'figure', 2, ...
    'text', 8, ...
    'axes', 2, ...
    'pushbutton', 13, ...
    'edit', 5, ...
    'popupmenu', 2, ...
    'uipanel', 6, ...
    'radiobutton', 5, ...
    'listbox', 2), ...
    'override', 1, ...
    'release', 13, ...
    'resize', 'custom', ...
    'accessibility', 'callback', ...
    'mfile', 1, ...
    'callbacks', 1, ...
    'singleton', 1, ...
    'syscolorfig', 1, ...
    'blocking', 0, ...
    'lastSavedFile', 'D:\Francisco\TUM\NCS-Proyect\secondgui_export.m');
appdata.lastValidTag = 'figure1';
appdata.GUIDELayoutEditor = [];

h1 = figure(...
'Units','characters',...
'PaperUnits',get(0,'defaultfigurePaperUnits'),...
'CloseRequestFcn','secondgui_export(''figure1_CloseRequestFcn'',gcbf,[],guidata(gcbf))',...
'Color',[0.941176470588235 0.941176470588235 0.941176470588235],...
'Colormap',[0 0 0.5625;0 0 0.625;0 0 0.6875;0 0 0.75;0 0 0.8125;0 0 0.875;0 0 0.9375;0 0 1;0 0.0625 1;0 0.125 1;0 0.1875 1;0 0.25 1;0 0.3125 1;0 0.375 1;0 0.4375 1;0 0.5 1;0 0.5625 1;0 0.625 1;0 0.6875 1;0 0.75 1;0 0.8125 1;0 0.875 1;0 0.9375 1;0 1 1;0.0625 1 1;0.125 1 0.9375;0.1875 1 0.875;0.25 1 0.8125;0.3125 1 0.75;0.375 1 0.6875;0.4375 1 0.625;0.5 1 0.5625;0.5625 1 0.5;0.625 1 0.4375;0.6875 1 0.375;0.75 1 0.3125;0.8125 1 0.25;0.875 1 0.1875;0.9375 1 0.125;1 1 0.0625;1 1 0;1 0.9375 0;1 0.875 0;1 0.8125 0;1 0.75 0;1 0.6875 0;1 0.625 0;1 0.5625 0;1 0.5 0;1 0.4375 0;1 0.375 0;1 0.3125 0;1 0.25 0;1 0.1875 0;1 0.125 0;1 0.0625 0;1 0 0;0.9375 0 0;0.875 0 0;0.8125 0 0;0.75 0 0;0.6875 0 0;0.625 0 0;0.5625 0 0],...
'IntegerHandle','off',...
'InvertHardcopy',get(0,'defaultfigureInvertHardcopy'),...
'MenuBar','none',...
'Name','secondgui',...
'NumberTitle','off',...
'PaperPosition',get(0,'defaultfigurePaperPosition'),...
'PaperSize',[20.98404194812 29.67743169791],...
'PaperType',get(0,'defaultfigurePaperType'),...
'Position',[103.8 16.4615384615385 195 45],...
'Renderer',get(0,'defaultfigureRenderer'),...
'RendererMode','manual',...
'ResizeFcn','secondgui_export(''figure1_ResizeFcn'',gcbo,[],guidata(gcbo))',...
'HandleVisibility','callback',...
'Tag','figure1',...
'UserData',[],...
'Behavior',get(0,'defaultfigureBehavior'),...
'Visible','on',...
'CreateFcn', {@local_CreateFcn, '', appdata} );

appdata = [];
appdata.lastValidTag = 'text1';

h2 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'FontSize',20,...
'Position',[-0.2 41 70.2 3.92307692307692],...
'String','MTIDS Graph Builder',...
'Style','text',...
'Tag','text1',...
'Behavior',get(0,'defaultuicontrolBehavior'),...
'CreateFcn', {@local_CreateFcn, '', appdata} );

appdata = [];
appdata.lastValidTag = 'axes1';

h3 = axes(...
'Parent',h1,...
'Units','characters',...
'Position',[89.8 14.5384615384615 70.2 26.5384615384615],...
'CameraPosition',[0.5 0.5 9.16025403784439],...
'CameraPositionMode',get(0,'defaultaxesCameraPositionMode'),...
'Color',get(0,'defaultaxesColor'),...
'ColorOrder',get(0,'defaultaxesColorOrder'),...
'LooseInset',[22.23 4.10384615384615 16.245 2.79807692307692],...
'XColor',get(0,'defaultaxesXColor'),...
'YColor',get(0,'defaultaxesYColor'),...
'ZColor',get(0,'defaultaxesZColor'),...
'Tag','axes1',...
'Behavior',get(0,'defaultaxesBehavior'),...
'CreateFcn', {@local_CreateFcn, '', appdata} );

h4 = get(h3,'title');

set(h4,...
'Parent',h3,...
'Color',[0 0 0],...
'HorizontalAlignment','center',...
'Position',[0.5 1.01884057971014 1.00005459937205],...
'VerticalAlignment','bottom',...
'HandleVisibility','off',...
'Behavior',struct());

h5 = get(h3,'xlabel');

set(h5,...
'Parent',h3,...
'Color',[0 0 0],...
'HorizontalAlignment','center',...
'Position',[0.497150997150997 -0.0681159420289856 1.00005459937205],...
'VerticalAlignment','cap',...
'HandleVisibility','off',...
'Behavior',struct());

h6 = get(h3,'ylabel');

set(h6,...
'Parent',h3,...
'Color',[0 0 0],...
'HorizontalAlignment','center',...
'Position',[-0.0811965811965814 0.497101449275362 1.00005459937205],...
'Rotation',90,...
'VerticalAlignment','bottom',...
'HandleVisibility','off',...
'Behavior',struct());

h7 = get(h3,'zlabel');

set(h7,...
'Parent',h3,...
'Color',[0 0 0],...
'HorizontalAlignment','right',...
'Position',[-1.28062678062678 1.14347826086957 1.00005459937205],...
'HandleVisibility','off',...
'Behavior',struct(),...
'Visible','off');

appdata = [];
appdata.lastValidTag = 'newnodelabel';

h8 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback','secondgui_export(''newnodelabel_Callback'',gcbo,[],guidata(gcbo))',...
'Position',[9.8 33.3076923076923 40.2 1.61538461538462],...
'String','Label',...
'Style','edit',...
'CreateFcn', {@local_CreateFcn, 'secondgui_export(''newnodelabel_CreateFcn'',gcbo,[],guidata(gcbo))', appdata} ,...
'Tag','newnodelabel',...
'Behavior',get(0,'defaultuicontrolBehavior'));

appdata = [];
appdata.lastValidTag = 'fromnode';

h9 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback','secondgui_export(''fromnode_Callback'',gcbo,[],guidata(gcbo))',...
'Position',[21 23.9230769230769 7.2 1.30769230769231],...
'String','',...
'Style','edit',...
'CreateFcn', {@local_CreateFcn, 'secondgui_export(''fromnode_CreateFcn'',gcbo,[],guidata(gcbo))', appdata} ,...
'Tag','fromnode',...
'Behavior',get(0,'defaultuicontrolBehavior'));

appdata = [];
appdata.lastValidTag = 'tonode';

h10 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback','secondgui_export(''tonode_Callback'',gcbo,[],guidata(gcbo))',...
'Position',[42.2 23.8461538461539 7 1.46153846153846],...
'String','',...
'Style','edit',...
'CreateFcn', {@local_CreateFcn, 'secondgui_export(''tonode_CreateFcn'',gcbo,[],guidata(gcbo))', appdata} ,...
'Tag','tonode',...
'Behavior',get(0,'defaultuicontrolBehavior'));

appdata = [];
appdata.lastValidTag = 'text4';

h11 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Position',[30.2 24 10 1.15384615384615],...
'String','to node',...
'Style','text',...
'Tag','text4',...
'Behavior',get(0,'defaultuicontrolBehavior'),...
'CreateFcn', {@local_CreateFcn, '', appdata} );

appdata = [];
appdata.lastValidTag = 'uipanel1';

h12 = uipanel(...
'Parent',h1,...
'Units','characters',...
'Title','Connections',...
'Position',[5.8 21 74.2 9.92307692307692],...
'Tag','uipanel1',...
'Behavior',get(0,'defaultuipanelBehavior'),...
'CreateFcn', {@local_CreateFcn, '', appdata} );

appdata = [];
appdata.lastValidTag = 'addconnection';

h13 = uicontrol(...
'Parent',h12,...
'Units','characters',...
'Callback','secondgui_export(''addconnection_Callback'',gcbo,[],guidata(gcbo))',...
'Position',[45.8 6.46153846153846 24.2 2],...
'String','Add connection',...
'Tag','addconnection',...
'Behavior',get(0,'defaultuicontrolBehavior'),...
'CreateFcn', {@local_CreateFcn, '', appdata} );

appdata = [];
appdata.lastValidTag = 'randomconnection';

h14 = uicontrol(...
'Parent',h12,...
'Units','characters',...
'Callback','secondgui_export(''randomconnection_Callback'',gcbo,[],guidata(gcbo))',...
'Position',[45.8 3.38461538461539 24.2 2],...
'String','Random connection',...
'Tag','randomconnection',...
'Behavior',get(0,'defaultuicontrolBehavior'),...
'CreateFcn', {@local_CreateFcn, '', appdata} );

appdata = [];
appdata.lastValidTag = 'removeconnection';

h15 = uicontrol(...
'Parent',h12,...
'Units','characters',...
'Callback','secondgui_export(''removeconnection_Callback'',gcbo,[],guidata(gcbo))',...
'Position',[45.8 0.692307692307692 24.2 2],...
'String','Remove connection',...
'Tag','removeconnection',...
'Behavior',get(0,'defaultuicontrolBehavior'),...
'CreateFcn', {@local_CreateFcn, '', appdata} );

appdata = [];
appdata.lastValidTag = 'text5';

h16 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Position',[8.2 24 10.8 1.15384615384615],...
'String','From',...
'Style','text',...
'Tag','text5',...
'Behavior',get(0,'defaultuicontrolBehavior'),...
'CreateFcn', {@local_CreateFcn, '', appdata} );

appdata = [];
appdata.lastValidTag = 'uipanel3';

h17 = uipanel(...
'Parent',h1,...
'Units','characters',...
'Title','Basic statistics',...
'Position',[83 0.307692307692308 110.2 7.53846153846154],...
'Tag','uipanel3',...
'Behavior',get(0,'defaultuipanelBehavior'),...
'CreateFcn', {@local_CreateFcn, '', appdata} );

appdata = [];
appdata.lastValidTag = 'nvertices';

h18 = uicontrol(...
'Parent',h17,...
'Units','characters',...
'Position',[19.8 4.46153846153846 10.2 1.15384615384615],...
'String','Nv',...
'Style','text',...
'Tag','nvertices',...
'Behavior',get(0,'defaultuicontrolBehavior'),...
'CreateFcn', {@local_CreateFcn, '', appdata} );

appdata = [];
appdata.lastValidTag = 'nedges';

h19 = uicontrol(...
'Parent',h17,...
'Units','characters',...
'Position',[19.8 2.69230769230769 10.2 1.15384615384615],...
'String','Ne',...
'Style','text',...
'Tag','nedges',...
'Behavior',get(0,'defaultuicontrolBehavior'),...
'CreateFcn', {@local_CreateFcn, '', appdata} );

appdata = [];
appdata.lastValidTag = 'text6';

h20 = uicontrol(...
'Parent',h17,...
'Units','characters',...
'Position',[3.8 4.46153846153846 10.6 1.15384615384615],...
'String','Nodes:',...
'Style','text',...
'Tag','text6',...
'Behavior',get(0,'defaultuicontrolBehavior'),...
'CreateFcn', {@local_CreateFcn, '', appdata} );

appdata = [];
appdata.lastValidTag = 'text7';

h21 = uicontrol(...
'Parent',h17,...
'Units','characters',...
'Position',[3.4 2.76923076923077 14 1.15384615384615],...
'String','Connections:',...
'Style','text',...
'Tag','text7',...
'Behavior',get(0,'defaultuicontrolBehavior'),...
'CreateFcn', {@local_CreateFcn, '', appdata} );

appdata = [];
appdata.lastValidTag = 'uipanel4';

h22 = uipanel(...
'Parent',h1,...
'Units','characters',...
'Title','Node creation/removal',...
'Position',[5.4 31.7692307692308 74.6 5.46153846153846],...
'Tag','uipanel4',...
'Behavior',get(0,'defaultuipanelBehavior'),...
'CreateFcn', {@local_CreateFcn, '', appdata} );

appdata = [];
appdata.lastValidTag = 'newnode';

h23 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','secondgui_export(''newnode_Callback'',gcbo,[],guidata(gcbo))',...
'Position',[57.4 33.3076923076923 16.2 1.76923076923077],...
'String','Add node',...
'Tag','newnode',...
'Behavior',get(0,'defaultuicontrolBehavior'),...
'CreateFcn', {@local_CreateFcn, '', appdata} );

appdata = [];
appdata.lastValidTag = 'clearconnections';

h24 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','secondgui_export(''clearconnections_Callback'',gcbo,[],guidata(gcbo))',...
'Position',[52.2 16.4615384615385 24.2 2],...
'String','Clear connections',...
'Tag','clearconnections',...
'Behavior',get(0,'defaultuicontrolBehavior'),...
'CreateFcn', {@local_CreateFcn, '', appdata} );

appdata = [];
appdata.lastValidTag = 'completegraph';

h25 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','secondgui_export(''completegraph_Callback'',gcbo,[],guidata(gcbo))',...
'Position',[25.8 13.6153846153846 24.2 2],...
'String','Complete graph',...
'Tag','completegraph',...
'Behavior',get(0,'defaultuicontrolBehavior'),...
'CreateFcn', {@local_CreateFcn, '', appdata} );

appdata = [];
appdata.lastValidTag = 'randomgraph';

h26 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','secondgui_export(''randomgraph_Callback'',gcbo,[],guidata(gcbo))',...
'Position',[52.2 13.6153846153846 24.2 2],...
'String','Random graph',...
'Tag','randomgraph',...
'Behavior',get(0,'defaultuicontrolBehavior'),...
'CreateFcn', {@local_CreateFcn, '', appdata} );

appdata = [];
appdata.lastValidTag = 'trimgraph';

h27 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','secondgui_export(''trimgraph_Callback'',gcbo,[],guidata(gcbo))',...
'Position',[25.8 16.3846153846154 24.2 2.07692307692308],...
'String','Trim graph',...
'Tag','trimgraph',...
'Behavior',get(0,'defaultuicontrolBehavior'),...
'CreateFcn', {@local_CreateFcn, '', appdata} );

appdata = [];
appdata.lastValidTag = 'uipanel5';

h28 = uipanel(...
'Parent',h1,...
'Units','characters',...
'Title','Topologies',...
'Position',[6.2 11.9230769230769 73.8 8.38461538461539],...
'Tag','uipanel5',...
'Behavior',get(0,'defaultuipanelBehavior'),...
'CreateFcn', {@local_CreateFcn, '', appdata} );

h29 = uimenu(...
'Parent',h1,...
'Callback','secondgui_export(''file_Callback'',gcbo,[],guidata(gcbo))',...
'Label','File',...
'Tag','file',...
'Behavior',get(0,'defaultuimenuBehavior'));

h30 = uimenu(...
'Parent',h29,...
'Callback','secondgui_export(''Newgraph_Callback'',gcbo,[],guidata(gcbo))',...
'Label','New Graph',...
'Tag','Newgraph',...
'Behavior',get(0,'defaultuimenuBehavior'));

h31 = uimenu(...
'Parent',h29,...
'Callback','secondgui_export(''loadgraph_Callback'',gcbo,[],guidata(gcbo))',...
'Label','Load...',...
'Tag','loadgraph',...
'Behavior',get(0,'defaultuimenuBehavior'));

h32 = uimenu(...
'Parent',h29,...
'Callback','secondgui_export(''Savegraph_Callback'',gcbo,[],guidata(gcbo))',...
'Label','Save',...
'Tag','Savegraph',...
'Behavior',get(0,'defaultuimenuBehavior'));

h33 = uimenu(...
'Parent',h29,...
'Callback','secondgui_export(''savegraphas_Callback'',gcbo,[],guidata(gcbo))',...
'Label','Save As...',...
'Tag','savegraphas',...
'Behavior',get(0,'defaultuimenuBehavior'));

h34 = uimenu(...
'Parent',h1,...
'Callback','secondgui_export(''viewmenu_Callback'',gcbo,[],guidata(gcbo))',...
'Label','View',...
'Tag','viewmenu',...
'Behavior',get(0,'defaultuimenuBehavior'));

h35 = uimenu(...
'Parent',h34,...
'Callback','secondgui_export(''labelview_Callback'',gcbo,[],guidata(gcbo))',...
'Label','Label View',...
'Tag','labelview',...
'Behavior',get(0,'defaultuimenuBehavior'));

h36 = uimenu(...
'Parent',h34,...
'Callback','secondgui_export(''numberview_Callback'',gcbo,[],guidata(gcbo))',...
'Label','Number View',...
'Tag','numberview',...
'Behavior',get(0,'defaultuimenuBehavior'));

h37 = uimenu(...
'Parent',h34,...
'Callback','secondgui_export(''colorview_Callback'',gcbo,[],guidata(gcbo))',...
'Label','Color View',...
'Tag','colorview',...
'Behavior',get(0,'defaultuimenuBehavior'));

h38 = uimenu(...
'Parent',h1,...
'Callback','secondgui_export(''Untitled_9_Callback'',gcbo,[],guidata(gcbo))',...
'Label','Node',...
'Tag','Untitled_9',...
'Behavior',get(0,'defaultuimenuBehavior'));

h39 = uimenu(...
'Parent',h38,...
'Callback','secondgui_export(''Untitled_10_Callback'',gcbo,[],guidata(gcbo))',...
'Label','Add Node...',...
'Tag','Untitled_10',...
'Behavior',get(0,'defaultuimenuBehavior'));

h40 = uimenu(...
'Parent',h38,...
'Callback','secondgui_export(''editnode_Callback'',gcbo,[],guidata(gcbo))',...
'Label','Edit Node...',...
'Tag','editnode',...
'Behavior',get(0,'defaultuimenuBehavior'));

h41 = uimenu(...
'Parent',h1,...
'Callback','secondgui_export(''dynamicsimporter_Callback'',gcbo,[],guidata(gcbo))',...
'Label','Dynamics',...
'Tag','dynamicsimporter',...
'Behavior',get(0,'defaultuimenuBehavior'));

h42 = uimenu(...
'Parent',h41,...
'Callback','secondgui_export(''adddynamics_Callback'',gcbo,[],guidata(gcbo))',...
'Label','Add Dynamic Model',...
'Tag','adddynamics',...
'Behavior',get(0,'defaultuimenuBehavior'));

h43 = uimenu(...
'Parent',h1,...
'Callback','secondgui_export(''Untitled_11_Callback'',gcbo,[],guidata(gcbo))',...
'Label','Network',...
'Tag','networkopts',...
'Behavior',get(0,'defaultuimenuBehavior'));

h44 = uimenu(...
'Parent',h1,...
'Callback','secondgui_export(''Untitled_12_Callback'',gcbo,[],guidata(gcbo))',...
'Label','Simulation',...
'Tag','Untitled_12',...
'Behavior',get(0,'defaultuimenuBehavior'));

h45 = uimenu(...
'Parent',h44,...
'Callback','secondgui_export(''generatesimulinkmdl_Callback'',gcbo,[],guidata(gcbo))',...
'Label','Create Simulink MDL',...
'Tag','generatesimulinkmdl',...
'Behavior',get(0,'defaultuimenuBehavior'));

h46 = uimenu(...
'Parent',h1,...
'Callback','secondgui_export(''about_Callback'',gcbo,[],guidata(gcbo))',...
'Label','About',...
'Tag','about',...
'Behavior',get(0,'defaultuimenuBehavior'));

h47 = uimenu(...
'Parent',h46,...
'Callback','secondgui_export(''aboutmtids_Callback'',gcbo,[],guidata(gcbo))',...
'Label','About MTIDS for MATLAB',...
'Tag','aboutmtids',...
'Behavior',get(0,'defaultuimenuBehavior'));

appdata = [];
appdata.lastValidTag = 'remnode';

h48 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback','secondgui_export(''remnode_Callback'',gcbo,[],guidata(gcbo))',...
'Position',[165 33.3076923076923 9.8 1.61538461538462],...
'String','',...
'Style','edit',...
'CreateFcn', {@local_CreateFcn, 'secondgui_export(''remnode_CreateFcn'',gcbo,[],guidata(gcbo))', appdata} ,...
'Tag','remnode',...
'Behavior',get(0,'defaultuicontrolBehavior'));

appdata = [];
appdata.lastValidTag = 'removenode';

h49 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','secondgui_export(''removenode_Callback'',gcbo,[],guidata(gcbo))',...
'Position',[178.6 33.3076923076923 16.2 1.84615384615385],...
'String','Remove node',...
'Tag','removenode',...
'Behavior',get(0,'defaultuicontrolBehavior'),...
'CreateFcn', {@local_CreateFcn, '', appdata} );

h50 = uicontextmenu(...
'Parent',h1,...
'Callback','click_add_node',...
'Tag','add Node',...
'Behavior',get(0,'defaultuicontextmenuBehavior'));

h51 = uimenu(...
'Parent',h50,...
'Callback','secondgui_export(''click_add_node_long_Callback'',gcbo,[],guidata(gcbo))',...
'Label','add Node Wizzard',...
'Tag','click_add_node_long',...
'Behavior',get(0,'defaultuimenuBehavior'));


hsingleton = h1;


% --- Set application data first then calling the CreateFcn. 
function local_CreateFcn(hObject, eventdata, createfcn, appdata)

if ~isempty(appdata)
   names = fieldnames(appdata);
   for i=1:length(names)
       name = char(names(i));
       setappdata(hObject, name, getfield(appdata,name));
   end
end

if ~isempty(createfcn)
   eval(createfcn);
end


% --- Handles default GUIDE GUI creation and callback dispatch
function varargout = gui_mainfcn(gui_State, varargin)


%   GUI_MAINFCN provides these command line APIs for dealing with GUIs
%
%      SECONDGUI_EXPORT, by itself, creates a new SECONDGUI_EXPORT or raises the existing
%      singleton*.
%
%      H = SECONDGUI_EXPORT returns the handle to a new SECONDGUI_EXPORT or the handle to
%      the existing singleton*.
%
%      SECONDGUI_EXPORT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SECONDGUI_EXPORT.M with the given input arguments.
%
%      SECONDGUI_EXPORT('Property','Value',...) creates a new SECONDGUI_EXPORT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".

%   Copyright 1984-2004 The MathWorks, Inc.
%   $Revision: 1.4.6.8 $ $Date: 2004/04/15 00:06:57 $

gui_StateFields =  {'gui_Name'
                    'gui_Singleton'
                    'gui_OpeningFcn'
                    'gui_OutputFcn'
                    'gui_LayoutFcn'
                    'gui_Callback'};
gui_Mfile = '';
for i=1:length(gui_StateFields)
    if ~isfield(gui_State, gui_StateFields{i})
        error('Could not find field %s in the gui_State struct in GUI M-file %s', gui_StateFields{i}, gui_Mfile);        
    elseif isequal(gui_StateFields{i}, 'gui_Name')
        gui_Mfile = [gui_State.(gui_StateFields{i}), '.m'];
    end
end

numargin = length(varargin);

if numargin == 0
    % SECONDGUI_EXPORT
    % create the GUI
    gui_Create = 1;
elseif isequal(ishandle(varargin{1}), 1) && ispc && iscom(varargin{1}) && isequal(varargin{1},gcbo)
    % SECONDGUI_EXPORT(ACTIVEX,...)    
    vin{1} = gui_State.gui_Name;
    vin{2} = [get(varargin{1}.Peer, 'Tag'), '_', varargin{end}];
    vin{3} = varargin{1};
    vin{4} = varargin{end-1};
    vin{5} = guidata(varargin{1}.Peer);
    feval(vin{:});
    return;
elseif ischar(varargin{1}) && numargin>1 && isequal(ishandle(varargin{2}), 1)
    % SECONDGUI_EXPORT('CALLBACK',hObject,eventData,handles,...)
    gui_Create = 0;
else
    % SECONDGUI_EXPORT(...)
    % create the GUI and hand varargin to the openingfcn
    gui_Create = 1;
end

if gui_Create == 0
    varargin{1} = gui_State.gui_Callback;
    if nargout
        [varargout{1:nargout}] = feval(varargin{:});
    else
        feval(varargin{:});
    end
else
    if gui_State.gui_Singleton
        gui_SingletonOpt = 'reuse';
    else
        gui_SingletonOpt = 'new';
    end
    
    % Open fig file with stored settings.  Note: This executes all component
    % specific CreateFunctions with an empty HANDLES structure.
    
    % Do feval on layout code in m-file if it exists
    if ~isempty(gui_State.gui_LayoutFcn)
        gui_hFigure = feval(gui_State.gui_LayoutFcn, gui_SingletonOpt);
        % openfig (called by local_openfig below) does this for guis without
        % the LayoutFcn. Be sure to do it here so guis show up on screen.
        movegui(gui_hFigure,'onscreen')
    else
        gui_hFigure = local_openfig(gui_State.gui_Name, gui_SingletonOpt);            
        % If the figure has InGUIInitialization it was not completely created
        % on the last pass.  Delete this handle and try again.
        if isappdata(gui_hFigure, 'InGUIInitialization')
            delete(gui_hFigure);
            gui_hFigure = local_openfig(gui_State.gui_Name, gui_SingletonOpt);            
        end
    end
    
    % Set flag to indicate starting GUI initialization
    setappdata(gui_hFigure,'InGUIInitialization',1);

    % Fetch GUIDE Application options
    gui_Options = getappdata(gui_hFigure,'GUIDEOptions');
    
    if ~isappdata(gui_hFigure,'GUIOnScreen')
        % Adjust background color
        if gui_Options.syscolorfig 
            set(gui_hFigure,'Color', get(0,'DefaultUicontrolBackgroundColor'));
        end

        % Generate HANDLES structure and store with GUIDATA
        guidata(gui_hFigure, guihandles(gui_hFigure));
    end
    
    % If user specified 'Visible','off' in p/v pairs, don't make the figure
    % visible.
    gui_MakeVisible = 1;
    for ind=1:2:length(varargin)
        if length(varargin) == ind
            break;
        end
        len1 = min(length('visible'),length(varargin{ind}));
        len2 = min(length('off'),length(varargin{ind+1}));
        if ischar(varargin{ind}) && ischar(varargin{ind+1}) && ...
                strncmpi(varargin{ind},'visible',len1) && len2 > 1
            if strncmpi(varargin{ind+1},'off',len2)
                gui_MakeVisible = 0;
            elseif strncmpi(varargin{ind+1},'on',len2)
                gui_MakeVisible = 1;
            end
        end
    end
    
    % Check for figure param value pairs
    for index=1:2:length(varargin)
        if length(varargin) == index
            break;
        end
        try set(gui_hFigure, varargin{index}, varargin{index+1}), catch break, end
    end

    % If handle visibility is set to 'callback', turn it on until finished
    % with OpeningFcn
    gui_HandleVisibility = get(gui_hFigure,'HandleVisibility');
    if strcmp(gui_HandleVisibility, 'callback')
        set(gui_hFigure,'HandleVisibility', 'on');
    end
    
    feval(gui_State.gui_OpeningFcn, gui_hFigure, [], guidata(gui_hFigure), varargin{:});
    
    if ishandle(gui_hFigure)
        % Update handle visibility
        set(gui_hFigure,'HandleVisibility', gui_HandleVisibility);
        
        % Make figure visible
        if gui_MakeVisible
            set(gui_hFigure, 'Visible', 'on')
            if gui_Options.singleton 
                setappdata(gui_hFigure,'GUIOnScreen', 1);
            end
        end

        % Done with GUI initialization
        rmappdata(gui_hFigure,'InGUIInitialization');
    end
    
    % If handle visibility is set to 'callback', turn it on until finished with
    % OutputFcn
    if ishandle(gui_hFigure)
        gui_HandleVisibility = get(gui_hFigure,'HandleVisibility');
        if strcmp(gui_HandleVisibility, 'callback')
            set(gui_hFigure,'HandleVisibility', 'on');
        end
        gui_Handles = guidata(gui_hFigure);
    else
        gui_Handles = [];
    end
    
    if nargout
        [varargout{1:nargout}] = feval(gui_State.gui_OutputFcn, gui_hFigure, [], gui_Handles);
    else
        feval(gui_State.gui_OutputFcn, gui_hFigure, [], gui_Handles);
    end
    
    if ishandle(gui_hFigure)
        set(gui_hFigure,'HandleVisibility', gui_HandleVisibility);
    end
end    

function gui_hFigure = local_openfig(name, singleton)

% openfig with three arguments was new from R13. Try to call that first, if
% failed, try the old openfig.
try 
    gui_hFigure = openfig(name, singleton, 'auto');
catch
    % OPENFIG did not accept 3rd input argument until R13,
    % toggle default figure visible to prevent the figure
    % from showing up too soon.
    gui_OldDefaultVisible = get(0,'defaultFigureVisible');
    set(0,'defaultFigureVisible','off');
    gui_hFigure = openfig(name, singleton);
    set(0,'defaultFigureVisible',gui_OldDefaultVisible);
end

