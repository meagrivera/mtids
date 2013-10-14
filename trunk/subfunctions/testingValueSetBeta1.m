function varargout = testingValueSet( varargin )
%TESTINGVALUESET checking numerical parameters of template
%
% This function tests the parameter value sets of a dynamic template on its
% consistency.
%
% INPUT: (1) handles    - handles structure of invoking figure
%        (2) ask4choice - boolean, if the routine should ask explicitly for
%                           going on with the program
% OUTPUT: (1) dimension - structure with fields "states", which determines
%                           the number of internal states, and "outputs",
%                           which determines the size of the output signal
%         (2) choice - user's choice if value set should be saved and
%                           figure be closed or if the set should edited
%                           again
%         (3) ME_testSimulation - Error message of simulink test
%                                   simulation, ; is empty if
%                                   everything's alright
%         (4) ME_paramsFeasible - Error message of proper settings in each
%                                   template block; is empty if
%                                   everything's alright
%
% Author: Ferdinand Trommsdorff (f.trommsdorff@gmail.com)
% Project: MTIDS (http://code.google.com/p/mtids/)

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
   varargout{1} = [];
   varargout{2} = 'no';
   varargout{3} = [];
   varargout{4} = [];
   return
end
if notValid
   errordlg(['At least one parameter value is not feasible '...
       'for its specific block type. Please correct it (them).']);
   varargout{1} = [];
   varargout{2} = 'no';
   varargout{3} = [];
   varargout{4} = [];
   return
end

% Collecting all parameters and writing it into a copy of the Model
% save_system( handles.sysname, [pwd filesep handles.sysname '_tempCopy']);
save_system( handles.sysname, [pwd filesep handles.sysname '_tempCopy.mdl']);
Data = get(handles.t,'Data');
flagParamsFeasible = 0;
try
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
    flagParamsFeasible = 1;
catch ME_paramsFeasible
    if ask4choice
        errordlg({'An error occurred during insertion of the prompted template parameters.',...
            'Maybe this message will help you to find the error: ',...
            ME_paramsFeasible.message});
    end
end

%-------Troubleshoot------------
Data = get(handles.t,'Data');
        
%Gather information regarding the input parameters.
Vars = regexp( get(handles.TextField1InputSpecs,'String'), ',|\s','split')
Vars = Vars(~cellfun(@isempty,Vars))
Vars = Vars{1}
noOfIntInputs = str2double( get(handles.TextField2InputSpecs,'string') );


disp('No Outputs')
noOfInputsToMux = size( getNumericValue( Vars,handles ),2 ) - noOfIntInputs
states_vector = size( getNumericValue( Vars,handles ),2 )
set_param([handles.sysname '_tempCopy/Mux'],'Inputs',...
    num2str(noOfInputsToMux) );
Mux = get_param([handles.sysname '_tempCopy/Mux'],'Inputs')
initial_index = 1
end_index = states_vector
for ii = 1 : size(Data,1)
    if regexp(Data{ii,1},'Selector') > 0
        set_param([handles.sysname '_tempCopy/' Data{ii,1} ], 'InputPortWidth', strcat('',num2str(noOfInputsToMux),'') )
        set_param([handles.sysname '_tempCopy/' Data{ii,1} ], 'Indices', strcat('','[',num2str(1),']','') )
        InputSize = get_param([handles.sysname '_tempCopy/' Data{ii,1} ], 'InputPortWidth')
        Indices = get_param([handles.sysname '_tempCopy/' Data{ii,1} ], 'Indices')
%         initial_index = end_index
    end
 end


%---------------------

% Perform simulation with model
choice = 'No';
if flagParamsFeasible
    try
        % --- Adapt "/Mux" according to specified inputs ---
%         Vars = regexp( get(handles.TextField1InputSpecs,'String'), '[a-zA-Z0-9/]','match');
        Data = get(handles.t,'Data');
        
        %Gather information regarding the input parameters.
        Vars = regexp( get(handles.TextField1InputSpecs,'String'), ',|\s','split')
        Vars = Vars(~cellfun(@isempty,Vars))
        noOfIntInputs = str2double( get(handles.TextField2InputSpecs,'string') );
        
        %Gather information regarding the output parameters
        VarsOutput = regexp( get(handles.TextOutputspecs1,'String'), ',|\s','split');
        VarsOutput = VarsOutput(~cellfun(@isempty,VarsOutput));
        noOfIntOutputs = str2double( get(handles.TextOutputspecs2,'string') );
        
        if ~isempty( Vars )            
            Vars = Vars{1}; %strcat(Vars{1:end});

            %Adapt the Mux to include input of external output.  This will
            %be followed by the modification of the various selectors
            if ~isempty( VarsOutput )
                disp('With Outputs')
                VarsOutput = VarsOutput{1};
                states_vector = size( getNumericValue( Vars,handles ),2 )
                outputs_vector = size(getNumericValue(VarsOutput,handles),2)
                noOfInputsToMux =  outputs_vector + states_vector...
                     - noOfIntInputs - noOfIntOutputs;
                set_param([handles.sysname '_tempCopy/Mux'],'Inputs',...
                   num2str(noOfInputsToMux) )

               %Adapt the selector to exact indices from states and
                %outputs vectors
                initial_index = 1
                end_index = states_vector
                if initial_index == outputs_vector %For the case that there is only one input and one output
                    disp('equal initial and end indices')
                    for ii = 1 : size(Data,1)
                        if regexp(Data{ii,1},'Selector') > 0
                            set_param([handles.sysname '_tempCopy/' Data{ii,1} ], 'InputPortWidth', strcat('',num2str(4),'') )
                            set_param([handles.sysname '_tempCopy/' Data{ii,1} ], 'Indices', strcat('','[',num2str(initial_index),']','') )
                        end
                    end
                elseif initial_index == states_vector & outputs_vector > states_vector
                    disp('single intial and long outs')
                    for ii = 1 : size(Data,1)
                        if regexp(Data{ii,1},'Selector') > 0
                            set_param([handles.sysname '_tempCopy/' Data{ii,1} ], 'InputPortWidth', strcat('',num2str(noOfInputsToMux),'') )
                            set_param([handles.sysname '_tempCopy/' Data{ii,1} ], 'Indices', strcat('','[',num2str(initial_index:end_index),']','') )
                            initial_index = end_index + 1;
                            end_index = initial_index + outputs_vector - 1;                            
                        end
                    end
                else
                    disp('Non equal matricies')
                    for ii = 1 : size(Data,1)
                        if regexp(Data{ii,1},'Selector') > 0
                            set_param([handles.sysname '_tempCopy/' Data{ii,1} ], 'InputPortWidth', strcat('',num2str(noOfInputsToMux),'') )
                                if initial_index == end_index
                                    set_param([handles.sysname '_tempCopy/' Data{ii,1} ], 'Indices', strcat('','[',num2str(initial_index),']','') )                           
                                else                     
                                    set_param([handles.sysname '_tempCopy/' Data{ii,1} ], 'Indices', strcat('','[',num2str(initial_index:end_index),']','') )
                                end
                                initial_index = end_index + 1;
                                end_index = initial_index + outputs_vector - 1;
                        end
                    end
                end
            else    %Case when there exists only 'Linear Dependent Input Parameters'.
%                 disp('No Outputs')
%                 noOfInputsToMux = size( getNumericValue( Vars,handles ),2 ) - noOfIntInputs
%                 states_vector = size( getNumericValue( Vars,handles ),2 )
%                 set_param([handles.sysname '_tempCopy/Mux'],'Inputs',...
%                     num2str(noOfInputsToMux) );
%                 Mux = get_param([handles.sysname '_tempCopy/Mux'],'Inputs')
%                 initial_index = 1
%                 end_index = states_vector
%                 for ii = 1 : size(Data,1)
%                     if regexp(Data{ii,1},'Selector') > 0
%                         set_param([handles.sysname '_tempCopy/' Data{ii,1} ], 'InputPortWidth', strcat('',num2str(noOfInputsToMux),'') )
%                         set_param([handles.sysname '_tempCopy/' Data{ii,1} ], 'Indices', strcat('','[',num2str(initial_index:end_index),']','') )
%                         InputSize = get_param([handles.sysname '_tempCopy/' Data{ii,1} ], 'InputPortWidth')
%                         Indices = get_param([handles.sysname '_tempCopy/' Data{ii,1} ], 'Indices')
%                         initial_index = end_index
%                     end
%                  end
            end
%             else    %This "else" is occurs only if the LTIOutput template is being used. It adapts
                %the selector to handle the number of states in the Aij
                %matrix, i.e. j states.  Since the Cij matrix has to
                %have the same number of states, I have defined that
                %the input to the Mux to be comprised of j States and j
                %Outputs (these 'Outputs' being the outputs from the
                %other verticies' outputs which are directed into this
                %vertex).
%                 disp('lti Exists')
%                 Vars = Vars{1}
%                 noOfInputsToMux = 2 * size( getNumericValue( Vars,handles ),2 ) - noOfIntInputs;
%                 set_param([handles.sysname '_tempCopy/Mux'],'Inputs',...
%                         num2str(noOfInputsToMux) );
%                 states_vector = size( getNumericValue( Vars,handles ),2 )
%                 initial_index = 1;
%                 end_index = states_vector;
%                 for ii = 1 : size(Data,1)
%                     if regexp(Data{ii,1},'Selector') > 0
%                         set_param([handles.sysname '_tempCopy/' Data{ii,1} ], 'InputPortWidth', strcat('',num2str(2*noOfInputsToMux),'') )
%                         set_param([handles.sysname '_tempCopy/' Data{ii,1} ], 'Indices', strcat('','[',num2str(initial_index:end_index),']','') )
%                         Portwidth = get_param([handles.sysname '_tempCopy/' Data{ii,1} ], 'InputPortWidth')
%                         Indices = get_param([handles.sysname '_tempCopy/' Data{ii,1} ], 'Indices')
        end
    
       
        % set_param([template '/Mux'],'Inputs',num2str(nodeNumber));#
        warning('off','all');
        simout = sim( [handles.sysname '_tempCopy'],'StopTime','0.1',...
            'SaveState','on','StateSaveName','xoutNew','SaveOutput','on',...
            'OutputSaveName','youtNew');
        warning('on','all');
        if ~isempty(VarsOutput) | LTIOutputExists > 0
            dimension.states = size( simout.get('xoutNew'),2 );
            dimension.outputs = size( simout.get('youtNew'),2 )-size( simout.get('xoutNew'),2 );
            dimension.template_outputs = size( simout.get('youtNew'),2 )
        else
            dimension.states = size( simout.get('xoutNew'),2 );
            dimension.outputs = size( simout.get('youtNew'),2 )
        end
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
    if flagParamsFeasible
        varargout{3} = ME_testSimulation;
    else
        varargout{3} = [];
    end
else
    varargout{3} = [];
end
if flagParamsFeasible
    varargout{4} = [];
else
    varargout{4} = ME_paramsFeasible;
end

%%%%%%%%%%%%