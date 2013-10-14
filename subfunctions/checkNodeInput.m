function varargout = checkNodeInput( varargin )
%CHECKNODEINPUT Tests input signal
% This function checks if the number of input signals fits to its
% parameters
% INPUT:    (1) -- Node ID
%           (2) -- mtids structure 'data'
%
% OUTPUT:   (1) -- boolean: 1 for correct, 0 for errors occured
%           (2) -- structure 'error':
%                   error.ParamNotFound: cell with names of input
%                   depending variables, which names are not unique within
%                   the template
%                   error.DimMismatch: cell with names of input depending
%                   variables, which do not obtain the correct dimension
%           (3) -- signal size of node input
%
% Author: Ferdinand Trommsdorff (f.trommsdorff@gmail.com)
% Project: MTIDS (http://code.google.com/p/mtids/)

if size( varargin,2 ) == 2
    nodeIDX = varargin{1};
    data = varargin{2};
    mat = matrix( data.g );
    template = data.templates(nodeIDX,:);
end
if size( varargin,2 ) == 3
    nodeIDX = varargin{1};
    data = getappdata(varargin{2},'appData');
    mat = matrix( data.g );
    template = varargin{3};
end

% sparse admittanz matrix
[row col ~] = find( mat );

% indices of node, which have incoming edges to the current node
incomingIDX = row( col == nodeIDX );

% check out size of incoming signal
signalSize.states = zeros( length(incomingIDX),1 );
signalSize.outputs = zeros( length(incomingIDX),1 );
signalSize.template_outputs = zeros( length(incomingIDX),1 );
for ii = 1:size( incomingIDX,1 )
    % access to output dimension of incoming nodes (PDK)
    signalSize.states(ii) = data.templates{ incomingIDX(ii),2 }.dimension.states;
    signalSize.outputs(ii) = data.templates{ incomingIDX(ii),2 }.dimension.outputs;
    signalSize.template_outputs(ii) = data.templates{ incomingIDX(ii),2 }.dimension.template_outputs;
end
signalSize.states = sum(signalSize.states);
signalSize.outputs = sum(signalSize.outputs);
signalSize.template_outputs = sum(signalSize.template_outputs);

varargout{3} = signalSize;

if any( ~cellfun( @isempty, template{ 1,2 }.inputSpec.Vars ) ) %&& sum( signalSize )
    %   if ~isempty( incomingIDX )
    %   if sum(SignalSize)
    
        % Get cell with strings of depending variables
        Vars = template{1,2}.inputSpec.Vars;
        errorDimMismatch = zeros( length( Vars ),1 );
        errorParamNotFound = zeros( length( Vars ),1 );
        noOfIntInputs = template{1,2}.inputSpec.noOfIntInputs;
        % Text 2nd dimension of all depending input parameters
        for ii = 1:length( Vars )
            tempSet = template{1,2}.set;
            blockname=regexp( Vars{ii}, ',|\/','split');
            tempRow=find(strcmp(tempSet(:,1),blockname{1}));
            tempCol=find(strcmp(tempSet(tempRow,:),blockname{2}));
            %        [tempRow tempCol] = find( strcmp(tempSet,Vars{ii}) );
            if length(tempRow) > 1 || length(tempCol) > 1
                % Error: there is more than one parameter with name Vars{ii},
                % thus the depending input params couldn't be allocated. Try the
                % following: repeat the import of the template and rename the
                % depending parameters to unique names.
                errorParamNotFound(ii) = 1;
            else
                %            cmd1 = [Vars{ii} ' = ' tempSet{ tempRow,tempCol+1 } ';'];
                %            eval( cmd1 );
                %            cmd2 = ['tempDim = size(' Vars{ii} ',2);'];
                cmd1 = ['tempvar = ' tempSet{ tempRow,tempCol+1 } ';'];
                eval( cmd1 );
                cmd2 = ['tempDim = size(tempvar,2);'];
                eval( cmd2 );
                % Test if sum of all input signals subtracted by possible
                % internal feedback to the input is equal to
                if signalSize.states == 0
                    if tempDim~=1+noOfIntInputs
                        errorDimMismatch(ii) = 1;
                    end
                else
                    if tempDim ~= signalSize.states + noOfIntInputs
                        % Error: param Vars{ii} is not feasible for that graph
                        % structure
                        % The number of input signals and its size is not the same
                        % as specified in the input depending parameter Vars{ii}
                        errorDimMismatch(ii) = 1;
                    else
                        % do nothing
                    end
                end
            end
        end
        
        
        if any( errorDimMismatch ) || any( errorParamNotFound )
            varargout{1} = 0;
            error.DimMismatch = Vars( logical( errorDimMismatch ));
            error.ParamNotFound = Vars( logical( errorParamNotFound ));
            varargout{2} = error;
        else
            varargout{1} = 1;
            varargout{2} = [];
        end
%     else
%         
%         
%     end
else
    % if there is no parameter, which is depending on size of input
    % signals, then it should be work
    varargout{1} = 1;
    varargout{2} = [];
end

% Checks that the dimensions of the output variables match what enters the
% node (PDK)

if any( ~cellfun( @isempty, template{ 1,2 }.inputSpec.VarsOutput ) )
        % Get cell with strings of depending variables
        VarsOutput = template{1,2}.inputSpec.VarsOutput;
        errorDimMismatch = zeros( length( VarsOutput ),1 );
        errorParamNotFound = zeros( length( VarsOutput ),1 );
        noOfIntInputs = template{1,2}.inputSpec.noOfIntInputs;
        noOfIntOutputs = template{1,2}.inputSpec.noOfIntOutputs;
        % Text 2nd dimension of all depending input parameters
        for ii = 1:length( VarsOutput )
            tempSet = template{1,2}.set;
            blockname=regexp( VarsOutput{ii}, ',|\/','split');
            tempRow=find(strcmp(tempSet(:,1),blockname{1}));
            tempCol=find(strcmp(tempSet(tempRow,:),blockname{2}));
            %        [tempRow tempCol] = find( strcmp(tempSet,VarsOutput{ii}) );
            if length(tempRow) > 1 || length(tempCol) > 1
                % Error: there is more than one parameter with name VarsOutput{ii},
                % thus the depending input params couldn't be allocated. Try the
                % following: repeat the import of the template and rename the
                % depending parameters to unique names.
                errorParamNotFound(ii) = 1;
            else
                %            cmd1 = [VarsOutput{ii} ' = ' tempSet{ tempRow,tempCol+1 } ';'];
                %            eval( cmd1 );
                %            cmd2 = ['tempDim = size(' VarsOutput{ii} ',2);'];
                cmd1 = ['tempvar = ' tempSet{ tempRow,tempCol+1 } ';'];
                eval( cmd1 );
                cmd2 = ['tempDim = size(tempvar,2);'];
                eval( cmd2 );
                % Test if sum of all input signals subtracted by possible
                % internal feedback to the input is equal to
                if signalSize.outputs == 0
                    if tempDim~=1+noOfIntInputs
                        errorDimMismatch(ii) = 1;
                    end
                else
                    if tempDim ~= signalSize.outputs + noOfIntOutputs
                        % Error: param VarsOutput{ii} is not feasible for that graph
                        % structure
                        % The number of input signals and its size is not the same
                        % as specified in the input depending parameter VarsOutput{ii}
                        errorDimMismatch(ii) = 1;
                    else
                        % do nothing
                    end
                end
            end
        end
        
        if any( errorDimMismatch ) || any( errorParamNotFound )
            varargout{4} = 0;
            error.DimMismatch = VarsOutput( logical( errorDimMismatch ));
            error.ParamNotFound = VarsOutput( logical( errorParamNotFound ));
            varargout{5} = error;
        else
            varargout{4} = 1;
            varargout{5} = [];
        end
else
    % if there is no parameter, which is depending on size of input
    % signals, then it should be work
    varargout{4} = 1;
    varargout{5} = [];        
end

end



