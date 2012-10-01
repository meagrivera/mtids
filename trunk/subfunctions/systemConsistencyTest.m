function varargout = systemConsistencyTest( handles,varargin )
%SYSTEMCONSISTENCYTEST compares input signal with input depending parameters
%
% This function checks the system, consisting of the graph and its
% numerical dynamic parameters, which are hidden inside the node templates,
% for consistency
%
% INPUT:    (1) -- Handles to parent figure
%
% OUTPUT:   (1) -- Boolean, '1' for no errors found
%           (2) -- Vector containing if node has consistent input depending
%                   parameters
%
% Author: Ferdinand Trommsdorff (f.trommsdorff@gmail.com)
% Project: MTIDS (http://code.google.com/p/mtids/)

if size( varargin,2 ) == 1
    plotBadNodes = varargin{1};
else
    plotBadNodes = 1;
end
data = getappdata(handles.figure1,'appData');
if nv(data.g) ~= 0
    isCorrect = zeros( nv(data.g),1 );
    error = cell( nv(data.g),1 );
    for kk = 1:nv(data.g)
       [isCorrect(kk) error{kk}] = checkNodeInput(kk,data);  
    end
    if any( ~isCorrect )
        check = 0;
        % Display errors
        if plotBadNodes
            disp('Errors occured for node number...');
            for kk = 1:nv(data.g)
                if ~isCorrect(kk)
                    disp([num2str(kk) ', concerning the variables: ',...
                        error{kk}.DimMismatch   ]);
                end
            end
        end
    else
        check = 1;
    end
else
    check = 0;
    isCorrect = [];
end
varargout{1} = check;
varargout{2} = isCorrect;