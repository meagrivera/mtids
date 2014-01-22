function varargout = User_guide(varargin)
%USER_GUIDE M-file for User_guide.fig
%      USER_GUIDE by itself, creates a new USER_GUIDE or raises the
%      existing singleton*.
%
%      H = USER_GUIDE returns the handle to a new USER_GUIDE or the handle to
%      the existing singleton*.
%
%      USER_GUIDE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in USER_GUIDE.M with the given input arguments.
%
%      USER_GUIDE('Property','Value',...) creates a new USER_GUIDE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before User_guide_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to User_guide_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
%
% Authors: Francisco Llobet, Jose Rivera
% Editor: Ferdinand Trommsdorff (f.trommsdorff@gmail.com)
% Project: MTIDS (http://code.google.com/p/mtids/)

% Last Modified by GUIDE v2.5 18-Jan-2014 00:03:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @User_guide_OpeningFcn, ...
                   'gui_OutputFcn',  @User_guide_OutputFcn, ...
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

% --- Executes just before User_guide is made visible.
function User_guide_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to User_guide (see VARARGIN)
% Choose default command line output for User_guide
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
% UIWAIT makes User_guide wait for user response (see UIRESUME)
uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = User_guide_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;
% The figure can be deleted now
delete(handles.figure1);

% --- Executes on button press in close.
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
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



% --- Executes on button press in Graph_theory.
function Graph_theory_Callback(hObject, eventdata, handles)
% hObject    handle to Graph_theory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% hObject    handle to close (see GCBO)
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
h1=text(0,0.5,'\underline{Graph theory:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'For modeling these interconnected systems a graph $ G $ is defined by a set of vertices $ V $ (also called nodes) and ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'a set of edges $ E $, [1], [3], [4]. Two vertices $i$ ang $j$ that are connected by an edge can be written in brackets ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'like (i,j).\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'There are two types of graphs, directed or undirected. In undirected graphs the nodes that are connected with an edge ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'communicate in both directions which is shown by a line. The nodes in directed graphs are connected with arcs that  ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 520],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'means the information flow is not bidirectional. If two nodes communicate in both directions, they are connected via  ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 480],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h8=text(0,0.5,'two antiparallel arcs.\\' ,'interpreter' ,'latex',...
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
h11=text(0,0.5,'  ','interpreter','latex',...
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
axes('units','pixels','position',[270 110 30 80],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'Directed and undirected graph','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[120 110 480 300],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('dirgraphs.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 

% --- Executes on button press in Directed_graph_statistics.
function Directed_graph_statistics_Callback(hObject, eventdata, handles)
% hObject    handle to Directed_graph_statistics (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = get(hObject,'String');
% Update handles structure
guidata(hObject, handles);
% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.figure1);
Directed_graph_statistics();


% handles.output = get(hObject,'String');
% % Update handles structure
% guidata(hObject, handles);
% % Use UIRESUME instead of delete because the OutputFcn needs
% % to get the updated handles structure.
% uiresume(handles.figure1);






% --- Executes on button press in About_MITDS.
function About_MITDS_Callback(hObject, eventdata, handles)
% hObject    handle to About_MITDS (see GCBO)
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
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);

x=20;
end
x=20;
axes('units','pixels','position',[40 110 30 760],'visible','off')
h1=text(0,0.5,'\underline{About MTIDS:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 30 720],'visible','off')
h2=text(0,0.5,'Copyright (C) 2012 The MTIDS Project ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 680],'visible','off')
h3=text(0,0.5,'This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 640],'visible','off')
h4=text(0,0.5,'Licence as published by the Free Software Foundation; either version 2 (GPL 2), or (at your option) any later version. ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 600],'visible','off')
h5=text(0,0.5,'This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 30 560],'visible','off')
h6=text(0,0.5,'implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 480],'visible','off')
h7=text(0,0.5,'For more information read LICENCE.txt','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 440],'visible','off')
h8=text(0,0.5,'The MTIDS project is hosted at: http://code.google.com/p/mtids','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[40 110 30 400],'visible','off')
h9=text(0,0.5,'MTIDS uses Matgraph (c) Ed Scheinermann','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 520],'visible','off')
h10=text(0,0.5,'General Public License for more details.','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 360],'visible','off')
h11=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 320],'visible','off')
h12=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 280],'visible','off')
h13=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 240],'visible','off')
h14=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 200],'visible','off')
h15=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 160],'visible','off')
h16=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 120],'visible','off')
h17=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 80],'visible','off')
h18=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 40],'visible','off')
h19=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide




% --- Executes on button press in Working_with_MTIDS.
function Working_with_MTIDS_Callback(hObject, eventdata, handles)
% hObject    handle to Working_with_MTIDS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = get(hObject,'String');
% Update handles structure
guidata(hObject, handles);
% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.figure1);
Working_with_MTIDS();








% --- Executes on button press in toolbox_statistics.
function toolbox_statistics_Callback(hObject, eventdata, handles)
% hObject    handle to toolbox_statistics (see GCBO)
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
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);

