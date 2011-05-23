% will later be the change template function
% open f14 and f16
open_system('template');

% degrre of subsystem (number of outs and ins)
deg= 500 ;
lastBlockBeforeOut= 'State-Space';

%change number of inputs of Mux
set_param('template/Mux','Inputs',num2str(deg));


% get position of ins and outs
%  get_param('template/In1','position')
inPos= blockPos(get_param('template/In1','position')) ;
outPos= blockPos(get_param('template/Out1','position'));


for i=2:deg
    inPos= [inPos(1) inPos(2)+2];
    outPos= [outPos(1) outPos(2)+2];
add_block('built-in/Inport',['template/In' num2str(i)],'position',blockCanvas(inPos));
%add_block('built-in/Outport',['template/Out' num2str(i)],'position',blockCanvas(outPos));


add_line('template',['In' num2str(i) '/1'], ['Mux/' num2str(i)],'autorouting','on')
%add_line('template',[lastBlockBeforeOut '/1'], ['Out' num2str(i) '/1' ],'autorouting','on')
end

%%% setting number of Muxs Inputs

%close_system('template',0)
%open_system('template');

sys= 'testing';
new_system(sys)
open_system(sys);


add_block('built-in/Subsystem',[sys '/Subsystem1' ] , 'position', blockCanvas([3 3]) );
add_block('built-in/Subsystem',[sys '/Subsystem2'] , 'position', blockCanvas([5 3]) );



% copy the block diagram f14 to an empty subsystem of f16 named f14cp
Simulink.BlockDiagram.copyContentsToSubSystem('template', [sys '/Subsystem1']);
Simulink.BlockDiagram.copyContentsToSubSystem('template', [sys '/Subsystem2']);


close_system('template',0)