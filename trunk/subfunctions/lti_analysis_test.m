function [ ] = lti_analysis_test( data, handles )
% lti_analysis_test compiles the A, B, C, and D matricies from the entire
% system and performs the tests of stability, observability, and
% controllability.

[~, ~, consistentNodesStates, ~] = systemConsistencyTest( handles,0 );
badNodesStates = ~consistentNodesStates;

if any(badNodesStates)
    errordlg('Not all nodes'' parameters are consistent.  Please recheck parameter dimensions of nodes or run Input Parameter Adaptation under the Simulation menu option.','Consistency Test')
    return
end

% Compilation of the State Matrix A.

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
for i = 1 : size(data.templates,1)
    Aii = str2num(data.templates{i,2}.set{1,3});                                %String entries converted to numerical values.
    A(indices{i},indices{i}) =  Aii;
end

%Remaining values are set into the A matrix through graph connections 
for i = 1 : size(data.templates,1)
    firstindex = 1;
    lastindex = 0;
    Aij = str2num(data.templates{i,2}.set{2,3});                                %String entries from Aij converted to numerical values.
    for j = 1 : size(data.templates,1)
            if data.g{j,i}>0                                                    %Through index j, checking which j node flows into i node.
                lastindex = lastindex + data.templates{j,2}.dimension.states;   %Prepares the ending index of subsystem matrix.
                A(indices{i},indices{j})= Aij(:,firstindex:lastindex);          %Inserts subsystem values into A matrix
                firstindex = lastindex + 1;                                     %If multiple edges flow into node i, prepares insertion of next section of Aij matrix.
            end
    end
end

assignin('base','A',A);                                                         %Places A matrix in the Workspace.

display(A)

%---------------------------------------------------------

%Compilation of the B matrix


%Assigns the variable B to an empty matrix.
B = [];

%Via the for loop and the blkdiag function, the B matrix is constructed.
for i = 1 : size(data.templates,1)
    Bi = str2num(data.templates{i,2}.set{3,3});                                 %Temporary variable to hold the converted from string to vector values.
    B = blkdiag(B,Bi);
end

assignin('base','B',B);                                                         %Places B matrix in the Workspace

display(B)

%---------------------------------------------------------

%Compilation of the C matrix


%Assigns the variable C to an empty matrix.
C = [];

%Intializes the indices of the submatrices of C.
indicesOut=cell(size(data.templates,1),1);
indicesOut{1}=1:data.templates{1,2}.dimension.outputs;
lastindex = data.templates{1,2}.dimension.outputs;
for k = 2:size(data.templates,1)
    indicesOut{k}=lastindex+1:lastindex+data.templates{k,2}.dimension.outputs;
    lastindex=lastindex+data.templates{k,2}.dimension.outputs;
end

%Calculation of total number of outputs.
numberofoutputs = 0; 

for k = 1 : size(data.templates,1)
    numberofoutputs = numberofoutputs + data.templates{k,2}.dimension.outputs;    
end


%Intialization of the C matrix with all zero entries.
C = zeros(numberofoutputs, numberofstates);

%Sets all diagonal entries with Cki values
for i = 1 : size(data.templates,1)
    Cki = str2num(data.templates{i,2}.set{4,3});                                %String entries converted to numerical values.
    C(indicesOut{i},indices{i}) =  Cki;
end

%Remaining values are set into the C matrix through graph connections 
for i = 1 : size(data.templates,1)
    firstindex = 1;
    lastindex = 0;
    Ckj = str2num(data.templates{i,2}.set{5,3});                                %String entries from Ckj converted to numerical values.
    for j = 1 : size(data.templates,1)
            if data.g{j,i}>0                                                    %Through index j, checking which j node flows into i node.
                lastindex = lastindex + data.templates{j,2}.dimension.states;   %Prepares the ending index of subsystem matrix.
                C(indicesOut{i},indices{j})= Ckj(:,firstindex:lastindex);          %Inserts subsystem values into C matrix
                firstindex = lastindex + 1;                                     %If multiple edges flow into node i, prepares insertion of next section of Aij matrix.
            end
    end
end

assignin('base','C',C);                                                         %Places C matrix in the Workspace

display(C)

%---------------------------------------------------------

%Compilation of the D matrix


%Assigns the variable D to an empty matrix.
D = [];

%Via the for loop and the blkdiag function, the D matrix is constructed.
for i = 1 : size(data.templates,1)
    Di = str2num(data.templates{i,2}.set{6,3});                                 %Temporary variable to hold the converted from string to vector values.
    D = blkdiag(D,Di);
end

assignin('base','D',D);                                                         %Places D matrix in the Workspace

display(D)

% ---------------------------------------------------------

% Testing the Stability, Controllability and Observability of the LTI system.

% Stability:
lambda = eig(A);
flag = 0;
for ii = 1 : size(A,1)
    if lambda(ii)>=0
        disp('The state matrix is unstable')
        flag = 1;
        break
    end
end

if flag ~= 1
    disp('The states matrix is stable.')
end

assignin('base','lambda', lambda);

% Controllability:

% Creation of the Controllability matrix.
[~, ~, ~, ~,k] = ctrbf(A,B,C);

rk = 0;

for ii = 1 : size(k,2)
    rk = rk + k(ii);
end

% Test if matrix is controllable via the rank method.
if rk == size(A,1)
    Co = 1;
    controllability = 'is';
else
    Co = -1;
    controllability = 'is not';
end

assignin('base','Co',Co);                                                        %Places the result of whether or not the Controllability matrix
                                                                                 %is controllable in the workspace.
disp(cat(2,'The system ', controllability,' controllable.'));
% ---------

% Observability:

% Creation of the Observability matrix.
[~,~,~,~,k] = obsvf(A,B,C);

% Test if matrix is observable via the rank method.
rk = 0;
for ii = 1 : size(k,2)
    rk = rk + k(ii);
end

if  rk == size(A,1)
    Ob = 1;
    observability = 'is';
else
    Ob = -1;
    observability = 'is not';
end

assignin('base','Ob',Ob);

disp(cat(2,'The system ', observability,' observable.'));


end

