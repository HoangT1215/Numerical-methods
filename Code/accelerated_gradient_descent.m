% Accelerated gradient descent (heat equation)
clc;
clear;

% initialize
k = 0.01;
h = 0.01;
s = 0.000004;
T = 15;

TimeSteps = round(T/h);
XSpan = transpose([0:k:1]);
N = length(XSpan)-1;

u1 = sin(0.5*pi*XSpan)
u2 = sin(2.5*pi*XSpan)
L = (-2*diag(ones(N-1,1)) + diag(ones(N-2,1),-1) + diag(ones(N-2,1),1));

b = zeros(N-1,1); % scalar value
b(end) = (s/k^2); % tentative value

x = u1
y = u2
old_x = x
handle = plot(XSpan, y);

% iteration
for t = 1:TimeSteps
  x(2:end-1) = y(2:end-1) + s*L/k^2*(y(2:end-1)) + b
  y = x + (t-1)/(t+2)*(x-old_x)
  old_x = x
  
  set(handle, 'ydata', y);
  title(['Time=',num2str(t*h)]);
  drawnow();
end
