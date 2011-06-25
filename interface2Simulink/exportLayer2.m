function[] =exportLayer2(name,template,templateList,A, xy, labs)
% exportLayer.m 
%
% Authors: Jose Rivera, Francisco Llobet 
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
% This function takes the data produced in mtids and generates a simulink
% model to function as template. This is used to do latering in grids


%% options
vizMaxNodeNumber=50;    % maximal number of nodes where Simulink opens

%% Ask for interface template
oldFolder = cd(strcat(pwd,'/templates'));
[filename, pathname] = uigetfile( ...
{'*.mdl','Simulink Model (*.mdl)';
   '*.*',  'All Files (*.*)'}, ...
   'Select Interface node template ');


 file = strcat(pathname, filename);

 addpath(pathname);
 
 [pathname, interface, ext] = fileparts(file);

cd(oldFolder);

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
nodeNumber= size(A,1)+1;
% 
% for i=1:size(templateList,1)
%     if any(strcmp(templateList{i},template))
%     templateModify(nodeNumber,templateList{i})
%     end
% end

% modify interface node

load_system(interface);
nodeConnections= 1:size(A,1);

    templateModify2(length(nodeConnections),nodeConnections,interface)
%% Arrange Subsystems and build them accourding to template

x=xy(:,1);
y=xy(:,2);

% Define reference frame
nodePosRadius= sqrt( x(1)^2 + y(1)^2) + nodeNumber/2;
graphCenter= [nodePosRadius+12 nodePosRadius+2] ;

% add input
add_block('built-in/Inport',[sys '/In1' ] , 'position', blockCanvas([1 graphCenter(2) ]) );
inPos= get_param([sys '/In1'],'position');
% add mux
add_block('built-in/Mux', [sys '/Mux' ],'position', inPos + [100 0 75 0 ] );
set_param( [sys '/Mux' ],'Inputs','2');
set_param( [sys '/Mux' ],'DisplayOption','bar');

% add out
add_block('built-in/Outport',[sys '/Out1' ] , 'position', blockCanvas([graphCenter(1)+nodePosRadius+5  graphCenter(2) ]) );

%add interface node
add_block('built-in/Subsystem',[sys '/Interface'] , 'position', blockCanvas([7 graphCenter(2) ]) );
Simulink.BlockDiagram.copyContentsToSubSystem(interface, [sys '/Interface' ]);

% close interface template
close_system(interface,0);

%connect things
add_line(sys,'Mux/1', 'Interface/1','autorouting','on')
add_line(sys,'In1/1', 'Mux/1','autorouting','on')



for i=1:nodeNumber-1
    
    
    load_system(template{i});
    
    nodeConnections= find(A(:,i));
    nodeConnections= [nodeConnections; nodeNumber] ;
    templateModify2(length(nodeConnections),nodeConnections,template{i})
   
%if i~=nodeNumber
    if x(i)>0
    nodePosAngle= atan(-y(i)/x(i)) ;
    else
      nodePosAngle= atan(-y(i)/x(i)) + pi ;  
    end
    
   nodePos= graphCenter + [nodePosRadius*cos(nodePosAngle) nodePosRadius*sin(nodePosAngle)] ;

add_block('built-in/Subsystem',[sys ['/' labs{i}]] , 'position', blockCanvas(nodePos) );



%modify template of subsystem call a function


Simulink.BlockDiagram.copyContentsToSubSystem(template{i}, [sys ['/' labs{i}]]);
%end

    
close_system(template{i},0);
    
    
    

end
% close subsystems templates
% for i=1:size(templateList,1)
% close_system(templateList{i},0)
% end

%% Connect Subsystems
open_system(sys)


for i=1:nodeNumber-1
    for j=1:nodeNumber-1
    
    %if i~=j  % make all nodes connect
    if i==nodeNumber
        add_line(sys,[ 'Interface/2'], [labs{j} '/' num2str(i)])
        
    else
        
    if A(i,j)~=0
   %add_line(sys,[labs{i} '/1'], [labs{j} '/' num2str(i)],'autorouting','on')
    add_line(sys,[labs{i} '/1'], [labs{j} '/' num2str( find(find(A(j,:)) == i))])
    end
 
    end
    end   
end

      
for i=1:nodeNumber-1
    %find a free port
    freePort= length(find(A(:,i))) + 1;
    %conect interface to free port
    add_line(sys,'Interface/2', [labs{i} '/' num2str(freePort)])
    add_line(sys,[labs{i} '/1'], ['Interface/' num2str(i+1)])
end

% interface connect to output

add_line(sys,'Interface/1', 'Out1/1','autorouting','on')

%% open system
% NO VISULAISATION FOR LARGE NUMBER OF NODES
if(nodeNumber<=vizMaxNodeNumber)
open_system(sys) 
end

%% save model ....
if(nodeNumber>vizMaxNodeNumber)
 [filename, pathname] = uiputfile( ...
{'*.mdl','Simulink Model (*.mdl)';
   '*.*',  'All Files (*.*)'}, ...
   'Save model');

 %file = strcat(pathname, filename);
try
save_system(sys,filename);
catch
   close_system(sys,0) 
end

close_system(sys,0)
end
%rmpath(pathname)