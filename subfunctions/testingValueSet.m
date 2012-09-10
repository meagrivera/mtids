function varargout = testingValueSet( varargin )
% This function tests the parameter value sets of a dynamic template on its
% consistency
% INPUT: (1) handles    - handles structure of invoking figure
%        (2) ask4choice - boolean, if the routine should ask explicitly for
%                           going on with the program
% OUTPUT: (1) dimension - structure with fields "states", which determines
%                           the number of internal states, and "outputs",
%                           which determines the size of the output signal
%         (2) choice - user's choice if value set should be saved and
%                           figure be closed or if the set should edited
%                           again
%         (3) ME_testSimulation - Error message of simulink test simulation
%

handles             = varargin{1};
if size( varargin,2 ) > 1
    ask4choice      = varargin{2};
else
    ask4choice      = 0;
end

% Checking if there is always a parameter value stored
misses = 0;
notValid = 0;
Data = get(handles.t,'Data');
for ii = 1:size( Data,1 )
    for jj = 2:2:size( Data,2 )
        paramExists = ~isempty( Data{ii,jj} );
        valueExists = ~isempty( Data{ii,jj+1} );
        if paramExists && ~valueExists
            misses = misses + 1;     
        end
        if paramExists && valueExists
            isValid = isValidData( handles, ii, jj+1 );
            if ~isValid
                notValid = notValid + 1;
            end
        end
    end
end
if misses
   errordlg(['At least one parameter values is missing.'...
       'Please add it (them).']);
   return
end
if notValid
   errordlg(['At least one parameter value is not feasible '...
       'for its specific block type. Please correct it (them).']);
   return
end

% Collecting all parameters and writing it into a copy of the Model
save_system( handles.sysname, [pwd filesep handles.sysname '_tempCopy']);
Data = get(handles.t,'Data');
for ii = 1:size( Data,1 )
    for jj = 2:2:size( Data,2 )
        paramExists = ~isempty( Data{ii,jj} );
        valueExists = ~isempty( Data{ii,jj+1} );        
        % store numerical values into temporal copy of model
        if paramExists && valueExists
            set_param([handles.sysname '_tempCopy/' Data{ii,1} ], Data{ii,jj}, Data{ii,jj+1} );
        end      
    end
end

% Perform simulation with model
choice = 'No';
try
    % Adapt "/Mux" according to specified inputs
    Vars = regexp( get(handles.TextField1InputSpecs,'String'), '[a-zA-Z0-9]','match');
    noOfIntInputs = str2double( get(handles.TextField2InputSpecs,'string') );
    if ~isempty( Vars )
        noOfInputsToMux = length( getNumericValue( Vars{1},handles ) ) - noOfIntInputs;
        set_param([handles.sysname '_tempCopy/Mux'],'Inputs',...
            num2str(noOfInputsToMux) );
    end
    
    % set_param([template '/Mux'],'Inputs',num2str(nodeNumber));
    simout = sim( [handles.sysname '_tempCopy'],'StopTime','0.1',...
        'SaveState','on','StateSaveName','xoutNew','SaveOutput','on',...
        'OutputSaveName','youtNew');
    dimension.states = size( simout.get('xoutNew'),2 );
    dimension.outputs = size( simout.get('youtNew'),2 );
    if ~isempty( simout )
        if ask4choice
            title = 'Testing suceeded';
            qstring = {'Variable check and explicit model simulation test suceeded.',...
                'Should the template import to MTIDS be finished?' };
            choice = questdlg(qstring,title,'Yes','No','No');
        else
            choice = 'yes';
        end
    end
catch ME_testSimulation
    if ask4choice
    errordlg(['The explicit test simulation of the simulink model failed. '...
        'Maybe this message will help you to find the error: '...
        ME_testSimulation.message ]);
    end
end
bdclose;
delete([pwd filesep handles.sysname '_tempCopy.mdl']);
load_system( [handles.pathname handles.sysname] );

if exist( 'dimension','var' )
    varargout{1} = dimension;
else
    varargout{1} = [];
end
varargout{2} = choice;
if strcmp( choice, 'no' )
    varargout{3} = ME_testSimulation;
else
    varargout{3} = [];
end

%%%%%%%%%%%%