function varargout = import_dynamic_params(varargin)
% IMPORT_DYNAMIC_PARAMS MATLAB code for import_dynamic_params.fig
%      IMPORT_DYNAMIC_PARAMS, by itself, creates a new IMPORT_DYNAMIC_PARAMS or raises the existing
%      singleton*.
%
%      H = IMPORT_DYNAMIC_PARAMS returns the handle to a new IMPORT_DYNAMIC_PARAMS or the handle to
%      the existing singleton*.
%
%      IMPORT_DYNAMIC_PARAMS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMPORT_DYNAMIC_PARAMS.M with the given input arguments.
%
%      IMPORT_DYNAMIC_PARAMS('Property','Value',...) creates a new IMPORT_DYNAMIC_PARAMS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before import_dynamic_params_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to import_dynamic_params_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help import_dynamic_params

% Last Modified by GUIDE v2.5 29-May-2012 11:20:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @import_dynamic_params_OpeningFcn, ...
                   'gui_OutputFcn',  @import_dynamic_params_OutputFcn, ...
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


% --- Executes just before import_dynamic_params is made visible.
function import_dynamic_params_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to import_dynamic_params (see VARARGIN)

% Choose default command line output for import_dynamic_params
handles.output = hObject;

listBlks = varargin{1};
listnms = varargin{2};
filename = varargin{3};
m=regexp( filename, '\.', 'split','once');
sysname = m{1};

%% Geometry
screenSize = get( 0, 'ScreenSize' );
fixedHeight = 150;
rowHeight = 30;
topFrame = 30;
bottomFrame = 0.5*topFrame;
sideFrame = 0.5*topFrame;

nrBlks = length(listBlks);

topGap = 1/12*screenSize(4);
left = screenSize(3)*0.1;
height = fixedHeight + nrBlks*rowHeight;

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
set(gcf,'Position',posVector,'Name','Import Dynamic Wizard','Toolbar','none','MenuBar','none','Resize','on');
defaultBackground = get(0,'defaultUicontrolBackgroundColor');
set(gcf,'Color',defaultBackground);

% parameters for panel, in which all other control elements are positioned
posVectorPanel = [sideFrame bottomFrame width-2*sideFrame height-topFrame]; % [left, bottom, width, height]
ph = uipanel('Parent',gcf,'Title','Collecting model parameters',...
        'Units','pixel','Position',posVectorPanel);

% parameters for pushbuttons
posVectorSubmitButton = [0.15*width 1.7*bottomFrame 140 35];
set(handles.pushbutton1,'Units','pixels','Position',posVectorSubmitButton,...
    'String','pushbutton1');

posVectorCancelButton = [0.55*width 1.7*bottomFrame 140 35];
set(handles.pushbutton2,'Units','pixels','String','pushbutton2',...
                'Position',posVectorCancelButton);


% build table with block information
t = uitable;
posVecTable = [1.5*sideFrame 5*bottomFrame width-3.5*sideFrame 40+nrBlks*rowHeight];
cnames = {'Block Name','Parameter Name','Value'};
columneditable =  [false true true];
columnformat = {'char','char','char'};
% rnames = cell(length(listBlks),1);
% for i = 1:length(listBlks)
%     rnames{i} = [listBlks{i} ': ' char(39) listnms{i} char(39)];
% end

% filling the table
dat = cell(length(listBlks),3);
dat(:,1) = listnms;
for i = 1:length(listBlks)
    % if there are well known block types here, we can provide some
    % initialisation of the table. If not, declare parameters names
    % otherwise
    switch listBlks{i}
        case 'Gain';
            % check out the model explorer to get the correct parameter
            % names
            paramname = 'Gain';
            % read it out of the imported system
            paramvalue = get_param([sysname '/' listnms{i}],paramname);
        case 'Integrator';
            paramname = 'InitialCondition';
            paramvalue = get_param([sysname '/' listnms{i}],paramname);
        case 'Constant';
            paramname = 'Value';
            paramvalue = get_param([sysname '/' listnms{i}],paramname);
        case 'StateSpace';
            paramname = {'A';'B';'C';'D';'X0'};
            paramvalue = cell( length(paramname) , 1);
            for j = 1:length(paramname)
                paramvalue{j} = get_param([sysname '/' listnms{i}],paramname{j});
            end
        otherwise;
            paramname = '';
            paramvalue = '';
    end

    for j = 1:length(paramname)
        dat{i,2*j} = paramname{j};
        dat{i,1+2*j} = paramvalue{j};
    end
end

set(t,'RowName',listBlks,'ColumnName',cnames,'Position',posVecTable,...
    'ColumnWidth','auto','Data',dat, 'ColumnEditable', columneditable,...
    'BackgroundColor',[1 1 1],'ColumnFormat',columnformat);





% Update handles structure
guidata(hObject, handles);

% UIWAIT makes import_dynamic_params wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = import_dynamic_params_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
