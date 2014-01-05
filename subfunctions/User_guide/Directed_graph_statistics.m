function varargout = Directed_graph_statistics(varargin)
%DIRECTED_GRAPH_STATISTICS M-file for Directed_graph_statistics.fig
%      DIRECTED_GRAPH_STATISTICS by itself, creates a new DIRECTED_GRAPH_STATISTICS or raises the
%      existing singleton*.
%
%      H = DIRECTED_GRAPH_STATISTICS returns the handle to a new DIRECTED_GRAPH_STATISTICS or the handle to
%      the existing singleton*.
%
%      DIRECTED_GRAPH_STATISTICS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DIRECTED_GRAPH_STATISTICS.M with the given input arguments.
%
%      DIRECTED_GRAPH_STATISTICS('Property','Value',...) creates a new DIRECTED_GRAPH_STATISTICS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Directed_graph_statistics_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Directed_graph_statistics_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
%
% Authors: Francisco Llobet, Jose Rivera
% Editor: Ferdinand Trommsdorff (f.trommsdorff@gmail.com)
% Project: MTIDS (http://code.google.com/p/mtids/)

% Last Modified by GUIDE v2.5 04-Jan-2014 01:43:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Directed_graph_statistics_OpeningFcn, ...
                   'gui_OutputFcn',  @Directed_graph_statistics_OutputFcn, ...
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

% --- Executes just before Directed_graph_statistics is made visible.
function Directed_graph_statistics_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Directed_graph_statistics (see VARARGIN)
% Choose default command line output for Directed_graph_statistics
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
% UIWAIT makes Directed_graph_statistics wait for user response (see UIRESUME)
uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = Directed_graph_statistics_OutputFcn(hObject, eventdata, handles)
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
User_guide_page2();


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

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide

if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9);
x=20;
end
x=20;
axes('units','pixels','position',[40 110 30 320],'visible','off')
h1=text(0,0.5,'\underline{Nodes:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 10 280],'visible','off')
h2=text(0,0.5,'The number of nodes in the graph.\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 240],'visible','off')
h3=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 200],'visible','off')
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 160],'visible','off')
h5=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 20 120],'visible','off')
h6=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 20 80],'visible','off')
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 20 40],'visible','off')
h8=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[40 110 20 1],'visible','off')
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide

