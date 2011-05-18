% To be later extended to a function as an interface for Simulink...lets
% c..if this Works... ?
% To do: connect graphs in other topologies more imputs per LTI, set
% parameters of LTI and see if the simulation is able to run...
%
%% number of nodes
nodeNumber= 50 ;


%% Create the model
sys = 'testModel';
new_system(sys) 
open_system(sys) 



%% Add LTI's

% Define block corners positions ()
x = 30;
y = 30;
w = 30;
h = 30;
offset = 60;
% generate names

for i = 1: nodeNumber;
nodeName{i}= ['LTI' num2str(i)];
end


for i=1:nodeNumber
    
 % subName= ['/LTI' num2str(i)];
  pos = [(x+i* offset) y (x+ i*offset)+w y+h];
 
    
add_block('built-in/State-Space',[sys ['/' nodeName{i}]],'Position',pos);

end

%% Connect LTI'S 

% ring network (connection to neighbors only)


for i=1:nodeNumber-1
    
    subNamePrev= ['LTI' num2str(i) '/1'];
     subNameNext= ['LTI' num2str(i+1) '/1'];
    
    add_line(sys,[nodeName{i} '/1'], [nodeName{i+1} '/1'],'autorouting','on')
    
    
    
end
add_line(sys,[nodeName{nodeNumber} '/1'], [nodeName{1} '/1'],'autorouting','on')

%add_line(sys,[nodeName{nodeNumber} '/1'], [nodeName{2} '/1'],'autorouting','on')

% one system going into more systems
% add_line(sys,'LTI3/1','LTI7/1','autorouting','on')
% add_line(sys,'LTI3/1','LTI5/1','autorouting','on')

%% save model ....if model exist the whole thing gives an error (need unique name for model)
%save_system(sys);

