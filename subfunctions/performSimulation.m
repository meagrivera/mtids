function varargout = performSimulation( varargin )
%PERFORMSIMULATION Simulates the MTIDS system in Simulink
%
% This function simulates the MTIDS system in Simulink.
%
% INPUT:    (1) -- struct of figure handles from MTIDS main function
%
% OUTPUT:   (1) -- Simulation results as Simulink.SimulationOutpu
%                       object
%
% Author: Ferdinand Trommsdorff (f.trommsdorff@gmail.com)
% Project: MTIDS (http://code.google.com/p/mtids/)

handles = varargin{1};

data = getappdata(handles.figure1,'appData');
expSucc = data.expSucc;

% Simulation parameters
if ~isfield( data,'simPrms' )
    data.simPrms = editSimParams( [data.template_list{1,1} '_CHECKED'],[] );
end
set_param(data.simPrms,'SaveState','on','StateSaveName','xout',...
    'SaveOutput','on','OutputSaveName','yout');

if expSucc
    currSysName = gcs;
    if isfield( data, 'sysFilename' ) && ...
            ~strcmp( gcs, data.sysFilename ) && ...
            exist( [data.sysFilename '.mdl'], 'file' )
        load_system( data.sysFilename );
        warning('off', 'all');
%         simOut = sim( data.sysFilename,'StopTime',num2str(simPrms.stopTime),...
%             'SaveState','on','StateSaveName','xout','SaveOutput','on',...
%             'OutputSaveName','yout');
        simOut = sim( data.sysFilename,data.simPrms );
        close_system( data.sysFilename );
        warning('on', 'all');
    elseif ~isempty( currSysName )
        warning('off', 'all');
%         simOut=sim(gcs,'StopTime',num2str(simPrms.stopTime),...
%             'SaveState','on','StateSaveName','xout','SaveOutput','on',...
%             'OutputSaveName','yout');
        simOut = sim( gcs,data.simPrms );
        warning('on', 'all');
    else
        errordlg('System not ready for simulation');
        varargout{1}=[];
        return
    end
else
    errordlg('System not ready for simulation');
    varargout{1}=[];
    return
end
varargout{1} = simOut;
