function create_ss_model(system_name, model_name, n_inputs, n_outputs, n_states)
%
% create_ss_model.m:
%
% Authors: Francisco Llobet, José Rivera
% Project: MTIDS
% Created: 26/5/2011
% This function creates a (state-space) block which has a defined number of inputs,
% outputs and states
%
% Inputs:
%           system_name: System name for Simulink(String)
%           model_name:  Name for the model subsystem (String)
%           n_inputs:    Number of inputs (int)
%           n_outputs:   Number of outputs (int)
%           n_states:    Number of states  (int)
% Outputs: 
%           

%open_system(system_name);

%add_block('built-in/Subsystem', strcat(system_name,'/',model_name));

%% Add a mux
add_block('built-in/Mux', strcat(system_name,'/',model_name,'/','Mux1'));
set_param( strcat(system_name,'/',model_name,'/','Mux1'),'Inputs',num2str(n_inputs));
set_param( strcat(system_name,'/',model_name,'/','Mux1'),'Position',[120,15,135,195]);
set_param( strcat(system_name,'/',model_name,'/','Mux1'),'DisplayOption','bar');

for i=1:n_inputs
    x0 = 40;
    y0 = 40;
    add_block('built-in/Inport', strcat(system_name,'/',model_name,'/','In',num2str(i)));
    set_param( strcat(system_name,'/',model_name,'/','In',num2str(i)),'Position',[x0,i*y0,x0+20,i*y0+20]);
    %Add connections to mux:
    add_line(strcat(system_name,'/',model_name),strcat('In',num2str(i),'/1'),strcat('Mux1/',num2str(i)),'autorouting','on');  
end

% Add a demux
add_block('built-in/Demux', strcat(system_name,'/',model_name,'/','Demux1'));
set_param( strcat(system_name,'/',model_name,'/','Demux1'),'Outputs',num2str(n_outputs));
set_param( strcat(system_name,'/',model_name,'/','Demux1'),'Position',[500,15,515,195]);
set_param( strcat(system_name,'/',model_name,'/','Demux1'),'DisplayOption','bar');


for i=1:n_outputs
    x0 = 550;
    y0 = 40;
    add_block('built-in/Outport', strcat(system_name,'/',model_name,'/','Out',num2str(i)));
    set_param( strcat(system_name,'/',model_name,'/','Out',num2str(i)),'Position',[x0 i*y0 x0+20 (i*y0+20)]);
    add_line(strcat(system_name,'/',model_name),strcat('Demux1/',num2str(i)),strcat('Out',num2str(i),'/1'),'autorouting','on');
end

%% Add State-Space block
 % State-Space matrix creator
    A =  eye(n_states);
    B = ones(n_states,n_inputs);
    C =  eye(n_outputs,n_states);
    D = zeros(n_outputs,n_inputs);

    A_str = matrix_to_string(A);
    B_str = matrix_to_string(B);
    C_str = matrix_to_string(C);
    D_str = matrix_to_string(D);

    add_block('built-in/State-Space', strcat(system_name,'/',model_name,'/','State-Space'));
    set_param(strcat(system_name,'/',model_name,'/','State-Space') , 'Position',[375,95,435,125]);
    set_param(strcat(system_name,'/',model_name,'/','State-Space') , 'A',A_str, 'B', B_str, 'C', C_str, 'D', D_str);
    
    % Connect to Mux and Demux
    add_line(strcat(system_name,'/',model_name),'State-Space/1','Demux1/1','autorouting','on');
    add_line(strcat(system_name,'/',model_name),'Mux1/1','State-Space/1','autorouting','on');