x=20;
end
x=20;
axes('units','pixels','position',[40 110 30 760],'visible','off')
h1=text(0,0.5,'\underline{Toolbox statistics:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 30 720],'visible','off')
h2=text(0,0.5,'To improve the work with distributed networks and because of the complexity they can reach, the MATLAB toolbox  ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 680],'visible','off')
h3=text(0,0.5,'MTIDS was built. This toolbox shows the important statistics that give information about the convergence, ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 640],'visible','off')
h4=text(0,0.5,'the connectivity and the robustness of the control system.\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 600],'visible','off')
h5=text(0,0.5,'This chapter includes the explanations for the statistics of the toolbox located in the window next to the','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 30 560],'visible','off')
h6=text(0,0.5,' picture of the actual graph. For the two typs of edges, either directed or undirected, there are two different','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 520],'visible','off')
h7=text(0,0.5,'versions of the graph statistics window. A look in the handbook, [4], on the webpage, [2], of MTIDS is profitable, too.','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 480],'visible','off')
h8=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[40 110 30 440],'visible','off')
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 400],'visible','off')
h10=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 360],'visible','off')
h11=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 320],'visible','off')
h12=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 280],'visible','off')
h13=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 240],'visible','off')
h14=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 200],'visible','off')
h15=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 160],'visible','off')
h16=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 120],'visible','off')
h17=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 80],'visible','off')
h18=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 40],'visible','off')
h19=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide

% --- Executes on button press in References.
function References_Callback(hObject, eventdata, handles)
% hObject    handle to References (see GCBO)
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
h1=text(0,0.5,'\underline{References:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'[1] F. Deroo and S. Hirche; A MATLAB Toolbox for Large-scale Networked Systems; ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[50 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'    at- Automatisierungstechnik, July 2013.','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'[2] URL: https://code.google.com/p/mtids/','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'[3] Christopher D. Godsil and Gordon Royle; Algebraic graph theory. Graduate texts in mathematics. Springer, 2001.','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'[4] Dragoslav D. Siljak. Large-Scale Dynamic Systems: Stability and Structure. Dover Piblications, 2007.','interpreter','latex',...
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
h11=text(0,0.5,'  ','interpreter','latex',...
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
axes('units','pixels','position',[170 110 330 600],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 





% --- Executes on button press in Graph_theory_page2.
function Graph_theory_page2_Callback(hObject, eventdata, handles)
% hObject    handle to Graph_theory_page2 (see GCBO)
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
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);
x=20;
end
x=20;
axes('units','pixels','position',[40 110 30 760],'visible','off')
h1=text(0,0.5,'\underline{Graph theory (2):}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 30 720],'visible','off')
h2=text(0,0.5,'Three special undirected graphs can be found:\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[80 110 30 680],'visible','off')
h3=text(0,0.5,'- The tree, where every node is connected by exactly one edge. It contains no cycles. \\ ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[80 110 30 640],'visible','off')
h4=text(0,0.5,'- The cycle in which the nodes are joined in a closed chain. ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[80 110 30 600],'visible','off')
h5=text(0,0.5,'- The complete graph, in which every node is connected to all the other nodes.','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 30 560],'visible','off')
h6=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 520],'visible','off')
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 480],'visible','off')
h8=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[100 110 550 360],'visible','off')
h9=imshow('GraphTheory3.png');   
axes('units','pixels','position',[40 110 30 400],'visible','off')
h10=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 360],'visible','off')
h11=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 320],'visible','off')
h12=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 280],'visible','off')
h13=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 240],'visible','off')
h14=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 240],'visible','off')
h15=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[40 110 30 160],'visible','off')
h16=text(0,0.5,'For the possibility of making some computations three important matricies are defined. ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 120],'visible','off')
h17=text(0,0.5,'The entries of the Incidence Matrix of a directed graph are defined as follows: (next page) \\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 80],'visible','off')
h18=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 80],'visible','off')
h19=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle'); 
save User_guide


