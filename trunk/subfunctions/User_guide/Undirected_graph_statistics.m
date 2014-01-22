function varargout = Undirected_graph_statistics(varargin)
%UNDIRECTED_GRAPH_STATISTICS M-file for Undirected_graph_statistics.fig
%      UNDIRECTED_GRAPH_STATISTICS by itself, creates a new UNDIRECTED_GRAPH_STATISTICS or raises the
%      existing singleton*.
%
%      H = UNDIRECTED_GRAPH_STATISTICS returns the handle to a new UNDIRECTED_GRAPH_STATISTICS or the handle to
%      the existing singleton*.
%
%      UNDIRECTED_GRAPH_STATISTICS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNDIRECTED_GRAPH_STATISTICS.M with the given input arguments.
%
%      UNDIRECTED_GRAPH_STATISTICS('Property','Value',...) creates a new UNDIRECTED_GRAPH_STATISTICS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Undirected_graph_statistics_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Undirected_graph_statistics_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
%
% Authors: Francisco Llobet, Jose Rivera
% Editor: Ferdinand Trommsdorff (f.trommsdorff@gmail.com)
% Project: MTIDS (http://code.google.com/p/mtids/)

% Last Modified by GUIDE v2.5 19-Jan-2014 22:43:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Undirected_graph_statistics_OpeningFcn, ...
                   'gui_OutputFcn',  @Undirected_graph_statistics_OutputFcn, ...
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

% --- Executes just before Undirected_graph_statistics is made visible.
function Undirected_graph_statistics_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Undirected_graph_statistics (see VARARGIN)
% Choose default command line output for Undirected_graph_statistics
handles.output = 'Yes';
% Update handles structure
guidata(hObject, handles);
% Insert custom Title and Text if specified by the user
% Hint: when choosing keywords, be sure they are not easily confused 
% with existing figure properties.  See the output of set(figure) for
% a list of figure properties.
if(nargin > 3)
    for index = 1:2:(nargin-3),
        if nargin-3==index, break, end
        switch lower(varargin{index})
         case 'title'
          set(hObject, 'Name', varargin{index+1});
         case 'string'
          set(handles.text1, 'String', varargin{index+1});
        end
    end
end
% Determine the position of the dialog - centered on the callback figure
% if available, else, centered on the screen
FigPos=get(0,'DefaultFigurePosition');
OldUnits = get(hObject, 'Units');
set(hObject, 'Units', 'pixels');
OldPos = get(hObject,'Position');
FigWidth = OldPos(3);
FigHeight = OldPos(4);
if isempty(gcbf)
    ScreenUnits=get(0,'Units');
    set(0,'Units','pixels');
    ScreenSize=get(0,'ScreenSize');
    set(0,'Units',ScreenUnits);
    FigPos(1)=1/2*(ScreenSize(3)-FigWidth);
    FigPos(2)=2/3*(ScreenSize(4)-FigHeight);
else
    GCBFOldUnits = get(gcbf,'Units');
    set(gcbf,'Units','pixels');
    GCBFPos = get(gcbf,'Position');
    set(gcbf,'Units',GCBFOldUnits);
    FigPos(1:2) = [(GCBFPos(1) + GCBFPos(3) / 2) - FigWidth / 2, ...
                   (GCBFPos(2) + GCBFPos(4) / 2) - FigHeight / 2];
end
FigPos(3:4)=[FigWidth FigHeight];
set(hObject, 'Position', FigPos);
set(hObject, 'Units', OldUnits);

% Show a question icon from dialogicons.mat - variables questIconData
% and questIconMap
load dialogicons.mat
% IconData=questIconData;
questIconMap(256,:) = get(handles.figure1, 'Color');
IconCMap=questIconMap;
MTIDSLogo = imread('mtidslogo.png');;
Img=image(MTIDSLogo);
set(handles.figure1, 'Colormap', IconCMap);
set(handles.axes1, ...
    'Visible', 'off', ...
    'YDir'   , 'reverse'       , ...
    'XLim'   , get(Img,'XData'), ...
    'YLim'   , get(Img,'YData')  ...
    );
% Make the GUI modal
set(handles.figure1,'WindowStyle','modal')
% UIWAIT makes Undirected_graph_statistics wait for user response (see UIRESUME)
uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = Undirected_graph_statistics_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;
% The figure can be deleted now
delete(handles.figure1);

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = get(hObject,'String');
% Update handles structure
guidata(hObject, handles);
% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.figure1);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = get(hObject,'String');
% Update handles structure
guidata(hObject, handles);
% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.figure1);

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isequal(get(hObject, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    uiresume(hObject);
else
    % The GUI is no longer waiting, just close it
    delete(hObject);
end


% --- Executes on key press over figure1 with no controls selected.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Check for "enter" or "escape"
if isequal(get(hObject,'CurrentKey'),'escape')
    % User said no by hitting escape
    handles.output = 'No';
    % Update handles structure
    guidata(hObject, handles);
    uiresume(handles.figure1);
end    
if isequal(get(hObject,'CurrentKey'),'return')
    uiresume(handles.figure1);
end    


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
User_guide_4();


% handles.output = get(hObject,'String');
% % Update handles structure
% guidata(hObject, handles);
% % Use UIRESUME instead of delete because the OutputFcn needs
% % to get the updated handles structure.
% uiresume(handles.figure1);



% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in Nodes.
function Nodes_Callback(hObject, eventdata, handles)
% hObject    handle to Nodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese größer als eins ist wird der Text von der vorherigen Funktion gelöscht. 
delete(h1);     %Variablen löschen bzw. Text oder Figure aus .fig Datei löschen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochzählen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'\underline{Nodes:}\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'The number of nodes that are given in the actual graph.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 520],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 480],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h8=text(0,0.5,'' ,'interpreter' ,'latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 440],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 400],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h10=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 360],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h11=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 320],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure. 
h12=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


axes('units','pixels','position',[40 110 30 280],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h13=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 240],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h14=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[290 110 30 170],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 160],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h16=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 120],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h17=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 80],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[210 110 260 360],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 

