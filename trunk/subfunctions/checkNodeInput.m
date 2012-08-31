function varargout = checkNodeInput( varargin )
% This function checks if the number of input signals fits to its
% parameters
% OUTPUT:   (1) boolean: 1 for correct, 0 for incorrect
%           (2) incoming signal size

nodeIDX = varargin{1};
data = varargin{2};

% sparse admittanz matrix
[row col ~]= find( matrix( data.g ) );

% indices of node, which have incoming edges to the current node
incomingIDX = row( col == nodeIDX );

% check out size of incoming signal
signalSize = zeros( length(incomingIDX),1 );
for ii = 1:length( incomingIDX )
    % index of template
    tempIDX = getTemplateIDX( incomingIDX(ii), data);
    % index of param value set
    paramIDX = getParamIDX(incomingIDX(ii),data);
    % access to output dimension
    signalSize(ii) = data.template_list{ tempIDX,4 }(paramIDX).dimension.outputs;
end

% check out depending parameters
tempIDX = getTemplateIDX( nodeIDX,data );
paramIDX = getParamIDX(nodeIDX,data);
    
if any( ~cellfun( @isempty, data.template_list{tempIDX,4}(paramIDX).inputSpec.Vars ) )
   Vars = data.template_list{tempIDX,4}(paramIDX).inputSpec.Vars;
   % assuming that both depend linearly of input parameters; thus we can
   % choose an arbitrary one out of it
else
    % if there is no parameter, which is depending on size of input
    % signals, then it should be work
    varargout{1} = 1;
end

varargout{2} = sum( signalSize );


