% Accelerated gradient descent (implicit method)
clc;
clear;

% initialize
k = 0.01;
h = 0.5;
T = 5;

TimeSteps = round(T/h);
XSpan = transpose([0:k:1]);
N = length(XSpan)-1;

u1 = sin(2.5*pi*XSpan)
L = (-2*diag(ones(N-1,1)) + diag(ones(N-2,1),-1) + diag(ones(N-2,1),1));

b = zeros(N-1,1);
b(end) = -1/(k^2);

x = u1
old_x = 0*XSpan
handle = plot(XSpan, x);

% iteration
for i = 1:TimeSteps
  x(2:end-1) = inv(L/k^2-(i+3)*diag(ones(N-1,1))/(i*h^2))*(-2*(x(2:end-1))/h^2 + (i-3)*old_x(2:end-1)/(i*h^2) + b)
  old_x = x
  
  set(handle, 'ydata', x);
  hold on
  YSpan = XSpan;
  plot(XSpan,YSpan)
  hold off
  title(['Time=',num2str(i*h)]);
  drawnow();
end
