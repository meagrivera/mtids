function varargout = Working_with_MTIDS(varargin)
%WORKING_WITH_MTIDS M-file for Working_with_MTIDS.fig
%      WORKING_WITH_MTIDS by itself, creates a new WORKING_WITH_MTIDS or raises the
%      existing singleton*.
%
%      H = WORKING_WITH_MTIDS returns the handle to a new WORKING_WITH_MTIDS or the handle to
%      the existing singleton*.
%
%      WORKING_WITH_MTIDS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WORKING_WITH_MTIDS.M with the given input arguments.
%
%      WORKING_WITH_MTIDS('Property','Value',...) creates a new WORKING_WITH_MTIDS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Working_with_MTIDS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Working_with_MTIDS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
%
% Authors: Francisco Llobet, Jose Rivera
% Editor: Ferdinand Trommsdorff (f.trommsdorff@gmail.com)
% Project: MTIDS (http://code.google.com/p/mtids/)

% Last Modified by GUIDE v2.5 17-Jan-2014 01:49:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Working_with_MTIDS_OpeningFcn, ...
                   'gui_OutputFcn',  @Working_with_MTIDS_OutputFcn, ...
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

% --- Executes just before Working_with_MTIDS is made visible.
function Working_with_MTIDS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Working_with_MTIDS (see VARARGIN)
% Choose default command line output for Working_with_MTIDS
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
% UIWAIT makes Working_with_MTIDS wait for user response (see UIRESUME)
uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = Working_with_MTIDS_OutputFcn(hObject, eventdata, handles)
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


% --- Executes on button press in Working_with_MITDS.
function Working_with_MITDS_Callback(hObject, eventdata, handles)
% hObject    handle to Working_with_MITDS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Working with MTIDS:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'MTIDS is a MATLAB toolbox with an open-source license (GNU GPL v2). To download and install the toolbox the link','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'in [2] is needed. In Downloads the actual version can be downloaded with a *.zip folder and extracted on the computer.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'Before starting the program, MATLAB has to be opened. After selecting the right folder the toolbox starts by running ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'the file mtids.m. At first the following window appears:\\','interpreter','latex',...
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
axes('units','pixels','position',[300 110 30 240],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h14=text(0,0.5,'Start window','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 200],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'Here the user can choose whether to work with former settings or to begin a new graph. Then the main user panel opens.\\','interpreter','latex',...
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
axes('units','pixels','position',[140 110 450 420],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('startwindow.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in h.
function h_Callback(hObject, eventdata, handles)
% hObject    handle to h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'h1','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'h2','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'h3','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'h4 ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'h5','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'h6','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 520],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'h7','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 480],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h8=text(0,0.5,'h8' ,'interpreter' ,'latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 440],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h9=text(0,0.5,'h9','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 400],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h10=text(0,0.5,'h10','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 360],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h11=text(0,0.5,' h11','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[140 110 30 320],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure. 
h12=text(0,0.5,'h12 ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


axes('units','pixels','position',[40 110 30 280],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h13=text(0,0.5,'h13','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 240],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h14=text(0,0.5,'h14','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 200],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'h15','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 160],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h16=text(0,0.5,'h16','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 120],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h17=text(0,0.5,'h17','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 80],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'h18','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 40],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('startwindow.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in User_panel.
function User_panel_Callback(hObject, eventdata, handles)
% hObject    handle to User_panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{User panel:}\\ ','interpreter','latex',...
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
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'','interpreter','latex',...
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
h19=imshow('user_panel3.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in User_panel_page2.
function User_panel_page2_Callback(hObject, eventdata, handles)
% hObject    handle to User_panel_page2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{User panel (2):}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'The picture above shows the user panel. It contains four main areas:\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'      -the menu bar on top','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'      -the graph window on the left','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'      -the statistics window on the right','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'      -the editing window on the bottom','interpreter','latex',...
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
axes('units','pixels','position',[40 110 30 80],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h19=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Menu_bar.
function Menu_bar_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_bar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Menu bar:}\\ ','interpreter','latex',...
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
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'','interpreter','latex',...
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
h9=text(0,0.5,'On top of the graph there are tools to manipulate the graph (red). After clicking on the loupe with the plus sign ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 400],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h10=text(0,0.5,'the user can zoom in. To zoom out of the graph the user has to select the loupe with the minus sign. If the hand-button ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 360],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h11=text(0,0.5,'is activated the whole graph can be moved. When a tool is selected the button stays pressed. To deactivate a tool  ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 320],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure. 
h12=text(0,0.5,'the pressed button has to be clicked again.\\ ','interpreter','latex',...
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
h19=imshow('toolsa.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in File.
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{File:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'Under the item File there are six elements:','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'   - New graph','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'   - Load\dots','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'   - Save as\dots','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'   - Export to workspace\dots','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 520],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'   - Export graph','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 480],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h8=text(0,0.5,'   - Exit' ,'interpreter' ,'latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 440],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 400],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h10=text(0,0.5,'With \textbf{File$\rightarrow$New graph} the existing graph is deleted. So the user can start to build a new one.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 360],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h11=text(0,0.5,'With \textbf{File$\rightarrow$Load\dots} a stored graph can be loaded.\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 320],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure. 
h12=text(0,0.5,'With \textbf{File$\rightarrow$Save as\dots} the actual graph can be saved with a certain name in a *.mat-file.\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


axes('units','pixels','position',[40 110 30 280],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h13=text(0,0.5,'With \textbf{File$\rightarrow$Export to workspace\dots} a new window where the three important graph matrices can ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 240],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h14=text(0,0.5,'be stored to the workspace opens:\\','interpreter','latex',...
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
axes('units','pixels','position',[10 110 1000 130],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in File_page2.
function File_page2_Callback(hObject, eventdata, handles)
% hObject    handle to File_page2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{File(2):}\\ ','interpreter','latex',...
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
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'','interpreter','latex',...
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
axes('units','pixels','position',[40 110 30 40],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h10=text(0,0.5,'    - Edge List ','interpreter','latex',...
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
h15=text(0,0.5,'Here the workspace name and the variable name can be changed. With the radio buttons, one of the three matrices ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 160],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h16=text(0,0.5,'can be selected:','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 120],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h17=text(0,0.5,'    - Laplacian Matrix','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 80],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'    - Adjacency Matrix','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[210 110 300 500],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('exportworkspace.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in File_page3.
function File_page3_Callback(hObject, eventdata, handles)
% hObject    handle to File_page3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{File(3):}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'More informations about the matrices is written in the chapter "graph theory".','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'With \textbf{File$\rightarrow$Export graph} the actual graph can be exported in the opened window.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'','interpreter','latex',...
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
axes('units','pixels','position',[40 110 30 200],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 160],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h16=text(0,0.5,'To save the graph as a *.tikz-, *.eps-, *.jpg-, *.pdf-, *.png- or *.tiff-file with a certain name, click the ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 120],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h17=text(0,0.5,'Export-button. Using the Close-button, the window shuts.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 80],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'With \textbf{File$\rightarrow$Exit} the user can quit the program.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[220 110 250 430],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('exportgraph.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in View.
function View_Callback(hObject, eventdata, handles)
% hObject    handle to View (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{View:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'In the menu point View the appearance of the nodes can be changed in three possible ways:\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'    - Label view','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'    -  Number view','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'    - Blank view','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'Additionally the node color can be set in an external window by selecting \textbf{View$\rightarrow$Set node color}.\\','interpreter','latex',...
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
axes('units','pixels','position',[340 110 30 50],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'Set node color window','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[190 110 400 300],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('setnodecolor.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Dynamics.
function Dynamics_Callback(hObject, eventdata, handles)
% hObject    handle to Dynamics (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Dynamics:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'In the segment Dynamics in the menu bar the dynamics of the nodes can be handled under the following topics:','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[80 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'-Create Dynamics Template','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[80 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'-Manage Parameter Sets','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[80 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'-LTI Analysis','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'The first thing to do when building an interconnected system is to create the subsystem dynamics which ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 520],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'can be applied to the nodes of the graph. Therefore a SIMULINK model with a assigned frame of SIMULINK blocks called ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 480],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h8=text(0,0.5,'template is provided. To use the templates, they have to be loaded in the parameter set manager (PSM) where the ' ,'interpreter' ,'latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 440],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h9=text(0,0.5,'parameter sets of the template can be edited and saved. How to build templates and apply dynamics to a node is ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 400],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h10=text(0,0.5,'described in a more accurate way in the chapter "Work Flow"','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 360],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h11=text(0,0.5,'\textbf{Create Dynamics Template:} ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 320],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure. 
h12=text(0,0.5,'To create dynamics of all kind, an empty template as SIMULINK model is provided. By clicking  ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


axes('units','pixels','position',[40 110 30 280],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h13=text(0,0.5,'\textbf{Dynamics$\rightarrow$Create Dynamics Template} the SIMULINK browser and a SIMULINK model called newtemplate opens \\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 240],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h14=text(0,0.5,'(next page).','interpreter','latex',...
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


% --- Executes on button press in Dynamics_page2.
function Dynamics_page2_Callback(hObject, eventdata, handles)
% hObject    handle to Dynamics_page2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Dynamics(2):}\\ ','interpreter','latex',...
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
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'','interpreter','latex',...
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
axes('units','pixels','position',[40 110 30 200],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 160],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h16=text(0,0.5,'In this model some SIMULINK blocks are already integrated. Please do not change them! This structure is important ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 120],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h17=text(0,0.5,'for exporting or importing the SIMULINK models to MTIDS.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 80],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[150 110 500 480],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('template.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Dynamics_page3.
function Dynamics_page3_Callback(hObject, eventdata, handles)
% hObject    handle to Dynamics_page3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Dynamics(3):}\\ ','interpreter','latex',...
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
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'','interpreter','latex',...
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
axes('units','pixels','position',[40 110 30 200],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 160],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h16=text(0,0.5,'In the free space which is marked red in the figure above any SIMULINK block can be used to create the desired dynamical system.\\ ','interpreter','latex',...
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
axes('units','pixels','position',[150 110 500 480],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('template2.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Dynamics_page4.
function Dynamics_page4_Callback(hObject, eventdata, handles)
% hObject    handle to Dynamics_page4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Dynamics(4):}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'\textbf{Manage Parameter Sets}','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'Under the menu point \textbf{Dynamics$\rightarrow$Manage Parameter Sets} the  ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'parameter settings window opens. Here, compared to the parameter ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'setting window in the node settings after double-clicking on a node, ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'the parameter can be managed in a more detailed manner.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 520],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'In the Managing mode (red) it can be selected whether the ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 480],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h8=text(0,0.5,'parameter set of an old template is edited or a new template ' ,'interpreter' ,'latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 440],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h9=text(0,0.5,'is imported to MTIDS and a new parameter set is made. The ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 400],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h10=text(0,0.5,'Managing modes only differ in the upper part of the PSM (blue).\\','interpreter','latex',...
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
axes('units','pixels','position',[250 110 700 400],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('manageparaset2.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Dynamics_page5.
function Dynamics_page5_Callback(hObject, eventdata, handles)
% hObject    handle to Dynamics_page5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Dynamics (5):}\\ ','interpreter','latex',...
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
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'','interpreter','latex',...
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

axes('units','pixels','position',[240 110 30 440],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h9=text(0,0.5,'Parameter set manager when "New template import" is selected','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 400],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h10=text(0,0.5,'In the New template import-mode a template can be loaded by clicking the Load template-button and choosing the ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 360],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h11=text(0,0.5,'new template. New blocks can be created with the Add Block-button. In the appearing window the name of the wanted  ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 320],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure. 
h12=text(0,0.5,'block has to be inserted, for example Gain. With the Add Parameter-button further parameters for new blocks can  ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


axes('units','pixels','position',[40 110 30 280],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h13=text(0,0.5,'be created. The Test Value Set-button tests the edited parameter set for compliance with the model to prevent ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 240],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h14=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 240],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'unnecessary SIMULINK errors. With the Finish import-button the import of the template is completed and the template ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 200],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h16=text(0,0.5,'with its parameter set is saved.\\','interpreter','latex',...
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
axes('units','pixels','position',[210 110 400 620],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('mode2.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Dynamics_page6.
function Dynamics_page6_Callback(hObject, eventdata, handles)
% hObject    handle to Dynamics_page6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Dynamics (6):}\\ ','interpreter','latex',...
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
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'','interpreter','latex',...
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

axes('units','pixels','position',[240 110 30 440],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h9=text(0,0.5,'Parameter set manager when "Edit parameter sets" is selected','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 400],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h10=text(0,0.5,'In the "Edit parameter sets"-mode an already imported template and an existing parameter set can be selected. ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 360],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h11=text(0,0.5,'Three standard templates are given and can be selected in the "Choose parameter set" field.\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 320],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure. 
h12=text(0,0.5,'In this mode the parameter set can also be tested or deleted or saved in a new file. The "Set is active"-button (green)  ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


axes('units','pixels','position',[40 110 30 280],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h13=text(0,0.5,'controls whether the chosen parameter set can be used in the editing window to apply it to a node.\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 240],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h14=text(0,0.5,'The chosen parameter set can be seen in the "template parameter value set". There, it is also possible to change ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 200],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'the parameters manually.','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 200],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
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
axes('units','pixels','position',[210 110 400 620],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('mode1.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Dynamics_page7.
function Dynamics_page7_Callback(hObject, eventdata, handles)
% hObject    handle to Dynamics_page7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Dynamics (7):}\\ ','interpreter','latex',...
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
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'','interpreter','latex',...
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

axes('units','pixels','position',[340 110 30 440],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h9=text(0,0.5,'Template parameter calue set','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 400],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h10=text(0,0.5,'The "Input Specifications" show linear depending state or output parameters and how much of the are internal inputs. ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 360],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h11=text(0,0.5,'The "Close"-button quits the parameter set manager.\\','interpreter','latex',...
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
h14=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 200],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 120],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h16=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[340 110 30 80],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h17=text(0,0.5,'Input specifications','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[210 110 450 220],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h18=imshow('inputspec.jpg');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[210 110 450 620],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('tempparaset.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Dynamics_page8.
function Dynamics_page8_Callback(hObject, eventdata, handles)
% hObject    handle to Dynamics_page8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Dynamics (8):}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'In the "Random Parameters Setup" a random value for the in the scroll bar with its name selected parameter can be set','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,' either in a uniform or a normal manner. For a normal distributed random value the mean and the standard deviation ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'can be defined. The minimum and the maximum value are properties of the uniform distribution. According to the number ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'of inputs and outputs the matrix dimensions have to be entered in the right way.\\','interpreter','latex',...
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

axes('units','pixels','position',[340 110 30 440],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 400],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h10=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 360],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h11=text(0,0.5,',','interpreter','latex',...
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
h14=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 200],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 120],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h16=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[340 110 30 80],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h17=text(0,0.5,'Random parameter setup','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[210 110 450 220],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h18=text(0,0.5,'Input specifications','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[210 110 400 320],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('randomparaset.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert.


% --- Executes on button press in Dynamics_page9.
function Dynamics_page9_Callback(hObject, eventdata, handles)
% hObject    handle to Dynamics_page9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Dynamics (9):}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,' \textbf{LTI Analysis}','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,' With a click on \textbf{Dynamics$\rightarrow$LTI Analysis} test window appears. The LTI analysis is only possible, ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'if the every node of the graph has LTI dynamics. The dynamics of a node can be chosen in the "editing window" before ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'clicking the "Add node"-button or in the node settings.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 520],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'A press on the "Test"-button checks whether the interconnected ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 480],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h8=text(0,0.5,'dynamical system is stable, observable and controllable. If not' ,'interpreter' ,'latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 440],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h9=text(0,0.5,' a pop-up window gives instructions to solve the LTI problems.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 400],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h10=text(0,0.5,'With the "Set"-button the program itself creates a stable  ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 360],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h11=text(0,0.5,'states matrix for a node.\\','interpreter','latex',...
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
h14=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 200],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 120],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h16=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[340 110 30 80],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h17=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[210 110 450 220],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h18=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[430 110 250 320],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('ltiana.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert.


% --- Executes on button press in Simulation.
function Simulation_Callback(hObject, eventdata, handles)
% hObject    handle to Simulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Simulation:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'The element "Simulation" in the menu bar serves the functions to run the interconnected systems made in MTIDS. In ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'the chapter "Workflow" is explained how to run simulations.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[140 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'-Export to Simulink','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[140 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'-Disable Simulink Warnings','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[140 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'-Run Simulation \& Plots','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[140 110 30 520],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'-Plot all output','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[140 110 30 480],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h8=text(0,0.5,'-Show Simulink Model' ,'interpreter' ,'latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[140 110 30 440],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h9=text(0,0.5,'-Input parameter adaption','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[140 110 30 400],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h10=text(0,0.5,'-Integrator initial condition','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[140 110 30 360],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h11=text(0,0.5,'-Set simulation parameters','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 320],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure. 
h12=text(0,0.5,'With \textbf{Simulation$\rightarrow$Export to Simulink} the whole graph is exported to a SIMULINK model for reasons of simulation.\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


axes('units','pixels','position',[40 110 30 280],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h13=text(0,0.5,'With \textbf{Simulation$\rightarrow$Disable Simulink Warnings} the user turns off all the warning messages generated by SIMULINK.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 240],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h14=text(0,0.5,'With \textbf{Simulation$\rightarrow$Run Simulation \& Plots} the simulation starts in MTIDS with the user defined ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 200],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'settings which can be changed in the edit node window after double-clicking on a node. If the plotting options are ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 160],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h16=text(0,0.5,'selected, MTIDS displays the plots after the simulation.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 120],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h17=text(0,0.5,'If \textbf{Simulation$\rightarrow$Plot all output} is marked every output of the graph is plotted after the simulation.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 80],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'If \textbf{Simulation$\rightarrow$Show Simulink Model} is marked after starting the simulation the SIMULINK model is opened.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[10 110 700 400],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Simulation_page2.
function Simulation_page2_Callback(hObject, eventdata, handles)
% hObject    handle to Simulation_page2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Textfeldbreite
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Simulation (2):}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'When the user adds new edges to the graph, the input parameter matrix $A_{ij}$ of a template does not have the correct ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'size anymore. This problem can be fixed automatically using \textbf{Simulation$\rightarrow$Input parameter adaption}.In the\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'appearing window there are five different options how MTIDS should set ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'these size-depending parameters.','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[80 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'-Fill with a specific constant value the user can define.','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[80 110 30 520],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'-Set for every entry 1/$n$, where $n$ is the number of incoming signals.','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[80 110 30 480],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h8=text(0,0.5,'-Average over the existing values if the parameter was set before.' ,'interpreter' ,'latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[80 110 30 440],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h9=text(0,0.5,'- Fill them with a random matrix.','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[80 110 30 400],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h10=text(0,0.5,'- Preserve the matrix if it was set already but concatenate with ones, or trim to the required size.','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[80 110 30 360],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h11=text(0,0.5,' or trim to the required size. ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 320],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure. 
h12=text(0,0.5,'So there is no need to conform the parameters manually and further ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


axes('units','pixels','position',[40 110 30 280],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h13=text(0,0.5,'proceedings like simulations may follow quickly.\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 240],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h14=text(0,0.5,'With \textbf{Simulation$\rightarrow$Integrator initial condition} the initial conditions for ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 200],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'all integrators in the entire system, which means for every SIMULINK ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 160],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h16=text(0,0.5,'integrator blocks of the used templates, can be set.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 120],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h17=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[540 110 30 40],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'Input parameter adaption','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[480 110 260 350],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('inputpara.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Simulation_page3.
function Simulation_page3_Callback(hObject, eventdata, handles)
% hObject    handle to Simulation_page3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Textfeldbreite
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Simulation (3):}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'The options are:','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[60 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'-Choose a certain constant.','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[60 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'-Average over the sum of the sizes of incoming signals.','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[60 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'-Average over the existing values.','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[60 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'-Take random values.','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[60 110 30 520],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'-Preserve the matrix if it was set already but concatenate with ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[60 110 30 480],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h8=text(0,0.5,' ones, or trim to the required size.' ,'interpreter' ,'latex',...
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
axes('units','pixels','position',[490 110 30 240],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h14=text(0,0.5,'Initial conditions for integrators','interpreter','latex',...
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
axes('units','pixels','position',[440 110 250 500],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('initialcond.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Simulation_page4.
function Simulation_page4_Callback(hObject, eventdata, handles)
% hObject    handle to Simulation_page4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Textfeldbreite
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Simulation (4):}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'With \textbf{Simulation$\rightarrow$Set simulation parameters} the simulation parameters window starts.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'','interpreter','latex',...
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
axes('units','pixels','position',[210 110 400 350],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('editsimpara.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Simulation_page5.
function Simulation_page5_Callback(hObject, eventdata, handles)
% hObject    handle to Simulation_page5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Textfeldbreite
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Simulation (5):}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'In this window the most important SIMULINK simulation options can be set. They can also be found in the SIMULINK  ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'browser under \textbf{Simulation$\rightarrow$Configuration Parameters\dots}.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'In the "Simulation Time" element the start time and the stop time can be insert. The solver type and certain solver ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'can be selected in the "Solver options". It is feasible to set the maximal, the minimal and the initial step size. ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'Other options are the relative tolerance, the absolute tolerance, the shape preservation and the number of consecutive ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 520],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'min steps.\\','interpreter','latex',...
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


% --- Executes on button press in Graph_window.
function Graph_window_Callback(hObject, eventdata, handles)
% hObject    handle to Graph_window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Textfeldbreite
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Graph window:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'In the graph window the actual graph is presented. The nodes of the graph ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'can be moved by a click and hold with the left mouse button. A node can ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'be added by \texttt{<Shift>-<Left-click>} with the mouse. To build a ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'connection a \texttt{<ctrl>-<Left-click>} has to be made on both nodes. ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'Is there an existing connection, this connection will be deleted. After ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 520],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'double-clicking on a node the "edit node"-window appears.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[60 110 30 480],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h8=text(0,0.5,' ' ,'interpreter' ,'latex',...
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
axes('units','pixels','position',[490 110 30 240],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h14=text(0,0.5,'Initial conditions for integrators','interpreter','latex',...
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
axes('units','pixels','position',[540 110 30 35],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'Edit node window','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[480 110 250 420],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('editnodea.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Graph_window_page2.
function Graph_window_page2_Callback(hObject, eventdata, handles)
% hObject    handle to Graph_window_page2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Graph window (2):}\\ ','interpreter','latex',...
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
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'','interpreter','latex',...
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

axes('units','pixels','position',[340 110 30 455],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h9=text(0,0.5,'Node information','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 420],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h10=text(0,0.5,'In this element the node number, the node label, the applied dynamics and the chosen parameter set can be seen. The  ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 380],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h11=text(0,0.5,'name of the node can be changed by clicking in the labeling field. New dynamics and parameter sets can be selected ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 340],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure. 
h12=text(0,0.5,'by using the control bars.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


axes('units','pixels','position',[40 110 30 280],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h13=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 240],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h14=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 200],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 120],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h16=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[140 110 30 40],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h17=text(0,0.5,'Plot parameters','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[230 110 350 180],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h18=imshow('plotparameters.jpg');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[210 110 350 640],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('nodeinfo.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Graph_window_page3.
function Graph_window_page3_Callback(hObject, eventdata, handles)
% hObject    handle to Graph_window_page3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Graph window (3):}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'To edit the plot parameters the window shown in the picture above is important. By selecting "Plot output signals" ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'or "Plot selected states" the program plots the defined outputs or states after a simulation is run. A click on the ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'"Edit Plot Parameters"-button leads to following window, where the Line Width, the Line Style, the Line Color, ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'the Marker Edge Color and the Marker Face Color can be varied.','interpreter','latex',...
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

axes('units','pixels','position',[340 110 30 455],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 420],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h10=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 380],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h11=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[280 110 30 300],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure. 
h12=text(0,0.5,'Color selection for the plots','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


axes('units','pixels','position',[40 110 30 240],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h13=text(0,0.5,'The "Submit Parameters"-button saves the parameters before closing the window, the "Cancel"-button does not ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 200],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h14=text(0,0.5,'save them.\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 240],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 120],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h16=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[140 110 30 40],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h17=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[230 110 350 180],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h18=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[110 110 520 440],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('editplot.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Graph_window_page4.
function Graph_window_page4_Callback(hObject, eventdata, handles)
% hObject    handle to Graph_window_page4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Graph window (4):}\\ ','interpreter','latex',...
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
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'','interpreter','latex',...
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

axes('units','pixels','position',[340 110 30 480],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h9=text(0,0.5,'Node information','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 420],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h10=text(0,0.5,'In the element "Incoming nodes" connections can be generated by writing the starting nodes in the brackets. Putting ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 380],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h11=text(0,0.5,'in a node number which does not exist, causes fatal errors.\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 340],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure. 
h12=text(0,0.5,'The changes can be confirmed with the "Apply Changes"-button. The node can be deleted with the "Delete Node"-button. ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


axes('units','pixels','position',[40 110 30 300],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h13=text(0,0.5,'For closing the window without applying the changes the "Cancel"-button can be used.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 260],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h14=text(0,0.5,'In order to check the consistency of the applied parameter values the "Consistency"-button can be used. ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 220],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'The "Edit params"-button opens a window where the parameter values of the dynamics can be changed.\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 120],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h16=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[140 110 30 40],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h17=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[230 110 350 180],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h18=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[210 110 350 640],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('incomingnodes.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Graph_window_page5.
function Graph_window_page5_Callback(hObject, eventdata, handles)
% hObject    handle to Graph_window_page5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Textfeldbreite
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Graph window (5):}\\ ','interpreter','latex',...
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
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'','interpreter','latex',...
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
axes('units','pixels','position',[340 110 30 20],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'Edit parameter values','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[210 110 420 400],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('editparaval.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Graph_window_page6.
function Graph_window_page6_Callback(hObject, eventdata, handles)
% hObject    handle to Graph_window_page6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Textfeldbreite
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Graph window (6):}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'The "Parameter Values"-window shows parameters of the dynamics in the selected template. A template is a SIMULINK ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'model of the dynamics of a node. It can be built under the point \textbf{"Dynamics$\rightarrow$Create Dynamics Template"} ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'in the menu bar. There is also a frame where the name of the parameter set can be edited.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'In the "Input Specifications" the Linear depending state parameters and there internal inputs are listed and also ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'the Linear depending outputs with the number of internal outputs.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 520],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'To edit the parameter values the parameter set manager can be opened with \textbf{"Dynamics$\rightarrow$Manage Parameter Sets"}','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 480],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h8=text(0,0.5,'The settings are stored to an extra file with the "Save to file"-button or saved to the actual template with the ' ,'interpreter' ,'latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 440],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h9=text(0,0.5,'"Save to template"-button. To leave the window without saving, click on the "Cancel"-button.\\','interpreter','latex',...
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
    'horiz','left','vert','middle'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Statistics_window.
function Statistics_window_Callback(hObject, eventdata, handles)
% hObject    handle to Statistics_window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Textfeldbreite
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Statistics window:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'The statistics window shows the basic statistics to the actual ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'graph. To get informations about the statistics the user guide ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'can be consulted by clicking the button. Also the chapter ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'"toolbox" provides detailed informations for the user.\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 520],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[60 110 30 480],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h8=text(0,0.5,' ' ,'interpreter' ,'latex',...
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
axes('units','pixels','position',[490 110 30 240],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h14=text(0,0.5,'Initial conditions for integrators','interpreter','latex',...
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
axes('units','pixels','position',[540 110 30 80],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'Basic statistics','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[420 110 300 420],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('statswin.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Editing_window.
function Editing_window_Callback(hObject, eventdata, handles)
% hObject    handle to Editing_window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Textfeldbreite
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Editing window:}\\ ','interpreter','latex',...
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
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'','interpreter','latex',...
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
h14=text(0,0.5,'In the editing window the graph, which is displayed in the graph window, is generated.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[340 110 30 280],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'Editing window','interpreter','latex',...
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
axes('units','pixels','position',[80 110 600 500],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('editingwindow.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Editing_window_page2.
function Editing_window_page2_Callback(hObject, eventdata, handles)
% hObject    handle to Editing_window_page2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Textfeldbreite
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Editing window (2): Node }\\ ','interpreter','latex',...
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
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 30],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'dynamics are applied to every node. The "Remove node"-button deletes the node with the user given number and all  ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 1],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h8=text(0,0.5,'the connections starting or ending in the node.\\' ,'interpreter' ,'latex',...
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


axes('units','pixels','position',[340 110 30 220],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h13=text(0,0.5,'Node creation','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 180],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h14=text(0,0.5,'A node is created by clicking on the "Add node"-button or by \texttt{<Shift>} \texttt{-<Left-click>} with the mouse. ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 150],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'In the white window next to the button the node can be labeled. The labels are only diplayed, when the "Label view" ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 120],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h16=text(0,0.5,'under the menu point "View" is active. It is also possible to add a user defined number of nodes with the ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 90],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h17=text(0,0.5,'"Add multiple nodes"-button. In the Dynamics-window between three dynamics and some value sets can be chosen. More ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 60],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'explanations for the dynamics follow in chapter "workflow".With the "Apply Dynamics to All Nodes"-button the selected ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[210 110 400 530],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('nodes.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Editing_window_page3.
function Editing_window_page3_Callback(hObject, eventdata, handles)
% hObject    handle to Editing_window_page3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Textfeldbreite
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Editing window (3): Connection}\\ ','interpreter','latex',...
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
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 30],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 1],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
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
axes('units','pixels','position',[40 110 30 400],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure. 
h12=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


axes('units','pixels','position',[340 110 30 370],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h13=text(0,0.5,'Connection creation','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 330],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h14=text(0,0.5,'In the writing fields after "From" and "to node" the nodes that will be connected can be specified either with their ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 290],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'label or their node number. The "Add connection"-button generates the defined connection. If the user puts in a node ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 250],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h16=text(0,0.5,'number, which does not exist, a fatal error occurs. The "Remove connection"-button deletes the connection and the ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 210],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h17=text(0,0.5,'"Random connection"-button adds a random connection anywhere in the graph. Another way to link two nodes, is a ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 170],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'\texttt{<Ctrl>-<Left-click>} on both. Is there an existing connection, this connection will be deleted.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[210 110 380 530],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('connectionsa.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Editing_window_page4.
function Editing_window_page4_Callback(hObject, eventdata, handles)
% hObject    handle to Editing_window_page4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Textfeldbreite
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Editing window (4): Topologies}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 240],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'In the control bar with the heading "Special graphs" between following random graph generating methods can be chosen:','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[80 110 30 210],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'-\textbf{Small world}','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[80 110 30 180],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'-\textbf{Scale-free}','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[80 110 30 150],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'-\textbf{Klemm-Eguiluz}','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[80 110 30 120],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'- \textbf{Adjustable scale free}','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 30],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 1],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
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
axes('units','pixels','position',[40 110 30 400],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure. 
h12=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


axes('units','pixels','position',[310 110 30 440],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h13=text(0,0.5,'Connection creation','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 400],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h14=text(0,0.5,'The "topologies"-window provides the ability to create some standard or random graphs.','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[80 110 30 360],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'-\textbf{"Make ring"-button}: generates a circular graph','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[80 110 30 330],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h16=text(0,0.5,'- \textbf{"Complete graph"-button}: generates a complete graph','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[80 110 30 300],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h17=text(0,0.5,'\textbf{-"Clear connections"-button}: deletes all connections','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[80 110 30 270],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'\textbf{-"Random graph"-button}: generates a random graph','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[210 110 280 600],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('topo.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Editing_window_page5.
function Editing_window_page5_Callback(hObject, eventdata, handles)
% hObject    handle to Editing_window_page5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Textfeldbreite
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Editing window (5): Modus}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 240],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[80 110 30 210],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[80 110 30 180],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[80 110 30 150],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[80 110 30 120],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 30],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 1],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
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
axes('units','pixels','position',[40 110 30 400],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure. 
h12=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


axes('units','pixels','position',[310 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h13=text(0,0.5,'Connection creation','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h14=text(0,0.5,'In this segment the modus of the graph can be selected with a radio button. The difference between an undirected ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 520],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'graph and a directed graph is that the direction of the information flow in a directed graph is shown by an arrow ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 480],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h16=text(0,0.5,'connection. An edge in an undirected graph has no arrows, because the information is always exchanged in both directions.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 440],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h17=text(0,0.5,'The "Circular visualization"-button, which is located under the modus choice, reorders the actual graph so that the ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 400],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'nodes are arranged on a circle. The neighboring nodes have an equal distance.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[280 110 170 700],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('modus.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Work_FLow.
function Work_FLow_Callback(hObject, eventdata, handles)
% hObject    handle to Work_FLow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Textfeldbreite
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Work flow:}\\ ','interpreter','latex',...
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
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'','interpreter','latex',...
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
axes('units','pixels','position',[340 110 30 20],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'Work Flow in MITDS','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 700 400],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('workflowmtids.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Work_FLow_page2.
function Work_FLow_page2_Callback(hObject, eventdata, handles)
% hObject    handle to Work_FLow_page2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Textfeldbreite
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Work flow(2):}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'The previous figure shows the general steps to work with MTIDS. After starting MTIDS the user panel which is the main ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'interface to build interconnected systems and their graph structure appears.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,' \textbf{Creation of the subsystem dynamics}','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'The first thing to do is to build the subsystem dynamics for every subsystem that will be part of the whole interconnected ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'system. Therefore either an empty template has to be filled with the desired dynamics or one of the three standard ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 520],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'templates can be used. A template is a SIMULINK model with a predefined frame structure (blue) for reasons of  ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 480],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h8=text(0,0.5,'converting it to MTIDS and a region where the user can implement his own dynamics (red). This frame structure should  ' ,'interpreter' ,'latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 440],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h9=text(0,0.5,'not be changed! The following picture presents an example template with LTI dynamics. The terminator blocks are   ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 400],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h10=text(0,0.5,'needed to avoid SIMULINK errors if the signal is not used.\\','interpreter','latex',...
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


% --- Executes on button press in Work_flow_page3.
function Work_flow_page3_Callback(hObject, eventdata, handles)
% hObject    handle to Work_flow_page3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Textfeldbreite
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Work flow (3):}\\ ','interpreter','latex',...
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
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'','interpreter','latex',...
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
axes('units','pixels','position',[270 110 30 40],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'Template for a LTI system','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[110 110 500 400],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('templateltia.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Work_flow_page4.
function Work_flow_page4_Callback(hObject, eventdata, handles)
% hObject    handle to Work_flow_page4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Textfeldbreite
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Work flow (4):}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'With the command \textbf{Dynamics$\rightarrow$Create Dynamics Template} in the menu bar the SIMULINK browser starts ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'and an empty template turns up. In the free, red marked space the user can put in any desired dynamics by using every ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'SIMULINK block. So there are endless possibilities for new templates and new dynamics.\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'','interpreter','latex',...
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
axes('units','pixels','position',[200 110 30 40],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'Empty template with red marked space for system dynamics','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[150 110 450 350],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('template2.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Work_flow_page5.
function Work_flow_page5_Callback(hObject, eventdata, handles)
% hObject    handle to Work_flow_page5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Textfeldbreite
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Work flow (5):}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'Use a provided template:','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'Three standard dynamics are provided:','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[80 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'-LTI (linear time invariant) system','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[80 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'-Consensus problem','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[80 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'-Kuramoto oscillator','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 520],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'The corresponding templates are shown in the figures. At first the LTI system template:\\','interpreter','latex',...
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
axes('units','pixels','position',[300 110 30 20],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'Template for a LTI system','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[210 110 360 270],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('templatelti.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Work_flow_page6.
function Work_flow_page6_Callback(hObject, eventdata, handles)
% hObject    handle to Work_flow_page6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Textfeldbreite
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Work flow (6):}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'The input of the LTI system template is constant zero, but can be replaced by any controller that uses state information ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'from local or even external systems.Below the Consensus problem template is shown:','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[80 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[80 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[80 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
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
axes('units','pixels','position',[300 110 30 1],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'Template for a consensus problem','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[110 110 550 334],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('templateconsensus.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Work_flow_page7.
function Work_flow_page7_Callback(hObject, eventdata, handles)
% hObject    handle to Work_flow_page7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Textfeldbreite
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Work flow (7):}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'The Figure displays the kuramoto oscillator template:','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[80 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[80 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[80 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
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
axes('units','pixels','position',[300 110 30 1],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h18=text(0,0.5,'Template for a kuramoto oscillator','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[110 110 550 334],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure.
h19=imshow('templatekuramoto.jpg'); %Bild implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save User_guide %Vor beenden werden die Variablen h1 bis h19 sowohl die Laufvariablen gespeichert. 


% --- Executes on button press in Work_flow_page8.
function Work_flow_page8_Callback(hObject, eventdata, handles)
% hObject    handle to Work_flow_page8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Textfeldbreite
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Work flow (8):}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'When the creation of the template is finished, in the next step the template has to be imported to MTIDS and the ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'parameters can be chosen in the parameter set manager (PSM). To open the PSM click  ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'\textbf{Dynamics$\rightarrow$ManageParameter Sets} in the menu bar. How to use the PSM is described in the chapter "Dynamics".\\','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'\textbf{Building an interconnected graph}','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'The building of a graph is straight forward. At first the desired Dynamics with preferred parameter set have to be ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 520],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'chosen in the editing window of the MTIDS user panel. After that the node can be created with a mouse-click or the ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 480],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h8=text(0,0.5,'right key combination. Easy like this, connections for directed or undirected graphs can be added. It is also possible ' ,'interpreter' ,'latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 440],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h9=text(0,0.5,'to build certain topologies, a complete graph, a circular graph or a random graph. When new edges are generated the ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 400],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h10=text(0,0.5,'parameters of a template do not fit together anymore. This problem can be solved by using ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 360],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h11=text(0,0.5,'\textbf{Simulation$\rightarrow$Input parameter adaption}. The graph statistics are updated automatically. To get more informations ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 288],'visible','off')%Bestimmen der x und y Posiotion der folgenden Figure. 
h12=text(0,0.5,'\textbf{Editing parameter settings}','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


axes('units','pixels','position',[40 110 30 240],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h13=text(0,0.5,'After double-clicking on a node the "edit node"-window opens, where the name, the dynamics and the parameter set ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 200],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h14=text(0,0.5,'can be specified in the "Node information". In the "Plot Parameters" it is possible to select whether the output','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 160],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h15=text(0,0.5,'and the states should be plotted after a simulation. ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 320],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h16=text(0,0.5,'look in the chapter "Simulation"','interpreter','latex',...
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


% --- Executes on button press in Work_flow_page9.
function Work_flow_page9_Callback(hObject, eventdata, handles)
% hObject    handle to Work_flow_page9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide %Laden der Variablen der letzten Simulation

if x > 1        %Laufvariable ist zu Beginn 1. Wenn diese gr��er als eins ist wird der Text von der vorherigen Funktion gel�scht. 
delete(h1);     %Variablen l�schen bzw. Text oder Figure aus .fig Datei l�schen
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


end
x=x+1; %Laufvariable hochz�hlen. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Textfeldbreite
axes('units','pixels','position',[40 110 30 760],'visible','off') %Bestimmen der x und y Posiotion des folgenden Textes. 
h1=text(0,0.5,'\underline{Work flow (9):}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes('units','pixels','position',[40 110 30 720],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h2=text(0,0.5,'\textbf{Simulation and post processing}','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 680],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h3=text(0,0.5,'When the graph with its dynamics and parameter settings is ready, the user can work with the system in MTIDS or ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 640],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h4=text(0,0.5,'export it to SIMULINK for a simulation. For the export \textbf{Simulation$\rightarrow$Export to Simulink} builds a SIMULINK  ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 600],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h5=text(0,0.5,'model. The simulation parameters can be determined in MTIDS under \textbf{Simulation$\rightarrow$Set simulation parameters}. ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 560],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h6=text(0,0.5,'The simulation data and results can be saved in *.mat files. Under \textbf{Simulation$\rightarrow$Run Simulation \& Plots} ','interpreter','latex',...
    'horiz','left','vert','middle');%Latex Code implementieren
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes('units','pixels','position',[40 110 30 520],'visible','off')%Bestimmen der x und y Posiotion des folgenden Textes. 
h7=text(0,0.5,'the simulation starts and predefined plots are made. With \textbf{File$\rightarrow$\dots} the graph can be saved or exported.','interpreter','latex',...
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


% --- Executes on button press in pushbutton75.
function pushbutton75_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton75 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton74.
function pushbutton74_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton74 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton73.
function pushbutton73_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton73 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