% --- Executes on button press in Connections.
function Connections_Callback(hObject, eventdata, handles)
% hObject    handle to Connections (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese größer als eins ist wird der Text von der vorherigen Funktion gelöscht. 
delete(h1);     %Variablen löschen bzw. Text oder Figure aus .fig Datei löschen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochzählen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'\underline{Connections:}\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'The number of connections (edges) between the nodes of the actual graph. If a node has no edges, it can be  ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'considered as a subgraph.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 520],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 480],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h8=text(0,0.5,'' ,'interpreter' ,'latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 440],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 400],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h10=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 360],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h11=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 320],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure. 
h12=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


axes('units','pixels','position',[40 110 30 280],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h13=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 240],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h14=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[290 110 30 170],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 160],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h16=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 120],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h17=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 80],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[210 110 260 360],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 

% --- Executes on button press in Independent_Graphs.
function Independent_Graphs_Callback(hObject, eventdata, handles)
% hObject    handle to Independent_Graphs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese größer als eins ist wird der Text von der vorherigen Funktion gelöscht. 
delete(h1);     %Variablen löschen bzw. Text oder Figure aus .fig Datei löschen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochzählen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'\underline{Independent Graphs}\\:','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'The number of independent subgraphs that are not connected to each other.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 520],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 480],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h8=text(0,0.5,'' ,'interpreter' ,'latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 440],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 400],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h10=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 360],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h11=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 320],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure. 
h12=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


axes('units','pixels','position',[40 110 30 280],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h13=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[270 110 30 210],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h14=text(0,0.5,'Undirected graph example','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 170],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 160],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h16=text(0,0.5,'In this example the nodes one and two form a subgraph and the nodes three and four form a subgraph. So there are ' ,'interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 120],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h17=text(0,0.5,'two independent subgraphs.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 80],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[250 110 180 410],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('IndependentGraph.png'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 

% --- Executes on button press in Avarage_clustering_coefficient.
function Avarage_clustering_coefficient_Callback(hObject, eventdata, handles)
% hObject    handle to Avarage_clustering_coefficient (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese größer als eins ist wird der Text von der vorherigen Funktion gelöscht. 
delete(h1);     %Variablen löschen bzw. Text oder Figure aus .fig Datei löschen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochzählen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'\underline{Average clustering coefficient:}\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'The average clustering coefficient is the number of all existing triangles divided by the number of all possible triangles. ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'A triangle is a circle with three nodes. In directed graphs, three nodes generate up to eight triangles (2*2*2 edges), ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 520],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'because every node be connected to another node in two directions.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 480],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h8=text(0,0.5,'To get the clustering vector the number of triangles are computed for every node and ' ,'interpreter' ,'latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 440],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h9=text(0,0.5,'put in a column vector. This means vector for the graph above is $ [8,0,8,8]^T $, ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%F
axes('units','pixels','position',[40 110 30 400],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h10=text(0,0.5,'because the node two is not an element of a triangle. For calculating the maximal ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 360],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h11=text(0,0.5,'possible number of triangles for every node, the number of all input and output edges ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 320],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure. 
h12=text(0,0.5,'are summed up in a degree vector $ [4,2,6,4]^T $. Since the node two is not element of a ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


axes('units','pixels','position',[40 110 30 280],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h13=text(0,0.5,'triangle the second entry is set to $ \infty $. After computing the maximal number of','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 240],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h14=text(0,0.5,'triangles for all pairs of nodes and subtracting wrong pairs the resulting  For  ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 200],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'calculating vector is $ [8,\infty,24,8]^T $. So the vector of the clustering coefficients looks   ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 160],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h16=text(0,0.5,'like $ [1,0,0.333,0]^T $. The average clustering coefficient is the mean value of the vector. ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 120],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h17=text(0,0.5,'In this example the average clustering coefficient is $ 0.583 $.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[565 110 30 180],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'Undirected graph example ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[560 110 160 370],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('Avarage_clustering.png'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 

% --- Executes on button press in Graph_density.
function Graph_density_Callback(hObject, eventdata, handles)
% hObject    handle to Graph_density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese größer als eins ist wird der Text von der vorherigen Funktion gelöscht. 
delete(h1);     %Variablen löschen bzw. Text oder Figure aus .fig Datei löschen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochzählen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'\underline{Graph density}\\:','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'The graph density is computed as follows:\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[270 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'graph density = mean(degree vector)/(dim(L)-1)','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 520],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'The graph density is the mean of the degree of every node divided by the number of nodes minus one. The degree of a ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 480],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h8=text(0,0.5,'node is the number of edges that are connected to the node. The Degree Matrix $ D $ contains the degrees of the nodes.\\' ,'interpreter' ,'latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 440],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 400],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h10=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 360],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h11=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 320],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure. 
h12=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


axes('units','pixels','position',[40 110 30 280],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h13=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 240],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h14=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[290 110 30 170],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 160],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h16=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 120],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h17=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 80],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[210 110 260 360],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 

% --- Executes on button press in Graph_heterogeneity.
function Graph_heterogeneity_Callback(hObject, eventdata, handles)
% hObject    handle to Graph_heterogeneity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese größer als eins ist wird der Text von der vorherigen Funktion gelöscht. 
delete(h1);     %Variablen löschen bzw. Text oder Figure aus .fig Datei löschen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochzählen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'\underline{Graph heterogeneity}\\:','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 460],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'The graph heterogeneity is the standard deviation divided by the mean of the degree vector. It says how much the ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 420],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'number of connections differs from node to node. The degree vector is extracted from the Degree Matrix $ D $ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 380],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'mentioned in the chapter one.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 480],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h8=text(0,0.5,'' ,'interpreter' ,'latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 440],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 400],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h10=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 360],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h11=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 320],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure. 
h12=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


axes('units','pixels','position',[40 110 30 280],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h13=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 240],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h14=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[290 110 30 170],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 160],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h16=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 120],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h17=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 80],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[210 110 360 560],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('graph_heterogentiy.png'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Algebraic_connectivity.
function Algebraic_connectivity_Callback(hObject, eventdata, handles)
% hObject    handle to Algebraic_connectivity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese größer als eins ist wird der Text von der vorherigen Funktion gelöscht. 
delete(h1);     %Variablen löschen bzw. Text oder Figure aus .fig Datei löschen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochzählen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'\underline{Algebraic connectivity:}\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'The algebraic connectivity of a graph G is the second-smallest eigenvalue of the Laplacian matrix of G. This ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'eigenvalue is greater than zero if and only if G is a connected graph. This is a corollary to the fact that the number   ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 520],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'of times zero appears as an eigenvalue in the Laplacian matrix is the number of connected components in the graph. ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 480],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h8=text(0,0.5,'The magnitude of this value reflects how well connected the overall graph is, and has been used in analyzing the ' ,'interpreter' ,'latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 440],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h9=text(0,0.5,'robustness and the ability of synchronization of networks.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 400],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h10=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 360],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h11=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 320],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure. 
h12=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


