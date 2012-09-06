function varargout = templateHasDependingInputs( varargin )
%TEMPLATEHASDEPENDINGINPUTS
%
% This returns if a given template obtains input parameters, which depend
% on the number of input signals and/or input signal size.
% INPUT:    (1) Index of node in mtids
%           (2) mtids structure 'data'
%
% OUTPUT:   (2) Boolean: true (1) or false (0)
%
%

nodeIDX     = varargin{1};
data        = varargin{2};

tempIDX = getTemplateIDX( nodeIDX,data );
paramIDX = getParamIDX(nodeIDX,data);

varargout{1} = any( ~cellfun( @isempty, ...
    data.template_list{tempIDX,4}(paramIDX).inputSpec.Vars ) );