if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9);
x=20;
end
x=20;
axes('units','pixels','position',[230 110 30 320],'visible','off')
h1=text(0,0.5,'\underline{Weak connected:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[230 110 10 280],'visible','off')
h2=text(0,0.5,'This field shows the number of weak connected subgraphs or weak connected','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 240],'visible','off')
h3=text(0,0.5,'components (WCC). A weak connected component constists of nodes that','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 200],'visible','off')
h4=text(0,0.5,'are connected with one or more edges. A node which has no starting or ending','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 175 160],'visible','off')
h5=imshow('Weak Connected.png'); 


axes('units','pixels','position',[230 110 10 160],'visible','off')
h6=text(0,0.5,'edge is also a WCC. For a strong connected subgraph the nodes must be connected','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 120],'visible','off')
h7=text(0,0.5,'in both directions.\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 40],'visible','off')
h8=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[40 110 20 1],'visible','off')
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide

if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9);
x=20;
end
x=20;
axes('units','pixels','position',[230 110 30 320],'visible','off')
h1=text(0,0.5,'\underline{Strong connected:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[230 110 10 280],'visible','off')
h2=text(0,0.5,'The field shows the number of strong connected subgraphs or strong ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 240],'visible','off')
h3=text(0,0.5,'connected components (SCC). The nodes in a strong connected subgraph ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 200],'visible','off')
h4=text(0,0.5,'are connected to each other in both directions.If a node is not strong ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 175 160],'visible','off')
h5=imshow('Strong Connected.png'); 


axes('units','pixels','position',[230 110 10 160],'visible','off')
h6=text(0,0.5,'connected to any other node, it is counted as SCC itself. The smaller the ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 120],'visible','off')
h7=text(0,0.5,'shown number, the less strong connected subgraph exist and the better the  ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 80],'visible','off')
h8=text(0,0.5,'whole graph is connected.A complete graph shows the number one. If there ','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[230 110 20 40],'visible','off')
h9=text(0,0.5,'are less sets of SCC as nodes in the graph, then there must be at least one cycle.\\','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide




save User_guide

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide

if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9);
x=20;
end
x=20;
axes('units','pixels','position',[230 110 30 320],'visible','off')
h1=text(0,0.5,'\underline{Average clustering coefficient:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[230 110 10 280],'visible','off')
h2=text(0,0.5,'The average clustering coefficient is the number of all existing triangles  ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 240],'visible','off')
h3=text(0,0.5,'divided by the number of all possible triangles. A triangle is a circle with ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 200],'visible','off')
h4=text(0,0.5,'three nodes. In directed graphs, three nodes generate up to eight triangles  ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 175 160],'visible','off')
h5=imshow('Avarage clustering.png'); 


axes('units','pixels','position',[230 110 10 160],'visible','off')
h6=text(0,0.5,'(2*2*2 edges), because every node be connected to another node in two directions.\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 120],'visible','off')
h7=text(0,0.5,'To get the clustering vector the number of triangles are computed for every node  ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 80],'visible','off')
h8=text(0,0.5,'and put in a column vector. This means vector for the graph above is $ [8,0,8,8]^T $,','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[230 110 20 40],'visible','off')
h9=text(0,0.5,'because the node two is not an element of a triangle. For calculating the maximal ','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide




% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide

if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9);
x=20;
end
x=20;
axes('units','pixels','position',[40 110 30 320],'visible','off')
h1=text(0,0.5,'\underline{Average degree:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 10 280],'visible','off')
h2=text(0,0.5,'The average degree is the mean of the In-degrees of all nodes in the graph.\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 240],'visible','off')
h3=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 200],'visible','off')
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 160],'visible','off')
h5=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 20 120],'visible','off')
h6=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 20 80],'visible','off')
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 20 40],'visible','off')
h8=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[40 110 20 1],'visible','off')
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide

% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide

if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9);
x=20;
end
x=20;
axes('units','pixels','position',[230 110 30 320],'visible','off')
h1=text(0,0.5,'\underline{Graph is balanced:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[230 110 10 280],'visible','off')
h2=text(0,0.5,'A graph is balanced, if every node has the same In-Degree and the same ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 240],'visible','off')
h3=text(0,0.5,'Out-Degree, this means the number of starting and arriving edges. This  ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 200],'visible','off')
h4=text(0,0.5,'property is fullfilled by a ring or a complete graph. Otherwise the answer is No.\\ ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 175 160],'visible','off')
h5=imshow('Graph is balanced.png'); 


axes('units','pixels','position',[230 110 10 160],'visible','off')
h6=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 120],'visible','off')
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 80],'visible','off')
h8=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[230 110 20 40],'visible','off')
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide
% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide

if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9);
x=20;
end
x=20;
axes('units','pixels','position',[230 110 30 320],'visible','off')
h1=text(0,0.5,'\underline{Has cycles:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[230 110 10 280],'visible','off')
h2=text(0,0.5,'The answer is Yes, if the graph contains cycles. Otherwise it is negated. ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 240],'visible','off')
h3=text(0,0.5,'When you start in a node and travel along a path in the direction of the   ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 200],'visible','off')
h4=text(0,0.5,'arrows until you return in the starting node, then you got a cycle.  ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 175 160],'visible','off')
h5=imshow('hascyles.png'); 


axes('units','pixels','position',[230 110 10 160],'visible','off')
h6=text(0,0.5,'The graph below shows a cycle with the nodes two, three and four.\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 120],'visible','off')
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 80],'visible','off')
h8=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[230 110 20 40],'visible','off')
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide



% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide

if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9);
x=20;
end
x=20;
axes('units','pixels','position',[230 110 30 320],'visible','off')
h1=text(0,0.5,'\underline{Rooted spanning tree:}\\','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[230 110 10 280],'visible','off')
h2=text(0,0.5,'This field says Yes if the graph can be built as a rooted spanning tree.  ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 240],'visible','off')
h3=text(0,0.5,'Otherwise it says No. As you can see in the figure every node is connected   ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 200],'visible','off')
h4=text(0,0.5,'to the root node by one or more lines. There are no cirle.\\ ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 175 160],'visible','off')
h5=imshow('rootedspanningtree.png'); 


axes('units','pixels','position',[230 110 10 160],'visible','off')
h6=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 120],'visible','off')
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 80],'visible','off')
h8=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[230 110 20 40],'visible','off')
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide




% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide
if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9);
x=20;
end
x=20;
axes('units','pixels','position',[40 110 30 320],'visible','off')
h1=text(0,0.5,'\underline{Minimum In-degree:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 10 280],'visible','off')
h2=text(0,0.5,'The term In-degree refers to the number of edges that end in a node. The Minimum In-degree gives back ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 240],'visible','off')
h3=text(0,0.5,'the smallest number of edges in the graph arriving in one node.\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 200],'visible','off')
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 160],'visible','off')
h5=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 20 120],'visible','off')
h6=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 20 80],'visible','off')
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 20 40],'visible','off')
h8=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[40 110 20 1],'visible','off')
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide

% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide
if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9);
x=20;
end
x=20;
axes('units','pixels','position',[40 110 30 320],'visible','off')
h1=text(0,0.5,'\underline{Maximum:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 10 280],'visible','off')
h2=text(0,0.5,'Maximum stands for the biggest number of edges that start in a node of the graph. The full ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 240],'visible','off')
h3=text(0,0.5,'name is Maximum Out-Degree.\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 200],'visible','off')
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 160],'visible','off')
h5=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 20 120],'visible','off')
h6=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 20 80],'visible','off')
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 20 40],'visible','off')
h8=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[40 110 20 1],'visible','off')
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide

% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide
if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9);
x=20;
end
x=20;
axes('units','pixels','position',[40 110 30 320],'visible','off')
h1=text(0,0.5,'\underline{Nodes:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 10 280],'visible','off')
h2=text(0,0.5,'The number of nodes in the graph.\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 240],'visible','off')
h3=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 200],'visible','off')
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 160],'visible','off')
h5=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 20 120],'visible','off')
h6=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 20 80],'visible','off')
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 20 40],'visible','off')
h8=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[40 110 20 1],'visible','off')
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide

% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide
if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9);
x=20;
end
x=20;
axes('units','pixels','position',[40 110 30 320],'visible','off')
h1=text(0,0.5,'\underline{Maximum In-degree:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 10 280],'visible','off')
h2=text(0,0.5,'The term In-degree refers to the number of edges that end in a node. The Maximum In-degree gives back ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 240],'visible','off')
h3=text(0,0.5,'the highest number of edges in the graph arriving in one node.\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 200],'visible','off')
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 160],'visible','off')
h5=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 20 120],'visible','off')
h6=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 20 80],'visible','off')
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 20 40],'visible','off')
h8=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[40 110 20 1],'visible','off')
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide

% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide
if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9);
end
x=20;
axes('units','pixels','position',[40 110 30 320],'visible','off')
h1=text(0,0.5,'\underline{Nodes:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 10 280],'visible','off')
h2=text(0,0.5,'The number of nodes in the graph.\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 240],'visible','off')
h3=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 200],'visible','off')
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 160],'visible','off')
h5=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 20 120],'visible','off')
h6=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 20 80],'visible','off')
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 20 40],'visible','off')
h8=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[40 110 20 1],'visible','off')
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide

% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide

delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9);


% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide

if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9);
x=20;
end
x=20;
axes('units','pixels','position',[230 110 30 320],'visible','off')
h1=text(0,0.5,'\underline{Average clustering coefficient (2):}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[230 110 10 280],'visible','off')
h2=text(0,0.5,'possible number of triangles for every node, the number of all input and output   ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 240],'visible','off')
h3=text(0,0.5,'edges are sumed up in a degree vector $ [4,2,6,4]^T $. Since the node two is not  ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 200],'visible','off')
h4=text(0,0.5,'element of a triangle the second entry is set to $ Inf $. After computing the maximal   ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 175 160],'visible','off')
h5=imshow('Avarage clustering.png'); 


axes('units','pixels','position',[230 110 10 160],'visible','off')
h6=text(0,0.5,'number of triangles for all pairs of nodes and subtracting wrong pairs the resulting ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 120],'visible','off')
h7=text(0,0.5,'vector is $ [8,Inf,24,8]^T $. So the vector of the clustering coefficients looks like ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 80],'visible','off')
h8=text(0,0.5,'$ [1,0,0.333,0]^T $. The average clustering coefficient is the mean value of the vector.','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[230 110 20 40],'visible','off')
h9=text(0,0.5,' In this example the average clustering coefficient is $ 0.583 $.\\','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide


% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton28.
function pushbutton28_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide
if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9);
end
x=20;
axes('units','pixels','position',[40 110 30 320],'visible','off')
h1=text(0,0.5,'\underline{Minimum:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 10 280],'visible','off')
h2=text(0,0.5,'Minimum stands for the smallest number of edges that start in a node of the graph. The full ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 240],'visible','off')
h3=text(0,0.5,'name is Minimum Out-Degree.\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 200],'visible','off')
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 160],'visible','off')
h5=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 20 120],'visible','off')
h6=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 20 80],'visible','off')
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 20 40],'visible','off')
h8=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[40 110 20 1],'visible','off')
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide

% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide
if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9);
x=20;
end
x=20;
axes('units','pixels','position',[40 110 30 320],'visible','off')
h1=text(0,0.5,'\underline{Average path length:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 30 280],'visible','off')
h2=text(0,0.5,'The average path length is the sum of all path length divided by the number of nodes times .','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 240],'visible','off')
h3=text(0,0.5,'the number of nodes minus one. The path length between two nodes is the smallest number ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 200],'visible','off')
h4=text(0,0.5,'of connections between the two nodes. If the graph contains not connected subgraphs the ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 160],'visible','off')
h5=text(0,0.5,'average path length is $ Inf $ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 30 120],'visible','off')
h6=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[240 110 360 80],'visible','off')
h7=imshow('Avarage path length.png');
axes('units','pixels','position',[40 110 30 40],'visible','off')
h8=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[40 110 30 1],'visible','off')
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide

% --- Executes on button press in pushbutton30.
function pushbutton30_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide

if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9);
x=20;
end
x=20;
axes('units','pixels','position',[230 110 30 320],'visible','off')
h1=text(0,0.5,'\underline{Strong connected (2):}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[230 110 10 280],'visible','off')
h2=text(0,0.5,'Here the node three and the node four are a strong connected subgraphs  ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 240],'visible','off')
h3=text(0,0.5,'and the nodes three and four form together a strong connected subgraph. ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 200],'visible','off')
h4=text(0,0.5,'Two weak connected subgraphs can be seen.\\ ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 175 160],'visible','off')
h5=imshow('Strong Connected.png'); 


axes('units','pixels','position',[230 110 10 160],'visible','off')
h6=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 120],'visible','off')
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 80],'visible','off')
h8=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[230 110 20 40],'visible','off')
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide
