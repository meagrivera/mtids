function varargout = pp2(varargin)
% PP2 MATLAB code for pp2.fig
%      PP2, by itself, creates a new PP2 or raises the existing
%      singleton*.
%
%      H = PP2 returns the handle to a new PP2 or the handle to
%      the existing singleton*.
%
%      PP2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PP2.M with the given input arguments.
%
%      PP2('Property','Value',...) creates a new PP2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pp2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pp2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pp2

% Last Modified by GUIDE v2.5 25-Apr-2012 11:50:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pp2_OpeningFcn, ...
                   'gui_OutputFcn',  @pp2_OutputFcn, ...
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


% --- Executes just before pp2 is made visible.
function pp2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pp2 (see VARARGIN)

% Choose default command line output for pp2
handles(1).output = hObject;

defaultBackground = get(0,'defaultUicontrolBackgroundColor');
set(gcf,'Color',defaultBackground);

%Initializing
nodenumber = varargin{1};
plotStates = varargin{2};
plotString = varargin{3};
oldParams = varargin{4};
handles(1).nrOfPlotStates = length(plotStates);

if handles(1).nrOfPlotStates ~= length(oldParams)
    display(['ERROR - nrOfPlotStates and length(oldParams) must be equal!']);
end

%DEBUGGING
%{
display(['Nodenumber: ' num2str(nodenumber) ]);
display(['Plot state vector: ' num2str(plotStates) ]);
display(['Number of states to plot: ' num2str(handles.nrOfPlotStates) ]);
%}

%% Outputstrings
handles(1).lineWidthVector = {'0.2','0.4','0.6','0.8','1.0','1.2','1.4','1.6','1.8','2.0',...
                '2.2','2.4','2.6','2.8','3.0','3.2','3.4','3.6','3.8','4.0'};
handles(1).lineStyleVector = {'-','--',':','-.','none'};
handles(1).markerVector = {'+','o','*','.','x','s','d','^','v','>','<','p','h','none'};
handles(1).colorVector = {'r','g','b','c','m','y','k','w'};
%%

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
height = fixedHeight + handles(1).nrOfPlotStates*rowHeight;

if screenSize(3)*0.9 > 760
    width = 760;
else
    width = screenSize(3)*0.85;
end

bottom = screenSize(4) - topGap - height;
posVector = [left bottom width height]; %do this dynamically % [left, bottom, width, height]

%% Building GUI

% setting figure parameters manually
set(gcf,'Units','pixels');
set(gcf,'Position',posVector,'Name',['Plot Parameters for node ' num2str( nodenumber ) ],'Toolbar','none','MenuBar','none');
defaultBackground = get(0,'defaultUicontrolBackgroundColor');
set(gcf,'Color',defaultBackground);

% parameters for panel, in which all other control elements are positioned
posVectorPanel = [sideFrame bottomFrame width-2*sideFrame height-topFrame]; % [left, bottom, width, height]
ph = uipanel('Parent',gcf,'Title','Choose plot parameters',...
        'Units','pixel','Position',posVectorPanel);

% parameters for pushbutton "submit"
posVectorSubmitButton = [0.15*width 1.7*bottomFrame 140 35];
set(handles(1).pushbutton1,'Units','pixels','Position',posVectorSubmitButton,...
    'String','Submit Parameters');

posVectorCancelButton = [0.55*width 1.7*bottomFrame 140 35];
set(handles(1).pushbutton2,'Units','pixels','String','Cancel',...
                'Position',posVectorCancelButton);

%DEBUGGING
%{
positionText1 = get(handles.text1,'Position');
set(handles.text1,'Position',[positionText1(1)+10 positionText1(2) positionText1(3) positionText1(4)]);
f=get(gcf,'Position');
set(handles.text1,'String',['Nodenumber:' num2str(nodenumber) ' States to plot:' plotStates]);
%}

% setting the text for the columns
posVectorTextLineWidth = [66 height-2.5*topFrame 90 rowHeight] + [60 0 0 0];
legendH1 = uicontrol(hObject,'Style','text','String','Line Width:',...
                'Position',posVectorTextLineWidth);
posVectorTextLineStyle = [154 height-2.5*topFrame 90 rowHeight] + [60 0 0 0];
legendH2 = uicontrol(hObject,'Style','text','String','Line Style:',...
                'Position',posVectorTextLineStyle);
