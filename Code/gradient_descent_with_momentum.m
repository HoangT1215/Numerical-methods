% gradient descent with momentum (heat equation)
clc;
clear;

% initialize
k = 0.01;
h = 0.01;
T = 3;
gamma = 5;

TimeSteps = round(T/h);
XSpan = transpose([0:k:1]);
N = length(XSpan)-1;

u1 = XSpan
u2 = sin(5*pi/2*XSpan)
L = (-2*diag(ones(N-1,1)) + diag(ones(N-2,1),-1) + diag(ones(N-2,1),1));

b = zeros(N-1,1); % scalar value
b(end) = h/(gamma*k^2);

p = u1
q = u2
handle = plot(XSpan, q);

for i = 1:TimeSteps
  p(2:end-1) = inv((1+gamma*h)*diag(ones(N-1,1)) - (h/k)^2*L)*(p(2:end-1)+h/k^2*L*(q(2:end-1)+b))
  q(2:end-1) = inv((1+gamma*h)*diag(ones(N-1,1)) - (h/k)^2*L)*(h*p(2:end-1)+(1+gamma*h)*(q(2:end-1)+b))
  
  set(handle, 'ydata', q);
  title(['Time=',num2str(i*h)]);
  drawnow();
end
