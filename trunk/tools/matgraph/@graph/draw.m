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

n = nv(g);

if ~hasxy(g)
    embed(g);
end

xy = getxy(g);

% first draw the edges

elist = edges(g);

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
    for j=1:ne(g)
        u = elist(j,1); %from u ...
        v = elist(j,2); % ... to v

        %prepare start and end coordinates
        from = xy(u,:)';
        to = xy(v,:)';
        %vector from outgoing vertex to incoming vertex
        ft = xy(v,:)'-xy(u,:)';
        %prepare the orthogonal of the line connection between both vertices
        ftT = [-ft(2); ft(1)];

        
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
            %test: slope at position of arrow (atop)
            slope=P(1)*2*x(95)+P(2);           
            %get point of curve, on which the arrow should lie
            atop=[x(95);P(1).*x(95).^2+P(2).*x(95)+P(3)];
            %compute y-axis-abschnitt
            t=atop(2)-slope*atop(1);
            %plot slope through atop
            %line([x(50);x(100)],[slope*x(50)+t;slope*x(100)+t]);
            %normalized slope vector on atop
            slope_vec = [x(100)-x(50); (slope*x(100)-t) - (slope*x(50)-t)];
            slope_vec_norm = slope_vec/norm(slope_vec);
            %first rotation matrix with angle phi
            phi = 5*pi/6;
            R=[cos(phi) -sin(phi); sin(phi) cos(phi)];
            %compute endpoint of one arrow cathetus
            end_point1 = R*slope_vec_norm;
            line([atop(1),atop(1)+0.05*end_point1(1)],...
                [atop(2),atop(2)+0.05*end_point1(2)],'Color',...
                edge_color,'LineStyle',line_style,'LineWidth',1.5);
            %second rotation matrix with angle phi
            phi = -5*pi/6;
            R=[cos(phi) -sin(phi); sin(phi) cos(phi)];
            %compute endpoint of one arrow cathetus
            end_point1 = R*slope_vec_norm;
            line([atop(1),atop(1)+0.05*end_point1(1)],...
                [atop(2),atop(2)+0.05*end_point1(2)],'Color',...
                edge_color,'LineStyle',line_style,'LineWidth',1.5);
        end
        %second case, if x1 and x2 are not proper
        if(norm(from(1)-to(1))<min_dist)
            %prepare middle of line connection between both vertices
            middle = 0.5*(xy(u,:)'+xy(v,:)');
            %print the curve using an ellipse
            [EllX EllY] = calculateEllipse(middle(1),middle(2),0.10,norm(ft)/2,0,100);
            line(EllX(25:75),EllY(25:75),'Color', edge_color,'LineStyle',line_style);
            
            %derivative of an ellipse: y'=-(b²x)/(a²y)
        end
        




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
