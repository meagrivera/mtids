function [ data ] = conv2stable( data )
% Convert a coupling states matrix to a stable matrix while still
% preserving the coupling states entry locations within matrix.
% Compilation of the State Matrix A.
% 
% Author: Philip Koehler (philip.koehler@tum.de)
% Date: 18 September 2013
% Project: MTIDS (http://code.google.com/p/mtids/)

% Intializes the indices of the submatrices of A.
indices=cell(size(data.templates,1),1);
indices{1}=1:data.templates{1,2}.dimension.states;
lastindex = data.templates{1,2}.dimension.states;
for k = 2:size(data.templates,1)
    indices{k}=lastindex+1:lastindex+data.templates{k,2}.dimension.states;
    lastindex=lastindex+data.templates{k,2}.dimension.states;
end

%Calculation of total number of states.
numberofstates = 0; 

for k = 1 : size(data.templates,1)
    numberofstates = numberofstates + data.templates{k,2}.dimension.states;    
end

%Intialization of the A matrix with all zero entries.
A = zeros(numberofstates, numberofstates);

%Sets all diagonal entries with Aii values
flag = 1;
iteration = 1;
max_iteration = 1000;

while flag == 1 & iteration <= max_iteration
     for i = 1 : size(data.templates,1)
        Aii_dimension = size(str2num(data.templates{i,2}.set{1,3}),2);                                  % String entries converted to numerical values.
        A(indices{i},indices{i}) =  stable_matrix(0.00001,50 * iteration, Aii_dimension);               % Can be substituted for more eleganter solution
        firstindex = 1;
        lastindex = 0;
        Aij = str2num(data.templates{i,2}.set{2,3});                                                    %String entries from Aij converted to numerical values.
        for j = 1 : size(data.templates,1)
                if data.g{j,i}>0                                                                        %Through index j, checking which j node flows into i node.
                    lastindex = lastindex + data.templates{j,2}.dimension.states;                       %Prepares the ending index of subsystem matrix.
                    A(indices{i},indices{j})= Aij(:,firstindex:lastindex);                              %Inserts subsystem values into A matrix
                    firstindex = lastindex + 1;                                                         %If multiple edges flow into node i, prepares insertion of next section of Aij matrix.
                end
        end
    end

    flag = 0;
    eig_A = eig(A);
    
    for ii = 1 : size(eig_A,1)
        if real(eig_A(ii))>0
            flag = 1;
            break
        end
    end
    
    iteration = iteration + 1;
end

if iteration ~= max_iteration
    for i = 1 : size(data.templates,1)
        temp_Aii =  A(indices{i},indices{i});
        str = '[';
        for jj = 1:size(temp_Aii,1) % for each line of 'valNew'
            str = [str num2str(temp_Aii(jj,:)) ';']; %#ok<AGROW>
        end
        str(end) = ']';
%         temp_Aii = mat2str(temp_Aii);
        data.templates{i,2}.set{1,3} = str;
    end
    disp('Stability conversion successful!')
else
    disp('Stability conversion unsuccessful. Maximum iteration attained without a viable result.')
end

assignin('base','A', A);

% ---- Debugging tools: -----
% assignin('base','DATA',data);
% display(A)
% display(eig_A)
% display(iteration)

end