posVectorTextMarkerStyle = [245 height-2.5*topFrame 90 rowHeight] + [60 0 0 0];
legendH3 = uicontrol(hObject,'Style','text','String','Marker Style:',...
                'Position',posVectorTextMarkerStyle);
posVectorTextColor = [343 height-2.5*topFrame 80 rowHeight] + [60 0 0 0];
legendH4 = uicontrol(hObject,'Style','text','String','Line Color:',...
                'Position',posVectorTextColor);
posVectorTextMarkerEdgeColor = [430 height-2.5*topFrame 120 rowHeight] + [60 0 0 0];
legendH5 = uicontrol(hObject,'Style','text','String','Marker Edge Color:',...
                'Position',posVectorTextMarkerEdgeColor);
posVectorTextMarkerFaceColor = [560 height-2.5*topFrame 120 rowHeight] + [60 0 0 0];
legendH5 = uicontrol(hObject,'Style','text','String','Marker Face Color:',...
                'Position',posVectorTextMarkerFaceColor);

% setting the elements for each row, depending on how many states are to
% plot
if handles(1).nrOfPlotStates > 0
    sth1 = zeros(handles(1).nrOfPlotStates,1); %handles text box 1

    for i = 1:handles(1).nrOfPlotStates
        %Label State
        posVectorSth1 = [rowOffset1 height-2.2*topFrame-i*rowHeight 120 rowHeight];
        sth1(i) = uicontrol(hObject,'Style','text','String',...
            plotString{i},'Position',posVectorSth1);
        %PopUp-Menu for LineWidth
        posVectorSh = [rowOffset1+posVectorSth1(3) height-1.38*topFrame-i*rowHeight 50 0.40*rowHeight];
        handles(i).pmh1 = uicontrol(hObject,'Style','popupmenu',...
                'String',handles(1).lineWidthVector,...
                'Value',5,'Position',posVectorSh);
        %PopUp-Menu for LineStyle
        posVectorSth2 = posVectorSh + [1.65*posVectorSh(3) 0 10 0];
        handles(i).pmh2 = uicontrol(hObject,'Style','popupmenu',...
                'String',handles(1).lineStyleVector,...
                'Value',1,'Position',posVectorSth2);
        %PopUp-Menu for Marker
        posVectorSth3 = posVectorSth2 + [1.5*posVectorSth2(3) 0 0 0];
        handles(i).pmh3 = uicontrol(hObject,'Style','popupmenu',...
                'String',handles(1).markerVector,...
                'Value',14,'Position',posVectorSth3);
        %PopUp-Menu for Line Color
        posVectorSth4 = posVectorSth3 + [1.7*posVectorSth3(3) -12 -15 15]; % [left, bottom, width, height]
        handles(i).pmh4 = uicontrol(hObject,'Style','Push Button',...
            'Units','pixels','Position',posVectorSth4,'BackgroundColor',[0 0 1], 'Tag', ['handles(' num2str(i) ').pmh4']);
        %set(handles(i).pmh4,'Callback',{@color_setting_Callback});
        %handles.pmh4(i) = uicontrol(hObject,'Style','popupmenu',...
        %        'String',handles.colorVector,...
        %        'Value',1,'Position',posVectorSth4);
        %PopUp-Menu for Marker Edge Color
        posVectorSth5 = posVectorSth4 + [2.4*posVectorSth4(3) 0 0 0];
        handles(i).pmh5 = uicontrol(hObject,'Style','Push Button',...
            'Units','pixels','Position',posVectorSth5,'BackgroundColor',[0 0 1],'Tag', ['handles(' num2str(i) ').pmh5']);
        %set(handles(i).pmh5,'Callback',{@color_setting_Callback});
        %handles.pmh5(i) = uicontrol(hObject,'Style','popupmenu',...
        %        'String',handles.colorVector,...
        %        'Value',1,'Position',posVectorSth5);
        %PopUp-Menu for Marker Edge Color
        posVectorSth6 = posVectorSth5 + [2.7*posVectorSth5(3) 0 0 0];
        handles(i).pmh6 = uicontrol(hObject,'Style','Push Button',...
            'Units','pixels','Position',posVectorSth6,'BackgroundColor',[0 0 1],'Tag', ['handles(' num2str(i) ').pmh6']);
        %set(handles(i).pmh6,'Callback',{@color_setting_Callback});
        %handles.pmh6(i) = uicontrol(hObject,'Style','popupmenu',...
        %        'String',handles.colorVector,...
        %        'Value',1,'Position',posVectorSth6);
    end
