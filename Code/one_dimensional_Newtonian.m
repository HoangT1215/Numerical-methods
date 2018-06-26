% one dimensional Newtonian

clc;
clear;

% initialize
k = 0.01;
h = 0.01;
T = 10;

SpaceSpan = (0:k:1);
TimeSteps = round(T/h);

N = length(SpaceSpan);
L = -(6*diag(ones(N-2,1)) - 4*diag(ones(N-3,1),-1) - 4*diag(ones(N-3,1),1) + diag(ones(N-4,1),-2) + diag(ones(N-4,1),2))/k^4;
b = zeros(N-2,1);
% b(end-1) = 1/k^4;
b(end) = 1/k^4;

u0 = SpaceSpan.^3;
u = u0;
handle = plot(SpaceSpan, u);

% implicit method
for i = 1:TimeSteps
  u(3:end-1)=transpose(inv(eye(N-2)/h-L)*(transpose(u(3:end-1))/h+b));

  set(handle, 'ydata', u);
  title(['Time=',num2str(i*h)]);
  drawnow();
  pause(0.1);
end