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

% Last Modified by GUIDE v2.5 07-Sep-2012 09:51:22

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

data.destroy = 0; %means, node should NOT be destroyed and changes should be applied

%Process Input Arguments!!
data.nodenumber = varargin{1};
data.nodelabel  = varargin{2};
data.template = varargin{3};
data.template_list = varargin{4};
data.neighbours = varargin{5};
data.printCell = varargin{6};
data.matrix = varargin{7};
data.plotParamsOld = data.printCell{:,2};
%Minimum length of print vector is 2. First entry denotes if node output
%should be plotted. Entries 1+i denotes if internal state i should be plotted.
data.printVectorOld = data.printCell{:,1}; %old print vector

[ny, nx] = size(data.template_list);

% INITIALIZE GUI
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

%set(handles.selector_dynamics, 'String', data.drop_string);
n1 = find(strcmp(data.template{1}, data.template_list));
set(handles.selector_dynamics, 'String', data.template{1}); % Get number of template name from list
set(handles.number_node, 'String', num2str(data.nodenumber));
set(handles.edit_label, 'String', data.nodelabel);
set(handles.connections, 'String', matrix_to_string(data.neighbours));

%Initialize figure with information contained in printCell
temp = data.printCell{1,1};
data.intStates = data.template{1,2}.dimension.states;
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


% store input data and figure handles
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
compute_printVector(handles);
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
    varargout{9} = data.plotParams;
    
elseif handles.OutputFlag == 1 % "cancel changes"
    varargout{1} = handles.output;
    varargout{2} = data.nodenumber;
    varargout{3} = data.nodelabel;
    varargout{4} = data.template;
    varargout{5} = data.neighbours;
    varargout{6} = data.destroy;
    varargout{7} = data.intStates;
    varargout{8} = data.printVectorOld;
    varargout{9} = data.plotParamsOld;
    
elseif handles.OutputFlag == 0 % "delete node"
    varargout{1} = handles.output;
    varargout{2} = data.nodenumber;
    varargout{3} = data.nodelabel;
    varargout{4} = data.template;
    varargout{5} = data.neighbours;
    varargout{6} = data.destroy;
    varargout{7} = data.intStates;
    varargout{8} = data.printVectorOld;
    varargout{9} = data.plotParamsOld;
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
setPlotParams(hObject,handles);
compute_printVector(handles);
%load application data
data = getappdata(handles.figure1,'appData');

data.destroy = 0; %node should NOT be destroyed and changes be applied

n_template = get(handles.selector_dynamics, 'String');
data.template = n_template;
%data.template = data.template_list{n_template};
data.nodelabel = get(handles.edit_label, 'String');
handles.nodelabel = get(handles.edit_label, 'String');
data.neighbours = get(handles.connections, 'String');

setappdata(handles.figure1,'appData',data);

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
data = getappdata(handles.figure1,'appData');
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
%check if string is scalar
if length( num2str(get(hObject,'String')) ) > 1
    %error
end
% check if internal states and chosen internal states to plot is
% consistent, resetting intStates if not
%{
display(['@edit_intStates_Callback ']);
display(['String of intStates: ' get(hObject,'String') ]);
display(['Max. of intStates to plot: ' num2str( max( str2num( get(handles.edit_selectedStates,'String') ) ) ) ]);
%}
if str2double(get(hObject,'String')) < max( str2num( get(handles.edit_selectedStates,'String') ) )
    set( hObject,'String', num2str( max( str2num( get(handles.edit_selectedStates,'String') ) ) ) );
end

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
data = getappdata(handles.figure1,'appData');
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
if max( str2num( get(hObject,'String'))) > str2num( get(handles.edit_intStates,'String'))
    set(handles.edit_intStates,'String', num2str( max( str2num( get(hObject,'String') ) ) ) );
end
set(handles.checkbox2,'Value',1.0);
data=getappdata(handles.figure1,'appData');
data.flagCheck2 = 1;
setappdata(handles.figure1,'appData',data);


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
%generateDefaultPlotParams(hObject,handles);


%case distinction for different templates needed
temp = get(handles.selector_dynamics,'String');
%temp = data.template_list{n_temp,1};

