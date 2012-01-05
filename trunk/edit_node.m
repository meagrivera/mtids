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

% Last Modified by GUIDE v2.5 03-Jan-2012 10:34:16

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

% Choose default command line output for edit_node
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
global nodenumber;
global nodelabel;
global template;
global template_list;
global neighbours;
global destroy;
%Additional variables for plotting the simulation
global intStates;
global printVector;
global printCell;
%intStates = 1;
%Minimum length of princt vector is 2. First entry denotes if node output
%should be plotted. Entries 1+i denotes if internal state i should be plotted.
printVector = [1 0];

%Flags for plot checkboxes
global flagCheck1;
global flagCheck2;


%Input Arguments!!
nodenumber = varargin{1};
nodelabel  = varargin{2};
template   = varargin{3};
template_list = varargin{4};
neighbours = varargin{5};
printCell = varargin{6};
global drop_string;

[ny, nx] = size(template_list);

% Building selector string
for i=1:ny
    if i == 1
        drop_string = template_list{1,1};
    elseif i == ny
        drop_string = strcat(drop_string,'|',template_list{i,1});
    else        
        drop_string = strcat(drop_string,'|',template_list{i,1});
    end
end

set(handles.selector_dynamics, 'String', drop_string);

n1 = strmatch(template, template_list, 'exact');

set(handles.selector_dynamics, 'Value', n1); % Get template name from list

set(handles.number_node, 'String', num2str(nodenumber));
set(handles.edit_label, 'String', nodelabel);
set(handles.connections, 'String', matrix_to_string(neighbours));

%Initialize figure with information contained in printCell
temp = printCell{nodenumber};
intStates = length(temp)-1;
set(handles.edit_intStates,'String',num2str(intStates));
if temp(1) == 1
    flagCheck1 = 1;
else
    flagCheck1 = 0;
end
set(handles.checkbox1,'Value',flagCheck1);
if any(temp(2:length(temp)))
    flagCheck2 = 1;
    stringSelectedStates = num2str(find(temp(2:length(temp))));
else
    flagCheck2 = 0;
    stringSelectedStates = '';
end
set(handles.checkbox2,'Value',flagCheck2);
set(handles.edit_selectedStates,'String',stringSelectedStates);


%set(handles.selector_dynamics, 'Value', '2');



% UIWAIT makes edit_node wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = edit_node_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
global nodenumber;
global nodelabel;
global template;
global template_list;
global neighbours;
global destroy;
global intStates;
global printVector;

uiwait(handles.output);

varargout{1} = handles.output;
varargout{2} = nodenumber;
varargout{3} = nodelabel;
varargout{4} = template;
varargout{5} = neighbours;
varargout{6} = destroy;
varargout{7} = intStates;
varargout{8} = printVector;
% uiresume(handles.output);






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
global nodenumber;
global nodelabel;
global template;
global template_list;
global neighbours;
global destroy;
global intStates;
global printVector;
global flagCheck1;
global flagCheck2;
global temp;

destroy = 0;

n_template = get(handles.selector_dynamics, 'Value');
template =  template_list{n_template};
nodelabel = get(handles.edit_label, 'String');
neighbours = get(handles.connections, 'String');

%Compute printVector
%TODO: case distinction for templates with only one internal state

%Get number of internal states
intStates = str2double(get(handles.edit_intStates,'String'));

%Set length of printVector, depending on number of internal states
%ATTENTION: value of intStates must be an integer and of the minimum of 1!
printVector = zeros(1,intStates+1);
%Read out manually the information about the states, which should be
%plotted. Format is: "i j l", no brackets, just a spacer between the
%numbers.
temp = str2num(get(handles.edit_selectedStates,'String'));

if flagCheck1 %Checkbox 1 is checked
    printVector(1) = 1;
else %Checkbox 1 is not checked
    printVector(1) = 0;
end

if flagCheck2 && strcmp(template,'LTI') %Checkbox 2 is checked AND dynamics are LTI
    for i = 1:intStates
        if find(temp == i)
           printVector(1+i) = 1; 
        end
    end
    %printVector(2) = 5; %just for debugging
    
else %Checkbox 2 is not checked
    printVector(2:intStates+1) = zeros(1,intStates);
    
end


close(handles.output);


% --- Executes on button press in button_delete.
function button_delete_Callback(hObject, eventdata, handles)
% hObject    handle to button_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global destroy;
destroy = 1;
close(handles.output);

% --- Executes on button press in button_cancel.
function button_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to button_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global destroy;
destroy = 2;
close(handles.output);


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of checkbox1
%global printVector;
global flagCheck1;
%global flagCheck2;
if (get(hObject,'Value') == get(hObject,'Max'))
    % Checkbox is checked-take appropriate action
    
    flagCheck1 = 1;
else
    % Checkbox is not checked-take appropriate action
    
    flagCheck1 = 0;
end



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
%global printVector;
%global intStates;
global flagCheck2;

if (get(hObject,'Value') == get(hObject,'Max'))
    % Checkbox is checked-take appropriate action

    flagCheck2 = 1;
else
    % Checkbox is not checked-take appropriate action

    flagCheck2 = 0;
end


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
