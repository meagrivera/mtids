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
[isCorrect consistentNodes] = systemConsistencyTest( handles,0 ); %#ok<ASGLU>
badNodes = ~consistentNodes;

% ask for adaptation method
[mode check] = inputParamsAdaptation;
if ~check
    return
end
for ii = 1:nv(data.g)
    if badNodes(ii)
        vars = data.templates{ii,2}.inputSpec.Vars;
        tempSet = data.templates{ii,2}.set;
        nodeInputs = data.templates{ii,2}.nodeInputs;
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
                        valNew = ones( size(valOld,1),nodeInputs );
                    else
                        valNew=0;
                    end
                case 'meanNodes';
                    if nodeInputs>0
                        valNew = ones( size(valOld,1),nodeInputs )/nodeInputs;
                    else
                        valNew=0;
                    end
                case 'meanValues';
                    if nodeInputs>0
                        valNew = ones( size(valOld,1),nodeInputs )*mean(valOld,2);
                    else
                        valNew=0;
                    end
                case 'random';
                    if nodeInputs>0
                        valNew = randn( size(valOld,1),nodeInputs );
                    else
                        valNew=0;
                    end
                case 'preserve';
                    if nodeInputs>0
                        if size( valOld,2 ) < nodeInputs
                            valNew = [valOld ones(size(valOld,1),nodeInputs-size(valOld,2))];
                        elseif size( valOld,2 ) > nodeInputs
                            valNew = valOld(:,1:nodeInputs);
                        end
                    else
                        valNew=0;
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