function ldraw(g,dir,line_style,nodeFillColor)
% ldraw(g,dir) -- draw a graph with vertices marked with their labels 
%                 and treat it as directed, if dir == 1
% ldraw(g,dir,line_style) --- give additional line_style
% If the graph is unlabled, we use the vertex numbers instead.
% See also draw, cdraw, and ndraw.


if ~is_labeled(g)
    if nargin ==1
        dir = 0;
        ndraw(g,dir,'-',nodeFillColor);
        return
    elseif nargin == 2
        ndraw(g,dir,'-',nodeFillColor);
        return
    else
        ndraw(g,dir,line_style,nodeFillColor)
        return
    end
end

if nargin == 1
    dir = 0;
    draw(g,dir,'-',nodeFillColor);
elseif nargin == 2
    draw(g,dir,'-',nodeFillColor);
else
    draw(g,dir,line_style,nodeFillColor);
end

draw_labels(g);
