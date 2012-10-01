function m = ne(g,dir,h)
% ne(g) --- number of edges in g 
% ne(g,dir) -- number of edges in g, if g is a directed graph and dir == 1
% ne(g,dir,h) --- check for inequality


global GRAPH_MAGIC

if nargin < 2
    dir = 0;
end

if (nargin == 3 && dir == 0)
    if any(size(g) ~= size(h))
        m = 1;
        return
    end
    D = GRAPH_MAGIC.graphs{g.idx}.array - GRAPH_MAGIC.graphs{h.idx}.array;
    m = nnz(D)>0;
    return
end

if (nargin == 2 && dir ~= 0)
    m = nnz(GRAPH_MAGIC.graphs{g.idx}.array);
    return
end

m = nnz(GRAPH_MAGIC.graphs{g.idx}.array)/2;