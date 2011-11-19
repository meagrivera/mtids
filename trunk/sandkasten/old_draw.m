%test, if x1 and x2 are proper to use quadratic interpolation
%if x1 and x2 is proper
if(norm(from(1)-to(1))>min_dist)

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

    %print the curve using an ellipse
    [EllX EllY] = calculateEllipse(middle(1),middle(2),0.10,norm(ft)/2,0,ellSteps);
    line(EllX(  25:75),EllY(    25:75),'Color', edge_color,'LineStyle',line_style);
    %get point of curve, on which the arrow should lie
    atop=[EllX(69);EllY(69)];
    via=[EllX(50);EllY(50)];
end