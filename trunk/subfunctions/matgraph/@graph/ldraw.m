function ldraw(g,dir,line_style,nodeFillColor,nodeEdgeColor)
% ldraw(g,dir) -- draw a graph with vertices marked with their labels 
%                 and treat it as directed, if dir == 1
% ldraw(g,dir,line_style) --- give additional line_style
% If the graph is unlabled, we use the vertex numbers instead.
% See also draw, cdraw, and ndraw.


if ~is_labeled(g)
    if nargin ==1
        dir = 0;
        ndraw(g,dir);
        return
    elseif nargin == 2
        ndraw(g,dir);
        return
    else
        ndraw(g,dir,line_style,nodeFillColor,nodeEdgeColor)
        return
    end
end

if nargin == 1
    dir = 0;
    draw(g,dir);
elseif nargin == 2
    draw(g,dir);
else
    draw(g,dir,line_style,nodeFillColor,nodeEdgeColor);
end

draw_labels(g);