end

guidata(hObject, handles);

for i = 1:handles(1).nrOfPlotStates
    set(handles(i).pmh4,'Callback',{@color_setting_Callback,handles});
    set(handles(i).pmh5,'Callback',{@color_setting_Callback,handles});
    set(handles(i).pmh6,'Callback',{@color_setting_Callback,handles});
    %show old plot params
    set(handles(i).pmh1,'Value',find( strcmp( handles(1).lineWidthVector, oldParams(i).lineWidth) ) );
    set(handles(i).pmh2,'Value',find( strcmp( handles(1).lineStyleVector, oldParams(i).lineStyle) ) );
    set(handles(i).pmh3,'Value', find( strcmp( handles(1).markerVector, oldParams(i).marker )  ) );
    set(handles(i).pmh4,'BackgroundColor',oldParams(i).lineColor);
    set(handles(i).pmh5,'BackgroundColor',oldParams(i).edgeColor);
    set(handles(i).pmh6,'BackgroundColor',oldParams(i).faceColor);
end


guidata(hObject, handles);

% UIWAIT makes pp2 wait for user response (see UIRESUME)
uiwait(handles(1).figure1);


% --- Outputs from this function are returned to the command line.
function varargout = pp2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


for i = 1:handles(1).nrOfPlotStates
    params(i).lineWidth = handles(1).lineWidthVector{get(handles(i).pmh1,'Value')};
    params(i).lineStyle = handles(1).lineStyleVector{get(handles(i).pmh2,'Value')};
    params(i).marker = handles(1).markerVector{get(handles(i).pmh3,'Value')};
    params(i).lineColor = get(handles(i).pmh4,'BackgroundColor');
    %handles.colorVector{get(handles.pmh4(i),'Value')};
    params(i).edgeColor = get(handles(i).pmh5,'BackgroundColor');
    params(i).faceColor = get(handles(i).pmh6,'BackgroundColor');
end


%DEBUGGING
%{
display([params]);
%}

% data should be applied to current node
if handles(1).OutputFlag == 2
    %varargout{1} = handles.output;
    varargout{1} = params;
% data should NOT be applied ('button' cancel or 'closerequest' was prompted    
elseif handles(1).OutputFlag == 1
    %varargout{1} = handles.output;
    varargout{1} = [];
end

delete(hObject);


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%for debugging
%set(handles.text1,'String',f);
% indictates, that the prompted data should be applied
handles(1).OutputFlag = 2;
guidata(hObject, handles);
uiresume(handles(1).figure1);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: delete(hObject) closes the figure
handles(1).OutputFlag = 1;
guidata(hObject, handles);
uiresume(handles(1).figure1);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles(1).OutputFlag = 1;
guidata(hObject, handles);
uiresume(handles(1).figure1);

% Opens a color setting dialog and passes the color to the invoking object
function color_setting_Callback(hObject, eventdata, handles)
C = uisetcolor(get(hObject,'BackgroundColor'));
set(hObject,'BackgroundColor',C);

%if color was chosen for lineColor, marker and markerface color should be
%set to same value
%display(['Tag of envoking object: ' get(hObject,'Tag') ]);
%determine line number
tmpstr = get(hObject,'Tag');

% THIS SOLUTION WORKS ONLY IF THERE ARE LESS THAN 10 STATES TO PLOT!!!
ln = str2double(tmpstr(9));
pmh = str2double(tmpstr(15));
%display(['ln = ' num2str(ln) ]);
%display(['pmh = ' num2str(pmh) ]);

%determine if color was set for linecolor
if pmh == 4
   eval( ['set(handles(' num2str(ln) ').pmh5,' char(39) 'BackgroundColor' char(39) ',C)'] );
   eval( ['set(handles(' num2str(ln) ').pmh6,' char(39) 'BackgroundColor' char(39) ',C)'] ); 
end

%guidata(hObject, handles);



%%%
