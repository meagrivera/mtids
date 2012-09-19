% --------------------------------------------------------------------
function input_parameter_adaptation_Callback(hObject, eventdata, handles)
% hObject    handle to input_parameter_adaptation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
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
            [tempRow tempCol] = find( strcmp(tempSet,vars{kk}) );
            if length(tempRow) > 1 || length(tempCol) > 1
                % error
                return
            end
            valOld = str2num( tempSet{ tempRow,tempCol+1 } );
            switch mode
                case 'ones';
                    valNew = ones( size(valOld,1),nodeInputs );
                case 'meanNodes';
                    valNew = ones( size(valOld,1),nodeInputs )/nodeInputs;
                case 'meanValues';
                    valNew = ones( size(valOld,1),nodeInputs )*mean(valOld,2);
                case 'random';
                    valNew = randn( size(valOld,1),nodeInputs );
                case 'preserve';
                    if size( valOld,2 ) < nodeInputs
                        valNew = [valOld ones(size(valOld,1),nodeInputs-size(valOld,2))];
                    elseif size( valOld,2 ) > nodeInputs
                        valNew = valOld(:,1:nodeInputs);
                    end
            end
            % wrap 'valNew' into correct format for writing the values into
            % simulink blocks
            str = '[';
            for jj = 1:size(valNew,1) % for each line of 'valNew'
                str = [str num2str(valNew(jj,:)) ';'];
            end
            str(end) = ']';
            data.templates{ii,2}.set{tempRow,tempCol+1} = str;
        end
    end
end

setappdata(handles.figure1,'appData',data);