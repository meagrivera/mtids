function varargout = mtids(varargin)
%
%      MTIDS 1.1
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
% Last Modified by GUIDE v2.5 24-Aug-2012 10:21:01

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
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mtids (see VARARGIN)

disp(' ');
disp('MTIDS 1.1');
disp('Test Rig for Large-Scale and Interconnected Dynamical Systems');
disp('<a href="http://code.google.com/p/mtids">http://code.google.com/p/mtids</a>');
disp(' ');
disp('This program is free software; you can redistribute it and/or');
disp('modify it under the terms of the GNU General Public License');
disp('as published by the Free Software Foundation; either version 2');
disp('of the License, or (at your option) any later version.');
disp('This program is distributed in the hope that it will be useful,');
disp('but WITHOUT ANY WARRANTY; without even the implied warranty of');
disp('MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the');
disp('GNU General Public License for more details.');
disp(' ');
disp('You should have received a copy of the GNU General Public License');
disp('along with this program; if not, write to the Free Software');
disp('Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.');
disp(' ');
disp(' ');


%--------------------------------------------------------------------------
%----------------INITIALISE PARAMETERS-------------------------------------
%--------------------------------------------------------------------------

addpath(strcat(pwd,'/tools/matgraph'));                     % Folder with a copy of Matgraph
addpath(strcat(pwd,'/templates'));                          % Folder for Simulink templates
addpath(strcat(pwd,'/subfunctions'));                       % Folder with GUIs and functions
addpath(strcat(pwd,'/subfunctions/interface2Simulink'));    % Folder with various import/export functions
addpath(strcat(pwd,'/subfunctions/mtids_main'));
addpath(strcat(pwd,'/resources'));                          % Folder with resource files like manuals, graphics, etc.

%initialize graph
graph_init;

%declare userdata as structures: data.*; with it global variables could be
%erased

flagLoadSet = 0;
try
    load_settings('lastset',handles);
    data = getappdata(handles.figure1,'appData');
    if ~isempty(data)
        choice = questdlg('Do you want to load the settings formerly used?', ...
            'Former settings?', ...
            'Yes','Yes, with last graph','No','No');
        switch choice
            case 'Yes';
                flagLoadSet = 1;
            case 'Yes, with last graph';
                loadGraphAtOpening(hObject, eventdata, handles);
                data = getappdata(handles.figure1,'appData');
                flagLoadSet = 2;
            case 'No';
                flagLoadSet = 0;
        end
    end
catch
    %
end

% Setting the parameters according to chosen old data
switch flagLoadSet
    case 1;
        data.templates = cell(0,1);
        data.printCell = cell(0,2);
        data.nodeColor = cell(0,2);
        g = graph; %% Creating a graph
        resize(g,0);
        data.g = g;
        
    case 2;
        
        
    otherwise;
        data.plotAllOutput = 1;
        data.flag_showSimMod = 1;
        data.template_list = cell(0,3);
        data.modus = 'undirected';
%         % template_list-data for debugging/testing-purpose
%         data.template_list{1,1} = 'LTI';
%         data.template_list{1,2} = [245 245 245]/255; % node face color for template
%         data.template_list{1,3} = [0 0 0]; % node edge color for template
%         paramValues(1).set = cell( 1,3 ); % param values
%         data.template_list{1,4} = paramValues;
%         data.template_list{1,5} = 1; % is active (or not), logical
        data.templates = cell(0,1);
        data.printCell = cell(0,2);
        data.nodeColor = cell(0,2);
        g = graph; %% Creating a graph
        resize(g,0);
        data.g = g;
end

data.template_list = readImportedTemplates(data.template_list);

data.move_index = 0;
data.expSucc = 0;
data.botton_down = 0;
data.add_connection = 0;
data.start_index = 0;
data.graph_refresh = 1;

%container for plot information - 
% 1.column: printVector -- containes the information about node number,
%internal states and which should be plotted
%2. column: plotParams -- the design information for the plot command, a
%struct with 6 elements per state
%       Example: a node has 3 int. states, 2 should be plotted, then
%       struct(1) and struct(2) exists, each with 6 elements


%--------------------------------------------------------------------------
%-------------------INITIALISE GUI-----------------------------------------
%--------------------------------------------------------------------------

if strcmp(data.modus, 'undirected')
    set(handles.button_undirected,'Value',1);
    set(handles.button_directed,'Value',0);
elseif strcmp(data.modus, 'directed')
    set(handles.button_undirected,'Value',0);
    set(handles.button_directed,'Value',1);
end

if data.plotAllOutput == 0
    set(handles.plotAllOutput,'Checked','off')
elseif data.plotAllOutput == 1
    set(handles.plotAllOutput,'Checked','on')
end

if data.flag_showSimMod == 0
    set(handles.showSimMod,'Checked','off')
elseif data.flag_showSimMod == 1
    set(handles.showSimMod,'Checked','on')
end

%grid on;
%zoom on;
set(handles.numberview,'Check','on');
set(handles.number_button,'Value', 1);
set(handles.newnodelabel,'String','Node');
set(handles.strong_connections,'String', ' ');        
set(handles.text16,'String', 'Graph density:');

% store userdata, use tag 'appData'
setappdata(hObject,'appData',data);

refresh_dynamics(eventdata, handles);
refresh_valueSet(handles);
refresh_graph(0, eventdata, handles,hObject);
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

% load application data
data = getappdata(handles.figure1,'appData');

g = data.g;
graph_refresh = data.graph_refresh;
templates = data.templates;
template_list = data.template_list;
printCell = data.printCell;
plotAllOutput = data.plotAllOutput;

