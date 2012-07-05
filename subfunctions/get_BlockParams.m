function [ paramname paramvalue ] = get_BlockParams( varargin )
% This function gets the parameter names and values for predefined block
% types.
% OUTPUT:
%       paramname       -- Name of the Parameter
%       paramvalue      -- Value of the Parameter - this is the Value, the
%                           user has to set during his MTIDS session
%       dat             -- Table (cell) data; one line of the uitable

if size( varargin,2 ) < 3
    error('Insufficient number of input arguments');
end

blockType           = varargin{1};
handles             = varargin{2};
blockName           = varargin{3};

switch blockType
    case 'Gain';
        % check out the model explorer to get the correct parameter
        % names
        paramname = {'Gain'};
        % read it out of the imported system
        paramvalue = {get_param([handles.sysname '/' blockName],paramname{1})};
    case 'Integrator';
        paramname = {'InitialCondition'};
        paramvalue = {get_param([handles.sysname '/' blockName],paramname{1})};
    case 'Constant';
        paramname = {'Value'};
        paramvalue = {get_param([handles.sysname '/' blockName],paramname{1})};
    case 'Trigonometry';
        paramname = {'Operator'};
        paramvalue = {get_param([handles.sysname '/' blockName],paramname{1})};
    case 'StateSpace';
        paramname = {'A';'B';'C';'D';'X0'};
        paramvalue = cell( length(paramname) , 1);
        for j = 1:length(paramname)
            paramvalue{j} = get_param([handles.sysname '/' blockName],paramname{j});
        end
    otherwise;
        paramname = {''};
        %                 paramname = get_param([handles.sysname '/' listnms{i}],'DialogParameters')
        paramvalue = {''};
end

