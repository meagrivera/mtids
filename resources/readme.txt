--------------<<<<<COMPLETED CHANGES:>>>>>>>>---------------------------------------------

add.m : if a 4th argument with value = 1 is prompted, then the new egde will be treated as directed.

draw.m : if a 4th argument like above is promted, the edges between the vertices will be drawn as curves and with an arrow, which indicates the direction of this edge. A more robust algorithm was implemented, thus the visualization works quite well.

edges.m : if "dir" as an additional argument is passed, then the read-out of the adjacency-matrix will be performed as direted

mtids.m
mtids.fig : The visualization of directed graphs seems to work well. There is some work left, e.g. the exporting functions does not work.

delete.m : if "dir" as an additional argument is passed, the deletion of an edge will be treated as directed.

sandkasten/old_code.m : some lines of code, maybe for later use; nothing productive

ldraw.m :
cdraw.m :
ndraw.m : works also with an argument, that indicates, if graph is treated as directed or not

ne.m : works also with an argument, that indicates, if graph is treated as directed or not; not totally debugged until now

random.m : Edited this function, to assure, that it works properly with directed graphs. Just added a few lines, to implement an own algorithm, to create random graphs. It may be poor, but quickly to write.

getDegree.m : Added new function to compute the in- and out-degree of adjacency matrices for directed graphs

export_as_matrix.m : Adopted for directed graphs, so that export_to_workplace works for directed graphs. Contains a choice for indegree and outdegree when computing the laplacian for directed graphs.

template_modify2.m : case distinction for nodes with zero input

export_to_simulink2.m : some minor changes for adoptaption to directed graphs; also added some functions for LTI-templates, that the state matrices can be differed now.

Copy_of_LTI.mdl : Added a To Workspace-Block; if this is fulfilling our needs, cannot be said actually. Maybe, some more changes are necessary.

ctrl_simulation.fig / .m : A new GUI, which hosts the starting function for the simulation as well as some checks for feasibility and the start of the plot function. A lot of work is left for now (18.12.11).


--------------<<<<<CHANGES STILL TO DO:>>>>>>>>--------------------------------------------

Basic stats: i cancled out every value, which seems useless for directed graphs. Here, we should talk about purposeful algorithms, which are to implement

Exporting functions: familiarize with the m-files







--------------<<<<<GENERAL REMARKS:>>>>>>>>--------------------------------------------

Concerning the edited matgraph-toolbox: due to that the "dir"-flag is more important that passed visualization arguments, most of the edited functions do not very likely work as before in cooperation with all other functions of matgraph.
In our special case, we can check each instance of the edited functions, because our context lies in defined functions and GUIs, so that the passed arguments can be proved, that nothing bad happens.

neighbors.m is also working with directed graphs. Thus dfstree.m works with directed graphs, which we need to perform the strong connectivity attributes.