function varargout = saveParamSet2File( varargin )
%SAVEPARAMSET2FILE
% This function saves a parameter value set for a still existing dynamic
% template
%
% INPUT:    (1) handle4InputSpecsVars
%           (2) handle4InputSpecsNoOfIntInputs
%           (3) templName
%           (4) handle4SetName
%           (5) Data
%           (6) dimension
% OUTPUT:   (1) 1 for being successful, 0 for fail
%           (2) Error message in case of fail

handle4InputSpecsVars           = varargin{1}; % handles.TextField1InputSpecs
handle4InputSpecsNoOfIntInputs  = varargin{2}; % handles.TextField2InputSpecs
templName                       = varargin{3}; % answer{1}
handle4SetName                  = varargin{4}; % handles.EditFieldSetName
Data                            = varargin{5}; %#ok<*NASGU>
dimension                       = varargin{6};
pathname                        = varargin{7};

flagEqual = 0;
varargout{1} = 0;
varargout{2} = '';
% Prepare storing of input specifications
inputSpec.Vars =regexp( get(handle4InputSpecsVars,'String'),',\s|,|\s','split');
inputSpec.noOfIntInputs = str2double(get(handle4InputSpecsNoOfIntInputs,'string'));
if exist([templName '_paramValues.mat'],'file')
    load([templName '_paramValues.mat']);
    % check if the paramSet still exists
    eval(['idx = length( ' templName '_paramValues);']);
    for ii = 1:idx
        cmd2 = ['flagEqual = isequal(Data,' templName ...
            '_paramValues(' num2str(ii) ').set);'];
        eval( cmd2 );
        if flagEqual == 1
            varargout{2} = 'A parameter set with identical values still exists';
            break
        end
    end
    if flagEqual == 0
        cmd1 = [templName '_paramValues(' num2str(idx+1) ').set = '...
            'Data;'];
        cmd3 = [templName '_paramValues(' num2str(idx+1) ').dimension = '...
            'dimension;'];
        cmd4 = [templName '_paramValues(' num2str(idx+1) ').inputSpec = '...
            'inputSpec;'];
        tempString = get(handle4SetName,'String');
        if regexp( tempString, 'Value Set')
            tempString = ['Value Set ' num2str(idx+1) ];
        else
            % check if set-name was used before
            for kk = 1:idx
                eval(['tmp = ' templName '_paramValues(' num2str(kk) ').setName;']);
                if strcmp( tempString,tmp )
%                     disp('Setname still exists - Please choose another one');
                    varargout{2} = 'Name for parameter set still exists';
                    return
                end
            end
        end
        cmd5 = [templName '_paramValues(' num2str(idx+1) ').setName = '''...
            tempString ''';'];
        eval( cmd1 );
        eval( cmd3 );
        eval( cmd4 );
        eval( cmd5 );
    end
else
    eval([templName '_paramValues.set = Data;']);
    eval([templName '_paramValues.dimension = dimension;']);
    eval([templName '_paramValues.inputSpec = inputSpec;']);
    tempString = 'Value Set 1';
    eval([templName '_paramValues.setName = ' tempString ';']);
end
if flagEqual == 0
    save([pathname templName '_paramValues'],[templName '_paramValues']);
    disp(['Parameter set ''' tempString ''' saved for template ''' templName '''']);
    varargout{1} = 1;
end

%%%%%%%%%