switch temp;
    case 'LTI';

        setPlotParams(hObject,handles);
        data = getappdata(handles.figure1,'appData');
        %process visualization data for pp2 (eg line naming)
        if (data.flagCheck1 == 1 && data.flagCheck2 == 1) %node output and selected int. states should be plotted
            plotStates = [1 str2num(get(handles.edit_selectedStates,'String'))];
            plotString = cell(length(plotStates),1 );
            for i = 1:length(plotStates)
                if i==1
                    plotString{i} = 'Node output:';
                elseif i>1
                    plotString{i} = ['Internal state ' num2str( plotStates(i) ) ':'];
                end      
            end
            temp = pp2(data.nodenumber, plotStates,plotString,data.plotParams);
            % if the following is true, then pp2 was cancel without passing new
            % params
            if ~isempty(temp)
                data.plotParams = temp;
            end 
        elseif (data.flagCheck1 == 1 && data.flagCheck2 == 0) %only node output should be plotted
            plotString = cell(1,1);
            plotString{1} = 'Node output:';
            temp = pp2(data.nodenumber, 1,plotString,data.plotParams);
            % if the following is true, then pp2 was cancel without passing new
            % params
            if ~isempty(temp)
                data.plotParams = temp;
            end 
        elseif (data.flagCheck1 == 0 && data.flagCheck2 == 1) %only selected int. states should be plotted
            plotStates = str2num(get(handles.edit_selectedStates,'String'));
            plotString = cell(length(plotStates),1 );
            for i = 1:length(plotStates)
                plotString{i} = ['Internal state ' num2str( plotStates(i) ) ':' ];     
            end
            temp = pp2(data.nodenumber, plotStates,plotString,data.plotParams);
            % if the following is true, then pp2 was cancel without passing new
            % params
            if ~isempty(temp)
                data.plotParams = temp;
            end 
            for i = 1:length(data.plotParams)
                %because no node output should be plotted, we introduce
                % an offset in the struct, where the first struct element is empty
                data.plotParams(i+1) = data.plotParams(i);
            end
            data.plotParams(1).lineWidth = [];
            data.plotParams(1).lineStyle = [];
            data.plotParams(1).marker = [];
            data.plotParams(1).lineColor = [];
            data.plotParams(1).edgeColor = [];
            data.plotParams(1).faceColor = [];
        elseif (data.flagCheck1 == 0 && data.flagCheck2 == 0)%nothing sould be plotted => do not open pp2.m
            errordlg('There is nothing selected to plot.','Error');
            plotParams = data.plotParamsOld;
            plotParams(1).lineWidth = [];
            plotParams(1).lineStyle = [];
            plotParams(1).marker = [];
            plotParams(1).lineColor = [];
            plotParams(1).edgeColor = [];
            plotParams(1).faceColor = [];
            data.plotParams = plotParams; %minimum plotParams configuration
        end
        
    case 'kuramoto';
        % only one output state must be considered
        
        data = getappdata(handles.figure1,'appData');
        
        if get(handles.checkbox1,'Value') % just check if output should be plotted
            plotString = cell(1,1);
            plotString{1} = 'Node output';
            if ~isfield(data,{'plotParams'})
                data.plotParams = data.plotParamsOld;
            end
            
            if size(data.plotParams,2) > 1
                data.plotParams = data.plotParams(1);
            end
            
            temp = pp2(data.nodenumber, 1,plotString,data.plotParams);
            
            if ~isempty(temp)
                data.plotParams = temp;
            end
        else
            
        end
        
end

setappdata(handles.figure1,'appData',data);
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

% ---- DEBUGGING OUTPUT---------------------------------------
% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%display(['get(handles.edit_intStates,"String": ' get(handles.edit_intStates,'String') ]);

compute_printVector(handles);
data = getappdata(handles.figure1,'appData');

n_template = get(handles.selector_dynamics, 'String');
%data.template = data.template_list{n_template};
data.nodelabel = get(handles.edit_label, 'String');
handles.nodelabel = get(handles.edit_label, 'String');
data.neighbours = get(handles.connections, 'String');

assignin('base','printVector',data.printVector);
assignin('base','plotParamsOld',data.plotParamsOld);
if isfield(data,{'plotParams'})
   assignin('base','plotParams',data.plotParams); 
end

