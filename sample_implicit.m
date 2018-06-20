% sample code by Professor Molei Tao

clc;
clear;

k = 0.01;
h = 0.01;
T = 5;

SpaceSpan=transpose([0:k:1]);
TimeSteps=round(T/h);

N = length(SpaceSpan) - 1;
L = (-2*diag(ones(N-1,1)) + diag(ones(N-2,1),-1) + diag(ones(N-2,1),1))/k^2;
b = zeros(N-1,1);
b(end) = 1/k^2;

u0 = sin(2.5*pi*SpaceSpan);
u = u0;
handle = plot(SpaceSpan, u);

for i = 1:TimeSteps
  u(2:end-1)=inv(eye(N-1)/h-L)*(u(2:end-1)/h+b);
  
  set(handle, 'ydata', u);
  title(['Time=',num2str(i*h)]);
  drawnow();
end
  