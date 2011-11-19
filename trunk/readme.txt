i changed matgraph the following way:

add.m : if a 4th argument with value = 1 is prompted, then the new egde will be treated as directed

draw.m : if a 4th argument like above is promted, the edges between the vertices will be drawn as curves and with an arrow, which indicates the direction of this edge. Debugging isn't completed yet.

edges.m : if "dir" as an additional argument is passed, then the read-out of the adjacency-matrix will be performed as direted

mtids.m
mtids.fig : start first changes to implement the different "modus operandi": "directed" / "undirected", but no working functions were implemented yet

sandkasten/old_code.m : some lines of code, maybe for later use; nothing productive

write a function, that replaces "edges.m", because it is written for undirected graphs and it searches only the upper triangular of the adjacency matrix
