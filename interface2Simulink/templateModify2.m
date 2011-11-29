% buildSubsystem.m
%model to put 
function [] = templateModify2(nodeNumber, nodeConnections, template)

% Template is already opened

% degree of subsystem (number of outs and ins)

% case distinction: number of inputs equals zero

% case distinction, if indegree equals zero
if (nodeNumber == 0)
    % task: delete input and mux
    
    % get position for constant block with zero values
    constPos= get_param([template '/In1'],'position');
    %constPos = constPos + [-20 -20 20 20];
    
    % delete line from Inport to Mux
    delete_line(template,'In1/1','Mux/1');
    % delete line from Mux to first input-block
    
    sigAll=find_system(template, 'FindAll', 'on','type','line');
    for n = 1:length(sigAll)
       if strcmp(get(sigAll(n),'SourcePort'),'Mux:1')
           endPoint = get(sigAll(n),'Points');
           delete_line(sigAll(n));
       end    
    end  
    
    % look for In1 before deletion
    if any(strcmp(get_param(template,'Blocks'), 'In1'))
        delete_block([template '/In1'])
    end
    
    % look for Mux before deletion
    if any(strcmp(get_param(template,'Blocks'), 'Mux'))
        delete_block([template '/Mux'])
    end
    
    % add constant block with value = 0
    add_block('built-in/Constant',[template '/Const']);
    set_param([template '/Const'],'position',constPos,'Value','0');
    
    % add line from const block to first subsystem block
    add_line(template, [get_param([template '/Const'],'Outport'); endPoint(2,:)]);
    
else % do job as before
    
    set_param([template '/Mux'],'Inputs',num2str(nodeNumber));
    set_param( [template '/Mux'],'DisplayOption','bar');


    % get position of ins and outs
    %  get_param('template/In1','position')
    inPos= blockPos(get_param([template '/In1'],'position')) ;
    %outPos= blockPos(get_param('template/Out1','position'));

    % change name of in-port 1
    set_param( [template '/In1'],'Name',['In' num2str(nodeConnections(1)) ] );

    for i=2:nodeNumber
        inPos= [inPos(1) inPos(2)+2];
        %outPos= [outPos(1) outPos(2)+2];
    add_block('built-in/Inport',[template '/In' num2str(nodeConnections(i))],'position',blockCanvas(inPos));
    %add_block('built-in/Outport',['template/Out' num2str(i)],'position',blockCanvas(outPos));


    add_line(template,['In' num2str(nodeConnections(i)) '/1'], ['Mux/' num2str(i)],'autorouting','on')
    %add_line('template',[lastBlockBeforeOut '/1'], ['Out' num2str(i) '/1' ],'autorouting','on')
    end
end
end

% copy modified template to subsystem

