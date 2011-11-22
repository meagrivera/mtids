function [inDegree,outDegree] = getDegree(matrix)
% getDegree(matrix) -- Computes the in- and out-degree of a adjacency
%                      matrix, which represents a directed graph
% Input:
%   matrix -- Must be an N-by-N matrix with zeros on the diagonal
% Output:
%   inDegree -- A Vector of Size N-by-1, which holds the in degree of each
%               vertex of the graph, which is represented by 'matrix'
%   outDegree -- Similar to inDegree, but for the out degree of each vertex

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
