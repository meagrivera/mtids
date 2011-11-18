function [elist] = edges(g,dir)
% edges(g) --- list the edges in g as a 2-column matrix
% edges(g,dir) --- treats the graph as directed

global GRAPH_MAGIC

if nargin < 2
    dir = 0;
end


if dir == 0
    [i,j] = find(triu(GRAPH_MAGIC.graphs{g.idx}.array));
    
end

if dir == 1
    Adj = GRAPH_MAGIC.graphs{g.idx}.array;
    
    [i,j] = find(Adj);
end

elist = [i,j];