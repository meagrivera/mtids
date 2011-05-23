% To be later extended to a function as an interface for Simulink...lets
% c..if this Works... ?
% To do: connect graphs in other topologies more imputs per LTI, set
% parameters of LTI and see if the simulation is able to run...
% HELP : Block-Specific Parameters
%con_port=get_param('untitled/block1','PortConnectivity')

% gives you the following information:
% 
% con_port=
% 3x1 struct array with fields:
%     Type
%     Position
%     SrcBlock
%     SrcPort
%     DstBlock
%     DstPort
% 
% This means that the sum of your inports and outports is 3 (e.g. one
% inport, two outports).
% 
% disp(con_port(1));
%     Type: '1'
%     Position: [160.00 120.00]
%     SrcBlock: 8906.00
%      SrcPort: 0
%     DstBlock: []
%      DstPort: []

%% load parameters of the grid
 load('test.mat')

 LTI= 'template';
%% number of nodes
nodeNumber= size(A,1);


%% Create the model
sys = 'testModel';
new_system(sys) 
open_system(sys) 

%% open template and modify it
templateModify(nodeNumber,LTI)


%% Arrange Subsystems and build them accourding to template
% To do : instead of modifying the LTI template each time...save a modified
% version of it...


graphCenter= [nodeNumber+2 nodeNumber-2] ;
nodePosRadius= sqrt( x(1)^2 + y(1)^2) + 2;

for i=1:nodeNumber

    if x(i)>0
    nodePosAngle= atan(-y(i)/x(i)) ;
    else
      nodePosAngle= atan(-y(i)/x(i)) + pi ;  
    end
    
   nodePos= graphCenter + [nodePosRadius*cos(nodePosAngle) nodePosRadius*sin(nodePosAngle)] ;

add_block('built-in/Subsystem',[sys ['/' labs{i}]] , 'position', blockCanvas(nodePos) );



%modify template of subsystem call a function


Simulink.BlockDiagram.copyContentsToSubSystem('template', [sys ['/' labs{i}]]);

%close template


end
close_system('template',0)


%% Connect Subsystems



for i=1:nodeNumber
    for j=1:nodeNumber
    
    %if i~=j  % connect ALL nodes
    if A(i,j)~=0
   add_line(sys,[labs{i} '/1'], [labs{j} '/' num2str(i)],'autorouting','on')
    end
 
    
    end   
end

%% save model ....if model exist the whole thing gives an error (need unique name for model)
%save_system(sys);

