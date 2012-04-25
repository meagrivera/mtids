function varargout = edit_node(varargin)
% EDIT_NODE M-file for edit_node.fig
%      EDIT_NODE, by itself, creates a new EDIT_NODE or raises the existing
%      singleton*.
%
%      H = EDIT_NODE returns the handle to a new EDIT_NODE or the handle to
%      the existing singleton*.
%
%      EDIT_NODE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EDIT_NODE.M with the given input arguments.
%
%      EDIT_NODE('Property','Value',...) creates a new EDIT_NODE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before edit_node_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to edit_node_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help edit_node

% Last Modified by GUIDE v2.5 22-Apr-2012 21:44:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @edit_node_OpeningFcn, ...
                   'gui_OutputFcn',  @edit_node_OutputFcn, ...
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


% --- Executes just before edit_node is made visible.
function edit_node_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to edit_node (see VARARGIN)

%global nodenumber;
%global nodelabel;
%global template;
%global template_list;
%global neighbours;
%global destroy;
%Additional variables for plotting the simulation
%global intStates;
%global printVector;
%global printCell;
%intStates = 1;
%Minimum length of princt vector is 2. First entry denotes if node output
%should be plotted. Entries 1+i denotes if internal state i should be plotted.
data.printVector = [1 0];
data.destroy = 0; %means, node should NOT be destroyed and changes should be applied

%Flags for plot checkboxes
%global flagCheck1;
%global flagCheck2;

%Input Arguments!!
data.nodenumber = varargin{1};
data.nodelabel  = varargin{2};
data.template = varargin{3};
data.template_list = varargin{4};
data.neighbours = varargin{5};
data.printCell = varargin{6};
%global drop_string;

[ny, nx] = size(data.template_list);

% Building selector string
for i=1:ny
    if i == 1
        data.drop_string = data.template_list{1,1};
    elseif i == ny
        data.drop_string = strcat(data.drop_string,'|',data.template_list{i,1});
    else        
        data.drop_string = strcat(data.drop_string,'|',data.template_list{i,1});
    end
end

set(handles.selector_dynamics, 'String', data.drop_string);

n1 = find(strcmp(data.template, data.template_list));

set(handles.selector_dynamics, 'Value', n1); % Get template name from list

set(handles.number_node, 'String', num2str(data.nodenumber));
set(handles.edit_label, 'String', data.nodelabel);
set(handles.connections, 'String', matrix_to_string(data.neighbours));

%Initialize figure with information contained in printCell
temp = data.printCell{data.nodenumber};
data.intStates = length(temp)-1;
set(handles.edit_intStates,'String',num2str(data.intStates));
if temp(1) == 1
    data.flagCheck1 = 1;
else
    data.flagCheck1 = 0;
end
set(handles.checkbox1,'Value',data.flagCheck1);
if any(temp(2:length(temp)))
    data.flagCheck2 = 1;
    stringSelectedStates = num2str(find(temp(2:length(temp))));
else
    data.flagCheck2 = 0;
    stringSelectedStates = '';
end
set(handles.checkbox2,'Value',data.flagCheck2);
set(handles.edit_selectedStates,'String',stringSelectedStates);


setappdata(handles.figure1,'appData',data);

% Choose default command line output for edit_node
handles.output = hObject;
guidata(hObject, handles);

%set(handles.selector_dynamics, 'Value', '2');
% UIWAIT makes edit_node wait for user response (see UIRESUME)
uiwait(handles.figure1);



% --- Outputs from this function are returned to the command line.
function varargout = edit_node_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%load application data
data = getappdata(handles.figure1,'appData');

