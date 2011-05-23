% buildSubsystem.m
%model to put 
function [] = buildSubsystem(nodeNumber,template,modelBlock)

open_system(template);

% degrre of subsystem (number of outs and ins)

set_param('template/Mux','Inputs',num2str(nodeNumber));


% get position of ins and outs
%  get_param('template/In1','position')
inPos= blockPos(get_param('template/In1','position')) ;
%outPos= blockPos(get_param('template/Out1','position'));


for i=2:nodeNumber
    inPos= [inPos(1) inPos(2)+2];
    %outPos= [outPos(1) outPos(2)+2];
add_block('built-in/Inport',['template/In' num2str(i)],'position',blockCanvas(inPos));
%add_block('built-in/Outport',['template/Out' num2str(i)],'position',blockCanvas(outPos));


add_line('template',['In' num2str(i) '/1'], ['Mux/' num2str(i)],'autorouting','on')
%add_line('template',[lastBlockBeforeOut '/1'], ['Out' num2str(i) '/1' ],'autorouting','on')
end

% copy modified template to subsystem
Simulink.BlockDiagram.copyContentsToSubSystem('template', modelBlock);

%close template
close_system('template',0)

