function varargout = performSimulation( varargin )
%PERFORMSIMULATION

handles = varargin{1};

data = getappdata(handles.figure1,'appData');
expSucc = data.expSucc;

% Simulation parameters
simPrms.stopTime = 10;

if expSucc
    currSysName = gcs;
    if isfield( data, 'sysFilename' ) && ...
            ~strcmp( gcs, data.sysFilename ) && ...
            exist( [data.sysFilename '.mdl'], 'file' )
        load_system( data.sysFilename );
        warning('off', 'all');
        simOut = sim( data.sysFilename,'StopTime',num2str(simPrms.stopTime),...
            'SaveState','on','StateSaveName','xout','SaveOutput','on',...
            'OutputSaveName','yout');
        close_system( data.sysFilename );
        warning('on', 'all');
    elseif ~isempty( currSysName )
        warning('off', 'all');
        simOut=sim(gcs,'StopTime',num2str(simPrms.stopTime),...
            'SaveState','on','StateSaveName','xout','SaveOutput','on',...
            'OutputSaveName','yout');
        warning('on', 'all');
    end
else
    errordlg('System not ready for simulation');
    return
end

varargout{1} = simOut;