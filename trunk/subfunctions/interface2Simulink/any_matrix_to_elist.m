function elist = any_matrix_to_elist(M,dir)
%ANY_MATRIX_TO_ELIST Reshapes an adjacency matrix into an edge list
%
% This function takes a matrix and outputs an edge list
%
% INPUT:    M     -- Laplacian, Adjacency or Edge List
%           dir   -- (optional) If dir = 1, the graph will be treated as
%                       directed
%         
% OUTPUT:   elist -- Edge list (M x 2 int) 
%
% Authors: Francisco Llobet, Jose Rivera
% Editor: Ferdinand Trommsdorff (f.trommsdorff@gmail.com)
% Project: MTIDS (http://code.google.com/p/mtids/)
% Created: 1/6/2011

if nargin < 2
    dir = 0;
end

[a, b] = size(M);

if (a == b)
    % Matrix is a square matrix
    % Test if matrix is symmetric
    if dir == 0
        if( M - M') %#ok<BDSCA,BDLOG>
            disp('Warning: Matrix is not symmetric');
            M = 0.500*(M + M');
        end
    end
    if(trace(M))
        %Matrix is a Laplacian
        D = diag(diag(M));
        L = M;
        M = D - L; % Converted to Adjacency matrix
    end
    abs(M);
    if dir == 0
        elist = adj_to_elist(M);
    elseif dir == 1
        [i,j] = find(M);
        elist = [i,j];
    end
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