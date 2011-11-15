% This is a test file of Ferdinand

figure
hold on;

x = [0.1 1]; % start und endpunkt der linie für die x-koordinate
y = [0.2 2]; % start und endpunkt der linie für die y-koordinate


h = line(x,y,'Color','b','LineStyle','-'); % Color und LineStyle fixed for the moment

set(h,'Marker','>','MarkerFaceColor','b');

