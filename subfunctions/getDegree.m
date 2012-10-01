function [inDegree,outDegree] = getDegree(matrix)
%GETDEGREE Computes in- and outdegree of a node in a digraph
%
% Computes the in- and out-degree of a adjacency matrix, which represents 
% a directed graph.
%
% INPUT:   matrix    -- Must be an N-by-N matrix with zeros on the diagonal
%
% OUTPUT:  inDegree  -- A Vector of Size N-by-1, which holds the in degree 
%                       of each vertex of the graph, which is represented 
%                       by 'matrix'
%          outDegree -- Similar to inDegree, but for the outdegree of each 
%                       vertex
%
% Author: Ferdinand Trommsdorff (f.trommsdorff@gmail.com)
% Project: MTIDS (http://code.google.com/p/mtids/)
n = size(matrix,1);

inDegree = zeros(n,1);
outDegree = zeros(n,1);

for i=1:n
    inDegree(i) = length(find(matrix(:,i)));
    outDegree(i) = length(find(matrix(i,:)));
end

if sum(inDegree) ~= sum(outDegree)
    fprintf('Something went wrong with the computation of the vertex degrees.\n');
    return
end
