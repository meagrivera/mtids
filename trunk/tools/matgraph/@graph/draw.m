function draw(g,dir,line_style,nodeFillColor)
% draw(g) --- draw g in a figure window
% draw(g,dir) --- interpret g as a directed graph
% draw(g,dir,line_style) --- lines have given line_style
% draw(g,dir,line_style,nodeFillColor) -- passes a desired color for the
% vertex face color, it is a cell array with as many entries as nodes in the graph
% see also ndraw, ldraw, and cdraw
  
if nargin < 4
    nodeFillColor = 'w';
end

if nargin < 3
    line_style='-';
end

if nargin < 2
    dir = 0;
end

% edit these to change the colors 
edge_color = 'b';

% do here the coloring for the nodes
vertex_color = 'r';
r = 0.15;

%step: needed for non-line connection between nodes
step = 0.15;
%min_dist: needed to avoid improper quadratic interpolation parametrization
min_dist = 0.05;
%set arrow parameters
arrLength = 0.10;
arrWidth = 0.08;
arrPos = 92/100; %position of arrow in percent of the length between outgoing and incoming node
%ellSample; iteration steps for drawing the ellipse
ellSteps = 100;

n = nv(g);

if ~hasxy(g)
    embed(g);
end

xy = getxy(g);

% first draw the edges

elist = edges(g,dir);

if dir == 0 %interpret graph as undirected
    for j=1:ne(g)
        u = elist(j,1); %from u ...
        v = elist(j,2); % ... to v
        x = xy([u,v],1);
        y = xy([u,v],2);
        line(x,y,'Color', edge_color,'LineStyle',line_style);
    end
end

if dir == 1 % interpret graph as directed
    for j=1:ne(g,dir)
        u = elist(j,1); %from u ...
        v = elist(j,2); % ... to v

        %prepare start and end coordinates
        from = xy(u,:)';
        to = xy(v,:)';
        %vector from outgoing vertex to incoming vertex
        ft = xy(v,:)'-xy(u,:)';
        %prepare the orthogonal of the line connection between both vertices
        ftT = [-ft(2); ft(1)]/norm([-ft(2); ft(1)]);
        %angle of direction vector pointing from outoing to incoming vertex
        ftAngle = atan2(ft(2),ft(1))/pi*180;
        %prepare middle of line connection between both vertices
        middle = 0.5*(xy(u,:)'+xy(v,:)');        
        %line from "from" to "to"
        xlin = linspace(from(1),to(1));
        ylin = linspace(from(2),to(2));
        
        for i = 1:length(xlin)
            alpha = pi/length(xlin)*i;
            temp = step*sin(alpha)*ftT;
            xlin(i) = xlin(i) + temp(1);
            ylin(i) = ylin(i) + temp(2);
        end
        
        line(xlin,ylin,'Color', edge_color,'LineStyle',line_style);
                
        %approximate slope vector for orientation of arrow
        arrVec = (to - [xlin(length(xlin)/2);ylin(length(xlin)/2)])/...
            norm(to - [xlin(length(xlin)/2);ylin(length(xlin)/2)]);       
        %get point of curve, on which the arrow should lie
        atop = [xlin(length(xlin)*arrPos);ylin(length(xlin)*arrPos)];
        
        %first rotation matrix with angle phi
        phi = 5*pi/6;
        R=[cos(phi) -sin(phi); sin(phi) cos(phi)];
        %compute endpoint of one arrow cathetus
        end_point1 = R*arrVec;
        line([atop(1),atop(1)+arrLength*end_point1(1)],...
            [atop(2),atop(2)+arrLength*end_point1(2)],'Color',...
            edge_color,'LineStyle',line_style,'LineWidth',arrWidth);
        %second rotation matrix with angle phi
        phi = -5*pi/6;
        R=[cos(phi) -sin(phi); sin(phi) cos(phi)];
        %compute endpoint of one arrow cathetus
        end_point1 = R*arrVec;
        line([atop(1),atop(1)+arrLength*end_point1(1)],...
            [atop(2),atop(2)+arrLength*end_point1(2)],'Color',...
            edge_color,'LineStyle',line_style,'LineWidth',arrWidth);

    end       
end

% now draw the vertices
  
for v=1:n
    x = xy(v,1);
    y = xy(v,2);
    if nargin < 4
    rectangle('Position', [x-r/2, y-r/2, r, r],...
              'Curvature', [1 1], ...
              'EdgeColor', vertex_color, ...
              'FaceColor', nodeFillColor);
    else
    rectangle('Position', [x-r/2, y-r/2, r, r],...
             'Curvature', [1 1], ...
             'EdgeColor', vertex_color, ...
             'FaceColor', nodeFillColor{v});
    end
end



axis equal
axis off