%DEBUGGING
%{
disp('------------------------------------------------------------------');
display(['@edit_node_OutputFcn: data.nodenumber = ' num2str(data.nodenumber)]);
display(['@edit_node_OutputFcn: data.nodelabel = ' data.nodelabel]);
display(['@edit_node_OutputFcn: data.template = ' data.template]);
display(['@edit_node_OutputFcn: data.neighbours = ' data.neighbours]);
display(['@edit_node_OutputFcn: data.destroy = ' data.destroy]);
display(['@edit_node_OutputFcn: data.intStates = ' data.intStates]);
display(['@edit_node_OutputFcn: data.printVector = ' num2str(data.printVector{:}) ]);
%}

if handles.OutputFlag == 2 % "apply changes"
    varargout{1} = handles.output;
    varargout{2} = data.nodenumber;
    varargout{3} = data.nodelabel;
    varargout{4} = data.template;
    varargout{5} = data.neighbours;
    varargout{6} = data.destroy;
    varargout{7} = data.intStates;
    varargout{8} = data.printVector;

    
elseif handles.OutputFlag == 1 % "cancel changes"
    varargout{1} = handles.output;
    varargout{2} = data.nodenumber;
    varargout{3} = data.nodelabel;
    varargout{4} = data.template;
    varargout{5} = data.neighbours;
    varargout{6} = data.destroy;
    varargout{7} = data.intStates;
    varargout{8} = data.printVector;

    
elseif handles.OutputFlag == 0 % "delete node"
    varargout{1} = handles.output;
    varargout{2} = data.nodenumber;
    varargout{3} = data.nodelabel;
    varargout{4} = data.template;
    varargout{5} = data.neighbours;
    varargout{6} = data.destroy;
    varargout{7} = data.intStates;
    varargout{8} = data.printVector;
    
end
delete(hObject)



