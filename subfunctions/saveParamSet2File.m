function varargout = saveParamSet2File( varargin )
%SAVEPARAMSET2FILE storing parameter set for a template
%
% This function saves a parameter value set for a still existing dynamic
% template.
%
% INPUT:    (1) -- Figure handle to uicontrol-object 'Edit Text', which 
%                   specifies variables, which depend on the input signal 
%                   size of the template
%           (2) -- Figure handle to uicontrol-object 'Edit Text', which
%                   specifies the number of internal inputs, e.g. feedback
%                   loops
%           (3) -- Name of template, to which a parameter set should be saved
%           (4) -- Figure handle to uicontrol-object 'Edit Text', where
%                   the name of the param set was prompted
%           (5) -- Main part of the parameter set, is stored in table, if
%                   a GUI is used.
%           (6) -- States dimension of a template with an explicit
%                   numerical parametrization
%           (7) -- Pathname of the .mat-file, where at least one parameter
%                   set must be stored yet
%           (8) -- Flag 'enable overwrite'; if '1', the user will be asked,
%                   if a still existing set (with identical name) should be
%                   overwritten
%
% OUTPUT:   (1) -- Boolean; '1' for being successful
%           (2) -- Char array with error message in case of fail; if saving
%                   was sucessfull, the array is empty
%
% Author: Ferdinand Trommsdorff (f.trommsdorff@gmail.com)
% Project: MTIDS (http://code.google.com/p/mtids/)

handle4InputSpecsVars           = varargin{1}; % handles.TextField1InputSpecs
handle4InputSpecsNoOfIntInputs  = varargin{2}; % handles.TextField2InputSpecs
templName                       = varargin{3}; % answer{1}
handle4SetName                  = varargin{4}; % handles.EditFieldSetName
Data                            = varargin{5}; %#ok<*NASGU>
dimension                       = varargin{6};
pathname                        = varargin{7};
if size( varargin,2 ) > 7
    handle4IsActive             = varargin{8};
    isActive = get(handle4IsActive,'Value');
else
    isActive = 1;
end
    
if size( varargin,2 ) > 8
    overwriteEnable = varargin{9};
else
%     overwriteEnable = 1;
    overwriteEnable = 0;
end

flagEqual = 0;
flagExists = 0;
answer = 'No';
varargout{1} = 0;
varargout{2} = '';
% Prepare storing of input specifications
inputSpec.Vars =regexp( get(handle4InputSpecsVars,'String'),',\s|,|\s','split');
inputSpec.noOfIntInputs = str2double(get(handle4InputSpecsNoOfIntInputs,'string'));
% check if name was prompted
tempString = get(handle4SetName,'String');
if isempty(tempString)
    varargout{1} = 0;
    varargout{2} = 'No name for parameter set prompted';
    return
end
if exist([templName '_paramValues.mat'],'file')
    load([templName '_paramValues.mat']);
    % check if the paramSet still exists
    eval(['idx = length( ' templName '_paramValues);']);
    tmpStruct.set = Data;
    tmpStruct.dimension = dimension;
    tmpStruct.inputSpec = inputSpec;
    tmpStruct.setName = tempString;
    tmpStruct.isActive = isActive; %#ok<STRNU>
    for ii = 1:idx
        cmd2 = ['flagEqual = isequal(tmpStruct,' templName ...
            '_paramValues(' num2str(ii) '));'];
        eval( cmd2 );
        if flagEqual == 1
            varargout{2} = 'A parameter set with identical values still exists';
            break
        end
    end
    if flagEqual == 0
        % check if set-name was used before
%         tempString = get(handle4SetName,'String');
        for kk = 1:idx
            eval(['tmp = ' templName '_paramValues(' num2str(kk) ').setName;']);
            if strcmp( tempString,tmp )
                flagExists = 1;
                idxExists = kk;
            end
        end
        if ~flagExists
            % saving new field to existing struct
            cmd1 = [templName '_paramValues(' num2str(idx+1) ').set = '...
                'Data;'];
            cmd3 = [templName '_paramValues(' num2str(idx+1) ').dimension = '...
                'dimension;'];
            cmd4 = [templName '_paramValues(' num2str(idx+1) ').inputSpec = '...
                'inputSpec;'];
            cmd5 = [templName '_paramValues(' num2str(idx+1) ').setName = '''...
                tempString ''';'];
            cmd6 = [templName '_paramValues(' num2str(idx+1) ').isActive = '...
               num2str(isActive) ';'];
            eval( cmd1 );
            eval( cmd3 );
            eval( cmd4 );
            eval( cmd5 );
            eval( cmd6 );
            overwriteEnable = 0;
        else
            if overwriteEnable
                % saving to existing struct
                answer = questdlg('Overwrite existing parameter set?',...
                    'Overwriting request');
                if strcmp(answer,'Yes')
                    cmd1 = [templName '_paramValues(' num2str(idxExists) ').set = '...
                        'Data;'];
                    cmd3 = [templName '_paramValues(' num2str(idxExists) ').dimension = '...
                        'dimension;'];
                    cmd4 = [templName '_paramValues(' num2str(idxExists) ').inputSpec = '...
                        'inputSpec;'];
                    cmd5 = [templName '_paramValues(' num2str(idxExists) ').setName = '''...
                        tempString ''';'];
                    cmd6 = [templName '_paramValues(' num2str(idxExists) ').isActive = '...
                        num2str(isActive) ';'];
                    eval( cmd1 );
                    eval( cmd3 );
                    eval( cmd4 );
                    eval( cmd5 );
                    eval( cmd6 );
                    disp('Overwriting...');
                else
                    varargout{2} = 'Parameter set exists and wasn''t overwritten';
                end
            else
                varargout{2} = 'Name for parameter set still exists';                
                return
            end
        end
    end % if flagEqual == 0
else
    eval([templName '_paramValues.set = Data;']);
    eval([templName '_paramValues.dimension = dimension;']);
    eval([templName '_paramValues.inputSpec = inputSpec;']);
    eval([templName '_paramValues.isActive = isActive;']);
%     tempString = 'Value Set 1';
    eval([templName '_paramValues.setName = ' char(39) tempString char(39) ';']);
end
if (flagEqual == 0 && ~overwriteEnable) || (overwriteEnable && strcmp( answer,'Yes'))
    save([pathname templName '_paramValues'],[templName '_paramValues']);
    disp(['Parameter set ''' tempString ''' saved for template ''' templName '''']);
    varargout{1} = 1;
end

%%%%%%%%%