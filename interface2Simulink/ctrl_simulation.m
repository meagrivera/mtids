function varargout = ctrl_simulation(varargin)
% CTRL_SIMULATION MATLAB code for ctrl_simulation.fig
%      CTRL_SIMULATION, by itself, creates a new CTRL_SIMULATION or raises the existing
%      singleton*.
%
%      H = CTRL_SIMULATION returns the handle to a new CTRL_SIMULATION or the handle to
%      the existing singleton*.
%
%      CTRL_SIMULATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CTRL_SIMULATION.M with the given input arguments.
%
%      CTRL_SIMULATION('Property','Value',...) creates a new CTRL_SIMULATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ctrl_simulation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ctrl_simulation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ctrl_simulation

% Last Modified by GUIDE v2.5 18-Dec-2011 15:58:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ctrl_simulation_OpeningFcn, ...
                   'gui_OutputFcn',  @ctrl_simulation_OutputFcn, ...
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


% --- Executes just before ctrl_simulation is made visible.
function ctrl_simulation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ctrl_simulation (see VARARGIN)

% Choose default command line output for ctrl_simulation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ctrl_simulation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ctrl_simulation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in start_simulation.
function start_simulation_Callback(hObject, eventdata, handles)
% hObject    handle to start_simulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global simout;

simout = sim(gcs);



% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in plot_states_over_time.
function plot_states_over_time_Callback(hObject, eventdata, handles)
% hObject    handle to plot_states_over_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global simout;


%get number of output nodes
temp = get_param(gcs,'Blocks');
nrOfNodes = size(temp,1);

%the data nodeout<i> is given within the matlab workspace after simulation
%combine 4 local states together in one plot
%counter
n = 1;
for i = 1:ceil(nrOfNodes / 4)
   figure;
   hold on;
   xlabel('Simulation time in [s]');
   ylabel('Absolute value of node output');
   for j = 1:4
      nrOfPlots = 4;
      if ((i-1)*4 + j) < nrOfNodes+1
          y = evalin('base',['nodeout' num2str(n)]);
          switch j
              case 1;
                  spec = '-k+';
              case 2;
                  spec = '--bo';
              case 3;
                  spec = ':g*';
              case 4;
                  spec = '-.rx';
          end
          plot(simout,y,spec,'Linewidth',1.2);
      else
          nrOfPlots = j-1;
          break;
      end
      n = n+1;
   end
   
   %to show a correct legend, compute: nr of plots, correct indexing of
   %node-number
   switch nrOfPlots
       case 4;
           legend(['Node' num2str(n-4)],['Node' num2str(n-3)],['Node' num2str(n-2)],['Node' num2str(n-1)]);
           title(['Behaviour of local agents' num2str(n-4) ' to ' num2str(n-1)]);
       case 3;
           legend(['Node' num2str(n-3)],['Node' num2str(n-2)],['Node' num2str(n-1)]);
           title(['Behaviour of local agents' num2str(n-3) ' to ' num2str(n-1)]);
       case 2;
           legend(['Node' num2str(n-2)],['Node' num2str(n-1)]);
           title(['Behaviour of local agents' num2str(n-2) ' to ' num2str(n-1)]);
       case 1;
           legend(['Node' num2str(n-1)]);
           title(['Behaviour of local agent' num2str(n-1)]);
   end
   
end


% --- Executes on button press in check_parametrization.
function check_parametrization_Callback(hObject, eventdata, handles)
% hObject    handle to check_parametrization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% implement check for missing parameters of the system
