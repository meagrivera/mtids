function varargout = setnodecolor(varargin)
% SETNODECOLOR MATLAB code for setnodecolor.fig
%      SETNODECOLOR, by itself, creates a new SETNODECOLOR or raises the existing
%      singleton*.
%
%      H = SETNODECOLOR returns the handle to a new SETNODECOLOR or the handle to
%      the existing singleton*.
%
%      SETNODECOLOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SETNODECOLOR.M with the given input arguments.
%
%      SETNODECOLOR('Property','Value',...) creates a new SETNODECOLOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before setnodecolor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to setnodecolor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help setnodecolor

% Last Modified by GUIDE v2.5 16-May-2012 20:56:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @setnodecolor_OpeningFcn, ...
                   'gui_OutputFcn',  @setnodecolor_OutputFcn, ...
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


% --- Executes just before setnodecolor is made visible.
function setnodecolor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to setnodecolor (see VARARGIN)

% Choose default command line output for setnodecolor
handles.output = hObject;

% read-in input arguments
handles.template_list = varargin{1};
handles.nrOfTemplates = size(handles.template_list,1);

%% Set layout parameters
rowHeight = 35; %height of each line
fixedHeight = 140; %height of figure, if no parameter is chosen
topFrame = 30;
bottomFrame = 0.5*topFrame;
sideFrame = 0.5*topFrame;
rowOffset1 = 25;

%% Geometry
screenSize = get( 0, 'ScreenSize' );

topGap = 1/12*screenSize(4);
left = screenSize(3)*0.1;
height = fixedHeight + handles.nrOfTemplates*rowHeight;
width = 500;

bottom = screenSize(4) - topGap - height;
posVector = [left bottom width height]; %do this dynamically % [left, bottom, width, height]

%% Building GUI

% setting figure parameters manually
set(gcf,'Units','pixels');
set(gcf,'Position',posVector,'Name',['Set Color for Templates'],'Toolbar','none','MenuBar','none');
defaultBackground = get(0,'defaultUicontrolBackgroundColor');
set(gcf,'Color',defaultBackground);

% parameters for panel, in which all other control elements are positioned
posVectorPanel = [sideFrame bottomFrame width-2*sideFrame height-topFrame]; % [left, bottom, width, height]
ph = uipanel('Parent',gcf,'Title','Color Settings',...
        'Units','pixel','Position',posVectorPanel);

% parameters for pushbutton "submit"
posVectorSubmitButton = [0.15*width 1.8*bottomFrame 140 35];
set(handles.pushbutton1,'Units','pixels','Position',posVectorSubmitButton,...
    'String','Submit Color(s)');

% parameters for pushbutton "cancel"
posVectorCancelButton = [0.55*width 1.8*bottomFrame 140 35];
set(handles.pushbutton2,'Units','pixels','String','Cancel',...
                'Position',posVectorCancelButton);    
  
% setting the text for the columns
posVectorTextTemplateName = [60 height-2.5*topFrame 100 rowHeight];% [left, bottom, width, height]
legendH1 = uicontrol(hObject,'Style','text','String','Template name:',...
                'Position',posVectorTextTemplateName);
posVectorTextNodeFaceColor = [180 height-2.5*topFrame 100 rowHeight];
legendH2 = uicontrol(hObject,'Style','text','String','Node face color:',...
                'Position',posVectorTextNodeFaceColor);         
posVectorTextNodeEdgeColor = [300 height-2.5*topFrame 100 rowHeight];
legendH3 = uicontrol(hObject,'Style','text','String','Node edge color:',...
                'Position',posVectorTextNodeEdgeColor);            

% setting the elements for each row, depending on how many states are to
% plot
if handles.nrOfTemplates > 0
    handles.rowName = zeros(handles.nrOfTemplates,1); %handles text box 1

    for i = 1:handles.nrOfTemplates
        %Label "template name"
        posVectorSth1 = [ 1.3*rowOffset1 height-2.2*topFrame-i*rowHeight 120 rowHeight];
        handles.rowName(i) = uicontrol(hObject,'Style','text','String',...
            handles.template_list{i,1},'Position',posVectorSth1);        
        % button for node face color
        posVectorSth2 = posVectorSth1 + [1.5*posVectorSth1(3) 14 -70 -10]; % [left, bottom, width, height]
        handles.colorButton1(i) = uicontrol(hObject,'Style','Push Button',...
            'Units','pixels','Position',posVectorSth2,'BackgroundColor',[0 0 1],...
            'Tag', ['handles.colorButton1(' num2str(i) ')']);
        % button for node edge color
        posVectorSth3 = posVectorSth2 + [2.2*posVectorSth2(3) 0 0 0]; % [left, bottom, width, height]
        handles.colorButton2(i) = uicontrol(hObject,'Style','Push Button',...
            'Units','pixels','Position',posVectorSth3,'BackgroundColor',[0 0 1],...
            'Tag', ['handles.colorButton2(' num2str(i) ')']);
        
    end
end
            
guidata(hObject, handles);

for i = 1:handles.nrOfTemplates
    %show old plot params and pass callback function to color buttons
    set(handles.colorButton1(i),'BackgroundColor',handles.template_list{i,2},...
        'Callback',{@color_setting_Callback,handles});
    set(handles.colorButton2(i),'BackgroundColor',handles.template_list{i,3},...
        'Callback',{@color_setting_Callback,handles});
end

            
guidata(hObject, handles);
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = setnodecolor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
% varargout{1} = handles.output;

for i = 1:handles.nrOfTemplates
    handles.template_list{i,2} = get(handles.colorButton1(i),'BackgroundColor');
    handles.template_list{i,3} = get(handles.colorButton2(i),'BackgroundColor');    
end

% data should be applied
if handles.OutputFlag == 2
    varargout{1} = handles.template_list;
% data should NOT be applied ('button' cancel or 'closerequest' was prompted    
elseif handles.OutputFlag == 1
    varargout{1} = [];
end
delete(hObject);


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.OutputFlag = 2;
guidata(hObject, handles);
uiresume(handles.figure1);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.OutputFlag = 1;
guidata(hObject, handles);
uiresume(handles.figure1);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
handles.OutputFlag = 1;
guidata(hObject, handles);
uiresume(handles.figure1);

% Opens a color setting dialog and passes the color to the invoking object
function color_setting_Callback(hObject, eventdata, handles)
C = uisetcolor(get(hObject,'BackgroundColor'));
set(hObject,'BackgroundColor',C);