axes('units','pixels','position',[40 110 30 280],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h13=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 240],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h14=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[290 110 30 170],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 160],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h16=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 120],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h17=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 80],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[210 110 260 360],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Rooted_spanning_tree.
function Rooted_spanning_tree_Callback(hObject, eventdata, handles)
% hObject    handle to Rooted_spanning_tree (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese größer als eins ist wird der Text von der vorherigen Funktion gelöscht. 
delete(h1);     %Variablen löschen bzw. Text oder Figure aus .fig Datei löschen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochzählen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'\underline{Rooted Spanning Tree}\\:','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'This field says "Yes" if the graph can be built as a rooted spanning tree. Otherwise it says "No". As you can see in ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'the figure every node is connected to the root node by one or more lines. There are no circles.','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 520],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 480],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h8=text(0,0.5,'' ,'interpreter' ,'latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 440],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 400],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h10=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 360],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h11=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 320],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure. 
h12=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


axes('units','pixels','position',[40 110 30 280],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h13=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 240],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h14=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[290 110 30 170],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'Rooted spanning tree','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 160],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h16=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 120],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h17=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 80],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[210 110 260 360],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('rootedspanningtree.png'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 



% --- Executes on button press in Minimum_degree.
function Minimum_degree_Callback(hObject, eventdata, handles)
% hObject    handle to Minimum_degree (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese größer als eins ist wird der Text von der vorherigen Funktion gelöscht. 
delete(h1);     %Variablen löschen bzw. Text oder Figure aus .fig Datei löschen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochzählen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'\underline{Minimum degree:}\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[300 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'degree vector = diag(L) ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'The degree vector contains the diagonal elements of the \textit{laplacian matrix} or the \textit{degree matrix}. ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 520],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'These elements are the degrees of the nodes, which means the number of edges which leave or arrive in one node.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 480],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h8=text(0,0.5,'The minimum degree shows the smallest degree of all nodes.\\' ,'interpreter' ,'latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 440],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 400],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h10=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 360],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h11=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 320],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure. 
h12=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


axes('units','pixels','position',[40 110 30 280],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h13=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 240],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h14=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 200],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 160],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h16=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 120],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h17=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 80],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[10 110 700 400],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Maximum_degree.
function Maximum_degree_Callback(hObject, eventdata, handles)
% hObject    handle to Maximum_degree (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese größer als eins ist wird der Text von der vorherigen Funktion gelöscht. 
delete(h1);     %Variablen löschen bzw. Text oder Figure aus .fig Datei löschen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochzählen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'\underline{Maximum degree:}\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'The maximum degree is the highest value of all degrees of the nodes. This means the biggest number of edges one  ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'node in the graph is connected to.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 520],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 480],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h8=text(0,0.5,'' ,'interpreter' ,'latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 440],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 400],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h10=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 360],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h11=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 320],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure. 
h12=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


