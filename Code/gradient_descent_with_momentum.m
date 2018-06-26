% gradient descent with momentum (heat equation)
clc;
clear;

% initialize
k = 0.01;
h = 0.01;
T = 0.05;
gamma = 0.15;

TimeSteps = round(T/h);
XSpan = (0:k:1);
N = length(SpaceSpan);

u1 = sin(pi/2*XSpan)
u2 = sin(pi/2*XSpan)
L = (-2*diag(ones(N-1,1)) + diag(ones(N-2,1),-1) + diag(ones(N-2,1),1))/k^2;

p = u1
q = u2
handle = plot(XSpan, x);

for i = 1:TimeSteps
  p = 1/(1+gamma*h-(h/k)^2)*(p+h/k^2*q)
  q = inv((1+gamma*h)*diag(ones(N,1)) - (h/k)^2*L)*(h*p+(1+gamma*h)*q)
  
  set(handle, 'ydata', x);
  title(['Time=',num2str(i*h)]);
  drawnow();
end
