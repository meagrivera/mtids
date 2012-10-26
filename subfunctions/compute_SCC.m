function SCC_sets = compute_SCC( graph1 )
%COMPUTE_SCC Computes strong connected components of a digraph
%
% This function computes the sets of strong connected components of a
% digraph, based on Matgraph. Sketch of algorithm is explained inside the
% source code.
%
% INPUT:    graph1   -- edited Matgraph Object, which represents a directed
%                       graph
%
% OUTPUT:   SCC_sets -- Cell vector, each cell contains the members of a SCC.
%                       By definition, a single node is a SCC. To get the
%                       number of SCCs, use length(SCC_sets)
%
% Author: Ferdinand Trommsdorff (f.trommsdorff@gmail.com)
% Project: MTIDS (http://code.google.com/p/mtids/)

% Algorithm: start in an arbitrary node i - mark this node as first visited
% in the SCC set j - perform a DFS twice: first with correct directed
% edges, then with switch directed edges - obtain two sets of visited nodes
% (where the starting node is the minimum of nodes, which is contained for
% sure in both sets) - every node, which is contained in both sets, is part
% of the SCC set j - go on with nodes, which are not in a SCC set.

% useful functions: nv(graph), neighbors(graph) double(matrix(graph)), 
% fast_set_matrix(graph,new_Adjacency), dfstree(t,g,v)

% for the DFS with switched edges, edit a copy of that graph
graph1_switched = graph;
copy( graph1_switched , graph1 );
fast_set_matrix(graph1_switched, transpose( double( matrix( graph1 ) ) ) );

% prepare list of unvisited nodes
listUnvisited = 1:1:nv(graph1);
% prepare sets of SCC
SCC_sets = cell( nv(graph1), 1);
% use index counter for cell SCC_sets to obtain a cell where only the last
% elements are empty
indexCounter = 0;

% create temporal graph structure, which is used by "dfstree.m"
t = graph;

% outer loop for iterating through all nodes
for i = 1:nv(graph1)
    % check if node i isn't yet contained in a set of SCC
    if ~isempty(listUnvisited ( listUnvisited == i))
        % get visited nodes of dfs search for the original graph
        visited1 = dfstree(t,graph1,i);
        % get visited nodes of dfs for graph with switched edges
        visited2 = dfstree(t,graph1_switched,i);
        % get SCC by comparing both index vectors
        foundSCCs = find(visited1 & visited2);
        % increase indexCounter
        indexCounter = indexCounter + 1;
        % store found SCC sets in prepared cell vector
        SCC_sets{indexCounter} = num2str(foundSCCs');
        % remove found nodes out of listUnvisited
        for j = 1:length(foundSCCs)
            listUnvisited(listUnvisited == foundSCCs(j)) = 0;
        end
    end
end

% reduce cell vector to non-empty elements
posEmptyCells = find(cellfun(@isempty, SCC_sets));
if ~isempty(posEmptyCells)
    SCC_sets = SCC_sets(1:min(posEmptyCells)-1);
end
free(graph1_switched);
free(t);
% free(graph1);
    
    
%%%%%%%%%%%%%%%