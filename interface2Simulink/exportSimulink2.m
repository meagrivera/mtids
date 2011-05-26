function[] =exportSimulink2(name, A, xy, labs)

% exportSimulink2.m :      
%                       input: name: mname of model that will be produced
%                               template: template used to generate subsystems
%                               A: Adjacense matrix,
%                               xy: Position of the nodes
%                               labs: cell with the names of the nodes
%                      
%                      output: no output, produces a simulink model save manually !!
% 
% This function takes the data produced in mtids and generates an interconnected 
% dynamical system in simulink. The system is generated as a circle formation.

%% Create the model
sys = name;
new_system(sys) 
open_system(sys) 

%% open template and modify it
nodeNumber= size(A,1);
% templateModify(nodeNumber,template)

%% Arrange Subsystems and build them accourding to template

x=xy(:,1);
y=xy(:,2);

graphCenter= [nodeNumber+2 nodeNumber-2] ;
nodePosRadius= 2*sqrt( x(1)^2 + y(1)^2) + 2;

for i=1:nodeNumber

    if x(i)>0
    nodePosAngle= atan(-y(i)/x(i)) ;
    else
      nodePosAngle= atan(-y(i)/x(i)) + pi ;  
    end
    
   nodePos= graphCenter + [nodePosRadius*cos(nodePosAngle) nodePosRadius*sin(nodePosAngle)] ;

add_block('built-in/Subsystem',strcat(sys,'/',labs{i}), 'Position', blockCanvas(nodePos) );
create_ss_model(name, labs{i}, nodeNumber, 1, 2);



%modify template of subsystem call a function


%Simulink.BlockDiagram.copyContentsToSubSystem('template', [sys ['/' labs{i}]]);

%close template


end
%close_system('template',0)


%% Connect Subsystems



for i=1:nodeNumber
    for j=1:nodeNumber
    
    %if i~=j  % make all nodes connect
    if A(i,j)~=0
   add_line(sys,[labs{i} '/1'], [labs{j} '/' num2str(i)],'autorouting','on')
    end
 
    
    end   
end

%% save model ....if model exist the whole thing gives an error (need unique name for model)
%save_system(sys);