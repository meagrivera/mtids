function input_parameter_adaptation_Callback(hObject, eventdata, handles) %#ok<INUSL>
%INPUT_PARAMETER_ADAPTATION_CALLBACK automatic correction of numerical parameters
%
% INPUT: hObject    -- handle to input_parameter_adaptation (see GCBO)
%        eventdata  -- reserved - to be defined in a future version of MATLAB
%        handles    -- structure with handles and user data (see GUIDATA)
%
% OUTPUT: (none)    -- Correct parameters are written directly into
%                       affected template value sets
%
% Author: Ferdinand Trommsdorff (f.trommsdorff@gmail.com)
% Project: MTIDS (http://code.google.com/p/mtids/)

data = getappdata(handles.figure1,'appData');

% get node which don't have consistent input depending parameters
[~, ~, consistentNodesStates, consistentNodesOutputs] = systemConsistencyTest( handles,0 ); % #ok<ASGLU>
badNodesStates = ~consistentNodesStates;
badNodesOutputs = ~consistentNodesOutputs;

% ask for adaptation method
[mode, check, factor ] = inputParamsAdaptation;
factor = str2num(factor);

if ~check
    return
end

for ii = 1:nv(data.g)
    if badNodesStates(ii)
        vars = data.templates{ii,2}.inputSpec.Vars;
        tempSet = data.templates{ii,2}.set;
        nodeInputstruct = data.templates{ii,2}.nodeInputs;
        nodeInputs = nodeInputstruct.states;
        for kk = 1:length(vars)
            blockname=regexp( vars{kk}, ',|\/','split');
            tempRow=find(strcmp(tempSet(:,1),blockname{1}));
            tempCol=find(strcmp(tempSet(tempRow,:),blockname{2}));
            %             [tempRow tempCol] = find( strcmp(tempSet,vars{kk}) );
            if length(tempRow) > 1 || length(tempCol) > 1
                % error
                return
            end
            valOld = str2num( tempSet{ tempRow,tempCol+1 } ); %#ok<ST2NM>
            switch mode
                case 'ones';
                    if nodeInputs>0
                        valNew = ones( size(valOld,1),nodeInputs )*factor;
                    else
                        valNew=zeros(size(valOld,1),1); %Editing (PDK)
                    end
                case 'meanNodes';
                    if nodeInputs>0
                        valNew = ones( size(valOld,1),nodeInputs )/nodeInputs;
                    else
                        valNew=zeros(size(valOld,1),1);
                    end
                case 'meanValues';
                    if nodeInputs>0
                        M1 = ones( size(valOld,1),nodeInputs );
                        M2 = mean(valOld,2);
                        for jj = 1:size(M1,1)
                           M1(jj,:) = M1(jj,:)*M2(jj); 
                        end
                        valNew = M1; %ones( size(valOld,1),nodeInputs )*mean(valOld,2);
                    else
                        valNew=zeros(size(valOld,1),1);
                    end
                case 'random';
                    if nodeInputs>0
                        valNew = randn( size(valOld,1),nodeInputs );
                    else
                        valNew=zeros(size(valOld,1),1);
                    end
                case 'preserve';
                    if nodeInputs>0
                        if size( valOld,2 ) < nodeInputs
                            valNew = [valOld ones(size(valOld,1),nodeInputs-size(valOld,2))];
                        elseif size( valOld,2 ) > nodeInputs
                            valNew = valOld(:,1:nodeInputs);
                        end
                    else
                        valNew=zeros(size(valOld,1),1);
                    end
            end
            % wrap 'valNew' into correct format for writing the values into
            % simulink blocks
            str = '[';
            for jj = 1:size(valNew,1) % for each line of 'valNew'
                str = [str num2str(valNew(jj,:)) ';']; %#ok<AGROW>
            end
            str(end) = ']';
            data.templates{ii,2}.set{tempRow,tempCol+1} = str;
        end
    end
end

% Runs through the output depending variables and adapts them to the vector
% input (PDK)

for ii = 1:nv(data.g)
    if badNodesOutputs(ii)
        varsoutput = data.templates{ii,2}.inputSpec.VarsOutput;
        tempSet = data.templates{ii,2}.set;
        nodeOutputstruct = data.templates{ii,2}.nodeInputs;
        nodeOutputs = nodeOutputstruct.outputs;
        for kk = 1:length(varsoutput)
            blockname=regexp( varsoutput{kk}, ',|\/','split');
            tempRow=find(strcmp(tempSet(:,1),blockname{1}));
            tempCol=find(strcmp(tempSet(tempRow,:),blockname{2}));
            %             [tempRow tempCol] = find( strcmp(tempSet,vars{kk}) );
            if length(tempRow) > 1 || length(tempCol) > 1
                % error
                return
            end
            valOld = str2num( tempSet{ tempRow,tempCol+1 } ); %#ok<ST2NM>
            switch mode
                case 'ones';
                    if nodeOutputs>0
                        valNew = ones( size(valOld,1),nodeOutputs )*factor;
                    else
                        valNew=zeros(size(valOld,1),1); %Editing (PDK);
                    end
                case 'meanNodes';
                    if nodeOutputs>0
                        valNew = ones( size(valOld,1),nodeOutputs )/nodeOutputs;
                    else
                        valNew=zeros(size(valOld,1),1);
                    end
                case 'meanValues';
                    if nodeOutputs>0
                        M1 = ones( size(valOld,1),nodeOutputs );
                        M2 = mean(valOld,2);
                        for jj = 1:size(M1,1)
                           M1(jj,:) = M1(jj,:)*M2(jj); 
                        end
                        valNew = M1; %ones( size(valOld,1),nodeInputs )*mean(valOld,2);
                    else
                        valNew=zeros(size(valOld,1),1);
                    end
                case 'random';
                    if nodeOutputs>0
                        valNew = randn( size(valOld,1),nodeOutputs );
                    else
                        valNew=zeros(size(valOld,1),1);
                    end
                case 'preserve';
                    if nodeOutputs>0
                        if size( valOld,2 ) < nodeOutputs
                            valNew = [valOld ones(size(valOld,1),nodeOutputs-size(valOld,2))];
                        elseif size( valOld,2 ) > nodeOutputs
                            valNew = valOld(:,1:nodeOutputs);
                        end
                    else
                        valNew=zeros(size(valOld,1),1);
                    end
            end
            % wrap 'valNew' into correct format for writing the values into
            % simulink blocks
            str = '[';
            for jj = 1:size(valNew,1) % for each line of 'valNew'
                str = [str num2str(valNew(jj,:)) ';']; %#ok<AGROW>
            end
            str(end) = ']';
            data.templates{ii,2}.set{tempRow,tempCol+1} = str;
        end
    end
end

setappdata(handles.figure1,'appData',data);