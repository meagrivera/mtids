function ndraw(g,dir,line_style,nodeFillColor)
% ndraw(g) --- draw g in a figure window with numbered vertices
% ndraw(g,dir) --- treat g as directed
% ndraw(g,dir,line_style) --- lines have given line_style
% see also draw, ldraw, and cdraw

if nargin < 2
    dir = 0;
    draw(g,dir,'-',nodeFillColor);
end

if nargin < 3
   draw(g,dir,'-',nodeFillColor); 
else
    draw(g,dir,line_style,nodeFillColor);
end

xy = getxy(g);
n = nv(g);

for v=1:n
    x = xy(v,1);
    y = xy(v,2);
    text(x-.05,y,int2str(v)); 
end