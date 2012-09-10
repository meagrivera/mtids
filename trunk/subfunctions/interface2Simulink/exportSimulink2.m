function[] =exportSimulink2(name, templates, templateList, A, xy, labs, flag_showSimMod)
% exportSimulink.m 
%
% Project: MTIDS
% Created: 27/5/2011
%      
%                      inputs: -name: mname of model that will be produced
%                              -template: template used to generate subsystems
%                              - templateList: List of templates that are
%                                 availible in mtids
%                              -A: Adjacense matrix,
%                              -xy: Position of the nodes
%                              -labs: cell with the names of the nodes
%                      
%                      output: no output, produces a simulink model save manually !!
% 
% This function takes the data produced in mtids and generates an interconnected 
% dynamical system in simulink. The system is generated as a circle formation.

%% options
vizMaxNodeNumber=50;    % maximal number of nodes where Simulink opens

%% Create the model 


try
    sys = name;
new_system(sys) 

catch  % if subsystem already exist then look for an availible name

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
% NO VISULALIZATION FOR LARGE NUMBER OF NODES
if(nodeNumber<=vizMaxNodeNumber && flag_showSimMod == 1)
    open_system(sys);
    %Enables state saving to workspace
    set_param(gcs,'SaveState','on');
end

%% save model ....if model exist the whole thing gives an error (need unique name for model)
if(nodeNumber>vizMaxNodeNumber || flag_showSimMod == 0)
 [filename, pathname] = uiputfile( ...
{'*.mdl','Simulink Model (*.mdl)';
   '*.*',  'All Files (*.*)'}, ...
   'Save model');

 %file = strcat(pathname, filename);
try
save_system(sys,filename);
catch
   close_system(sys,0);
end

close_system(sys,0)
end



%%%%%%%%