function connections_Callback(hObject, eventdata, handles)
% hObject    handle to connections (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of connections as text
%        str2double(get(hObject,'String')) returns contents of connections as a double


% --- Executes during object creation, after setting all properties.
function connections_CreateFcn(hObject, eventdata, handles)
% hObject    handle to connections (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in selector_dynamics.
function selector_dynamics_Callback(hObject, eventdata, handles)
% hObject    handle to selector_dynamics (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns selector_dynamics contents as cell array
%        contents{get(hObject,'Value')} returns selected item from selector_dynamics


% --- Executes during object creation, after setting all properties.
function selector_dynamics_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selector_dynamics (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in button_edit.
function button_edit_Callback(hObject, eventdata, handles)
% hObject    handle to button_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%load application data
data = getappdata(handles.figure1,'appData');

data.destroy = 0; %node should NOT be destroyed and changes be applied

n_template = get(handles.selector_dynamics, 'Value');
data.template = data.template_list{n_template};
data.nodelabel = get(handles.edit_label, 'String');
handles.nodelabel = get(handles.edit_label, 'String');
data.neighbours = get(handles.connections, 'String');

%DEBUGGING
%display([data.nodelabel]);

%Compute printVector
%TODO: case distinction for templates with only one internal state

%Get number of internal states
data.intStates = str2double(get(handles.edit_intStates,'String'));

%Set length of printVector, depending on number of internal states
%ATTENTION: value of intStates must be an integer and of the minimum of 1!
data.printVector = zeros(1,data.intStates+1);
%Read out manually the information about the states, which should be
%plotted. Format is: "i j l", no brackets, just a spacer between the
%numbers.
data.temp = str2num(get(handles.edit_selectedStates,'String'));

if data.flagCheck1 %Checkbox 1 is checked
    data.printVector(1) = 1;
else %Checkbox 1 is not checked
    data.printVector(1) = 0;
end

if any(data.temp)
    data.flagCheck2 = 1;
end

if data.flagCheck2 && strcmp(data.template,'LTI') %Checkbox 2 is checked AND dynamics are LTI
    for i = 1:data.intStates
        if find(data.temp == i)
           data.printVector(1+i) = 1; 
        end
    end
    %printVector(2) = 5; %just for debugging
    
else %Checkbox 2 is not checked
    data.printVector(2:data.intStates+1) = zeros(1,data.intStates);
    
end

setappdata(handles.figure1,'appData',data);

%DO DEBUGGING
%display([data.neighbours]);

%DEBUGGING
%{
disp('------------------------------------------------------------------');
display(['@button_edit_Callback: data.nodelabel = ' data.nodelabel]);
%}

handles.OutputFlag = 2;

guidata(hObject, handles);
%close(handles.output);
uiresume(handles.figure1);


% --- Executes on button press in button_delete.
function button_delete_Callback(hObject, eventdata, handles)
% hObject    handle to button_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data = getappdata(handles.figure1,'appData');
data.destroy = 1; %graph should be destroyed
setappdata(handles.figure1,'appData',data);
handles.OutputFlag = 0;
guidata(hObject, handles);
uiresume(handles.figure1);

% --- Executes on button press in button_cancel.
function button_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to button_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = getappdata(handles.figure1,'appData');
%global destroy;
data.destroy = 2; %graph should NOT be destroyed, but changes should NOT be applied
setappdata(handles.figure1,'appData',data);
handles.OutputFlag = 1;
guidata(hObject, handles);
uiresume(handles.figure1);


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of checkbox1
%global printVector;

if (get(hObject,'Value') == get(hObject,'Max'))
    % Checkbox is checked-take appropriate action  
    data.flagCheck1 = 1;
else
    % Checkbox is not checked-take appropriate action 
    data.flagCheck1 = 0;
end
setappdata(handles.figure1,'appData',data);



function edit_intStates_Callback(hObject, eventdata, handles)
% hObject    handle to edit_intStates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of edit_intStates as text
%        str2double(get(hObject,'String')) returns contents of edit_intStates as a double


% --- Executes during object creation, after setting all properties.
function edit_intStates_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_intStates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of checkbox2

if (get(hObject,'Value') == get(hObject,'Max'))
    % Checkbox is checked-take appropriate action
    data.flagCheck2 = 1;
else
    % Checkbox is not checked-take appropriate action
    data.flagCheck2 = 0;
end
setappdata(handles.figure1,'appData',data);


function edit_selectedStates_Callback(hObject, eventdata, handles)
% hObject    handle to edit_selectedStates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of edit_selectedStates as text
%        str2double(get(hObject,'String')) returns contents of edit_selectedStates as a double


% --- Executes during object creation, after setting all properties.
function edit_selectedStates_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_selectedStates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in edit_plot_parameters.
function edit_plot_parameters_Callback(hObject, eventdata, handles)
% hObject    handle to edit_plot_parameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data = getappdata(handles.figure1,'appData');
plotStates = str2num(get(handles.edit_selectedStates,'String'));

[params] = pp2(data.nodenumber, plotStates);
if isempty(params)
    % line specs figure was cancled - no new plot specs should be applied
    data.plotParams = params;
    set(handles.figure1,'appData',data);
else
    % use plot specs in struct 'params'
    data.plotParams = params;
    set(handles.figure1,'appData',data);
end
guidata(hObject, handles);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = getappdata(handles.figure1,'appData');
data.destroy = 2; %graph should NOT be destroyed, but changes should NOT be applied
setappdata(handles.figure1,'appData',data);
handles.OutputFlag = 1;
guidata(hObject, handles);

%DEBUGGING
%{
disp('------------------------------------------------------------------');
display(['@edit_node_OutputFcn: data.nodenumber = ' num2str(data.nodenumber)]);
display(['@edit_node_OutputFcn: data.nodelabel = ' data.nodelabel]);
display(['@edit_node_OutputFcn: data.template = ' data.template]);
display(['@edit_node_OutputFcn: data.neighbours = ' data.neighbours]);
display(['@edit_node_OutputFcn: data.destroy = ' data.destroy]);
display(['@edit_node_OutputFcn: data.intStates = ' data.intStates]);
display(['@edit_node_OutputFcn: data.printVector = ' num2str(data.printVector{:}) ]);
%}

uiresume(handles.figure1);
%delete(hObject);


%%%