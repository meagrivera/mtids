function elist = adj_to_elist(A)
%
% adj_to_elist(A).m:
%
% Authors: Francisco Llobet, Jose Rivera
% Project: MTIDS
% Created: 30/5/2011
% This function takes an adjacency matrix as input and outputs an edge list
%
% Inputs:
%           A:      Symmetric adjacency matrix (n x n double)
%         
% Outputs: 
%           elist:  Edge list (m x 2 int) 
%


nv = mean(size(A));
ne = 0;

for i=1:nv
   for j=i:nv
      
       if A(i,j)
          ne = ne + 1;
          elist(ne ,1) = i;
          elist(ne ,2) = j;
          A(j,i) = 0;
       end
       
   end
      
end