%debugging output
%{
display(['DEBUGGING - "Add node']);
display(['After loading the application data:']);
display(['______________________________________________________________']);
display(['Number of elements in "templates": ' num2str(numel(templates)) ]);
display(['Number of elements in "template_list": ' num2str(numel(template_list)) ]);
for k = 1:numel(templates)
    display(['data.templates{' num2str(k) '} = ' templates(k)]);
end
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
% Get number of template name from list
n_template = get(handles.selector_dynamic, 'Value'); 
n_valueSet = get(handles.selector_valueSet, 'Value');
templates{nv(g),1} = template_list{n_template,1};
templates{nv(g),2} = n_valueSet;
%{
switch templates{nv(g),1};
    case 'LTI'; col = [245 245 245]/255;
    case 'kuramoto'; col = [230 230 250]/255;
    otherwise; col = [0 149 237]/255; 
end
%}
length_nodeColor = size(data.nodeColor,1);
tempNodeColor = data.nodeColor;
data.nodeColor = cell(length_nodeColor+1,2);
for i = 1:length_nodeColor
   data.nodeColor(i,:) = tempNodeColor(i,:);
end
% this line sets the face color for the node
data.nodeColor{length_nodeColor+1,1} = template_list{n_template,2};
data.nodeColor{length_nodeColor+1,2} = template_list{n_template,3};

%Now, after the node was created, the printCell can be added  
length_cellPrint = size(printCell,1);

%Keep the informations of the old nodes
tempCell = printCell;
printCell = cell(length_cellPrint+1,2);
for i = 1:length_cellPrint
    printCell(i,:) = tempCell(i,:);
end

%Initially, the printVector and the plotParams are the same for all templates
printCell(length_cellPrint+1,1) = num2cell([plotAllOutput 0],2);
printCell{length_cellPrint+1,2} = initPlotParams;
setappdata(handles.figure1,'appData',data);
if graph_refresh == 1
    refresh_graph(0, eventdata, handles,hObject);
end

% store changed data back to structure 'data'
data.g = g;
data.graph_refresh = graph_refresh;
data.templates = templates;
data.template_list = template_list;
data.printCell = printCell;
data.plotAllOutput = plotAllOutput;
setappdata(handles.figure1,'appData',data);

%debugging output
%{
display(['DEBUGGING - "Add node",']);
display(['End of callback function:']);
display(['___________________________________________________________']);
display(['Number of elements in "templates": ' num2str(numel(templates)) ]);
for k = 1:numel(templates)
    display(['data.templates{' num2str(k) '} = ' templates(k)]);
end
%}

guidata(hObject, handles);



% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% load application data
data = getappdata(handles.figure1,'appData');

save_settings('lastset',handles);
filename = 'lastgraph.mat';
pathname = [pwd filesep 'resources' filesep];
saveGraph(hObject, eventdata, handles, pathname, filename);
data = getappdata(handles.figure1,'appData');

% Hint: delete(hObject) closes the figure
%global g;
g = data.g;
free(g)
graph_destroy;
%store application data
data.g = g;
setappdata(handles.figure1,'appData',data);

guidata(hObject, handles);

% graph_destroy();
delete(hObject);



% --- Executes on button press in addconnection.
function addconnection_Callback(hObject, eventdata, handles)
% hObject    handle to addconnection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%load application data
data = getappdata(handles.figure1,'appData');
g = data.g;
modus = data.modus;

% Fix connections
% Search labels
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
        refresh_graph(0, eventdata, handles,hObject);
    case 'directed';
        add(g,n1(1), n2(1),1);
        refresh_graph(0, eventdata, handles,hObject);
end

%refresh_graph(0, eventdata, handles,hObject);

%store application data
data.modus = modus;
data.g = g;
setappdata(handles.figure1,'appData', data);

guidata(hObject, handles);



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

%load application data
data = getappdata(handles.figure1,'appData');
g = data.g;
modus = data.modus;

%global g;
%global modus;

switch modus
    case 'undirected';
        dir = 0;
    case 'directed';
        dir = 1;
end

a = ceil(nv(g)*rand());
b = floor(nv(g)*rand());

add(g,a,b,dir);

%store application data
data.modus = modus;
data.g = g;
setappdata(handles.figure1,'appData', data);

refresh_graph(0, eventdata, handles,hObject);

guidata(hObject, handles);

% --- Executes on button press in removeconnection.
function removeconnection_Callback(hObject, eventdata, handles)
% hObject    handle to removeconnection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%load application data
data = getappdata(handles.figure1,'appData');
g = data.g;
modus = data.modus;

%global g;
%global modus;

% Arreglar conexiones
% Buscar en labels
label1 = get(handles.fromnode,'String');
label2 = get(handles.tonode,'String');

%debugging output
%{
display(['DEBUGGING - "removeconnection_Callback",']);
display(['Before evaluating the buttons "Label" and "Node number":']);
display(['_____________________________________________________________']);
display(['Removing... ']);
display(['From: ' label1 ' to: ' label2]);
display(['_____________________________________________________________']);
%}


%the radio buttons "Label" and "Node number" evaluates, if a node is
%adressed via its number or label
if (get(handles.label_button,'Value') == get(handles.label_button,'Max')) 
    %if this is true, the radio button is selected
    labs = get_label(g);
    %n1 = strmatch(label1, labs, 'exact');
    n1 = find(strcmp(label1, labs));
    %n2 = strmatch(label2, labs, 'exact');
    n2 = find(strcmp(label2, labs));
elseif (get(handles.number_button,'Value') == get(handles.label_button,'Max'))
    n1 = str2num(label1);
    n2 = str2num(label2);
end


%debugging output
%{
display(['DEBUGGING - "removeconnection_Callback",']);
display(['After evaluating the buttons "Label" and "Node number":']);
display(['_____________________________________________________________']);
display(['Evaluation of button "Label": ' num2str(get(handles.label_button,'Value'))]);
display(['If 0: value is a number, if 1: value is a string. ']);
display(['---------------']);
if (get(handles.label_button,'Value') == get(handles.label_button,'Max'))
    display(['Displaying the content of the structure "labels" of graph:']);
    display(['---------------']);
    for k = 1:numel(labs)
       display(['Entry' num2str(k) 'of "labs": ' labs(k)]); 
    end
    display(['---------------']);
    %display(['Class of the variables n1 and n2, which are used ']);
    %display(['to delete the chosen edge: ']);
    display(['Class of n1: ' class(n1) ', Class of n2: ' class(n2) ]);
    display(['If numbers are visible, validation was correct: ']);
    display(['From: n1 = ' int2str(n1) ' to: n2 = ' num2str(n2) ]);
else
    display(['Class of n1: ' class(n1) ', Class of n2: ' class(n2) ]);
    display(['If numbers are visible, validation was correct: ']);
    display(['From: n1 = ' num2str(n1) ' to: n2 = ' num2str(n2) ]);
end

display(['_____________________________________________________________']);
%}

switch modus
    case 'undirected';
        delete(g,n1(1),n2(1));
        %dir = 0;      
    case 'directed';
        dir = 1;
        delete(g,n1(1), n2(1), dir);
end


%store application data
data.g = g;
data.modus = modus;
setappdata(handles.figure1,'appData',data);

refresh_graph(0, eventdata, handles,hObject);

guidata(hObject, handles);


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

% load application data
data = getappdata(handles.figure1,'appData');

%global g;
g = data.g;
%global templates;
templates = data.templates;
%global printCell;
printCell = data.printCell;

a = str2num(get(handles.remnode,'String'));
if nv(g) && (a <= nv(g))
    templates(a,:) = []; % Deleting the template for the node, which should be deleted

    delete(g,a);

    %Here, the i-th entry of the printCell must be deleted too
    length_printCell = size(printCell,1);
    temp_printCell = printCell;
    printCell = cell(length_printCell-1,2);
    for i = 1:(a-1)
        printCell(i,:) = temp_printCell(i,:);
    end
    for i = (a+1):length_printCell
        printCell(i-1,:) = temp_printCell(i,:);
    end

    refresh_graph(0, eventdata, handles,hObject);
end

%store application data
data.g = g;
data.templates = templates;
data.printCell = printCell;
setappdata(handles.figure1,'appData',data);

guidata(hObject, handles);



% --- Executes on button press in trimgraph.
function trimgraph_Callback(hObject, eventdata, handles)
% hObject    handle to trimgraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%load application data
data = getappdata(handles.figure1,'appData');

trim(data.g);

%store application data
setappdata(handles.figure1,'appData',data);

refresh_graph(0, eventdata, handles,hObject);

guidata(hObject, handles);


% --- Executes on button press in clearconnections.
function clearconnections_Callback(hObject, eventdata, handles)
% hObject    handle to clearconnections (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%load application data
data = getappdata(handles.figure1,'appData');
g = data.g;
%global g;

clear_edges(g);

%store application data
data.g = g;
setappdata(handles.figure1,'appData',data);

refresh_graph(0, eventdata, handles,hObject);

guidata(hObject, handles);


% --- Executes on button press in completegraph.
function completegraph_Callback(hObject, eventdata, handles)
% hObject    handle to completegraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%load application data
data = getappdata(handles.figure1,'appData');
g = data.g;

complete(g);

%store application data
data.g = g;
setappdata(handles.figure1,'appData',data);

refresh_graph(0, eventdata, handles,hObject);

guidata(hObject, handles);

% --- Executes on button press in randomgraph.
function randomgraph_Callback(hObject, eventdata, handles)
% hObject    handle to randomgraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%load application data
data = getappdata(handles.figure1,'appData');

switch data.modus
    case 'undirected';
        random(data.g,1/2);
    case 'directed';
        random(data.g);
end

%store application data
setappdata(handles.figure1,'appData',data);

refresh_graph(0, eventdata, handles,hObject)
guidata(hObject, handles);



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

%load application data
data = getappdata(handles.figure1,'appData');
g = data.g;

resize(g,0);
templates = cell(0,1);

%store application data
data.g = g;
data.templates = templates;
setappdata(handles.figure1,'appData',data);

refresh_graph(1, eventdata, handles,hObject);

% --------------------------------------------------------------------
function loadgraph_Callback(hObject, eventdata, handles)
% hObject    handle to loadgraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% load application data
data = getappdata(handles.figure1,'appData');
g = data.g;
template_list = data.template_list;

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
        S = load(file, 'nverts', 'nedges','adj_matrix', 'XY', 'labs', 'templates',...
            'printCell','template_list','modus','nodeColor') ;
        %S = load(file, 'data' );
        %data = S.data;
        %assignin('base','data',data);
        
        nverts = S.nverts;
        adj_matrix = S.adj_matrix;
        XY = S.XY;
        labs = S.labs;
        templates = S.templates;
        template_list = S.template_list;
        data.modus = S.modus;
        data.printCell = S.printCell;
        data.nodeColor = S.nodeColor;
        g = graph(nverts);
        switch data.modus;
            case 'undirected'; dir = 0;
            case 'directed'; dir = 1;
        end

        for i=1:nverts
            label(g,i,labs{i});
            for j=1:nverts
              if adj_matrix(i,j)
                 add(g,i,j,dir);
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

%set the uipanel according to stored value of "modus"
switch data.modus
    case 'directed'
        set(handles.button_undirected,'Value', 0.0);
        set(handles.button_directed,'Value', 1.0);
    case 'undirected'
        set(handles.button_undirected,'Value', 1.0);
        set(handles.button_directed,'Value', 0.0);        
end

%store application data
data.g = g;
data.templates = templates;
data.template_list = template_list;

setappdata(handles.figure1,'appData',data);
guidata(hObject, handles);
refresh_dynamics(eventdata, handles);
refresh_graph(0, eventdata, handles,hObject);


% --------------------------------------------------------------------
function savegraphas_Callback(hObject, eventdata, handles)
% hObject    handle to savegraphas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uiputfile( ...
{  '*.mat','MAT-files [Prefered] (*.mat)'; ...
   '*.*',  'All Files (*.*)';}, ...
   'Save');
saveGraph(hObject, eventdata, handles, pathname, filename);

% --------------------------------------------------------------------
function aboutmtids_Callback(hObject, eventdata, handles)
% hObject    handle to aboutmtids (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
about_mtids();


% --------------------------------------------------------------------
function labelview_Callback(hObject, eventdata, handles)
% hObject    handle to labelview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%load application data
data = getappdata(handles.figure1,'appData');
g = data.g;

%global g;
checkstatus = get(hObject,'Check');

if strcmp(checkstatus, 'on')
    set(hObject,'Check','off');
elseif strcmp(checkstatus, 'off')
    set(handles.colorview,'Check','off');
    set(handles.labelview,'Check','on');
    set(handles.numberview,'Check','off');
    set(handles.blankview,'Check','off');
    refresh_graph(0, eventdata, handles,hObject)
end

%store application data
data.g = g;
setappdata(handles.figure1,'appData',data);

guidata(hObject, handles);

% --------------------------------------------------------------------
function colorview_Callback(hObject, eventdata, handles)
% hObject    handle to colorview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%load application data
data = getappdata(handles.figure1,'appData');
g = data.g;

%global g;
checkstatus = get(hObject,'Check');

if strcmp(checkstatus, 'on')
    set(hObject,'Check','off');
elseif strcmp(checkstatus, 'off')
    set(handles.colorview,'Check','on');
    set(handles.labelview,'Check','off');
    set(handles.numberview,'Check','off');
    set(handles.blankview,'Check','off');
    refresh_graph(0, eventdata, handles,hObject)
end

guidata(hObject, handles);

% --------------------------------------------------------------------
function numberview_Callback(hObject, eventdata, handles)
% hObject    handle to numberview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%load application data
data = getappdata(handles.figure1,'appData');
g = data.g;

%global g;
checkstatus = get(hObject,'Check');

if strcmp(checkstatus, 'on')
    set(hObject,'Check','off');
elseif strcmp(checkstatus, 'off')
    set(handles.colorview,'Check','off');
    set(handles.labelview,'Check','off');
    set(handles.numberview,'Check','on');
    set(handles.blankview,'Check','off');
    refresh_graph(0, eventdata, handles,hObject)
end

%store application data
data.g = g;
setappdata(handles.figure1,'appData',data);

guidata(hObject, handles);


% --------------------------------------------------------------------
function blankview_Callback(hObject, eventdata, handles)
% hObject    handle to blankview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%load application data
data = getappdata(handles.figure1,'appData');
g = data.g;

%global g;
checkstatus = get(hObject,'Check');

if strcmp(checkstatus, 'on')
    set(hObject,'Check','off');
elseif strcmp(checkstatus, 'off')
    set(handles.colorview,'Check','off');
    set(handles.labelview,'Check','off');
    set(handles.numberview,'Check','off');
    set(handles.blankview,'Check','on');
    refresh_graph(0, eventdata, handles,hObject);
end

%store application data
data.g = g;
setappdata(handles.figure1,'appData',data);

guidata(hObject, handles);



% --------------------------------------------------------------------
function export_as_layer_2_Callback(hObject, eventdata, handles)
% hObject    handle to export_as_layer_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)global g;

%load application data
data = getappdata(handles.figure1,'appData');
g = data.g;
templates = data.templates;
template_list = data.template_list;

A  = double(matrix(g));

rmxy(g);
embed(g);
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

%function contained in folder "interface2simulink"
exportLayer2(name,templates,template_list,A, xy, labs); 

if nv(g) > 50
    disp('Done exporting');
    disp(' ');
    %msgbox('Done exporting','Export to Simulink');
else   
    disp('Done exporting');
end

%store application data
data.g = g;
data.templates = templates;
data.template_list = template_list;
setappdata(handles.figure1,'appData',data);

guidata(hObject, handles);


function refresh_graph(reset, eventdata, handles,hObject)
% This function refreshes the graph window

%load application data
data = getappdata(handles.figure1,'appData');

g = data.g;
modus = data.modus;

% Check which kind of lable is activated
checklabel = get(handles.labelview,'Check');
checknumber = get(handles.numberview,'Check');
%checkcolor = get(handles.colorview,'Check');
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
            set(handles.text32,'String',' ');
            set(handles.strong_connections,'String', ' ');            
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
            set(handles.text32,'String','Strong connected subgraphs:');
            set(handles.strong_connections,'String', '0');            
            set(handles.text22,'String', 'Weak connected subgraphs:');
            set(handles.connected_graphs,'String', '0');
            set(handles.text9,'String', 'Minimum In-Degree:');
            set(handles.minimum_degree,'String', '0');
            set(handles.text10,'String', 'Maximum In-Degree: ');
            set(handles.average_degree,'String', '0');
            set(handles.text11,'String', 'Minimum Out-Degree:');
            set(handles.median_degree,'String', '0');
            set(handles.text12,'String', 'Maximum Out-Degree:');
            set(handles.maximum_degree,'String', '0');
            set(handles.text16,'String', 'Average Degree:');
            set(handles.graph_density,'String', '0');            
            set(handles.text18,'String', 'Graph is balanced:');
            set(handles.graph_heterogenity,'String', '-');
            set(handles.text19,'String', 'Has cycles:');
            set(handles.algebraic_connectivity,'String', '-');
        end    
end

% set node color

% check for choice of vertex-layout
if strcmp(checklabel, 'on')
    ldraw(g,dir,'-',data.nodeColor(:,1), data.nodeColor(:,2) );
%elseif strcmp(checkcolor, 'on')
%    cdraw(g,dir);
elseif strcmp(checknumber, 'on')
    ndraw(g,dir,'-',data.nodeColor(:,1), data.nodeColor(:,2) );
else
    draw(g,dir,'-',data.nodeColor(:,1), data.nodeColor(:,2) );
end

set(handles.nedges,'String', num2str(ne(g,dir)));
set(handles.nvertices,'String',num2str(nv(g)));

%store application data
data.g = g;
setappdata(handles.figure1,'appData',data);

guidata(hObject, handles);


% --- Executes on button press in laplacianvisualize.
function basic_stats(eventdata, handles)
% hObject    handle to laplacianvisualize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%load application data
data = getappdata(handles.figure1,'appData');
g = data.g;
modus = data.modus;

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
        set(handles.text32,'String',' ');
        set(handles.strong_connections,'String', ' ');        
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
        [InDeg OutDeg]=getDegree(matrixOfGraph(g));
        LaplacianIn = diag(InDeg) - double(matrixOfGraph(g));
        LaplacianOut = diag(OutDeg) - double(matrixOfGraph(g));
        rank_L_In = rank(LaplacianIn); %rank of laplacian with indegree
        rank_L_Out = rank(LaplacianOut); %rank of laplacian with outdegree
        dim_L = mean(size(LaplacianIn)); %matrix-dimension
        
        set(handles.text22,'String', 'Weak connected subgraphs:');
        %if rank_L_In ~= rank_L_Out
        %    set(handles.connected_graphs,'String', 'Error!');
        %elseif rank_L_In == rank_L_Out
            %rank of the nullspace, gives the number of connected subgraphs
        %    null_L = dim_L-rank_L_In;
        %    set(handles.connected_graphs,'String', num2str(null_L,'%d')); 
        %end
        
        set(handles.connected_graphs,'String', num2str( length( compute_WCC( data.g))));
        
        minInDeg = min(InDeg);
        maxInDeg = max(InDeg);
        minOutDeg = min(OutDeg);
        maxOutDeg = max(OutDeg);
        
        [i,j,s]=find(InDeg == OutDeg);
        
        if size(s,1) == dim_L
            isBalanced = 'Yes';
        else %if size(s,1) < dim_L
            isBalanced = 'No';
        end
        strongCons = num2str( length( compute_SCC( data.g )));
        
        % idea of detecting cyclic graphs: if there are less sets of SCC
        % as nodes in the graph, then there must be at least one cycle.
        if str2double( strongCons ) < nv(data.g)
            isCyclic = 'Yes';
        else
            isCyclic = 'No';
        end
        
        set(handles.text32,'String','Strong connected subgraphs:');
        set(handles.strong_connections,'String', strongCons);
        set(handles.text9,'String', 'Minimum In-Degree:');
        set(handles.minimum_degree,'String', num2str(minInDeg,'%d'));        
        set(handles.text10,'String', 'Maximum In-Degree:');
        set(handles.average_degree,'String', num2str(maxInDeg,'%d'));
        set(handles.text11,'String', 'Minimum Out-Degree:');
        set(handles.median_degree,'String', num2str(minOutDeg,'%d'));
        set(handles.text12,'String', 'Maximum Out-Degree:');
        set(handles.maximum_degree,'String', num2str(maxOutDeg,'%d'));
        set(handles.text16,'String', 'Average Degree:');
        set(handles.graph_density,'String', num2str(mean(InDeg), '%1.3f'));        
        set(handles.text18,'String', 'Graph is balanced:');
        set(handles.graph_heterogenity,'String', isBalanced);
        set(handles.text19,'String', 'Has cycles:');
        set(handles.algebraic_connectivity,'String', isCyclic);
end
%no data storaged needed, because this is a "void" function


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

%load application data
data = getappdata(handles.figure1,'appData');
g = data.g;
template_list = data.template_list;
templates = data.templates;

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

%store application data
data.g = g;
data.template_list = template_list;
data.templates = templates;
setappdata(handles.figure1,'appData',data);

refresh_graph(0, eventdata, handles,hObject);
guidata(hObject, handles);


% --------------------------------------------------------------------
function export_to_simulink_Callback(hObject, eventdata, handles)
% hObject    handle to export_to_simulink (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%load application data
data = getappdata(handles.figure1,'appData');
g = data.g;
template_list = data.template_list;
templates = data.templates;

disp('Export mode 1');

A  = double(matrix(g));

% Makes the graph a circle
rmxy(g);
embed(g);

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
%no app data storage needed, because this can be seen as a "void" function.


% --- Executes on button press in add_multiple_nodes.
function add_multiple_nodes_Callback(hObject, eventdata, handles)
% hObject    handle to add_multiple_nodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%load application data
data = getappdata(handles.figure1,'appData');
templates = data.templates;
%g = data.g;
%global g;
%global graph_refresh;
n_nodes = str2num(get(handles.number_of_nodes,'String'));

%debugging output
%{
display(['DEBUGGING - "Add multiple nodes",']);
display(['directly after loading the application data:']);
display(['_____________________________________________________________']);
display(['Number of elements in "templates": ' num2str(numel(templates)) ]);
for k = 1:numel(templates)
    display(['data.templates{' num2str(k) '} = ' templates(k)]);
end
display(['_____________________________________________________________']);
%}

% this is needed, because during creation of the nodes the graph isn't build
% newly; only at the end the graph should built new.
data.graph_refresh = 0;
setappdata(handles.figure1,'appData',data);

for i=1:n_nodes
   newnode_Callback(hObject, eventdata, handles); 
end

data = getappdata(handles.figure1,'appData');
%store application data
%data.g = g;
data.graph_refresh = 1;
setappdata(handles.figure1,'appData',data);

%debugging output
%{
display(['DEBUGGING - "Add multiple nodes"']);
display(['End of callback function:']);
display(['_____________________________________________________________']);
display(['Number of elements in "templates": ' num2str(numel(templates)) ]);
for k = 1:numel(templates)
    display(['data.templates{' num2str(k) '} = ' templates(k)]);
end
display(['_____________________________________________________________']);
%}

refresh_graph(0, eventdata, handles, hObject);


% --------------------------------------------------------------------
function exit_to_matlab_Callback(hObject, eventdata, handles)
% hObject    handle to exit_to_matlab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(handles.output);

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



% --------------------------------------------------------------------
function export_to_workplace_Callback(hObject, eventdata, handles)
% hObject    handle to export_to_workplace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%load application data
data = getappdata(handles.figure1,'appData');
g = data.g;
modus = data.modus;

%global g;
%global modus;

uiwait( export_as_matrix(laplacian(g),g,modus));


% --------------------------------------------------------------------
function import_from_workplace_Callback(hObject, eventdata, handles)
% hObject    handle to import_from_workplace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%load application data
data = getappdata(handles.figure1,'appData');
g = data.g;
templates = data.templates;
template_list = data.template_list;
modus = data.modus;
%printCell = data.printCell;

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

%Initialize the printCell
nrNodes = nv(g);
printCell = cell(nrNodes,2);
for i = 1:nrNodes
    printCell(i,1) = num2cell([1 0],2);
    printCell{i,1} = initPlotParams;
end

%store application data
data.g = g;
data.templates = templates;
data.template_list = template_list;
data.modus = modus;
data.printCell = printCell;
setappdata(handles.figure1,'appData',data);

guidata(hObject, handles);
refresh_graph(0, eventdata, handles,hObject);


% --------------------------------------------------------------------
function add_mdl_template_Callback(hObject, eventdata, handles)
% hObject    handle to add_mdl_template (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%load application data
data = getappdata(handles.figure1,'appData');
template_list = data.template_list;
templates = data.templates;

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
                template_list{ny+1,2} = [1 1 1]; %default color
                template_list{ny+1,3} = [0 0 1]; %default color
            end 
        else
            disp(strcat('ERROR: "',filename{i}, '" is not a Simulink model'));
        end
    end % End del for
elseif filename %filename is not a cell (it's a string) and not 0
    file = strcat(pathname, filename);
    [path, template, ext] = fileparts(file);
    if strcmp('.mdl', ext)
        if strmatch(template, template_list{:,1}, 'exact')
            disp(strcat('WARNING: A template with the name "', template, '" was already imported!'));
        else
            [ny, nx] = size(template_list);
            template_list{ny+1,1} = template;
            template_list{ny+1,2} = [1 1 1]; %default color
            template_list{ny+1,3} = [0 0 1]; %default color
        end 
    else
        disp(strcat('ERROR: "',filename, '" is not a Simulink model'));
    end
end

cd(oldFolder);

%store application data
data.template_list = template_list;
setappdata(handles.figure1,'appData',data);

refresh_dynamics(eventdata, handles);
guidata(hObject, handles);
 


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
% refresh_dynamics(eventdata, handles);
% data = getappdata(handles.figure1,'appData');
% template_list = cell(0,1);
% template_list{1,1} = 'LTI';
% drop_string = cell(0,0);
% [ny, nx] = size(data.template_list);
% for i=1:ny
%     if i == 1
%         drop_string = data.template_list{1,1};
%     elseif i == ny
%         drop_string = strcat(drop_string,'|',data.template_list{i,1});
%     else        
%         drop_string = strcat(drop_string,'|',data.template_list{i,1});
%     end
% end
% set(hObject, 'String', drop_string);
%set(handles.selector_dynamic, 'String', drop_string);
%guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function selector_valueSet_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selector_valueSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function refresh_dynamics(eventdata, handles)
% This function refreshes the graph window

%load application data
data = getappdata(handles.figure1,'appData');
template_list = data.template_list;
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
refresh_valueSet(handles);
%guidata(hObject, handles);
%no data storage needed, because this can be seen as a "void" function.
 
function refresh_valueSet(handles)
% This function refreshes the graph window

%load application data
data = getappdata(handles.figure1,'appData');

%Check which template is chosen
idxDynSelector = get(handles.selector_dynamic,'Value');
stringDynSelector = get(handles.selector_dynamic,'String');

% Choose param struct
temp = ~cellfun( @isempty, regexp( data.template_list(:,1), ...
    regexp( stringDynSelector(idxDynSelector,:),'\w+','match') ) );
nrOfParamSets = length( data.template_list{temp,4} );

% template_list = data.template_list;
% [ny, nx] = size(data.template_list);
drop_string = cell( nrOfParamSets,1 );
for i=1:nrOfParamSets
    drop_string{i} = ['Value set ' num2str(i)];
%     if i == 1
%         drop_string = {['Set: ' num2str(i)]}; %template_list{1,1};
%     else
%         drop_string = strcat(drop_string,'|', ['Set: ' num2str(i)]);
%     end
end

set(handles.selector_valueSet, 'String', drop_string);
%guidata(hObject, handles);
%no data storage needed, because this can be seen as a "void" function.

% --- Executes on button press in circular_graph.
function circular_graph_Callback(hObject, eventdata, handles)
% hObject    handle to circular_graph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%load application data
data = getappdata(handles.figure1,'appData');
g = data.g;
modus = data.modus;

%global g;
%global modus;

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

%store application data
data.g = g;
data.modus = modus;
setappdata(handles.figure1,'appData',data);
    
refresh_graph(0, eventdata, handles,hObject);
guidata(hObject, handles);



% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%load application data
data = getappdata(handles.figure1,'appData');
g = data.g;
botton_down = data.botton_down;
move_index = data.move_index;
start_index = data.start_index;
templates = data.templates;
template_list = data.template_list;
modus = data.modus;
printCell = data.printCell;

%global g;
%global botton_down;
%global add_connection;
%global move_index;
%global start_index;
%global templates;
%global template_list;
%global modus;
%global printCell;


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
            refresh_graph(0, eventdata, handles,hObject);
        else
            start_index = I;
        end
    
    elseif strcmp(get(handles.output, 'SelectionType'), 'open')
    % Opens node modification dialog
   [s1,nodenumber,nodelabel,template,neighbours,destroy,intStates,printVector,plotParams] = ...
       edit_node(I, get_label(g,I), templates{I}, template_list, g(I), printCell(I,:) );

   %DEBUGGING
   %{
   display(['Nodenumber: ' num2str(nodenumber)]);
   display(['PrintCell: ' printCell(nodenumber)]);
   %assignin('base','neighbours',neighbours);
   %neighbours = eval(neighbours); %save variable to workspace
   disp('------------------------------------------------------------------');
    display(['@figure1_WindowButtonDownFcn: nodenumber = ' num2str(nodenumber)]);
    display(['@figure1_WindowButtonDownFcn: nodelabel = ' nodelabel]);
    display(['@figure1_WindowButtonDownFcn: template = ' template]);
    display(['@figure1_WindowButtonDownFcn: class of "neighbours": ' class(neighbours) ]);
   if strcmp(class(neighbours), 'double')
        display(['@figure1_WindowButtonDownFcn: neighbours = ' num2str(neighbours) ]);
   else
        display(['@figure1_WindowButtonDownFcn: neighbours = ' neighbours]);
   end
    display(['@figure1_WindowButtonDownFcn: destroy = ' num2str(destroy) ]);
    %display(['@figure1_WindowButtonDownFcn: intStates = ' num2str(intStates) ]);
   display(['@figure1_WindowButtonDownFcn: length of printVector = ' num2str(length(printVector)) ]);
    display(['@figure1_WindowButtonDownFcn: printVector = ' num2str(printVector) ]);
   %}
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
        
        if ~strcmp('double',class(neighbours))
            %display(['Class of variable "neighbour" is not "double".']);
            neighbours = eval(neighbours); %neighbours must be of type "double"
        end
   
        for i=1:size_ne
           delete(g,I,e_delete(i)); 
        end

        size_ne = size(neighbours,2);

        if ~strcmp(neighbours, '[]')
            for i=1:size_ne
                add(g,I,neighbours(i)); 
            end
        end
        %assignin('base','printVector',printVector);
        %Provide here the new plotting information
        printCell(nodenumber,1) = num2cell(printVector,2);
        printCell{nodenumber,2} = plotParams;
            
        refresh_graph(0, eventdata, handles,hObject);
            
   elseif destroy == 1
            if nv(g) && (I <= nv(g))
            templates(I,:) = []; % Deleting a template

            delete(g,I);
            
            %Here, the i-th entry of the printCell must be deleted too
            if size(printCell,1) == 1
                printCell = cell(0,2);
            else
                length_printCell = size(printCell,1);
                % display(['Length of printCell: ' num2str(length_printCell) ]);
                temp_printCell = printCell;
                printCell = cell(length_printCell-1,2);
                for i = 1:(nodenumber-1)
                    printCell(i,:) = temp_printCell(i,:);
                end
                for i = (nodenumber+1):length_printCell
                    printCell(i-1,:) = temp_printCell(i,:);
                end
            end

            refresh_graph(0, eventdata, handles,hObject);
            end

   end %if destroy == 0
   %}
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
    refresh_graph(0, eventdata, handles,hObject);
end

%store application data
data.g = g;
data.templates = templates;
data.botton_down = botton_down;
data.move_index = move_index;
data.start_index = start_index;
data.templates = templates;
data.template_list = template_list;
data.modus = modus;
data.printCell = printCell;
setappdata(handles.figure1,'appData',data);

guidata(hObject, handles);




% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonUpFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%load application data
data = getappdata(handles.figure1,'appData');
%botton_down = data.botton_down;
g = data.g;

%global botton_down;
%global g;

botton_down = 0;

%store application data
data.g = g;
data.botton_down = botton_down;
setappdata(handles.figure1,'appData',data);
guidata(hObject, handles);

% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%load application data
data = getappdata(handles.figure1,'appData');
botton_down = data.botton_down;
move_index = data.move_index;
g = data.g;

%global botton_down;
%global move_index;
%global g;

if botton_down
    CP = get(handles.axes1, 'CurrentPoint');
    x_c = CP(1,1);
    y_c = CP(1,2);
    XY = getxy(g);
    XY(move_index,1) = x_c;
    XY(move_index,2) = y_c;
    embed(g,XY);
    refresh_graph(0, eventdata, handles,hObject);
end

%store application data
data.botton_down = botton_down;
data.move_index = move_index;
data.g = g;
setappdata(handles.figure1,'appData',data);

guidata(hObject, handles);  


% --------------------------------------------------------------------
function export_as_layer_Callback(hObject, eventdata, handles)
% hObject    handle to export_as_layer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%load application data
data = getappdata(handles.figure1,'appData');
g = data.g;
templates = data.templates;
template_list = data.template_list;

%global g;
%global templates;
%global template_list;

A  = double(matrix(g));

%
rmxy(g);
embed(g);

%
xy = getxy(g);

labs = get_label(g);
name =	'untitled';
template ='LTI'; 
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


% --- Executes on button press in update_graph_button.
function update_graph_button_Callback(hObject, eventdata, handles)
% hObject    handle to update_graph_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

refresh_graph(1, eventdata, handles,hObject);



% --------------------------------------------------------------------
function export_to_simulink2_Callback(hObject, eventdata, handles)
% hObject    handle to export_to_simulink2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%load application data
data = getappdata(handles.figure1,'appData');
g = data.g;
templates = data.templates;
template_list = data.template_list;

%global g;
%global templates;
%global template_list;
%global expSucc;

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
exportSimulink2(name, templates, template_list, A, xy, labs, data.flag_showSimMod);

if nv(g) > 50
    disp('Done exporting');
    disp(' ');
    %msgbox('Done exporting','Export to Simulink');
else   
    disp('Done exporting');
end
expSucc = 1;

%store application data
data.expSucc = expSucc;
setappdata(handles.figure1,'appData',data);

guidata(hObject, handles); 



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

%load application data
data = getappdata(handles.figure1,'appData');

switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'button_undirected'
        data.modus = 'undirected';
        qstring = {'Preserve vertices?','(Edges will be deleted in both cases)'};
        choice = questdlg(qstring, ...
            'Change of graph modus', ...
            'Yes','No','No');
        switch choice
            case 'Yes';
                % Only delete edges
                elist = edges(data.g,1);
                for ii = 1:size(elist,1)
                    delete( data.g, elist(ii,1), elist(ii,2), 1 );
                end
            case 'No';
                % Delete entire graph
                resize(data.g,0);
                data.printCell = cell(0,2);
                data.nodeColor = cell(0,2);                
        end     
        refresh_graph(0, eventdata, handles,hObject);
        guidata(hObject, handles);
    case 'button_directed'
        data.modus = 'directed';
        qstring = {'Preserve vertices?','(Edges will be deleted in both cases)'};
        choice = questdlg(qstring, ...
            'Change of graph modus', ...
            'Yes','No','No');
        switch choice
            case 'Yes';
                elist = edges(data.g,0);
                delete(data.g,elist);
            case 'No';
                resize(data.g,0);
                data.printCell = cell(0,2);
                data.nodeColor = cell(0,2);
        end
        refresh_graph(0, eventdata, handles,hObject);
        guidata(hObject, handles);
    % Continue with more cases as necessary.
    otherwise
        % Code for when there is no match.
        data.modus = 'undirected';
end

%store application data
setappdata(handles.figure1,'appData',data);

guidata(hObject, handles); 


% --------------------------------------------------------------------
function run_simulation_Callback(hObject, eventdata, handles)
% hObject    handle to run_simulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%load application data
data = getappdata(handles.figure1,'appData');
g = data.g;
expSucc = data.expSucc;
printCell = data.printCell;
templates = data.templates;

%global g;
%global printCell;
%global templates;
%global expSucc;

%After export to simulink is complete, start the simulation, using the
%plotting parameters in printCell
if expSucc ~= 1
    msgbox('Please start Export to Simulink2 before using this function.','Notice');
end

if expSucc == 1
    %We need: number of nodes, number of internal states per node
    nrNodes = nv(g);
    intStates = zeros(nrNodes,1);
    for i = 1:nrNodes
        intStates(i) = length(printCell{i,1})-1;
    end

    %t contains the simulation time, x the states in order of the nodenumbers.
    %The output of each %node is contained in the To Workspace struct nodeouti, 
    %where i stands for the nodenumber
    [t,x]=sim(gcs);

    %Plotting of the simulation result can be done on different ways. For now,
    %every state gets its own figure

    for i = 1:nrNodes
        %Check printCell to see if visualization of state i is wanted
        temp = printCell{i,1};
        if any(temp)
        figure;
        hold on;
        y = evalin('base',['nodeout' num2str(i) '.signals.values']);
        plot(t,y,'Linewidth',2.0);
        %legend(['Output signal of node' num2str(i)]);
        xlabel('Simulation time in [s]');

        if strcmp(templates{i},'LTI')
            if i == 1
                index = 1;
            else
                index = 1+sum(intStates(1:(i-1)));
            end
            x_loc = x(:,index:index+intStates(i)-1); 
            %Build string matrix for legend
            stringMatrix = cell(1,1);
            stringMatrix{1} = ['Output signal of node ' num2str(i)];
            counterStringMatrix = 1;
            for j=2:intStates(i)+1
                if temp(j) == 1
                    counterStringMatrix = counterStringMatrix + 1;
                    stringMatrix = [stringMatrix; cell(1,1)];
                    p=plot(t,x_loc(:,j-1),'Linewidth',1.2);
                    R = 0.1 + 0.5*rand;
                    G = 0.1 + 0.5*rand;
                    B = 0.1 + 0.5*rand;
                    set(p,'Color', [R G B] );
                    stringMatrix{counterStringMatrix} = ['State ' num2str(j-1) ' of node ' num2str(i)];
                end
            end
            legend(stringMatrix,'Location','NorthEastOutside');
        else
            legend(['Output signal of node ' num2str(i)]);
        end

        hold off;
        end
    end
end



% --------------------------------------------------------------------
function plotAllOutput_Callback(hObject, eventdata, handles)
% hObject    handle to plotAllOutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = getappdata(handles.figure1,'appData');

if strcmp(get(handles.plotAllOutput,'Checked'),'on')
    set(handles.plotAllOutput,'Checked','off')
    plotAllOutput = 0;
else
    set(handles.plotAllOutput,'Checked','on')
    plotAllOutput = 1;
end

%store application data
data.plotAllOutput = plotAllOutput;
setappdata(handles.figure1,'appData',data);

guidata(hObject, handles); 


% --------------------------------------------------------------------
function run_simulation_plots_Callback(hObject, eventdata, handles)
% hObject    handle to run_simulation_plots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%load application data
data = getappdata(handles.figure1,'appData');
g = data.g;
printCell = data.printCell;
templates = s;
expSucc = data.expSucc;

%global g;
%global printCell;
%global templates;
%global expSucc;
global xout;
global tout;


%After export to simulink is complete, start the simulation, using the
%plotting parameters in printCell
if expSucc ~= 1
    msgbox('Please start Export to Simulink2 before using this function.','Notice');
end

if expSucc == 1
    %We need: number of nodes, number of internal states per node
    nrNodes = nv(g);
    intStates = zeros(nrNodes,1);
    for i = 1:nrNodes
        intStates(i) = length(printCell{i,1})-1;
    end

    %t contains the simulation time, x the states in order of the nodenumbers.
    %The output of each %node is contained in the To Workspace struct nodeouti, 
    %where i stands for the nodenumber
    %[t,x]=sim(gcs);

    %Plotting of the simulation result can be done on different ways. For now,
    %every state gets its own figure

    for i = 1:nrNodes
        %Check printCell to see if visualization of state i is wanted
        temp = printCell{i,1};
        if any(temp)
        figure;
        hold on;
        y = evalin('base',['nodeout' num2str(i) '.signals.values']);
        plot(tout,y,'Linewidth',2.0);
        %legend(['Output signal of node' num2str(i)]);
        xlabel('Simulation time in [s]');

        if strcmp(templates{i},'LTI')
            if i == 1
                index = 1;
            else
                index = 1+sum(intStates(1:(i-1)));
            end
            x_loc = xout(:,index:index+intStates(i)-1); 
            %Build string matrix for legend
            stringMatrix = cell(1,1);
            stringMatrix{1} = ['Output signal of node ' num2str(i)];
            counterStringMatrix = 1;
            for j=2:intStates(i)+1
                if temp(j) == 1
                    counterStringMatrix = counterStringMatrix + 1;
                    stringMatrix = [stringMatrix; cell(1,1)];
                    p=plot(t,x_loc(:,j-1),'Linewidth',1.2);
                    R = 0.1 + 0.5*rand;
                    G = 0.1 + 0.5*rand;
                    B = 0.1 + 0.5*rand;
                    set(p,'Color', [R G B] );
                    stringMatrix{counterStringMatrix} = ['State ' num2str(j-1) ' of node ' num2str(i)];
                end
            end
            legend(stringMatrix,'Location','NorthEastOutside');
        else
            legend(['Output signal of node ' num2str(i)]);
        end

        hold off;
        end
    end
end


% --- Executes on button press in pushbutton17.
% -- This button is only necessary for easily generating debugging output
% -- it should be set to invisible or deleted after debugging
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
      %DEBUGGING
data = getappdata(handles.figure1,'appData');
      
display(['Number of nodes: ' num2str(nv(data.g)) ]);
%display(['PrintCell: ' printCell(nodenumber)]);
assignin('base','data',data);



% -- this function initializes the plot parameters for a node
function [argout] = initPlotParams()
% output is a (1+n) element struct containing six elements, where
%n is the amount of internal states to plot. At start of mtids, n=1 for
%each node
plotParams.lineWidth = '1.0';
plotParams.lineStyle = '-';
plotParams.marker = 'none';
plotParams.lineColor = [0 0 1];
plotParams.edgeColor = [0 0 1];
plotParams.faceColor = [0 0 1];

%at start of mtids, no int. states should be plotted, thus no 2nd struct
%exists

argout = plotParams;



% --------------------------------------------------------------------
function showSimMod_Callback(hObject, eventdata, handles)
% hObject    handle to showSimMod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = getappdata(handles.figure1,'appData');

if strcmp(get(handles.showSimMod,'Checked'),'on')
    set(handles.showSimMod,'Checked','off')
    data.flag_showSimMod = 0;
else
    set(handles.showSimMod,'Checked','on')
    data.flag_showSimMod = 1;
end

setappdata(handles.figure1,'appData',data);
guidata(hObject, handles);         
        
       
function load_settings(filename,handles)
%data = getappdata(handles.figure1,'appData');
S=load(filename, 'modus','flag_showSimMod','plotAllOutput','template_list');
data.modus = S.modus;
data.flag_showSimMod = S.flag_showSimMod;
data.plotAllOutput = S.plotAllOutput;
data.template_list = S.template_list;
setappdata(handles.figure1,'appData',data);

function save_settings(filename,handles)
data = getappdata(handles.figure1,'appData');
save(filename, '-struct','data', 'modus', 'flag_showSimMod','plotAllOutput',...
    'template_list');


function loadGraphAtOpening(hObject, eventdata, handles)
% hObject    handle to loadgraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% load application data
data = getappdata(handles.figure1,'appData');
% g = data.g;
template_list = data.template_list;

% [filename, pathname] = uigetfile( ...
% {'*.mat;','Graph/Network Files';
%    '*.mat','MAT-files (*.mat)'; ...
%     '*.*',  'All Files (*.*)'}, ...
%    'Open');
filename = 'lastgraph.mat';
pathname = [pwd filesep 'resources' filesep];

if filename       
    file = strcat(pathname, filename);
    [pathname, filename, ext] = fileparts(file);
%     free(g);
    
    if strcmp(ext, '.mat') 
        S = load(file, 'nverts', 'nedges','adj_matrix', 'XY', 'labs', 'templates',...
            'printCell','template_list','modus','nodeColor') ;
        %S = load(file, 'data' );
        %data = S.data;
        %assignin('base','data',data);
        
        nverts = S.nverts;
        adj_matrix = S.adj_matrix;
        XY = S.XY;
        labs = S.labs;
        templates = S.templates;
        template_list = S.template_list;
        data.modus = S.modus;
        data.printCell = S.printCell;
        data.nodeColor = S.nodeColor;
        g = graph(nverts);
        switch data.modus;
            case 'undirected'; dir = 0;
            case 'directed'; dir = 1;
        end

        for i=1:nverts
            label(g,i,labs{i});
            for j=1:nverts
              if adj_matrix(i,j)
                 add(g,i,j,dir);
                 adj_matrix(j,i) = 0;
              end            
            end
        end

        embed(g,XY);
        
%     elseif strcmp(ext, '.gr')
%         load(g, file);
%         templates = cell(0,1);
%         % Temporary code...
%         n_template = get(handles.selector_dynamic, 'Value'); % Get template name from list
%         for i=1:nv(g)
%             templates{i,1}=template_list{n_template,1};
%         end
        
    end
end

%set the uipanel according to stored value of "modus"
switch data.modus
    case 'directed'
        set(handles.button_undirected,'Value', 0.0);
        set(handles.button_directed,'Value', 1.0);
    case 'undirected'
        set(handles.button_undirected,'Value', 1.0);
        set(handles.button_directed,'Value', 0.0);        
end

%store application data
data.g = g;
data.templates = templates;
data.template_list = template_list;

setappdata(handles.figure1,'appData',data);
guidata(hObject, handles);
% refresh_dynamics(eventdata, handles);
% refresh_graph(0, eventdata, handles,hObject);

% --------------------------------------------------------------------
function set_node_color_Callback(hObject, eventdata, handles)
% hObject    handle to set_node_color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = getappdata(handles.figure1,'appData');
temp = setnodecolor(data.template_list);
if ~isempty(temp)
    data.template_list = temp;
    for i = 1:nv(data.g)
        nr_template = find( strcmp( data.templates(i), data.template_list(:,1) ));
        data.nodeColor{i,1} = data.template_list{nr_template,2}; 
        data.nodeColor{i,2} = data.template_list{nr_template,3}; 
    end    
end

guidata(hObject, handles);
setappdata(handles.figure1,'appData',data);
refresh_graph(0, eventdata, handles,hObject);


% --------------------------------------------------------------------
function create_dynamic_Template_Callback(hObject, eventdata, handles)
% hObject    handle to create_dynamic_Template (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% out = dialog('WindowStyle', 'normal', 'Name', 'Open');
title = 'Creation of new dynamic template';
message = ['A new model in Simulink will be loaded now. Please leave Inport, Outport ' ...
    'and the Mux-Block at the Inport unmodified. Save your work afterwards and open the import ' ...
    'wizard to use the created dynamics in mtids.' ...
    'See ''help'' for detailed advise.'];
h1=msgbox(message,title,'help');
posVector=get(h1,'OuterPosition');
set(h1,'OuterPosition',posVector + [0 0 20 0]); %[left, bottom, width, height]
simulink;
open_system('nodeTemplate.mdl');



% --------------------------------------------------------------------
function template_import_wizard_Callback(hObject, eventdata, handles)
% hObject    handle to template_import_wizard (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% next step: load template invisibly from mdl-file
oldFolder = cd(strcat(pwd,'/templates'));

[filename, pathname] = uigetfile( ...
{'*.mdl','Simulink model template(*.mdl)';
   '*.*',  'All Files (*.*)'}, ...
   'Import Simulink model templates', ...
   'MultiSelect', 'on');

% disp(['Filename: ' filename]);
if all( filename ~= 0 )
    load_system(filename);
else
    cd(oldFolder);
    return
end

% check this file for unset parameter values - this is a prestep to the
% dialog of asking for all needed parameters for this template
% finds all blocks in the simulink model
blks = find_system(gcs, 'Type', 'block');
listblks = get_param(blks, 'BlockType');
listnms = get_param(blks,'Name');

% is is very hard to show the variation of all editable parameters
% thus just show the blocks and let the user type in which values should be
% introduced as parameters for the template OR make a choice of possible
% values, which are very likely

% there are some blocks, which are very likely not to contain parameters,
% which the user should set, e.g.:
% Inport, Outport, Sum, Mux, Math
% sort out these blocks:
listnms( ~cellfun( @isempty, regexp( listblks,...
    'Inport|Outport|Sum|Mux|Math|Scope|ToWorkspace','start')) ) = [];
listblks( ~cellfun( @isempty, regexp( listblks,...
    'Inport|Outport|Sum|Mux|Math|Scope|ToWorkspace','start')) ) = [];

% create new figure and place found blocks in table environment
if ~cellfun( @isempty, listblks )
    argout = import_dynamic_params(listblks,listnms,filename);
else
    % errordlg('No blocks with editable');
end

close_system(filename);
cd(oldFolder);
data = getappdata(handles.figure1,'appData');
data.template_list = readImportedTemplates(data.template_list);
setappdata(handles.figure1,'appData',data);
refresh_dynamics(eventdata, handles);

% --------------------------------------------------------------------
function saveGraph(hObject, eventdata, handles, pathname, filename)
% hObject    handle to savegraphas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%load application data
data = getappdata(handles.figure1,'appData');
g = data.g;
templates = data.templates;
template_list = data.template_list;
modus = data.modus;
printCell = data.printCell;

if filename
     file = strcat(pathname, filename);
     [pathname, filename, ext] = fileparts(file);
     %save(g, file);

     adj_matrix = double(matrix(g));
     labs = get_label(g);
     XY = getxy(g);
     nverts = nv(g);
     nedges = ne(g);
     nodeColor = data.nodeColor;

     if strcmp(ext, '.mat')
        %save(file, 'data' );
        save(file, 'nverts', 'nedges','adj_matrix', 'XY', 'labs', 'templates',...
            'printCell','template_list','modus','nodeColor') ;
%         disp(strcat('Saved graph as binary .mat file ("', file,'")'));
     elseif strcmp(ext, '.gr')
        save(g, file);
        disp(strcat('Saved graph as Matgraph file ("', file,'")'));
     end
end
 
refresh_graph(0, eventdata, handles,hObject);



%--------------------------------------------------------------------------
%-------UNUSED FUNCTION CALLBACKS - AUTOMATICALLY GENERATED BY GUIDE-------
%--------------------------------------------------------------------------

% --- Executes on button press in radiobutton7.
function radiobutton7_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton7

function tonode_Callback(hObject, eventdata, handles)
% hObject    handle to tonode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of tonode as text
%        str2double(get(hObject,'String')) returns contents of tonode as a double

function fromnode_Callback(hObject, eventdata, handles)
% hObject    handle to fromnode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of fromnode as text
%        str2double(get(hObject,'String')) returns contents of fromnode as a double

% --- Executes on selection change in selector_dynamic.
function selector_dynamic_Callback(hObject, eventdata, handles)
% hObject    handle to selector_dynamic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns selector_dynamic contents as cell array
%        contents{get(hObject,'Value')} returns selected item from selector_dynamic
%get(hObject,'Value')

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

% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of checkbox2

% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%       Key: name of the key that was pressed, in lower case
%       Character: character interpretation of the key(s) that was pressed
%       Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function Savegraph_Callback(hObject, eventdata, handles)
% hObject    handle to Savegraph (see GCBO)
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
function click_add_node_long_Callback(hObject, eventdata, handles)
% hObject    handle to click_add_node_long (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function remnode_Callback(hObject, eventdata, handles)
% hObject    handle to remnode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of remnode as text
%        str2double(get(hObject,'String')) returns contents of remnode as a double

function dynamic_label_Callback(hObject, eventdata, handles)
% hObject    handle to dynamic_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of dynamic_label as text
%        str2double(get(hObject,'String')) returns contents of dynamic_label as a double

function number_of_nodes_Callback(hObject, eventdata, handles)
% hObject    handle to number_of_nodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of number_of_nodes as text
%        str2double(get(hObject,'String')) returns contents of number_of_nodes as a double

% --- Executes on selection change in selector_valueSet.
function selector_valueSet_Callback(hObject, eventdata, handles)
% hObject    handle to selector_valueSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns selector_valueSet contents as cell array
%        contents{get(hObject,'Value')} returns selected item from selector_valueSet


%%%%%%%%%