% --- Executes on button press in Graph_theory_page3.
function Graph_theory_page3_Callback(hObject, eventdata, handles)
% hObject    handle to Graph_theory_page3 (see GCBO)
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
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);
x=20;
end
x=20;
axes('units','pixels','position',[40 110 30 760],'visible','off')
h1=text(0,0.5,'\underline{Graph theory (3):}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 30 720],'visible','off')
h2=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 680],'visible','off')
h3=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[290 110 330 660],'visible','off')
h4=imshow('GraphTheory_M_1.png');  
axes('units','pixels','position',[40 110 30 600],'visible','off')
h5=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 30 560],'visible','off')
h6=text(0,0.5,'The \textit{incidence matrix} exits only for simple graphs that means, for graphs without self-loops.\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 520],'visible','off')
h7=text(0,0.5,'The entries of \textit{adjacency matrix} are computed like this:','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 480],'visible','off')
h8=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[240 110 430 440],'visible','off')
h9=imshow('GraphTheory_M_2.png'); 
axes('units','pixels','position',[40 110 30 400],'visible','off')
h10=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 360],'visible','off')
h11=text(0,0.5,'The matrix $ A $ is the binary directed or undirected connection matrix. Normally $ A $ has no diagonal elements,  ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 320],'visible','off')
h12=text(0,0.5,'because in most cases no edge starts and ends in the same node. The definition of the entries of the \textit{degree matrix} is: \\\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 280],'visible','off')
h13=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[240 110 400 240],'visible','off')
h14=imshow('GraphTheory_M_3.png'); 
% axes('units','pixels','position',[100 110 850 360],'visible','off')
% h9=imshow('GraphTheory4.png');
axes('units','pixels','position',[300 110 30 40],'visible','off')
h15=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 160],'visible','off')
h16=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 120],'visible','off')
h17=text(0,0.5,'D is a diagonal matrix. Its elements are the degrees of the nodes. The \textit{laplacian matrix} $ L $ is difference  ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 80],'visible','off')
h18=text(0,0.5,'between the \textit{adjacency matrix} $ A $ and the \textit{degree matrix} $ D $.\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[300 110 30 40],'visible','off')
h19=text(0,0.5,'L=D-A','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide


% --- Executes on button press in Graph_theory_page4.
function Graph_theory_page4_Callback(hObject, eventdata, handles)
% hObject    handle to Graph_theory_page4 (see GCBO)
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
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);
x=20;
end
x=20;
axes('units','pixels','position',[40 110 30 760],'visible','off')
h1=text(0,0.5,'\underline{Graph theory (4):}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 30 720],'visible','off')
h2=text(0,0.5,'The Laplacian matrix is symmetric, positive semidefinite and diagonally dominant.\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 680],'visible','off')
h3=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 150 540],'visible','off')
h4=imshow('GraphTheory_5.png');  
axes('units','pixels','position',[200 110 530 475],'visible','off')
h5=imshow('GraphTheory_6.png');

axes('units','pixels','position',[240 110 30 600],'visible','off')
h6=text(0,0.5,'The matricies for this graph look like follows:\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 320],'visible','off')
h7=text(0,0.5,'If the graph is connected the eigenvalues of L increase starting with zero.\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 480],'visible','off')
h8=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 80],'visible','off')
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[240 110 430 440],'visible','off')
%h9=imshow('GraphTheory_M_2.png'); 
axes('units','pixels','position',[40 110 30 400],'visible','off')
h10=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 360],'visible','off')
h11=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 320],'visible','off')
h12=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[240 110 30 280],'visible','off')
h13=text(0,0.5,'0=$\lambda_{1}$  $<$ $\lambda_{2}$ $<$ $\lambda_{3}$ $<$ $\lambda_{4}$ $<$ ... $<$ $\lambda_{n}$','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[240 110 400 240],'visible','off')
h14=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 480],'visible','off')
h15=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
% axes('units','pixels','position',[100 110 850 360],'visible','off')
% h9=imshow('GraphTheory4.png');  
axes('units','pixels','position',[40 110 30 240],'visible','off')
h16=text(0,0.5,'If the eigenvalue $\lambda_2=0$, which is called algebraic connectivity or fiedler value, the graph is not connected.  ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 200],'visible','off')
h17=text(0,0.5,'It is a measure for connectivity. The greater $\lambda_2$ is, the better is the robustness of the graph.\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 160],'visible','off')
h18=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 120],'visible','off')
h19=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide


% --- Executes on button press in Undirected_graph_statistics.
function Undirected_graph_statistics_Callback(hObject, eventdata, handles)
% hObject    handle to Undirected_graph_statistics (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = get(hObject,'String');
% Update handles structure
guidata(hObject, handles);
% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.figure1);
Undirected_graph_statistics();


% --- Executes on button press in Introduction_to_MTIDS.
function Introduction_to_MTIDS_Callback(hObject, eventdata, handles)
% hObject    handle to Introduction_to_MTIDS (see GCBO)
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
h1=text(0,0.5,'\underline{Introduction to MTIDS:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'The MATLAB toolbox MTIDS is a tool for modelling and simulating systems that consist of several subsystems which  ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'areconnected to each other either physically or via communication paths. These systems are also known as large-scale ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'interconnected systems, networked dynamical/control systems, multi-agent systems or distributed dynamical systems. ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'There is no other software tool that combines graph theory with simulation. Using MTIDS many systems or networks  ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'from very different fields can be modeled. Some technical examples are the power system, including transformators, loads  ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 520],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'and generators, the traffic system which tries to avoid jams and the internet which connects millions of computers.Even in ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 480],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h8=text(0,0.5,'biology some interconnected systems can be found, like neuronal networks for brain studies, animal populations or little ' ,'interpreter' ,'latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 440],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h9=text(0,0.5,'ecosystems. Another point of research is the flocking behavior of birds or fish.Other practical applications are ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 400],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h10=text(0,0.5,'economic or social networks. In the next chapter some basic knowledge about the graph theory is stated, because ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 360],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h11=text(0,0.5,'MTIDS is based on graph theory.\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 320],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure. 
h12=text(0,0.5,'','interpreter','latex',...
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
axes('units','pixels','position',[170 110 330 600],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 
