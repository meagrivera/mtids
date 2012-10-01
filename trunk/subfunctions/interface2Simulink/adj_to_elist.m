function elist = adj_to_elist(A)
%ADJ_TO_ELIST Reshapes an (N x N) adjacency matrix into a (M x 2) edge list
%
% This function takes an adjacency matrix as input and outputs an edge list
%
% INPUTS: A         -- Symmetric adjacency matrix (N x N)
%         
% OUTPUT: elist     -- Edge list (M x 2) 
%
%
% Authors: Francisco Llobet, Jose Rivera
% Editor: Ferdinand Trommsdorff (f.trommsdorff@gmail.com)
% Project: MTIDS (http://code.google.com/p/mtids/)
% Created: 30/5/2011

nv = size(A,1);
ne = 0;
for i=1:nv
   for j=i:nv
      if A(i,j)
          ne = ne + 1;
          elist(ne ,1) = i; %#ok<*AGROW>
          elist(ne ,2) = j;
          A(j,i) = 0;
      end
   end
end

if ne == 0
   elist = 0; 
end