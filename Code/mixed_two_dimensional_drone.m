% two dimensional dynamics
clc;
clear;

% initialize
k = 0.01;
h = k^3/2;
T = 0.05;

TimeSteps = round(T/h);
XSpan = (0:k:1);

u1 = sin(pi/2*XSpan)
u2 = sin(pi/2*XSpan)

x = u1
y = u2
handle = plot(XSpan, x);

for i = 1:TimeSteps
  dtt = [[0, (x(1:end-2)-2*x(2:end-1)+x(3:end))/k^2 - (y(3:end) - y(2:end-1))/k - x(2:end-1), 0];[0, (y(1:end-2)-2*y(2:end-1)+y(3:end))/k^2 + (y(3:end) - y(2:end-1))/k, 0]]
  x = x + h*dtt(1,:);
  y = y + h*dtt(2,:);
  set(handle, 'ydata', x);
  title(['Time=',num2str(i*h)]);
  drawnow();
end
