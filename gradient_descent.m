clear;
clc;

% initialize
V=@(x,y) (x.^2-1).^2/4 + (y-x.^2).^2/2; % Rosenbrock function
dV=@(x,y) [(x.^2-1).*x+(x.^2-y).*x*2;y-x.^2]; 
threshold=1E-4; 
h=0.01; 

x0=-0.5;
y0=0.1; 

x=x0;
y=y0; 

% display contour
xSpan=[-1.2:0.01:1.2];
ySpan=[-1.2:0.01:2];
[XSpan,YSpan]=meshgrid(xSpan,ySpan);
surf(XSpan,YSpan,V(XSpan,YSpan)); 

hold on
dot=scatter3(x,y,V(x,y),100, 'filled');

i=0;

error=norm(dV(x,y));
while (error>threshold)
    i=i+1; 
    temp=dV(x,y); 
    x=x-h*temp(1); 
    y=y-h*temp(2); 
    
    error=norm(dV(x,y)); 
    set(dot,'xdata',x,'ydata',y,'zdata', V(x,y)); 
    title(['Time=', num2str(i*h),'error=', num2str(error)]);
    drawnow
end