% blockVanvas.m, defines simulink  define Block position 
% plane divided into blocks

function canvas= blockCanvas(pos)

% set up width and height of Block
width=30;
height=30; 


x=pos(1);
y=pos(2);

% coordinates for canvas
upLeftX= x*width ;
upRightX= (x+1)*width ;
loLeftY=y*height;
loRightY= (y+1)*height ;
canvas = [upLeftX loLeftY upRightX loRightY] ;