%display(['get(handles.selector_dynamics: ' num2str(n_template) ]);
%display(['data.template: ' data.template]);
%display(['data.template_list: ' data.template_list ]);
%display(['data.nodelabel: ' data.nodelabel ]);
%assignin('base','data',data);
checkPlotParams(handles);
 
% -- check for the same number of states to plot and number of plot
% parameters
function [argout] = checkPlotParams (handles)
data = getappdata(handles.figure1,'appData');
% number of states
nrOfStates = str2double( get(handles.edit_intStates,'String') );
% number of sets of plot params
if isfield(data,{'plotParams'})
    nrOfPlotParams = length( data.plotParams );
    display(['Number of states to plot: ' num2str( nrOfStates ) ]);
    display(['Number of sets of plot params: ' num2str( nrOfPlotParams ) ]);
end

function editPlotParams(hObject, handles)
data = getappdata(handles.figure1,'appData');

%hard coded default-value => in future versions editable
auswahl = 1; %First colors according to order 'r','b','m','g','k'
             %LineStyle, LineWidth, markers always set to: '-',1.0, 'none'

nrOfPlotStates = length(find(data.printVector));
lengthPlotParams = length(data.plotParams);

colorTemplate = [[1 0 0];[0 0 1];[1 0 1];[0 1 0];[0 0 0]];
if nrOfPlotStates == 0
    data.plotParams(1).lineWidth = [];
    data.plotParams(1).lineStyle = [];
    data.plotParams(1).marker = [];
    data.plotParams(1).lineColor = [];
    data.plotParams(1).edgeColor = [];
    data.plotParams(1).faceColor = [];

elseif lengthPlotParams > nrOfPlotStates
    data.plotParams = data.plotParams(1:nrOfPlotStates);
else
    data.plotParams(1:lengthPlotParams) = data.plotParams;

    if nrOfPlotStates-lengthPlotParams > 5
        coltemp = zeros(nrOfPlotStates+lengthPlotParams,3);
        coltemp(lengthPlotParams+1:lengthPlotParams+5,:) = colorTemplate;
        for i = lengthPlotParams+6:lengthPlotParams+nrOfPlotStates
           coltemp(i,:) = [0.7*rand 0.7*rand 0.7*rand]; %a factor f < 1.0 makes each color channel darker
        end
        color = coltemp;
    else
        color = [zeros(lengthPlotParams,3)  ; colorTemplate(1:nrOfPlotStates,:)];
    end

    switch auswahl;
        case 1; 
            for i = lengthPlotParams+1:lengthPlotParams+nrOfPlotStates
                data.plotParams(i).lineWidth = '1.0';
                data.plotParams(i).lineStyle = '-';
                data.plotParams(i).marker = 'none';
                data.plotParams(i).lineColor = color(i,:);
                data.plotParams(i).edgeColor = color(i,:);
                data.plotParams(i).faceColor = color(i,:);
            end      
    end
end

setappdata(handles.figure1,'appData',data);
%guidata(hObject, handles);

function generatePlotParams(hObject,handles)
%hard coded default-value => in future versions editable
auswahl = 1; %First colors according to order 'r','b','m','g','k'
             %LineStyle, LineWidth, markers always set to: '-',1.0, 'none'
             
data = getappdata(handles.figure1,'appData');
nrOfPlotStates = length(find(data.printVector));
lengthPlotParamsOld = length(data.plotParamsOld);
             
colorTemplate = [[1 0 0];[0 0 1];[1 0 1];[0 1 0];[0 0 0]];

if nrOfPlotStates == 0
    data.plotParams(1).lineWidth = [];
    data.plotParams(1).lineStyle = [];
    data.plotParams(1).marker = [];
    data.plotParams(1).lineColor = [];
    data.plotParams(1).edgeColor = [];
    data.plotParams(1).faceColor = [];

elseif lengthPlotParamsOld > nrOfPlotStates
    data.plotParams = data.plotParamsOld(1:nrOfPlotStates);
