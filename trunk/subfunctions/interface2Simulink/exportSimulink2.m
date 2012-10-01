function varargout = exportSimulink2( varargin )
%EXPORTSIMULINK2 creates Simulink system out of MTIDS graph
%
% This function takes the data produced in mtids and generates an interconnected 
% dynamical system in simulink. The system is generated as a circle formation.
%      
% INPUT:    (1) -- name of model that will be produced
%           (2) -- template used to generate subsystems
%           (3) -- templateList: List of templates that are
%           (4) -- availible in mtids
%           (5) -- Adjacency matrix,
%           (6) -- Position of the nodes
%           (7) -- cell with the names of the nodes
%                      
% OUTPUT: (none) -- Creates a simulink model, which must be saved manually
%
% Authors: Francisco Llobet, Jose Rivera
% Editor: Ferdinand Trommsdorff (f.trommsdorff@gmail.com)
% Project: MTIDS (http://code.google.com/p/mtids/)
% Created: 27/5/2011

%% Read in variables

if size( varargin,2 ) < 7
    error('Insufficient number of input arguments');
end

name            = varargin{1};
templates       = varargin{2};
templateList    = varargin{3}; %#ok<NASGU>
A               = varargin{4};
xy              = varargin{5};
labs            = varargin{6};
flag_showSimMod = varargin{7};

%% options
vizMaxNodeNumber=50;    % maximal number of nodes where Simulink opens

%% Create the model 
try
    sys = name;
    new_system(sys)
catch  %#ok<*CTCH> % if subsystem already exist then look for an availible name
    for i=1:100
        newsys= [sys num2str(i)];
        try
            new_system(newsys) ;
            sys=newsys;
            break;
        catch
            
        end
    end
end

%% open template and modify it do not visulize if number of nodes to high
nodeNumber= size(A,1);
%
%for i=1:size(templateList,1)
%    if any(strcmp(templateList{i},template))
%    templateModify(nodeNumber,templateList{i})
%    end
%end

%% Arrange Subsystems and build them accourding to template

x=xy(:,1);
y=xy(:,2);

nodePosRadius= sqrt( x(1)^2 + y(1)^2) + nodeNumber/2;
graphCenter= [nodePosRadius+4 nodePosRadius+2] ;

for i=1:nodeNumber
    % Avoid problem with shadowing of .mdl-file "LTI"
    if strcmp(templates{i},'LTI')
        templates{i} = strcat('Copy_of_',templates{i});
    end
    invSysName = [ templates{i,1} '_CHECKED']; 
    load_system( invSysName ); % Loads an invisible Simulink model
    % Choose the valueSet according to the stored entries in templates
%     idxOfTemplate = ~cellfun( @isempty, ...
%         regexp( templateList(:,1), templates{i,1} ) );
%     
%     valueSet = templateList{idxOfTemplate,4};
%     valueSet = valueSet( templates{i,2} ).set;
    valueSet = templates{i,2}.set;  
    for jj = 1:size(valueSet,1)
       for kk = 2:2:size( valueSet(jj,:),2 )
           if ~isempty( valueSet(jj,kk) )
               set_param( [invSysName '/' valueSet{jj,1}], ...
                   valueSet{jj,kk},valueSet{jj,kk+1} );
           end
       end
    end    
    nodeConnections= find(A(:,i)); % Find in-degree   
    templateModify2(length(nodeConnections),nodeConnections,invSysName);
    %Numbers the To Workspace blocks, which have been added to every
    %template
    set_param( [ invSysName '/To Workspace'], 'VariableName', ['nodeout' num2str(i)] );  
    if x(i)>0
        nodePosAngle= atan(-y(i)/x(i)) ;
    else
        nodePosAngle= atan(-y(i)/x(i)) + pi ;  
    end 
    nodePos= graphCenter + [nodePosRadius*cos(nodePosAngle) nodePosRadius*sin(nodePosAngle)] ;
    add_block('built-in/Subsystem',[sys ['/' labs{i}]] , 'position', blockCanvas(nodePos) );
    %modify template of subsystem call a function
    Simulink.BlockDiagram.copyContentsToSubSystem(invSysName, [sys ['/' labs{i}]]);
    %close template
    close_system(invSysName,0)
end

%% Connect Subsystems
for i=1:nodeNumber
    for j=1:nodeNumber
        %if i~=j  % make all nodes connect
        if A(i,j)~=0
            %add_line(sys,[labs{i} '/1'], [labs{j} '/' num2str(i)],'autorouting','on')
            %add_line(sys,[labs{i} '/1'], [labs{j} '/' num2str(i)]);
            add_line(sys, [labs{i} '/1'], [labs{j} '/' num2str( find(find(A(:,j)) == i))]);
        end
    end   
end

%% open system
% NO VISUALIZATION FOR LARGE NUMBER OF NODES
if(nodeNumber<=vizMaxNodeNumber && flag_showSimMod == 1)
    open_system(sys);
    %Enables state saving to workspace
    set_param(gcs,'SaveState','on');
end

%% save model ....if model exist the whole thing gives an error (need unique name for model)
saveSucc = 0;
if nodeNumber>vizMaxNodeNumber || ~flag_showSimMod
    if strcmp( name,'untitled' )
        [filename, pathname] = uiputfile( ...
            {'*.mdl','Simulink Model (*.mdl)';
            '*.*',  'All Files (*.*)'}, ...
            'Save model');
    else
        filename = [name '.mdl'];
        pathname = [pwd filesep];
    end    
    %file = strcat(pathname, filename);
    try
        save_system(sys,[pathname filename]);
        saveSucc = 1;
    catch
        close_system(sys,0);
        saveSucc = 0;
    end    
    if saveSucc
        close_system(sys,0);
        close_system([pathname filename],0);
    end
end
if saveSucc
    varargout{1} = filename(1:end-4);
else
    varargout{1} = [];
end


%%%%%%%%