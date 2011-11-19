function draw(g,dir,line_style)
% draw(g) --- draw g in a figure window
% draw(g,dir) --- interpret g as a directed graph
% draw(g,dir,line_style) --- lines have given line_style
% see also ndraw, ldraw, and cdraw
  
if nargin < 3
    line_style='-';
end

if nargin < 2
    dir = 0;
end

% edit these to change the colors 
edge_color = 'b';
vertex_color = 'r';
vertex_fill = 'w';
r = 0.15;

%step: needed for non-line connection between nodes
step = 0.15;
%min_dist: needed to avoid improper quadratic interpolation parametrization
min_dist = 0.05;
%set arrow parameters
arrLength = 0.10;
arrWidth = 0.08;
arrPos = 90; %percent of the length between outgoing and incoming node
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
        ftT = [-ft(2); ft(1)];
        %angle of direction vector pointing from outoing to incoming vertex
        ftAngle = atan2(ft(2),ft(1))/pi*180;
        
        %test, if x1 and x2 are proper to use quadratic interpolation
        %if x1 and x2 is proper
        if(norm(from(1)-to(1))>min_dist)
            %prepare middle of line connection between both vertices
            middle = 0.5*(xy(u,:)'+xy(v,:)');
            %Via-point of connection line, needed for quadratic interpolation
            via = middle + step*ftT/norm(ftT); %step: distance of via point from middle of line connection between outoing and incoming vertex
            %generate quadratic interpolation coefficients
            P = polyfit([from(1);via(1);to(1)],[from(2);via(2);to(2)],2);
            %prepare x-values of connection
            x = linspace(from(1),to(1));
            line(x,P(1)*x.^2+P(2)*x+P(3),'Color', edge_color,'LineStyle',line_style);
            %get point of curve, on which the arrow should lie
            atop=[x(arrPos);P(1).*x(arrPos).^2+P(2).*x(arrPos)+P(3)];
        end
        %second case, if x1 and x2 are not proper
        if(norm(from(1)-to(1))<min_dist)
            %prepare middle of line connection between both vertices
            middle = 0.5*(xy(u,:)'+xy(v,:)');
            %print the curve using an ellipse
            [EllX EllY] = calculateEllipse(middle(1),middle(2),0.10,norm(ft)/2,0,ellSteps);
            line(EllX(  25:75),EllY(    25:75),'Color', edge_color,'LineStyle',line_style);
            %get point of curve, on which the arrow should lie
            atop=[EllX(69);EllY(69)];
            via=[EllX(50);EllY(50)];
       end
        
        %approximate slope vector for orientation of arrow
        arrVec = (to - via)/norm(to - via);       

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
    rectangle('Position', [x-r/2, y-r/2, r, r],...
              'Curvature', [1 1], ...
              'EdgeColor', vertex_color, ...
              'FaceColor', vertex_fill);    
end



axis equal
axis off
