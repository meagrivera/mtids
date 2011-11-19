--------------<<<<<COMPLETED CHANGES:>>>>>>>>---------------------------------------------

add.m : if a 4th argument with value = 1 is prompted, then the new egde will be treated as directed

draw.m : if a 4th argument like above is promted, the edges between the vertices will be drawn as curves and with an arrow, which indicates the direction of this edge. Debugging isn't completed yet.

edges.m : if "dir" as an additional argument is passed, then the read-out of the adjacency-matrix will be performed as direted

mtids.m
mtids.fig : start first changes to implement the different "modus operandi": "directed" / "undirected", but no working functions were implemented yet

delete.m : if "dir" as an additional argument is passed, the deletion of an edge will be treated as directed.

sandkasten/old_code.m : some lines of code, maybe for later use; nothing productive

ldraw.m :
cdraw.m :
ndraw.m : works also with an argument, that indicates, if graph is treated as directed or not

ne.m : works also with an argument, that indicates, if graph is treated as directed or not; not totally debugged until now



--------------<<<<<CHANGES STILL TO DO:>>>>>>>>--------------------------------------------

now that the dynamic visualization works (roughly) with the directed version, much bugs are visible. if bugs are heavy, details were listed here:
-check arrow direction for the "ellipse"-case
-the quadratic interpolation can only be used in the case, if both x-values are fairly distant to each other. otherwise, the interpolation generates funny things
-the ellipse-case plots the edge in both cases "from-to" and "to-from" in the same way, that the edges are overlapping


the function "randomconnection_Callback" is not stable. It happens also in the "undirected" case. If possible, check this bug with a former version of mtids to be sure, that the bug was not ferdls fault :)


do something with the basic stats stuff, if the modus is set to "directed", e.g. in the function refresh_graph





--------------<<<<<GENERAL REMARKS:>>>>>>>>--------------------------------------------

Concerning the edited matgraph-toolbox: due to that the "dir"-flag is more important that passed visualization arguments, most of the edited functions do not very likely work as before in cooperation with all other functions of matgraph.
In our special case, we can check each instance of the edited functions, because our context lies in defined functions and GUIs, so that the passed arguments can be proved, that nothing bad happens.
