function WCC_sets = compute_WCC( graphINPUT )
%COMPUTE_WCC Computes weak connected components of a digraph
%
% This function computes the weak connected components of a directed graph,
% based on Matgraph. Sketch of algorithm is explained inside the source
% code.
%
% INPUT: graph1    --   Edited Matgraph graph object, which represents a
%                       directed graph
% OUTPUT: WCC_sets --   Cell vector, each cell contains the numbers of
%                       nodes, which belong to its WCC. For the number WCC
%                       sets, use length(WCC_sets)
%
% Author: Ferdinand Trommsdorff (f.trommsdorff@gmail.com)
% Project: MTIDS (http://code.google.com/p/mtids/)

% Algorithm: for each node exchange the directed edges with andirected
% edges - perform a DFS and set all visited nodes, including the start
% node, to a set of WCC.
% Attention: due to the special Matgraph data storage, the input graph is a
% reference to the original graph in mtids. This means, that graph should
% not be edited. Thus a new copy must be generated.

% set a new copy of graph
graph1 = graph;
copy(graph1,graphINPUT);

% exchange all directed edges with undirected edges
newAdj = logical(double( matrix( graph1 )) + double( matrix( graph1 ))');
fast_set_matrix( graph1, newAdj);

% prepare list of unvisited nodes
listUnvisited = 1:1:nv(graph1);
% prepare sets of SCC
WCC_sets = cell( nv(graph1), 1);
% use index counter for cell SCC_sets to obtain a cell where only the last
% elements are empty
indexCounter = 0;

% create temporal graph structure, which is used by "dfstree.m"
t = graph;

for i = 1:nv(graph1)
    % check if node i isn't yet contained in a set of SCC
    if ~isempty(listUnvisited ( listUnvisited == i))
        foundWCCs = find( dfstree(t,graph1,i));
        % increase indexCounter
        indexCounter = indexCounter + 1;
        % store found SCC sets in prepared cell vector
        WCC_sets{indexCounter} = num2str(foundWCCs');

        % remove found nodes out of listUnvisited
        for j = 1:length(foundWCCs)
            listUnvisited(listUnvisited == foundWCCs(j)) = 0;
        end
    end
end

% reduce cell vector to non-empty elements
posEmptyCells = find(cellfun(@isempty, WCC_sets));
if ~isempty(posEmptyCells)
    WCC_sets = WCC_sets(1:min(posEmptyCells)-1);
end



%%%%%%%%%%%%%%