else
    data.plotParams(1:lengthPlotParamsOld) = data.plotParamsOld;

    if nrOfPlotStates-lengthPlotParamsOld > 5
        coltemp = zeros(nrOfPlotStates+lengthPlotParamsOld,3);
        coltemp(lengthPlotParams+1:lengthPlotParamsOld+5,:) = colorTemplate;
        for i = lengthPlotParamsOld+6:lengthPlotParamsOld+nrOfPlotStates
           coltemp(i,:) = [0.7*rand 0.7*rand 0.7*rand]; %a factor f < 1.0 makes each color channel darker
        end
        color = coltemp;
    else
        color = [zeros(lengthPlotParamsOld,3)  ; colorTemplate(1:nrOfPlotStates-lengthPlotParamsOld,:)];
    end

    switch auswahl;
        case 1; 
            for i = lengthPlotParamsOld+1:nrOfPlotStates
                data.plotParams(i).lineWidth = '1.0';
                data.plotParams(i).lineStyle = '-';
                data.plotParams(i).marker = 'none';
                data.plotParams(i).lineColor = color(i,:);
                data.plotParams(i).edgeColor = color(i,:);
                data.plotParams(i).faceColor = color(i,:);
            end      
    end
end

setappdata(handles.figure1,'appData',data);


function compute_printVector(handles)
%TODO: case distinction for templates with only one internal state
data = getappdata(handles.figure1,'appData');

%Get number of internal states
data.intStates = str2num(get(handles.edit_intStates,'String'));

%Set length of printVector, depending on number of internal states
%ATTENTION: value of intStates must be an integer and of the minimum of 1!
%display(['@button_edit_node: number of intStates: ' num2str(data.intStates) ]);
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

if data.flagCheck2 && strcmp(data.template,'LTI') %check is needed, because at the moment, only the LTI template
    %can provide more than one internal state
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

function setPlotParams(hObject,handles)
compute_printVector(handles);
data = getappdata(handles.figure1,'appData');
nrOfPlotStates = length(find(data.printVector));

%consider the following cases:

%no change to printVector (compared to printVectorOld)
%--- use plotParamsOld
if ( length(data.printVectorOld) == length(data.printVector ) &&  all(data.printVectorOld == data.printVector))
    choice = 1;

%change to printVector AND plotParams does not exist => no input has been created yet
%--- generate default plotParams
elseif ( isfield(data,{'plotParams'}) == 0 )
    choice = 2;

%change to printVector, but nrOfPlotStates hasn't changed
%--- use plotParams
elseif ( ( isfield(data,{'plotParams'} ) ~= 0 ) && ( nrOfPlotStates == length(data.plotParams) ) )
    choice = 3;

%change to printVector AND nrOfPlotStates has changed, plotParams must
%exist
%--- edit plotParams
elseif ( isfield(data,{'plotParams'} ) ~= 0 )
    choice = 4;

%default case: generate default plotParams
else
    choice = 2;
end


switch choice
    case 1;
        if isfield(data,{'plotParams'}) == 0
            data.plotParams = data.plotParamsOld;
        end
    case 2;
        generatePlotParams(hObject,handles);
        data = getappdata(handles.figure1,'appData');
    case 3;
        %do nothing
    case 4;
        editPlotParams(hObject, handles);
        data = getappdata(handles.figure1,'appData');
end

setappdata(handles.figure1,'appData',data);


% --- Executes on button press in push_editParams.
function push_editParams_Callback(hObject, eventdata, handles)
% hObject    handle to push_editParams (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = getappdata(handles.figure1,'appData');
try
    newTemplate = edit_paramValues(data.template);
    flagOkay = 1;
catch
    flagOkay = 0;
end
if flagOkay
    data.template = newTemplate;
end

% --- Executes on button press in push_consistency.
function push_consistency_Callback(hObject, eventdata, handles) %#ok<*INUSL>
% hObject    handle to push_consistency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = getappdata(handles.figure1,'appData');
[isCorrect error]=checkNodeInput(data.nodenumber,data.matrix,data.template);
if ~isCorrect
    errStrg = [];
    for kk = 1:length( error.DimMismatch )
        errStrg = [errStrg ', ' error.DimMismatch{kk}];
    end
    errStrg = errStrg(3:end);
    disp(['For node ' num2str(data.nodenumber) ': Input variable(s) "' errStrg '" has (have) not correct dimension(s).']);
else
    disp(['For node ' num2str(data.nodenumber) ': Input variables are consistent.']);
end


%%%%%