axes('units','pixels','position',[40 110 30 280],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h13=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 240],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h14=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 200],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 160],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h16=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 120],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h17=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 80],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[10 110 700 400],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Avarage_degree.
function Avarage_degree_Callback(hObject, eventdata, handles)
% hObject    handle to Avarage_degree (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese größer als eins ist wird der Text von der vorherigen Funktion gelöscht. 
delete(h1);     %Variablen löschen bzw. Text oder Figure aus .fig Datei löschen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochzählen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'\underline{Average degree:}\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'The average degree sums up the degrees of all nodes and divides it by the number of nodes. The degree of a node is ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'the number of edges, which are connected to the node. It stands in the \textit{degree matrix}.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 520],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 480],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h8=text(0,0.5,'' ,'interpreter' ,'latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 440],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 400],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h10=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 360],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h11=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 320],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure. 
h12=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


axes('units','pixels','position',[40 110 30 280],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h13=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 240],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h14=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 200],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 160],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h16=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 120],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h17=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 80],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[10 110 700 400],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Isoperimetric_number.
function Isoperimetric_number_Callback(hObject, eventdata, handles)
% hObject    handle to Isoperimetric_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese größer als eins ist wird der Text von der vorherigen Funktion gelöscht. 
delete(h1);     %Variablen löschen bzw. Text oder Figure aus .fig Datei löschen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochzählen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'\underline{Isoperimetric number:}\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'This number gives knowledge about the robustness and the connectivity of the graph. $S$ and $S^c$ are subgraphs and ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'$|S|$ and $|S^c|$ are the number of nodes in the subgraphs. $|\partial S|$ is the number of edges connecting the two subgraphs.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 520],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 480],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h8=text(0,0.5,'' ,'interpreter' ,'latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 440],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 360],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h10=text(0,0.5,'A small isoperimetric number means that big subgraphs are connected via a small number of edges. In the case a ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 320],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h11=text(0,0.5,'connection gets damaged it has great influence on the system. So the graph is not very robust.\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 320],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure. 
h12=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


