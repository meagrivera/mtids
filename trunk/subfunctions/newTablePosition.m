function newTablePosition( varargin )
% Compute and set new layout positions for the figure

if size( varargin,2 ) < 4
    error('Insufficient number of arguments');
end

handles                 = varargin{1};
eventdata               = varargin{2};
rownames                = varargin{3};
dataNew                 = varargin{4};

figResize(handles.figure1,eventdata,handles);

while 1
    heightTableNew = 1.25*sizeChar2Pixel(handles.figure1, 'h', ( size(dataNew,1) + 2 ) );
    [ widthTableNew columnwidth] = get_tableColumnWidth(handles.figure1,...
        rownames,dataNew,get(handles.t,'ColumnName'));
    positionTable = abs(get(handles.t,'Position'));
    positionTableNew = positionTable;
    positionTableNew(3) = widthTableNew;
    positionTableNew(4) = heightTableNew;
    
    % positionTable = get(handles.t,'Position'); % [left, bottom, width, height]
    positionPanel = abs( get(handles.uipanel1, 'Position'));
    positionFigure = abs( get(handles.figure1, 'Position'));
    positionOuterFigure = abs( get(handles.figure1,'OuterPosition') );
    
    OffsetPanelTableHeight = positionPanel(4) - positionTable(4);
    OffsetFigureTableHeight = positionFigure(4) - positionTable(4);
    
    OffsetPanelTableWidth = positionPanel(3) - positionTable(3);
    OffsetFigureTableWidth = positionFigure(3) - positionTable(3);
    
    heigthPanelNew = positionTableNew(4) + OffsetPanelTableHeight;
    heigthFigureNew = positionTableNew(4) + OffsetFigureTableHeight;
    
    widthPanelNew = positionTableNew(3) + OffsetPanelTableWidth;
    widthFigureNew = positionTableNew(3) + OffsetFigureTableWidth;
    
    positionPanelNew = positionPanel;
    positionFigureNew = positionFigure;
    
    positionPanelNew(4) = round(heigthPanelNew);
    positionFigureNew(4) = round(heigthFigureNew);
    
    positionPanelNew(3) = round(widthPanelNew);
    positionFigureNew(3) = round(widthFigureNew);
    
    deltaHeight = positionFigureNew(4) - positionFigure(4);
    deltaOuterPos = positionOuterFigure - positionFigure;
    
    % Correct the bottom of the figure to avoid growing of figure to the top
    positionFigureNew(2) = round(positionFigureNew(2) - deltaHeight);
    positionOuterFigureNew = deltaOuterPos + positionFigureNew;
    
    if any([ positionPanelNew positionFigureNew positionOuterFigureNew positionTableNew] < 0)
        save('workspace@import_dynamic_params');
        figResize(handles.figure1,eventdata,handles);
        %     error('Position vector for graphic objects must be > 0');
    else
        break;
    end
end
set(handles.figure1,'Position',positionFigureNew,...
    'OuterPosition',positionOuterFigureNew);
set(handles.uipanel1,'Position',positionPanelNew);
set(handles.t,'RowName',rownames,'Data',dataNew,...
    'Position',positionTableNew,'ColumnWidth',columnwidth);

figResize(handles.figure1,eventdata,handles);