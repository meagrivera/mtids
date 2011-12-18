function varargout = mtids(varargin)
%
%      MTIDS 1.0
%      (C) 2011 The MTIDS Project (http://code.google.com/p/mtids)
%      Matlab Toolbox for Interconnected Dynamical Systems
%      Test Rig for Large-Scale Interconnected Systems.
%
%      MTIDS uses and redistributes Matgraph (C) 2005 Ed Scheinermann (http://www.ams.jhu.edu/~ers/matgraph/)
%
%      This program is free software; you can redistribute it and/or
%      modify it under the terms of the GNU General Public License
%      as published by the Free Software Foundation; either version 2
%      of the License, or (at your option) any later version.
%
%      This program is distributed in the hope that it will be useful,
%      but WITHOUT ANY WARRANTY; without even the implied warranty of
%      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%      GNU General Public License for more details.
%
%      You should have received a copy of the GNU General Public License
%      along with this program; if not, write to the Free Software
%      Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
%
%       A copy of the GNU GPL v2 Licence is available inside the LICENCE.txt
%       file.
%
% Last Modified by GUIDE v2.5 18-Dec-2011 11:54:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mtids_OpeningFcn, ...
                   'gui_OutputFcn',  @mtids_OutputFcn, ...
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


% --- Executes just before mtids is made visible.
function mtids_OpeningFcn(hObject, eventdata, handles, varargin)
disp(' ');
disp('MTIDS 1.0');
disp('Test Rig for Large-Scale and Interconnected Dynamical Systems');
disp('<a href="http://code.google.com/p/mtids">http://code.google.com/p/mtids</a>');
disp(' ');
disp('This program is free software; you can redistribute it and/or');
disp('modify it under the terms of the GNU General Public License');
disp('as published by the Free Software Foundation; either version 2');
disp('of the License, or (at your option) any later version.');
disp('This program is distributed in the hope that it will be useful,');
disp('but WITHOUT ANY WARRANTY; without even the implied warranty of');
disp('MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the');
disp('GNU General Public License for more details.');
disp(' ');
disp('You should have received a copy of the GNU General Public License');
disp('along with this program; if not, write to the Free Software');
disp('Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.');
disp(' ');
disp(' ');

addpath(strcat(pwd,'/tools/matgraph'));     % Folder with a copy of Matgraph
addpath(strcat(pwd,'/interface2Simulink')); % Folder with various import/export functions
addpath(strcat(pwd,'/templates'));          % Folder for Simulink templates

graph_init;
global g;
global gui_handle;
global graph_refresh;
global template_list;
global templates;
global botton_down;
global move_index;
global start_index;

botton_down = 0;
add_connection = 0;
start_index = 0;
g = graph;

template_list = cell(0,1);
templates = cell(0,1);

% Parameter to divide the modus "undirected" / "directed": dir
% To start the program, activate "undirected"
global modus;
modus = 'undirected';
set(handles.button_undirected,'Value',1);
set(handles.button_directed,'Value',0);

template_list{1,1} = 'LTI';
%template_list{1,2} = strcat(pwd,'/templates/LTI.mdl');

graph_refresh = 1;
g = graph; %% Creating a graph
resize(g,0);
%grid on;
%zoom on;
set(handles.numberview,'Check','on');
refresh_dynamics(eventdata, handles);
refresh_graph(0, eventdata, handles);
set(handles.newnodelabel,'String','Node');



% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mtids (see VARARGIN)

% Choose default command line output for mtids
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mtids wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mtids_OutputFcn(hObject, eventdata, handles) 
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
global graph_refresh;
global templates;
global template_list;

%/ Visualization creator
%{
if nv(g) == 0;
    x_n = 2;
    y_n = 0;
    
else    
        XY = getxy(g);

        x = XY(:,1)';
        y = XY(:,2)'; 
        d = x.*x + y.*y;
        R = 2;
        N = 12;
   
       
        run_loop = 1;
   
     while run_loop
        for i = 0:N-1
        phi = i*2*pi/N;
        x_n = R*cos(phi);
        y_n = R*sin(phi);
   
        dx1 = x - x_n;
        dy1 = y - y_n;
        dd  = dx1.*dx1 + dy1.*dy1;
 
            if min(dd) > 0.05
                run_loop = 0;
                break;
            end
        end
        
        R = 2*R;
        N = 2*N;
        end
        
  end
   
XY(new_vertex,1) = x_n;
XY(new_vertex,2) = y_n;

embed(g,XY);
%}
    rmxy(g);
    new_vertex = nv(g) + 1;
    resize(g, new_vertex);
    labs = get_label(g);
    lab_string =  get(handles.newnodelabel,'String');

% check if any of the existing names is equal as the new one
if any(strncmp(lab_string,labs,length(lab_string))) % strmatch(lab_string,labs,'exact') % strmatch is scalar in contrast to strcmp
    n = find(strcmp(lab_string,labs)); % find index of node, which
    % contains the used name
    if n
        label(g, n, [lab_string '1']); % add a '1' to the unnumbered name
        labs = get_label(g);
    end
    
    for i=1:nv(g)
        % check
        if strmatch(strcat(lab_string, num2str(i)),labs,'exact') % check if current number 'i' is available
            continue;
        else
           lab_string = strcat(lab_string, num2str(i)); % if 'i' isn't contained, take this for the new name
           break; % if a "free" name was discovered, quit the for-loop
        end

    end
end


label(g, new_vertex, lab_string); 

n_template = get(handles.selector_dynamic, 'Value'); % Get template name from list

templates{nv(g),1}=template_list{n_template,1};
% templates{nv(g),2}=template_list{n_template,2};

if graph_refresh == 1
    refresh_graph(0, eventdata, handles)
end

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
global modus;

% Arreglar conexiones
% Buscar en labels
label1 = get(handles.fromnode,'String');
label2 = get(handles.tonode,'String');

if (get(handles.label_button,'Value') == get(handles.label_button,'Max'))
    labs = get_label(g);
    n1 = strmatch(label1, labs, 'exact');
    n2 = strmatch(label2, labs, 'exact');
else
    n1 = str2num(label1);
    n2 = str2num(label2);
end

switch modus
    case 'undirected';
        add(g,n1(1), n2(1));
        refresh_graph(0, eventdata, handles);
    case 'directed';
        add(g,n1(1), n2(1),1);
        refresh_graph(0, eventdata, handles);
end

%refresh_graph(0, eventdata, handles);

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
global modus;

switch modus
    case 'undirected';
        dir = 0;
    case 'directed';
        dir = 1;
end

a = ceil(nv(g)*rand());
b = floor(nv(g)*rand());

add(g,a,b,dir);

refresh_graph(0, eventdata, handles)

guidata(hObject, handles);

% --- Executes on button press in removeconnection.
function removeconnection_Callback(hObject, eventdata, handles)
% hObject    handle to removeconnection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;
global modus;

% Arreglar conexiones
% Buscar en labels
label1 = get(handles.fromnode,'String');
label2 = get(handles.tonode,'String');

if (get(handles.label_button,'Value') == get(handles.label_button,'Max'))
    labs = get_label(g);
    n1 = strmatch(label1, labs, 'exact');
    n2 = strmatch(label2, labs, 'exact');
else
    n1 = str2num(label1);
    n2 = str2num(label2);
end

switch modus
    case 'undirected';
        dir = 0;
        
    case 'directed';
        dir = 1;
        
end

delete(g,n1(1), n2(1), dir);


refresh_graph(0, eventdata, handles);

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
global templates;

    a = str2num(get(handles.remnode,'String'));
if nv(g) && (a <= nv(g))
    templates(a,:) = []; % Deleting a template

    delete(g,a);

    refresh_graph(0, eventdata, handles)
end

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
global modus;

switch modus
    case 'undirected';
        random(g,1/2);
    case 'directed';
        random(g);
end

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
global templates;

resize(g,0);
templates = cell(0,1);
refresh_graph(1, eventdata, handles);

% --------------------------------------------------------------------
function loadgraph_Callback(hObject, eventdata, handles)
% hObject    handle to loadgraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;
global templates;
global template_list;

[filename, pathname] = uigetfile( ...
{'*.mat;','Graph/Network Files';
   '*.mat','MAT-files (*.mat)'; ...
    '*.*',  'All Files (*.*)'}, ...
   'Open');

if filename
     
    
    file = strcat(pathname, filename);
    [pathname, filename, ext] = fileparts(file);

    free(g);
    
     if strcmp(ext, '.mat') 
    S = load(file, 'nverts', 'nedges','adj_matrix', 'XY', 'labs', 'templates', 'template_list') ;
    
    nverts = S.nverts;
    adj_matrix = S.adj_matrix;
    XY = S.XY;
    labs = S.labs;
    templates = S.templates;
    template_list = S.template_list;
  
   g = graph(nverts);
    
    for i=1:nverts
    label(g,i,labs{i});
    for j=1:nverts
      if adj_matrix(i,j)
         add(g,i,j);
         adj_matrix(j,i) = 0;
      end            
    end
 end

embed(g,XY);
    
    elseif strcmp(ext, '.gr')
        load(g, file);
        templates = cell(0,1);
        % Temporary code...
        n_template = get(handles.selector_dynamic, 'Value'); % Get template name from list

        for i=1:nv(g)
            templates{i,1}=template_list{n_template,1};
        end
    end
end

refresh_dynamics(eventdata, handles);
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
global templates;
global template_list;

[filename, pathname] = uiputfile( ...
{'*.mat;','Graph/Network Files';
   '*.mat','MAT-files [Prefered] (*.mat)'; ...
   '*.*',  'All Files (*.*)'}, ...
   'Save');

if filename
 file = strcat(pathname, filename);
[pathname, filename, ext] = fileparts(file);
 %save(g, file);
 
 adj_matrix = double(matrix(g));
 labs = get_label(g);
 XY = getxy(g);
 nverts = nv(g);
 nedges = ne(g);
 
 if strcmp(ext, '.mat') 
    save(file, 'nverts', 'nedges','adj_matrix', 'XY', 'labs', 'templates', 'template_list') ;
    disp(strcat('Saved graph as binary .mat file ("', file,'")'));
 elseif strcmp(ext, '.gr')
    save(g, file);
    disp(strcat('Saved graph as Matgraph file ("', file,'")'));       
 end
end
 
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
about_mtids();

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
function export_as_layer_2_Callback(hObject, eventdata, handles)
% hObject    handle to export_as_layer_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)global g;

global g;
global templates;
global template_list;

A  = double(matrix(g));

%
rmxy(g);
embed(g);

%
xy = getxy(g);



labs = get_label(g);
name =	'untitled';
 template =	'LTI'; 
 if nv(g) > 200
    disp('Exporting...may take some time...go get some coffee...');
 else   
     disp('Exporting...');
 end
     disp('  ');
 
    exportLayer2(name,templates,template_list,A, xy, labs);

 if nv(g) > 50
    disp('Done exporting');
    disp(' ');
   %msgbox('Done exporting','Export to Simulink');
 else   
     disp('Done exporting');
 end



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
global modus;

% Check which kind of lable is activated
 checklabel = get(handles.labelview,'Check');
checknumber = get(handles.numberview,'Check');
 checkcolor = get(handles.colorview,'Check');
 checkblank = get(handles.blankview,'Check');
 
% rmxy(g);
cla;

if reset == 1
    rmxy(g); %rmxy: erase g's embedding
end

switch modus
    case 'undirected';
        dir = 0;
        if(ne(g)>0) %check if there are vertices in the current graph
            basic_stats(eventdata, handles);
        else
            set(handles.text22,'String', 'Independent Graphs:');
            set(handles.connected_graphs,'String', '0');
            set(handles.text16,'String', 'Graph density:');
            set(handles.graph_density,'String', '0');
            set(handles.text10,'String', 'Average degree:');
            set(handles.average_degree,'String', '0');
            set(handles.text11,'String', 'Median degree:');
            set(handles.median_degree,'String', '0');
            set(handles.text9,'String', 'Minimum degree:');
            set(handles.minimum_degree,'String', '0');
            set(handles.text12,'String', 'Maximum degree:');
            set(handles.maximum_degree,'String', '0');
            set(handles.text18,'String', 'Graph heterogenity:');
            set(handles.graph_heterogenity,'String', '0');
            set(handles.text19,'String', 'Algebraic connectivity:');
            set(handles.algebraic_connectivity,'String', '0');
        end

    case 'directed';
        dir = 1;
        % do something with the basic stats stuff
        if(ne(g)>0) %check if there are vertices in the current graph
            basic_stats(eventdata, handles);
        else
            set(handles.text22,'String', ' ');
            set(handles.connected_graphs,'String', ' ');
            set(handles.text16,'String', ' ');
            set(handles.graph_density,'String', ' ');
            set(handles.text10,'String', ' ');
            set(handles.average_degree,'String', ' ');
            set(handles.text11,'String', ' ');
            set(handles.median_degree,'String', ' ');
            set(handles.text9,'String', ' ');
            set(handles.minimum_degree,'String', ' ');
            set(handles.text12,'String', ' ');
            set(handles.maximum_degree,'String', ' ');
            set(handles.text18,'String', ' ');
            set(handles.graph_heterogenity,'String', ' ');
            set(handles.text19,'String', ' ');
            set(handles.algebraic_connectivity,'String', ' ');
        end
        
end

% check for choice of vertex-layout
if strcmp(checklabel, 'on')
    ldraw(g,dir);
elseif strcmp(checkcolor, 'on')
    cdraw(g,dir);
elseif strcmp(checknumber, 'on')
    ndraw(g,dir);
else
    draw(g,dir);
end

set(handles.nedges,'String', num2str(ne(g,dir)));
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
global modus;

switch modus
    case 'undirected';

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
        set(handles.text22,'String', 'Independent Graphs:');
        set(handles.connected_graphs,'String', num2str(null_L,'%d'));
        set(handles.text16,'String', 'Graph density:');
        graph_density = mean(degree_vector)/(dim_L-1); %(1)
        set(handles.graph_density,'String', num2str(graph_density, '%1.3f'));
        graph_average_degree = mean(degree_vector);
        set(handles.text10,'String', 'Average degree:');
        set(handles.average_degree,'String', num2str(graph_average_degree, '%3.2f'));
        set(handles.text11,'String', 'Median degree:');
        graph_median_degree = median(degree_vector);
        set(handles.median_degree,'String', num2str(graph_median_degree));
        graph_min_degree = min(degree_vector);
        set(handles.text9,'String', 'Minimum degree:');
        set(handles.minimum_degree,'String', num2str(graph_min_degree));
        graph_max_degree = max(degree_vector);
        set(handles.text12,'String', 'Maximum degree:');
        set(handles.maximum_degree,'String', num2str(graph_max_degree));
        %graph_density = 2*NEdges/(NVertex*(NVertex-1)); % Segun Wikipedia
        graph_heterogenity = sqrt(var(degree_vector))/mean(degree_vector);
        set(handles.text18,'String', 'Graph heterogenity:');
        set(handles.graph_heterogenity,'String', num2str(graph_heterogenity,'%1.3f'));
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
         set(handles.text19,'String', 'Algebraic connectivity:');
         set(handles.algebraic_connectivity,'String', num2str(graph_connectivity));
         fiedler_vector   = Eigen_Matrix_L(:,null_L+1);

         estrada_connectivity = diag(exp(A));

         estrada_graph_index  = trace(exp(A));
 
    case 'directed';
        set(handles.text22,'String', ' ');
        set(handles.connected_graphs,'String', ' ');
        set(handles.text16,'String', ' ');
        set(handles.graph_density,'String', ' ');
        set(handles.text10,'String', ' ');
        set(handles.average_degree,'String', ' ');
        set(handles.text11,'String', ' ');
        set(handles.median_degree,'String', ' ');
        set(handles.text9,'String', ' ');
        set(handles.minimum_degree,'String', ' ');
        set(handles.text12,'String', ' ');
        set(handles.maximum_degree,'String', ' ');
        set(handles.text18,'String', ' ');
        set(handles.graph_heterogenity,'String', ' ');
        set(handles.text19,'String', ' ');
        set(handles.algebraic_connectivity,'String', ' ');
end







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
global g;
global template_list;
global templates;

[filename, pathname] = uigetfile( ...
{'*.mdl','Simulink Model (*.mdl)';
   '*.*',  'All Files (*.*)'}, ...
   'Import Simulink model');


 file = strcat(pathname, filename);

 addpath(pathname);
 
 [pathname, model, ext] = fileparts(file);
 
 
 [A, nverts, nedges, xy, labs ] = importSimulink(model);

 % Delete graph!
  
 % Deprecated! elist = adj_to_elist(A);

 free(g);
 
 g = graph(nverts); 
  
% Preliminary template import 
n_template = get(handles.selector_dynamic, 'Value'); % Get template name from list

for i=1:nverts
    label(g,i,labs{i});
    templates{i,1}=template_list{n_template,1};
    for j=1:nverts
      if A(i,j)
         add(g,i,j);
         A(j,i) = 0;
      end            
    end
 end

embed(g,xy); 

refresh_graph(0, eventdata, handles);

% --------------------------------------------------------------------
function export_to_simulink_Callback(hObject, eventdata, handles)
% hObject    handle to export_to_simulink (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;
global templates;
global template_list;

disp('Export mode 1');

A  = double(matrix(g));

% Makes the graph a circle
rmxy(g);
embed(g);
%

xy = getxy(g);


labs = get_label(g);
name =	'untitled';
 template =	'LTI'; 
 if nv(g) > 200
    disp('Exporting...may take some time...go get some coffee...');
 else   
     disp('Exporting...');
 end
     disp('  ');

  
     
    exportSimulink(name,templates,template_list,A, xy, labs);

 if nv(g) > 50
    disp('Done exporting');
    disp(' ');
   %msgbox('Done exporting','Export to Simulink');
 else   
     disp('Done exporting');
 end




% --- Executes on button press in add_multiple_nodes.
function add_multiple_nodes_Callback(hObject, eventdata, handles)
% hObject    handle to add_multiple_nodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global g;
global graph_refresh;
n_nodes = str2num(get(handles.number_of_nodes,'String'));

graph_refresh = 0;

for i=1:n_nodes
   newnode_Callback(hObject, eventdata, handles); 
end

graph_refresh = 1;

refresh_graph(0, eventdata, handles);


% --------------------------------------------------------------------
function exit_to_matlab_Callback(hObject, eventdata, handles)
% hObject    handle to exit_to_matlab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(handles.output);




function number_of_nodes_Callback(hObject, eventdata, handles)
% hObject    handle to number_of_nodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of number_of_nodes as text
%        str2double(get(hObject,'String')) returns contents of number_of_nodes as a double


% --- Executes during object creation, after setting all properties.
function number_of_nodes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to number_of_nodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in label_button.
function label_button_Callback(hObject, eventdata, handles)
% hObject    handle to label_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of label_button

set(handles.number_button,'Value', 0);
set(handles.label_button,'Value', 1);


% --- Executes on button press in number_button.
function number_button_Callback(hObject, eventdata, handles)
% hObject    handle to number_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of number_button
set(handles.label_button,'Value', 0);
set(handles.number_button,'Value', 1);


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --------------------------------------------------------------------
function export_to_workplace_Callback(hObject, eventdata, handles)
% hObject    handle to export_to_workplace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;
global modus;

uiwait( export_as_matrix(laplacian(g),g,modus));


% --------------------------------------------------------------------
function import_from_workplace_Callback(hObject, eventdata, handles)
% hObject    handle to import_from_workplace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;
global templates;
global template_list;
global modus;

prompt = {'Workspace:','Variable name:'};
dlg_title = 'Inport matrix from workspace';
num_lines = 1;
def = {'base','matrix'};
answer = inputdlg(prompt,dlg_title,num_lines,def);

if isempty(answer)

else
    M = evalin(answer{1},answer{2});
    switch modus
        case 'undirected';
            elist = any_matrix_to_elist(M);
        case 'directed';
            elist = any_matrix_to_elist(M,1);
    end

    %Corrects the problem posed by a zero-adj-matrix!
     if ( elist(1,:) == zeros(1,2)  )
        g = graph( size(M,1) );
     else
        switch modus
            case 'undirected';
                g = graph(elist);
            case 'directed';
                maxM = max(M);
                g = graph(maxM(1));
                for i = 1:length(elist)
                    add(g,elist(i,1),elist(i,2),1);
                end
        end
     end

    templates = cell(0,1);

    n_template = get(handles.selector_dynamic, 'Value'); % Get template name from list

    for i=1:nv(g)

        templates{i,1}=template_list{n_template,1};
    end
end


refresh_graph(0, eventdata, handles);


% --------------------------------------------------------------------
function add_mdl_template_Callback(hObject, eventdata, handles)
% hObject    handle to add_mdl_template (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global template_list;
oldFolder = cd(strcat(pwd,'/templates'));

[filename, pathname] = uigetfile( ...
{'*.mdl','Simulink model template(*.mdl)';
   '*.*',  'All Files (*.*)'}, ...
   'Import Simulink model templates', ...
   'MultiSelect', 'on');

if iscell(filename)
    
    [a, b] = size(filename);

    for i=1:b
       file = strcat(pathname, filename{i});
       [path, template, ext] = fileparts(file);
       
       if strcmp('.mdl', ext)

            if strmatch(template, template_list, 'exact')
             disp(strcat('WARNING: A template with the name "', template, '" was already imported!'));
             continue;
            else
             [ny, nx] = size(template_list);
             template_list{ny+1,1} = template;
             %template_list{ny+1,2} = file;
            end 

        else
            disp(strcat('ERROR: "',filename{i}, '" is not a Simulink model'));
        end
        end % End del for
        
elseif filename %filename is not a cell (it's a string) and not 0
    file = strcat(pathname, filename);
    [path, template, ext] = fileparts(file);
     
    if strcmp('.mdl', ext)

            if strmatch(template, template_list, 'exact')
             disp(strcat('WARNING: A template with the name "', template, '" was already imported!'));
            else
             [ny, nx] = size(template_list);
             template_list{ny+1,1} = template;
             %template_list{ny+1,2} = file;
            end 

        else
            disp(strcat('ERROR: "',filename, '" is not a Simulink model'));
        end
    
end

cd(oldFolder);

refresh_dynamics(eventdata, handles); 
 


% --- Executes on selection change in selector_dynamic.
function selector_dynamic_Callback(hObject, eventdata, handles)
% hObject    handle to selector_dynamic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns selector_dynamic contents as cell array
%        contents{get(hObject,'Value')} returns selected item from selector_dynamic

%get(hObject,'Value')

% --- Executes during object creation, after setting all properties.
function selector_dynamic_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selector_dynamic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

global g;
global template_list;
%global drop_string;% = cell(0,0);

drop_string = cell(0,0);

[ny, nx] = size(template_list);


for i=1:ny
    if i == 1
        drop_string = template_list{1,1};
    elseif i == ny
        drop_string = strcat(drop_string,'|',template_list{i,1});
    else        
        drop_string = strcat(drop_string,'|',template_list{i,1});
    end
end

set(hObject, 'String', drop_string);
%set(handles.selector_dynamic, 'String', drop_string);



function refresh_dynamics(eventdata, handles)
% This function refreshes the graph window

global g;
global template_list;

[ny, nx] = size(template_list);


for i=1:ny
    if i == 1
        drop_string = template_list{1,1};
    elseif i == ny
        drop_string = strcat(drop_string,'|',template_list{i,1});
    else        
        drop_string = strcat(drop_string,'|',template_list{i,1});
    end
end

set(handles.selector_dynamic, 'String', drop_string);
 


% --- Executes on button press in circular_graph.
function circular_graph_Callback(hObject, eventdata, handles)
% hObject    handle to circular_graph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;
global modus;

switch modus
    case 'undirected';
        dir = 0;
    case 'directed';
        dir = 1;
end

clear_edges(g);

for i=1:(nv(g)-1)
    add(g,i,i+1,dir);
end
    add(g,nv(g),1,dir)

refresh_graph(0, eventdata, handles);



% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;
global botton_down;
global add_connection;
global move_index;
global start_index;
global templates;
global template_list;
global modus;


CP = get(handles.axes1, 'CurrentPoint');
x_c = CP(1,1);
y_c = CP(1,2);

XY = getxy(g);
x = XY(:,1);
y = XY(:,2);

d_x = x-x_c;
d_y = y-y_c;

radius = d_x.*d_x+d_y.*d_y;
[C,I] = min(radius);
if C <= 0.05; % Hardcoded value!
 
    
    if strcmp(get(handles.output, 'SelectionType'), 'normal')
 %  disp(I);
    move_index = I;
    botton_down = 1;
    start_index = 0; % Reset starting index

    elseif strcmp(get(handles.output, 'SelectionType'), 'alt')
        if start_index
            if has(g, start_index, I) %no additional request for the case of directed graphs necessary
                switch modus
                    case 'undirected';
                        delete(g,start_index, I);
                    case 'directed';
                        delete(g,start_index, I,1);
                end
            else
                switch modus
                    case 'undirected';
                        add(g,start_index,I);
                    case 'directed';
                        add(g,start_index,I,1);
                end
            end
            start_index = 0;
            refresh_graph(0, eventdata, handles);
        else
            start_index = I;
        end
    
    elseif strcmp(get(handles.output, 'SelectionType'), 'open')
    % Opens node modification dialog

   [s1,nodenumber,nodelabel,template,neighbours,destroy] = edit_node(I, get_label(g,I), templates{I}, template_list, g(I));
  
   if destroy == 0
       if ~strcmp(nodelabel, get_label(g,I))
            if(strmatch(nodelabel,get_label(g),'exact'))
                for i=1:nv(g)
                    if (strmatch(strcat(nodelabel, num2str(i)),get_label(g),'exact'))
                        continue;
                    else
                        nodelabel = strcat(nodelabel, num2str(i));
                        break;
                    end
                end
            end
       end
       
        label(g,I, nodelabel);

        templates{I} = template;
        e_delete = g(I);
        size_ne = size(e_delete,2);

        neighbours = eval(neighbours);

        for i=1:size_ne
           delete(g,I,e_delete(i)); 
        end

        size_ne = size(neighbours,2);

        if ~strcmp(neighbours, '[]')
            for i=1:size_ne
                add(g,I,neighbours(i)); 
            end
        end
                
            
        refresh_graph(0, eventdata, handles)
            
   elseif destroy == 1
            if nv(g) && (I <= nv(g))
            templates(I,:) = []; % Deleting a template

            delete(g,I);

            refresh_graph(0, eventdata, handles)
            end
       
   end
    
end

else % do nothing?
  
end

 
if strcmp(get(handles.output, 'SelectionType'), 'extend')
    start_button = 0;
    button_down = 0;
    
    newnode_Callback(hObject, eventdata, handles);
    
    XY(nv(g),1) = x_c;
    XY(nv(g),2) = y_c;
    embed(g,XY);
    refresh_graph(0, eventdata, handles);
end




% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonUpFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global botton_down;
global g;

botton_down = 0;

% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global botton_down;
global move_index;
global g;


if botton_down
    CP = get(handles.axes1, 'CurrentPoint');
    x_c = CP(1,1);
    y_c = CP(1,2);
    XY = getxy(g);
    XY(move_index,1) = x_c;
    XY(move_index,2) = y_c;
    embed(g,XY);
    refresh_graph(0, eventdata, handles);
end
   




% --------------------------------------------------------------------
function Untitled_13_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_14_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function export_as_layer_Callback(hObject, eventdata, handles)
% hObject    handle to export_as_layer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;
global templates;
global template_list;

A  = double(matrix(g));

%
rmxy(g);
embed(g);

%
xy = getxy(g);



labs = get_label(g);
name =	'untitled';
 template =	'LTI'; 
 if nv(g) > 200
    disp('Exporting...may take some time...go get some coffee...');
 else   
     disp('Exporting...');
 end
     disp('  ');
 
    exportLayer(name,templates,template_list,A, xy, labs);

 if nv(g) > 50
    disp('Done exporting');
    disp(' ');
   %msgbox('Done exporting','Export to Simulink');
 else   
     disp('Done exporting');
 end



% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in update_graph_button.
function update_graph_button_Callback(hObject, eventdata, handles)
% hObject    handle to update_graph_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

refresh_graph(1, eventdata, handles);



% --------------------------------------------------------------------
function export_to_simulink2_Callback(hObject, eventdata, handles)
% hObject    handle to export_to_simulink2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;
global templates;
global template_list;

disp('Export mode 2');
A  = double(matrix(g));

% Makes the graph a circle
rmxy(g);
embed(g);
%

xy = getxy(g);


labs = get_label(g);

name =	'untitled';
 template =	'LTI'; 
 if nv(g) > 200
    disp('Exporting...may take some time...go get some coffee...');
 else   
     disp('Exporting...');
 end
     disp('  ');

  
     
    exportSimulink2(name,templates,template_list,A, xy, labs);

 if nv(g) > 50
    disp('Done exporting');
    disp(' ');
   %msgbox('Done exporting','Export to Simulink');
 else   
     disp('Done exporting');
 end
 
 % If visualization is needed, the plotting functions are evoked here
% if strcmp(get(handle.Live_Plot,'Check'), 'On')
     % evoke Live Plot Figure
     % We need: number of nodes, name of output signals of nodes
%     nrNodes = size(A,1);
% end
 
% if strcmp(get(handle.Exportable_Plot,'Check'), 'On')
     % evoke Exportable Plots in separate figures
%     nrNodes = size(A,1);
     
% end




% --- Executes on button press in radiobutton7.
function radiobutton7_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton7





% --- Executes when selected object is changed in uipanel9.
function uipanel9_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel9 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
% Originally taken from the Help Menu "Programming a button group"
% With it, the choice of which graphs are supported can be done

global modus;
global g;

switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'button_undirected'
        modus = 'undirected';
        % Function, that creates a pop-up-menu, that says: "save current
        % graph?"
        resize(g,0);
        refresh_graph(0, eventdata, handles);
        guidata(hObject, handles);
    case 'button_directed'
        modus = 'directed';
        % Function, that creates a pop-up-menu, that says: "interpret
        % undirected graph as directed? (Yes / No) If no, save current
        % graph?"
        resize(g,0);
        refresh_graph(0, eventdata, handles);
        guidata(hObject, handles);
    % Continue with more cases as necessary.
    otherwise
        % Code for when there is no match.
        modus = 'undirected';
end


% --------------------------------------------------------------------
function Visualization_Callback(hObject, eventdata, handles)
% hObject    handle to Visualization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Live_Plot_Callback(hObject, eventdata, handles)
% hObject    handle to Live_Plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% if the status of the checkfield is to be evaluated, use:
% get(handle.Live_Plot,'Check');

checkstatus = get(hObject,'Check');

if strcmp(checkstatus, 'on')
    set(hObject,'Check','off');
elseif strcmp(checkstatus, 'off')
    set(hObject,'Check','on');
    
end

% --------------------------------------------------------------------
function Exportable_Plot_Callback(hObject, eventdata, handles)
% hObject    handle to Exportable_Plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% if the status of the checkfield is to be evaluated, use:
% get(handle.Exportable_Plot,'Check');

checkstatus = get(hObject,'Check');

if strcmp(checkstatus, 'on')
    set(hObject,'Check','off');
elseif strcmp(checkstatus, 'off')
    set(hObject,'Check','on');
end