axes('units','pixels','position',[40 110 30 280],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h13=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 240],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h14=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 200],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 160],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h16=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 120],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h17=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 80],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[170 110 360 470],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('isoperemtricnumber.png'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 






% --- Executes on button press in Median_degree.
function Median_degree_Callback(hObject, eventdata, handles)
% hObject    handle to Median_degree (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese größer als eins ist wird der Text von der vorherigen Funktion gelöscht. 
delete(h1);     %Variablen löschen bzw. Text oder Figure aus .fig Datei löschen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochzählen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'\underline{Median degree:}\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'The median degree puts every degree of a node in an increasing row. If the number of the degrees is odd, it shows ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'the value in the middle. If the number of the degrees is even, it shows the mean of two values in the middle. ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 520],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'The degree of a node can be extracted from the \textit{degree matrix}.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 480],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h8=text(0,0.5,'' ,'interpreter' ,'latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 440],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 400],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h10=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 360],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h11=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 320],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure. 
h12=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


axes('units','pixels','position',[40 110 30 280],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h13=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 240],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h14=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[290 110 30 170],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 160],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h16=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 120],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h17=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 80],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[210 110 260 360],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 




% --- Executes on button press in Avarage_path_length.
function Avarage_path_length_Callback(hObject, eventdata, handles)
% hObject    handle to Avarage_path_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese größer als eins ist wird der Text von der vorherigen Funktion gelöscht. 
delete(h1);     %Variablen löschen bzw. Text oder Figure aus .fig Datei löschen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochzählen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'\underline{Average path length:}\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'The average path length is the sum of all path length divided by the number of nodes times the number of nodes ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'minus one. The path length between two nodes is the smallest number of connections between the two nodes. If the  ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 520],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'graph contains not connected subgraphs the average path length is $ \infty $.','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 480],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h8=text(0,0.5,'' ,'interpreter' ,'latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 440],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 400],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h10=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 360],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h11=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 320],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure. 
h12=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


axes('units','pixels','position',[40 110 30 280],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h13=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 240],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h14=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 200],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 160],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h16=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 120],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h17=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 80],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[160 110 370 400],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('Avarage_path_length.png'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Show_degree_distribution.
function Show_degree_distribution_Callback(hObject, eventdata, handles)
% hObject    handle to Show_degree_distribution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese größer als eins ist wird der Text von der vorherigen Funktion gelöscht. 
delete(h1);     %Variablen löschen bzw. Text oder Figure aus .fig Datei löschen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochzählen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'\underline{Show degree distribution:}\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'The degree distribution shows the probability for a node in the graph to have a certain degree. The degrees of the ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'nodes are known from the \textit{degree matrix}. The occurrence of a certain degree is compared to the others. A big ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 520],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'number of a certain degree leads to a big probability for a node to have these certain degree.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 480],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h8=text(0,0.5,'' ,'interpreter' ,'latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 440],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 400],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h10=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 360],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h11=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 320],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure. 
h12=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


axes('units','pixels','position',[40 110 30 280],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h13=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 240],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h14=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[290 110 30 170],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 160],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h16=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 120],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h17=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 80],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[210 110 260 360],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in pushbutton34.
function pushbutton34_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton33.
function pushbutton33_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton32.
function pushbutton32_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
