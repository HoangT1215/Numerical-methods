% Explicit method
clc;
clear;

% initialize
k = 0.01;
h = k^2/2;
T = 1;

SpaceSpan = (0:k:1);
TimeSteps = round(T/h);

u0 = sin(2.5*pi*SpaceSpan);
u = u0;
handle = plot(SpaceSpan, u);

for i = 1:TimeSteps
  dudtt = [0, (u(1:end-2)-2*u(2:end-1)+u(3:end))/k^2, 0];
  u = u + h*dudtt;
  
  set(handle, 'ydata', u);
  title(['Time=',num2str(i*h)]);
  drawnow();
end
