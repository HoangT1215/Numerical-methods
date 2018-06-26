% two dimensional Newtonian dynamics
clc;
clear;

% initialize
k = 0.1;
h = k^4/8;
T = 0.5;

TimeSteps = round(T/h);
XSpan = (0:k:1);

x0 = sin(pi/2*XSpan);
x = x0;
handle = plot(XSpan, x);

% Newtonian dynamics (explicit method)
for i = 1:TimeSteps
  dt4 = [0, 0, (x(1:end-4)-4*x(2:end-3)+6*x(3:end-2)-4*x(4:end-1)+x(5:end))/k^4, 0, 0]
  x = x - h*dt4;
  set(handle, 'ydata', x);
  title(['Time=',num2str(i*h)]);
  drawnow();
end