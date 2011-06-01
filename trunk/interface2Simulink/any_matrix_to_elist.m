function elist = any_matrix_to_elist(M)
%
% any_matrix_to_elist().m:
%
% Authors: Francisco Llobet, Jose Rivera
% Project: MTIDS
% Created: 1/6/2011
% This function takes a matrix and outputs an edge list
%
% Inputs:
%           M:     Laplacian, Adjacency or Edge List
%         
% Outputs: 
%           elist:  Edge list (m x 2 int) 
%

[a, b] = size(M);

if (a == b)
    % Matrix is a square matrix
    % Test if matrix is symmetric
    if( M - M')
       disp('Warning: Matrix is not symmetric'); 
       M = 0.500*(M + M');     
    end
    
    if(trace(M))
       %Matrix is a Laplacian
       D = diag(diag(M));
       L = M;
       M = D - L; % Converted to Adjacency matrix
    end
    
        abs(M);
        
        elist = adj_to_elist(M);
    
   
elseif (b == 2) || (a == 2)
    % Matrix is probably an elist
    if (a == 2) && (b ~= 2)
        elist = M'; %Matrix is supposed to be a transposed Edge-list
    else
        elist = M;
    end
    
else
    % Matrix is not a recognized type
    disp('ERROR: Matrix format is not known');
end